package smc


import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

@Secured('ROLE_ADMIN')
class InstalmentController {

    InstalmentService instalmentService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        respond instalmentService.list(params), model:[instalmentCount: instalmentService.count()]
    }

    def show(Long id) {
        respond instalmentService.get(id)
    }

    def create() {
        respond new Instalment(params)
    }

    def save(Instalment instalment) {
        if (instalment == null) {
            notFound()
            return
        }

        try {
            instalmentService.save(instalment)
        } catch (ValidationException e) {
            respond instalment.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'instalment.label', default: 'Instalment'), instalment.id])
                redirect instalment
            }
            '*' { respond instalment, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond instalmentService.get(id)
    }

    def update(Instalment instalment) {
        if (instalment == null) {
            notFound()
            return
        }

        try {
            instalmentService.save(instalment)
        } catch (ValidationException e) {
            respond instalment.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'instalment.label', default: 'Instalment'), instalment.id])
                redirect instalment
            }
            '*'{ respond instalment, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        instalmentService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'instalment.label', default: 'Instalment'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'instalment.label', default: 'Instalment'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
