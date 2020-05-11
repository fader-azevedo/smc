package smc


import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

@Secured('ROLE_ADMIN')
class LoanGuaranteeController {

    LoanGuaranteeService loanGuaranteeService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        respond loanGuaranteeService.list(params), model:[loanGuaranteeCount: loanGuaranteeService.count()]
    }

    def show(Long id) {
        respond loanGuaranteeService.get(id)
    }

    def create() {
        respond new LoanGuarantee(params)
    }

    def save(LoanGuarantee loanGuarantee) {
        if (loanGuarantee == null) {
            notFound()
            return
        }

        try {
            loanGuaranteeService.save(loanGuarantee)
        } catch (ValidationException e) {
            respond loanGuarantee.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'loanGuarantee.label', default: 'LoanGuarantee'), loanGuarantee.id])
                redirect loanGuarantee
            }
            '*' { respond loanGuarantee, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond loanGuaranteeService.get(id)
    }

    def update(LoanGuarantee loanGuarantee) {
        if (loanGuarantee == null) {
            notFound()
            return
        }

        try {
            loanGuaranteeService.save(loanGuarantee)
        } catch (ValidationException e) {
            respond loanGuarantee.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'loanGuarantee.label', default: 'LoanGuarantee'), loanGuarantee.id])
                redirect loanGuarantee
            }
            '*'{ respond loanGuarantee, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        loanGuaranteeService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'loanGuarantee.label', default: 'LoanGuarantee'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'loanGuarantee.label', default: 'LoanGuarantee'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
