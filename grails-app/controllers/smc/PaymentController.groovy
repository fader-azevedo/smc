package smc

import auth.User
import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured
import groovy.json.JsonSlurper
import net.sf.jasperreports.engine.JasperExportManager
import net.sf.jasperreports.engine.JasperFillManager
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource
import org.grails.core.io.ResourceLocator

@Secured('ROLE_ADMIN')
class PaymentController {

    ResourceLocator grailsResourceLocator
    PaymentService paymentService
    InstalmentService instalmentService
    LoanService loanService
    def springSecurityService
    def dashboard = new DashboardController()
    def loanController = new LoanController()

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index() {
        dashboard.disableSessions()
        def paymentList = Payment.createCriteria().list {
            loan{
                eq('status','aberto')
            }
            order('dateCreated','desc')
        }
        model:[paymentList: paymentList]
    }

    def list(){
        session.setAttribute('loanClientStatus',params.loanClientStatus)
        render('')
    }

    def show(Long id) {
        dashboard.disableSessions()
        respond paymentService.get(id)
    }

    def create() {
        respond new Payment(params)
    }

    def newPayment(){
        session.setAttribute('loanID',params.loanID)
        render('')
    }

    def beforeSave(){
        render([status: true] as JSON)
    }

    def save(Payment payment) {
        println('test-save')
        def loan = Loan.get(new Long(params.loan))
        payment.setCreatedBy((User) springSecurityService.currentUser)
        payment.setUpdatedBy((User) springSecurityService.currentUser)
        payment.setCode(loan.code.concat(loan.payments.size()+1 as String))
        payment.setTotalPaid(new Double(params.totalPaid))
        payment.setLoan(loan)
        paymentService.save(payment)

        def instalmentsJson = new JsonSlurper().parseText(params.instalments.toString())

        instalmentsJson.each {
            def instalment = Instalment.get(it.id)

            def instalmentPayment = new InstalmentPayment(payment: payment)
            instalmentPayment.setPaymentMothod(PaymentMethod.get(1))
            instalmentPayment.setCreatedBy((User) springSecurityService.currentUser)
            instalmentPayment.setUpdatedBy((User) springSecurityService.currentUser)
            instalmentPayment.setCode(dashboard.codeGenerator(InstalmentPayment))
            instalmentPayment.setAmountPaid( new Double(it.value))

            if(!it.part){
                instalment.setStatus('Pago')
                instalment.addToInstalmentPayments(instalmentPayment)
                instalmentService.save(instalment)
            }else{
                def newInstalment = new Instalment()

                newInstalment.setCode(instalment.getCode()+instalment.instalments.size()+1)
                newInstalment.setLoan(loan)
                newInstalment.setOwner(instalment)
                newInstalment.setType(InstalmentType.findByName('Parcela'))
                newInstalment.setAmountPayable(new Double(it.value))
                newInstalment.setCreatedBy((User) springSecurityService.currentUser)
                newInstalment.setUpdatedBy((User) springSecurityService.currentUser)
                newInstalment.setDueDate(instalment.dueDate)
                newInstalment.setStatus('Pago')

                newInstalment.addToInstalmentPayments(instalmentPayment)
                instalmentService.save(newInstalment)
            }
        }

        if(Instalment.findAllByLoanAndStatus(loan,'Pendente').size() == 0){
            loan.setStatus('Fechado')
            loanService.save(loan)
            println('emprestimo '+loan.code+' closed')
        }
        render([payment:payment.id,saved:true] as JSON)
    }

    def edit(Long id) {
        dashboard.disableSessions()
        respond paymentService.get(id)
    }

    def update(Payment payment) {

    }

    def _byClient(){
        def status = params.status.toString().trim()
        def loanList = Loan.createCriteria().list {
            eq('client',Client.get(new Long(params.id)))
            if(status){
                eq('status',status)
            }
            order('dateCreated','desc')
        }as List<Loan>
        model: [loanList:loanList]
    }

    def _filterPaymentByLoanStatus(){
        def status = params.status.toString().trim()
        def dateOne = params.dateOne
        def dateTwo = params.dateTwo

        if (dateOne){
            dateOne = new Date().parse("dd/MM/yyy",dateOne.toString())
        }
        if (dateTwo){
            dateTwo = new Date().parse("dd/MM/yyy",dateTwo.toString())
        }

        def paymentList = Payment.createCriteria().list {
            if(status){
                loan{
                    eq('status',status)
                }
            }
            if (dateOne && dateTwo) {
                between("dateCreated", dateOne, dateTwo)
            }
            order('dateCreated','desc')
        } as List<Payment>
        render(template: 'all',model: [paymentList: paymentList])
    }

    class Receipt{
        String logo,info,num,client,date,entity
        String tab_num,tab_method,tab_reference,tab_value,tab_type
        String sub_total, iva,total
    }

    def static saveDestiny

    def generateReceipt(id){
        def payment = Payment.get(id)
        def destiny = loanController.getLoanDir(payment.loan)+'/'+payment.code.concat('.pdf')

        if (!new File(destiny).isFile()) {
            def i = 0
            def receiptListTable = new ArrayList<Receipt>()

            payment.getInstalmentPayments().each {
                def receipt = new Receipt()
                receipt.setTab_num(it.instalment.code)
                receipt.setTab_type(it.instalment.type.name)
                receipt.setTab_method(it.paymentMothod.name)
                receipt.setTab_reference('0000' + i)
                receipt.setTab_value(it.amountPaid.toString())

                receiptListTable.add(receipt)
            }

            def mapTable = new HashMap<String, Object>()
            def receiptDataSource= new JRBeanCollectionDataSource(receiptListTable)
            mapTable.put('receiptDataSource', receiptDataSource)

            def logo = grailsResourceLocator.findResourceForURI('/avatar.jpg').file.toString()

            def receiptInfo = new Receipt()
            receiptInfo.setLogo(logo)
            receiptInfo.setInfo('<h1>Organization Name<h1><p>Junior Macuvele<p>')
            receiptInfo.setNum(payment.code)
            receiptInfo.setClient(payment.loan.client.fullName)
            receiptInfo.setDate(DashboardController.formatDateTime(new Date()))
            receiptInfo.setEntity('Nome da organization')

            def percent = 12
            def iva = payment.totalPaid * percent / 100
            receiptInfo.setSub_total(String.format("%,.2f", payment.totalPaid))
            receiptInfo.setIva('(' + percent + '%):   ' + String.format('%,.2f', iva))
            receiptInfo.setTotal(String.format('%,.2f', payment.totalPaid + iva))

            def receiptInfoList = new ArrayList<Receipt>()
            receiptInfoList.add(receiptInfo)

            def receiptInfoCollection = new JRBeanCollectionDataSource(receiptInfoList)

            def receiptJasper = grailsResourceLocator.findResourceForURI('/jasper/receipt.jasper').file.toString()
//            def receiptJasper = new File('D:/receipt.jasper').toString()

            def jasperPrint = JasperFillManager.fillReport(receiptJasper, mapTable, receiptInfoCollection)
            JasperExportManager.exportReportToPdfStream(jasperPrint, new FileOutputStream(new File(destiny)))
        }
        saveDestiny = destiny
        render ([destiny:destiny,status: true] as JSON)
    }

    def getReceipt(){
        println('text-receipt')
        generateReceipt(params.id)
    }

    def test(){
        println('text-then')
        render('')
    }

    def receipt(){
        render(file: saveDestiny, contentType: 'application/pdf')
    }

    def testSweet(){
        println('params: '.concat(params.name.toString()))
        render([name:'Macuvele',age:10] as JSON)
    }
}