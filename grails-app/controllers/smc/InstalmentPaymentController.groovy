package smc


import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

@Secured('ROLE_ADMIN')
class InstalmentPaymentController {

    InstalmentPaymentService instalmentPaymentService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        respond instalmentPaymentService.list(params), model:[instalmentPaymentCount: instalmentPaymentService.count()]
    }

    def show(Long id) {
        respond instalmentPaymentService.get(id)
    }

    def create() {
        respond new InstalmentPayment(params)
    }

    def save(InstalmentPayment instalmentPayment) {
        if (instalmentPayment == null) {
            notFound()
            return
        }

        try {
            instalmentPaymentService.save(instalmentPayment)
        } catch (ValidationException e) {
            respond instalmentPayment.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'instalmentPayment.label', default: 'InstalmentPayment'), instalmentPayment.id])
                redirect instalmentPayment
            }
            '*' { respond instalmentPayment, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond instalmentPaymentService.get(id)
    }

    def update(InstalmentPayment instalmentPayment) {
        if (instalmentPayment == null) {
            notFound()
            return
        }

        try {
            instalmentPaymentService.save(instalmentPayment)
        } catch (ValidationException e) {
            respond instalmentPayment.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'instalmentPayment.label', default: 'InstalmentPayment'), instalmentPayment.id])
                redirect instalmentPayment
            }
            '*'{ respond instalmentPayment, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        instalmentPaymentService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'instalmentPayment.label', default: 'InstalmentPayment'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'instalmentPayment.label', default: 'InstalmentPayment'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
