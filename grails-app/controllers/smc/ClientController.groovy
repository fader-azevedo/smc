package smc

import auth.User
import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

@Secured('ROLE_ADMIN')
class ClientController {

    ClientService clientService

    def springSecurityService
    def dashboard = new DashboardController()
    def settings = Settings.all.first()
    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        dashboard.disableSessions()
        respond clientService.list(params), model: [clientCount: clientService.count()]
    }

    def show(Long id) {
        respond clientService.get(id)
    }

    def getInitialChars() {
        def avatar = ''
        params.name.toString().trim().split(' ').each {
            avatar += it[0]
        }
        render(avatar)
    }

    def create() {
        dashboard.disableSessions()
        dashboard.codeGenerator(Client)

        respond new Client(params)
    }

    def save(Client client) {
        client.setCreatedBy((User) springSecurityService.currentUser)
        client.setUpdatedBy((User) springSecurityService.currentUser)
        client.setCode(dashboard.codeGenerator(Loan))
        def birthDate = new Date().parse("dd/MM/yyy",params.birthDate_.toString())
        client.setBirthDate(birthDate)

        client.setCode(dashboard.codeGenerator(Client))

        try {
            if (clientService.save(client)) {
                new File(settings.root + '/' + settings.loans + '/' + DashboardController.removeAccents(client.fullName.trim()) + '_' + client.code).mkdirs()
            }
        } catch (ValidationException ignored) {
            respond client.errors, view: 'create'
            return
        }
        redirect(action: 'show', id: client.id)
    }

    def edit(Long id) {
        respond clientService.get(id)
    }

    def update(Client client) {
        if (client == null) {
            notFound()
            return
        }

        try {
            clientService.save(client)
        } catch (ValidationException ignored) {
            respond client.errors, view: 'edit'
            return
        }
        redirect(action: 'show',id:client.id)
    }

    def delete(Long id) {

    }

    def getClient() {
        render([client: Client.findByFullName(params.name.toString())] as JSON)
    }

    def getDetails() {
        def client = Client.get(new Long(params.id))
        def totalPaid = 0
        def totalBorrowed = 0
        client.loans.each {
            totalPaid += LoanController.getValuePaid(Instalment.findAllByLoanAndStatus(it, 'Pago'))
            totalBorrowed += it.borrowedAmount
        }
        render([loans: client.loans.size(), client: client, totalBorrowed: totalBorrowed, totalPaid: totalPaid,
                createdBy: client.createdBy.fullName, updatedBy: client.updatedBy.fullName
        ] as JSON)
    }

    def clients() {
        render(Client.findAllByEnabled(new Boolean(params.status)).size())
    }

    def getDir(client) {
        def dir = settings.root + '/' + settings.loans + '/' + DashboardController.removeAccents(((Client) client).fullName.trim()) + '_' + ((Client) client).code

        if (!new File(dir).isDirectory()) {
            new File(dir).mkdirs()
        }
        return dir
    }

}
