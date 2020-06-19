package smc

import auth.User
import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException
import net.sf.jasperreports.engine.JasperExportManager
import net.sf.jasperreports.engine.JasperFillManager
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource
import org.grails.core.io.ResourceLocator

import java.text.DecimalFormat

import static org.springframework.http.HttpStatus.*

@Secured('ROLE_ADMIN')
class LoanController {

    LoanService loanService
    def springSecurityService
    def dashboard = new DashboardController()

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index() {
        dashboard.disableSessions()
        generateReceipt()
        model:[loanCount: loanService.count(),loanList: Loan.findAllByStatus('aberto').sort{it.dateCreated}.reverse()]
    }

    def show(Long id) {
        respond loanService.get(id)
    }

    def create() {
        dashboard.disableSessions()
        respond new Loan(params)
    }

    def save(Loan loan) {

        loan.setCreatedBy((User) springSecurityService.currentUser)
        loan.setUpdatedBy((User) springSecurityService.currentUser)
        loan.setCode(codeGenerator(loan.getPaymentMode().id))
        def signatureDate = new Date().parse("dd/MM/yyy",params.signatureDate_.toString())
        def payDate = new Date().parse("dd/MM/yyy",params.payDate_.toString())
        def dueDate = new Date().parse("dd/MM/yyy",params.dueDate_.toString())
        loan.setSignatureDate(signatureDate)
        loan.setPayDate(payDate)
        loan.setDueDate(dueDate)


        loan.setInstalments(generateInstalments(loan) as Set<Instalment>)

        try {
            if(loanService.save(loan)){
                generateGuarantees().each {
                    it.save()
                    new LoanGuarantee(code: '000',loan: loan,guarantee: it,latitude: 0,longitude: 0,observation: '',
                            updatedBy: loan.updatedBy,createdBy: loan.createdBy
                    ).save()
                }
            }
        } catch (ValidationException e) {
            respond loan.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'loan.label', default: 'Loan'), loan.id])
                redirect loan
            }
            '*' { respond loan, [status: CREATED] }
        }
    }


