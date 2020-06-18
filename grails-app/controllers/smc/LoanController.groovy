package smc

import auth.User
import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException
import java.text.DecimalFormat

import static org.springframework.http.HttpStatus.*

@Secured('ROLE_ADMIN')
class LoanController {

    LoanService loanService
    def springSecurityService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index() {
        model:[loanCount: loanService.count(),loanList: Loan.findAllByStatus('aberto').sort{it.dateCreated}.reverse()]
    }

    def show(Long id) {
        respond loanService.get(id)
    }

    def create() {
        respond new Loan(params)
    }

    def save(Loan loan) {

        if (loan == null) {
            notFound()
            return
        }
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


    def deFr = new DecimalFormat('#.00')
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
        if (loan == null) {
            notFound()
            return
        }

        try {
            loanService.save(loan)
        } catch (ValidationException e) {
            respond loan.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'loan.label', default: 'Loan'), loan.id])
                redirect loan
            }
            '*'{ respond loan, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        loanService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'loan.label', default: 'Loan'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'loan.label', default: 'Loan'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
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
}
