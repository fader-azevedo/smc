package smc


import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

@Secured('ROLE_ADMIN')
class PaymentMethodController {

    PaymentMethodService paymentMethodService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        respond paymentMethodService.list(params), model:[paymentMethodCount: paymentMethodService.count()]
    }

    def show(Long id) {
        respond paymentMethodService.get(id)
    }

    def create() {
        respond new PaymentMethod(params)
    }

    def save(PaymentMethod paymentMethod) {
        if (paymentMethod == null) {
            notFound()
            return
        }

        try {
            paymentMethodService.save(paymentMethod)
        } catch (ValidationException e) {
            respond paymentMethod.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'paymentMethod.label', default: 'PaymentMethod'), paymentMethod.id])
                redirect paymentMethod
            }
            '*' { respond paymentMethod, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond paymentMethodService.get(id)
    }

    def update(PaymentMethod paymentMethod) {
        if (paymentMethod == null) {
            notFound()
            return
        }

        try {
            paymentMethodService.save(paymentMethod)
        } catch (ValidationException e) {
            respond paymentMethod.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'paymentMethod.label', default: 'PaymentMethod'), paymentMethod.id])
                redirect paymentMethod
            }
            '*'{ respond paymentMethod, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        paymentMethodService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'paymentMethod.label', default: 'PaymentMethod'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'paymentMethod.label', default: 'PaymentMethod'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
