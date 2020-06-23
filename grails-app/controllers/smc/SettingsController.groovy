package smc

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException

@Secured('ROLE_ADMIN')
class SettingsController {

    def grailsResourceLocator
    SettingsService settingsService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        respond settingsService.list(params), model:[settingsCount: settingsService.count()]
    }
    def create() {
        respond new Settings(params)
    }

    def save(Settings settings) {
        try {
            settingsService.save(settings)
        } catch (ValidationException e) {
            respond settings.errors, view:'create'
            return
        }

        redirect(create())
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
