package smc

import auth.User
import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException
import net.sf.jasperreports.engine.JasperExportManager
import net.sf.jasperreports.engine.JasperFillManager
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource

import java.text.DecimalFormat

@Secured('ROLE_ADMIN')
class LoanController {

    LoanService loanService
    def grailsResourceLocator
    def springSecurityService
    def dashboard = new DashboardController()
    def settings = Settings.all.first()
    def clientController = new ClientController()
    def static pdfContract = ''

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index() {
        dashboard.disableSessions()
        model:
        [loanCount: loanService.count(), loanList: Loan.findAllByStatus('aberto').sort { it.dateCreated }.reverse()]
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
        loan.setCode(dashboard.codeGenerator(Loan))
        def signatureDate = new Date().parse("dd/MM/yyy", params.signatureDate_.toString())
        def payDate = new Date().parse("dd/MM/yyy", params.payDate_.toString())
        def dueDate = new Date().parse("dd/MM/yyy", params.dueDate_.toString())
        loan.setSignatureDate(signatureDate)
        loan.setPayDate(payDate)
        loan.setDueDate(dueDate)
        loan.setInstalments(generateInstalments(loan) as Set<Instalment>)

        try {
            if (loanService.save(loan)) {
                println('loan saved')
                generateGuarantees().each {
                    it.save()
                    new LoanGuarantee(code: '000', loan: loan, guarantee: it, latitude: 0, longitude: 0, observation: '',
                            updatedBy: loan.updatedBy, createdBy: loan.createdBy
                    ).save()
                }

                setLoanDir(loan)
                getLoanValues(loan) // to generate pdf contract
            }
        } catch (ValidationException ignored) {
            render([status: 'error', message: loan.errors] as JSON)
        }
    }

    private void setLoanDir(loan) {
        def client = ((Loan) loan).client
        def clientLoan = client.loans.size() + ' Emprestimo'

        def dir = settings.root + '/' + settings.loans + '/' + clientController.getDir(client) + '/' + clientLoan
        if (!new File(dir).isDirectory()) {
            new File(dir).mkdirs()
            loan.setDirectory(clientLoan)
            loanService.save(loan)
        }
    }

    def getLoanDir(loan) {
        def dir = clientController.getDir(loan.client) + '/'.concat(loan.directory)
        if (!new File(dir).isDirectory()) {
            new File(dir).mkdirs()
        }
        return dir
    }

    def getLoanValues(loan) {
        def borrowedAmountInFull = dashboard.numberToInFull(loan.borrowedAmount.toString())
        def amountPayableInFull = dashboard.numberToInFull(loan.amountPayable.toString())
        render([status     : 'ok',
                valorPedido: String.format('%,.2f', loan.borrowedAmount) + ' (' + borrowedAmountInFull + ')',
                valorApagar: String.format('%,.2f', loan.amountPayable) + ' (' + amountPayableInFull + ')',
                loan       : loan.id,
                garantias  : 'As garantias sao:'
        ] as JSON) // to generate contract
    }

    def getLoanValuesToPdf(){
        def loan = Loan.get(new Long(params.id))
        getLoanValues(loan)
    }

    def deFr = new DecimalFormat('#.00')

    //instalments begin
    def jumpSunday(def date) {
        Calendar calendar = Calendar.getInstance()
        calendar.setTime(date)
        (calendar.get(Calendar.DAY_OF_WEEK) == 1) ? Date.parse("yyyy-MM-dd", (date + 1).format("yyyy-MM-dd")) : date
    }

