package smc


import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

@Secured('ROLE_ADMIN')
class GuaranteeTypeController {

    GuaranteeTypeService guaranteeTypeService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        respond guaranteeTypeService.list(params), model:[guaranteeTypeCount: guaranteeTypeService.count()]
    }

    def show(Long id) {
        respond guaranteeTypeService.get(id)
    }

    def create() {
        respond new GuaranteeType(params)
    }

    def save(GuaranteeType guaranteeType) {
        if (guaranteeType == null) {
            notFound()
            return
        }

        try {
            guaranteeTypeService.save(guaranteeType)
        } catch (ValidationException e) {
            respond guaranteeType.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'guaranteeType.label', default: 'GuaranteeType'), guaranteeType.id])
                redirect guaranteeType
            }
            '*' { respond guaranteeType, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond guaranteeTypeService.get(id)
    }

    def update(GuaranteeType guaranteeType) {
        if (guaranteeType == null) {
            notFound()
            return
        }

        try {
            guaranteeTypeService.save(guaranteeType)
        } catch (ValidationException e) {
            respond guaranteeType.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'guaranteeType.label', default: 'GuaranteeType'), guaranteeType.id])
                redirect guaranteeType
            }
            '*'{ respond guaranteeType, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        guaranteeTypeService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'guaranteeType.label', default: 'GuaranteeType'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'guaranteeType.label', default: 'GuaranteeType'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
