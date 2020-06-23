package smc

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException
import org.grails.core.io.ResourceLocator

import java.text.Normalizer

import static org.springframework.http.HttpStatus.*

@Secured('ROLE_ADMIN')
class SettingsController {

    def grailsResourceLocator
    SettingsService settingsService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        respond settingsService.list(params), model:[settingsCount: settingsService.count()]
    }

    def show(Long id) {
        respond settingsService.get(id)
    }

    def create() {
        respond new Settings(params)
    }

    def save(Settings settings) {
        if (settings == null) {
            notFound()
            return
        }

        try {
            settingsService.save(settings)
        } catch (ValidationException e) {
            respond settings.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'settings.label', default: 'Settings'), settings.id])
                redirect settings
            }
            '*' { respond settings, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond settingsService.get(id)
    }

    def update(Settings settings) {
        if (settings == null) {
            notFound()
            return
        }

        try {
            settingsService.save(settings)
        } catch (ValidationException e) {
            respond settings.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'settings.label', default: 'Settings'), settings.id])
                redirect settings
            }
            '*'{ respond settings, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        settingsService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'settings.label', default: 'Settings'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'settings.label', default: 'Settings'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

    def getLogo() {
        def resource = grailsResourceLocator.findResourceForURI('/logo.jpg')
        render file: resource.file.bytes, contentType: 'image/jpg'
    }

    def updateItem(){
        def attr = params.attr.toString().trim()
        def value = params.value

        def settings = Settings.all.first()
        settings.setProperty(attr,value)
        if(settingsService.save(settings)){
            render([status: 'ok',message:'saved'] as JSON)
        }else{
            render([status: 'error',message:' not saved '.concat(settings.errors.toString())] as JSON)
        }
    }
}