    def generateInstalments(loan) {
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
        for (def i = 1; i <= loan.getInstalmentsNumber(); i++) {
            def installment = new Instalment()
            installment.setLoan(loan)
            installment.setType(InstalmentType.findByName('Renda Normal'))
            installment.setAmountPayable(new Double(params.amountPerInstalment))
            installment.setCreatedBy((User) springSecurityService.currentUser)
            installment.setUpdatedBy((User) springSecurityService.currentUser)
            installment.setCode(loan.getCode() + i)

            if (i == 1) {
                installment.setDueDate(loan.payDate)
            } else {
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
    //instalments end

    //guarantee begin
    def generateGuarantees() {
        def check = params.guarantee_check
        def guaranteeList = new ArrayList<Guarantee>()
        if (check) {
            def guaranteeType = params.guaranteeType
            def description = params.description
            if (description instanceof String) {
                guaranteeList.add(createGuarantee(guaranteeType, description))
            } else {
                def counter = 0
                description.each {
                    guaranteeList.add(createGuarantee(guaranteeType[counter], it))
                    counter += 1
                }
            }
        }
        return guaranteeList
    }

    def createGuarantee(type, description) {
        def guaranteeType = GuaranteeType.findOrSaveWhere(name: type)
        return new Guarantee(type: guaranteeType, description: description, image: 'image')
    }
    //guarantee end

    def getDetails() {
        def loan = Loan.get(new Long(params.id))
        def instPayed = Instalment.findAllByLoanAndStatus(loan, 'Pago').size()
        def instPend = Instalment.findAllByLoanAndStatus(loan, 'Pendente').size()
        def instAll = Instalment.findAllByLoan(loan).size()

        def valuePaid = getValuePaid(Instalment.findAllByLoanAndStatus(loan, 'Pago'))

        def debit = loan.amountPayable - valuePaid
        render([
                loan     : loan, client: loan.client, instPayed: instPayed,
                instPend : instPend, instAll: instAll, valuePaid: valuePaid, debit: debit, createdBy: loan.createdBy.fullName,
                updatedBy: loan.updatedBy.fullName, instalmentType: loan.paymentMode.name
        ] as JSON)
    }

    def totalPaid() {
        def loan = Loan.get(params.id)
        def valuePaid = getValuePaid(Instalment.findAllByLoanAndStatus(loan, 'Pago'))

        render(valuePaid)
    }

    def static getValuePaid(paidInstallment) {
        def amountPaid = 0.0
        paidInstallment.each { installment ->
            installment.instalmentPayments.each { installmentPay ->
                amountPaid += installmentPay.amountPaid
            }
        }
        return amountPaid
    }

    def getInstallDebit() {
        def installment = Instalment.get(new Long(params.id))
        render installment.amountPayable - getValuePaid(Instalment.findAllByOwnerAndStatus(installment, 'Pago'))
    }

    def loans() {
        render params.status ? Loan.findAllByStatus(params.status.toString()).size() : Loan.count()
    }

    def filter() {
        def status = params.status
        def client = params.client
        def loanList = Loan.createCriteria().list {
            if (status) {
                eq('status', status)
            }
            if (client) {
                eq('client', Client.get(new Long(client)))
            }
            order('dateCreated', 'desc')
        } as List<Loan>
        render(template: 'table', model: [loanList: loanList])
    }

//  contract generator begin
    class Contract {
        String logo, info, details, lender, client, date, user, signatureDate
    }

    def generateContract() {

        def loan = Loan.get(new Long(params.loan))
        def destiny = getLoanDir(loan).concat('/contract.pdf')

        if (!new File(destiny).isFile()) {

            def contract = new Contract()
            def details = params.details.toString()
            def client = loan.client
            def logo = grailsResourceLocator.findResourceForURI('/logo.jpg').file.toString()

            contract.setInfo(settings.contractHeader)
            contract.setLogo(logo)
            contract.setDetails(details)
            contract.setUser(((User) springSecurityService.currentUser).fullName)
            contract.setLender(settings.lender)
            contract.setClient(client.fullName)
            contract.setSignatureDate(DashboardController.formatDateWithMonthName(loan.signatureDate))
            contract.setDate(DashboardController.formatDateTime(new Date()))

            def contractList = new ArrayList<Contract>()
            contractList.add(contract)

            def contractCollection = new JRBeanCollectionDataSource(contractList)

            def contractJasper = grailsResourceLocator.findResourceForURI('/jasper/contract.jasper').file.toString()
            println('contract generated ' + destiny)

            def jasperPrint = JasperFillManager.fillReport(contractJasper, null, contractCollection)
            JasperExportManager.exportReportToPdfStream(jasperPrint, new FileOutputStream(new File(destiny)))
        }

        pdfContract = destiny
        render([status: 'ok'] as JSON)
    }

    def contract() {
        render(file: pdfContract, contentType: 'application/pdf')
    }
    //  contract generator end
}
