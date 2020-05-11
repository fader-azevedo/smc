package smc


import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

@Secured('ROLE_ADMIN')
class PaymentModeController {

    PaymentModeService paymentModeService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        respond paymentModeService.list(params), model:[paymentModeCount: paymentModeService.count()]
    }

    def show(Long id) {
        respond paymentModeService.get(id)
    }

    def create() {
        respond new PaymentMode(params)
    }

    def save(PaymentMode paymentMode) {
        if (paymentMode == null) {
            notFound()
            return
        }

        try {
            paymentModeService.save(paymentMode)
        } catch (ValidationException e) {
            respond paymentMode.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'paymentMode.label', default: 'PaymentMode'), paymentMode.id])
                redirect paymentMode
            }
            '*' { respond paymentMode, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond paymentModeService.get(id)
    }

    def update(PaymentMode paymentMode) {
        if (paymentMode == null) {
            notFound()
            return
        }

        try {
            paymentModeService.save(paymentMode)
        } catch (ValidationException e) {
            respond paymentMode.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'paymentMode.label', default: 'PaymentMode'), paymentMode.id])
                redirect paymentMode
            }
            '*'{ respond paymentMode, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        paymentModeService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'paymentMode.label', default: 'PaymentMode'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'paymentMode.label', default: 'PaymentMode'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
