package smc


import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

@Secured('ROLE_ADMIN')
class GuarantorController {

    GuarantorService guarantorService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        respond guarantorService.list(params), model:[guarantorCount: guarantorService.count()]
    }

    def show(Long id) {
        respond guarantorService.get(id)
    }

    def create() {
        respond new Guarantor(params)
    }

    def save(Guarantor guarantor) {
        if (guarantor == null) {
            notFound()
            return
        }

        try {
            guarantorService.save(guarantor)
        } catch (ValidationException e) {
            respond guarantor.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'guarantor.label', default: 'Guarantor'), guarantor.id])
                redirect guarantor
            }
            '*' { respond guarantor, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond guarantorService.get(id)
    }

    def update(Guarantor guarantor) {
        if (guarantor == null) {
            notFound()
            return
        }

        try {
            guarantorService.save(guarantor)
        } catch (ValidationException e) {
            respond guarantor.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'guarantor.label', default: 'Guarantor'), guarantor.id])
                redirect guarantor
            }
            '*'{ respond guarantor, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        guarantorService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'guarantor.label', default: 'Guarantor'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'guarantor.label', default: 'Guarantor'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