//    def deFr = new DecimalFormat('#.00')
    def generateInstalments(loan){
        def dateDif = 1
        switch (loan.paymentMode.name.toLowerCase().trim()) {
            case 'semanal': dateDif = 7
                break
            case 'quinzenal': dateDif = 15
                break
            case 'mensal': dateDif = 30
                break
        }
        def dateIncrement = dateDif

        def limit = Calendar.getInstance()
        limit.setTime(loan.payDate)

        def installments = new ArrayList<Instalment>()
        for(def i=1; i <= loan.getInstalmentsNumber(); i++){
            def installment = new Instalment()
            installment.setLoan(loan)
            installment.setType(InstalmentType.findByName('Renda Normal'))
            installment.setAmountPayable(new Double(params.amountPerInstalment))
            installment.setCreatedBy((User) springSecurityService.currentUser)
            installment.setUpdatedBy((User) springSecurityService.currentUser)
            installment.setCode(loan.getCode()+i)

            if(i == 1){
                installment.setDueDate(loan.payDate)
            }else {
                if (i == loan.getInstalmentsNumber()) {
                    installment.setDueDate(loan.dueDate)
                } else {
                    if (dateDif != 30) {
                        installment.setDueDate(jumpSunday(loan.getPayDate() + dateIncrement))
                        dateIncrement += dateDif
                    } else {
                        installment.setDueDate(jumpSunday(limit.getTime()))
                        limit.add(Calendar.MONTH, 1)
                    }
                }
            }
            installments.add(installment)
        }
        return installments
    }

    def generateGuarantees(){
        def check = params.guarantee_check
        def guaranteeList = new ArrayList<Guarantee>()
        if(check){
            def guaranteeType = params.guaranteeType
            def description = params.description
            if(description instanceof String){
                guaranteeList.add(createGuarantee(guaranteeType,description))
            }else {
                def counter = 0
                description.each {
                    guaranteeList.add(createGuarantee(guaranteeType[counter],it))
                    counter+=1
                }
            }
        }
        return guaranteeList
    }

    def createGuarantee(type,description){
        def guaranteeType = GuaranteeType.findOrSaveWhere(name: type)
        return new Guarantee(type: guaranteeType,description: description,image: 'image')
    }

    def edit(Long id) {
        respond loanService.get(id)
    }

    def update(Loan loan) {

    }

    def delete(Long id) {

    }

    def static codeGenerator(id){
        def paymentMode = PaymentMode.get(id)
        def regionString = paymentMode.name[0]

        def loanSaved = Loan.createCriteria().list {
            eq('paymentMode',paymentMode)
        } as List<Loan>

        def size = loanSaved.size()+1
        def length = size.toString().length()
        def code = ''
        for(def i=length; i<5; i++){
            code += '0'
        }
        return regionString.concat(code).concat(size as String) //code ex: S00002
    }

    def codeGenerate(){
        render(codeGenerator(new Long(params.id)))
    }

    def jumpSunday(def date){
        Calendar calendar = Calendar.getInstance()
        calendar.setTime(date)
        (calendar.get(Calendar.DAY_OF_WEEK) == 1)?Date.parse("yyyy-MM-dd", (date + 1).format("yyyy-MM-dd")):date
    }

    def getDetails(){
        def loan = Loan.get(new Long(params.id))
        def instPayed = Instalment.findAllByLoanAndStatus(loan,'Pago').size()
        def instPend = Instalment.findAllByLoanAndStatus(loan,'Pendente').size()
        def instAll = Instalment.findAllByLoan(loan).size()

        def valuePaid = getValuePaid(Instalment.findAllByLoanAndStatus(loan,'Pago'))

        def debit = loan.amountPayable - valuePaid
        render([
                loan:loan, client:loan.client,instPayed:instPayed,
                instPend:instPend,instAll:instAll,valuePaid:valuePaid, debit:debit,createdBy: loan.createdBy.fullName,
                updatedBy: loan.updatedBy.fullName,instalmentType:loan.paymentMode.name
        ] as JSON)
    }

    def totalPaid(){
        def loan = Loan.get(params.id)
        def valuePaid = getValuePaid(Instalment.findAllByLoanAndStatus(loan,'Pago'))

        render(valuePaid)
    }

    def static getValuePaid(paidInstallment){
        def amountPaid = 0.0
        paidInstallment.each {installment->
//            if(installment.instalments){
//                installment.instalments.each{
//                    installment.instalmentPayments.each {installmentPay->
//                        amountPaid+=installmentPay.amountPaid
//                    }
//                }
//            }
            installment.instalmentPayments.each {installmentPay->
                amountPaid+=installmentPay.amountPaid
            }
        }
        return amountPaid
    }

    def getInstallDebit(){
        def installment = Instalment.get(new Long(params.id))
        render installment.amountPayable - getValuePaid(Instalment.findAllByOwnerAndStatus(installment,'Pago'))
    }

    def loans (){
        render params.status?Loan.findAllByStatus(params.status.toString()).size():Loan.count()
    }

    def filter(){
        def loanList = Loan.findAllByStatus(params.status.toString()).sort{it.dateCreated}.reverse()
        render(template: 'table',model: [loanList:loanList])
    }

    def getFile(){
//        def file = resource(dir: '',file: '',)
    }

    @Secured('permitAll')
    def getBytes(file) {

        def bytes = file.length()
        if (bytes == 0){
            return  '0 Bytes'
        }else{
            def k = 1024;
            def sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB']

            def i = Math.floor(Math.log(bytes) / Math.log(k))
            return  (round(bytes / Math.pow(k, i), 2)) + ' ' + sizes.get((int) i)
        }
    }

    private static double round(double value, int places) {
        if (places < 0) throw new IllegalArgumentException()

        long factor = (long) Math.pow(10, places)
        value = value * factor
        long tmp = Math.round(value)
        return (double) tmp / factor
    }

    ResourceLocator grailsResourceLocator // injected during initialization


    def getImage() {
//        def resource = this.class.classLoader.getResource('conf.json')
        def resource = grailsResourceLocator.findResourceForURI('/Macuvele/batman.jpg')
        def path = resource.file.path // absolute file path
        def inputStream = resource.inputStream // input stream for the file
        println('path: '+path+'  stream: '+inputStream)

        render file: resource.file.bytes, contentType: 'image/jpg'
    }

    class Receipt{
        String logo,info,num,client,date,entity
        String tab_num,tab_method,tab_reference,tab_value
        String sub_total, iva_percent, iva_value,total
    }

    def generateReceipt(){

//        def installmentPayment = payment.instalmentPayments
        def installmentPayment = InstalmentPayment.all
        def receiptList = new ArrayList<Receipt>()
        def i = 0
        installmentPayment.each { it->
            def receipt = new Receipt()
            receipt.setTab_num(((InstalmentPayment)it).id.toString())
            receipt.setTab_method(((InstalmentPayment)it).paymentMothod.name)
            receipt.setTab_reference('0000'+i)
            receipt.setTab_value(((InstalmentPayment)it).amountPaid.toString())

            receiptList.add(receipt)
        }

        println('Size: '+receiptList.size())

        def beanTable = new JRBeanCollectionDataSource(receiptList)
        def mapTable = new HashMap<String,Object>()
        mapTable.put('receiptDataSource',beanTable)

//        String info,num,client,date,entity

        def receiptList0 = new ArrayList<Receipt>()
        def receipt0 = new Receipt()
        def logo = grailsResourceLocator.findResourceForURI('/jasper/receipt.jasper').file.toString()

        receipt0.setLogo(logo)
        receipt0.setInfo('<h1>Organization Name<h1><p>Junior Macuvele<p>')
        receipt0.setNum('00001')
        receipt0.setClient('Fader Azevedo Macuvele')
        receipt0.setDate('20-12-2020')
        receipt0.setEntity('Nome da organization')

//        String sub_total, iva_percent, iva_value,total

        receipt0.setSub_total('18.000,00')
        receipt0.setIva_percent('12')
        receipt0.setIva_value('100')
        receipt0.setTotal('20.000,00')
        receiptList0.add(receipt0)

        def beanActivity0 = new JRBeanCollectionDataSource(receiptList0)

//        def receiptJasper = grailsResourceLocator.findResourceForURI('/jasper/receipt.jasper').file
//        def receiptJasper = new File('D:/receipt.jasper').toString()
        def destiny = 'D:/recibo.pdf'
//        println('Bytes: '+getBytes(receiptJasper))

//        def jasperPrint = JasperFillManager.fillReport(new File('D:/receipt.jasper').toString(), mapTable, beanActivity0)
        def jasperPrint = JasperFillManager.fillReport(new File('D:/receipt.jasper').toString(), null, beanTable)
        JasperExportManager.exportReportToPdfStream(jasperPrint, new FileOutputStream(new File(destiny)))
    }
}
