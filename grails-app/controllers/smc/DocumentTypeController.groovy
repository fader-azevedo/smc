package smc


import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

@Secured('ROLE_ADMIN')
class DocumentTypeController {

    DocumentTypeService documentTypeService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        respond documentTypeService.list(params), model:[documentTypeCount: documentTypeService.count()]
    }

    def show(Long id) {
        respond documentTypeService.get(id)
    }

    def create() {
        respond new DocumentType(params)
    }

    def save(DocumentType documentType) {
        if (documentType == null) {
            notFound()
            return
        }

        try {
            documentTypeService.save(documentType)
        } catch (ValidationException e) {
            respond documentType.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'documentType.label', default: 'DocumentType'), documentType.id])
                redirect documentType
            }
            '*' { respond documentType, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond documentTypeService.get(id)
    }

    def update(DocumentType documentType) {
        if (documentType == null) {
            notFound()
            return
        }

        try {
            documentTypeService.save(documentType)
        } catch (ValidationException e) {
            respond documentType.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'documentType.label', default: 'DocumentType'), documentType.id])
                redirect documentType
            }
            '*'{ respond documentType, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        documentTypeService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'documentType.label', default: 'DocumentType'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'documentType.label', default: 'DocumentType'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
