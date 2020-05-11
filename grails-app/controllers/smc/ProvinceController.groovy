package smc


import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

@Secured('ROLE_ADMIN')
class ProvinceController {

    ProvinceService provinceService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        respond provinceService.list(params), model:[provinceCount: provinceService.count()]
    }

    def show(Long id) {
        respond provinceService.get(id)
    }

    def create() {
        respond new Province(params)
    }

    def save(Province province) {
        if (province == null) {
            notFound()
            return
        }

        try {
            provinceService.save(province)
        } catch (ValidationException e) {
            respond province.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'province.label', default: 'Province'), province.id])
                redirect province
            }
            '*' { respond province, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond provinceService.get(id)
    }

    def update(Province province) {
        if (province == null) {
            notFound()
            return
        }

        try {
            provinceService.save(province)
        } catch (ValidationException e) {
            respond province.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'province.label', default: 'Province'), province.id])
                redirect province
            }
            '*'{ respond province, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        provinceService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'province.label', default: 'Province'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'province.label', default: 'Province'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
