package smc

import auth.Role
import auth.User
import auth.UserRole
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
        respond new Client(params)
    }

    def save(Client client) {
        def code = dashboard.codeGenerator(Client)
        def user = new User(fullName: params.fullName,username: params.fullName.toString().trim().replace(' ',''),password: code)
        client.setCreatedBy((User) springSecurityService.currentUser)
        client.setUpdatedBy((User) springSecurityService.currentUser)
        client.setCode(code)
        client.setUser(user)
        try {
            if (clientService.save(client)) {
                println('client and user related (saved)')
                if(new UserRole(user: user, role: Role.findByAuthority('ROLE_CLIENT')).save()){
                    println('user granted role client')
                }
                new File(settings.root + '/' + settings.loans + '/' + DashboardController.removeAccents(client.user.fullName.trim()) + '-' + client.code).mkdirs()
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
        def dir = settings.root + '/' + settings.loans + '/' + DashboardController.removeAccents(((Client) client).user.fullName.trim()) + '-' + ((Client) client).code

        if (!new File(dir).isDirectory()) {
            new File(dir).mkdirs()
        }
        return dir
    }
}
