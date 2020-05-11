package smc


import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

@Secured('ROLE_ADMIN')
class DistrictController {

    DistrictService districtService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        respond districtService.list(params), model:[districtCount: districtService.count()]
    }

    def show(Long id) {
        respond districtService.get(id)
    }

    def create() {
        respond new District(params)
    }

    def save(District district) {
        if (district == null) {
            notFound()
            return
        }

        try {
            districtService.save(district)
        } catch (ValidationException e) {
            respond district.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'district.label', default: 'District'), district.id])
                redirect district
            }
            '*' { respond district, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond districtService.get(id)
    }

    def update(District district) {
        if (district == null) {
            notFound()
            return
        }

        try {
            districtService.save(district)
        } catch (ValidationException e) {
            respond district.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'district.label', default: 'District'), district.id])
                redirect district
            }
            '*'{ respond district, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        districtService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'district.label', default: 'District'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'district.label', default: 'District'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
