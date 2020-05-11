package smc


import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

@Secured('ROLE_ADMIN')
class InstalmentTypeController {

    InstalmentTypeService instalmentTypeService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        respond instalmentTypeService.list(params), model:[instalmentTypeCount: instalmentTypeService.count()]
    }

    def show(Long id) {
        respond instalmentTypeService.get(id)
    }

    def create() {
        respond new InstalmentType(params)
    }

    def save(InstalmentType instalmentType) {
        if (instalmentType == null) {
            notFound()
            return
        }

        try {
            instalmentTypeService.save(instalmentType)
        } catch (ValidationException e) {
            respond instalmentType.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'instalmentType.label', default: 'InstalmentType'), instalmentType.id])
                redirect instalmentType
            }
            '*' { respond instalmentType, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond instalmentTypeService.get(id)
    }

    def update(InstalmentType instalmentType) {
        if (instalmentType == null) {
            notFound()
            return
        }

        try {
            instalmentTypeService.save(instalmentType)
        } catch (ValidationException e) {
            respond instalmentType.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'instalmentType.label', default: 'InstalmentType'), instalmentType.id])
                redirect instalmentType
            }
            '*'{ respond instalmentType, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        instalmentTypeService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'instalmentType.label', default: 'InstalmentType'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'instalmentType.label', default: 'InstalmentType'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
