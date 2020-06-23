package smc

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

@Secured('ROLE_ADMIN')
class ClientController {

    ClientService clientService

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
        if (client == null) {
            notFound()
            return
        }
        client.setCode(dashboard.codeGenerator(Client))

        try {
            if (clientService.save(client)) {
                new File(settings.root + '/' + settings.loans + '/' + DashboardController.removeAccents(client.fullName.trim()) + '_' + client.code).mkdirs()
            }
        } catch (ValidationException e) {
            respond client.errors, view: 'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'client.label', default: 'Client'), client.id])
                redirect client
            }
            '*' { respond client, [status: CREATED] }
        }
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
        } catch (ValidationException e) {
            respond client.errors, view: 'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'client.label', default: 'Client'), client.id])
                redirect client
            }
            '*' { respond client, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        clientService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'client.label', default: 'Client'), id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'client.label', default: 'Client'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
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
        render([loans    : client.loans.size(), client: client, totalBorrowed: totalBorrowed, totalPaid: totalPaid,
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
