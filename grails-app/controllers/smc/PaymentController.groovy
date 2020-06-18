package smc

import auth.User
import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException
import groovy.json.JsonSlurper

import static org.springframework.http.HttpStatus.*

@Secured('ROLE_ADMIN')
class PaymentController {

    PaymentService paymentService
    InstalmentService instalmentService
    LoanService loanService
    def springSecurityService
    def dashboard = new DashboardController()

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
        println('ll: '+session.getAttribute('loanClientStatus'))
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

    def save(Payment payment) {
        def loan = Loan.get(new Long(params.loan))
        payment.setCreatedBy((User) springSecurityService.currentUser)
        payment.setUpdatedBy((User) springSecurityService.currentUser)
        payment.setCode(codeGenerator(loan.payments.size()+1))
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
            instalmentPayment.setCode(LoanController.codeGenerator(loan.getPaymentMode().id))
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

        render('saved')
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

    private static codeGenerator(size){

        def length = size.toString().length()
        def code = ''
        for(def i=length; i<5; i++){
            code += '0'
        }
        return (code).concat(size as String)
    }
}
