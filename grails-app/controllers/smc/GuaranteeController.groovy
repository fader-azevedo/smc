package smc


import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

@Secured('ROLE_ADMIN')
class GuaranteeController {

    GuaranteeService guaranteeService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        respond guaranteeService.list(params), model:[guaranteeCount: guaranteeService.count()]
    }

    def show(Long id) {
        respond guaranteeService.get(id)
    }

    def create() {
        respond new Guarantee(params)
    }

    def save(Guarantee guarantee) {
        if (guarantee == null) {
            notFound()
            return
        }

        try {
            guaranteeService.save(guarantee)
        } catch (ValidationException e) {
            respond guarantee.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'guarantee.label', default: 'Guarantee'), guarantee.id])
                redirect guarantee
            }
            '*' { respond guarantee, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond guaranteeService.get(id)
    }

    def update(Guarantee guarantee) {
        if (guarantee == null) {
            notFound()
            return
        }

        try {
            guaranteeService.save(guarantee)
        } catch (ValidationException e) {
            respond guarantee.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'guarantee.label', default: 'Guarantee'), guarantee.id])
                redirect guarantee
            }
            '*'{ respond guarantee, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        guaranteeService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'guarantee.label', default: 'Guarantee'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'guarantee.label', default: 'Guarantee'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
