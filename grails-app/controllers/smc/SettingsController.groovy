package smc

import auth.User
import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException
import net.sf.jasperreports.engine.JasperExportManager
import net.sf.jasperreports.engine.JasperFillManager
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource

@Secured('ROLE_ADMIN')
class SettingsController {

    def grailsResourceLocator
    SettingsService settingsService
    def settings = Settings.all.first()
    def springSecurityService

    def index(Integer max) {
        respond settingsService.list(params), model:[settingsCount: settingsService.count()]
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

    class Contract{
        String logo,info,details,lender,client,date,user,signatureDate
    }

    def generateContract() {
        def header = params.header.toString()
        def details = params.details.toString()
        def logo = grailsResourceLocator.findResourceForURI('/logo.jpg').file.toString()

        def contract = new Contract()
        contract.setInfo(header)
        contract.setLogo(logo)
        contract.setDetails(details)
        contract.setDate(DashboardController.formatDateTime(new Date()))
        contract.setUser(((User)springSecurityService.currentUser).fullName)
        contract.setLender(settings.lender)
        contract.setClient('Nome do cliente')
        contract.setSignatureDate(DashboardController.formatDateWithMonthName(new Date()))

        def contractList = new ArrayList<Contract>()
        contractList.add(contract)

        def contractCollection = new JRBeanCollectionDataSource(contractList)

        def contractJasper = grailsResourceLocator.findResourceForURI('/jasper/contract.jasper').file.toString()
        def destiny = settings.root.concat('/contract.pdf')

        def jasperPrint = JasperFillManager.fillReport(contractJasper, null, contractCollection)
        JasperExportManager.exportReportToPdfStream(jasperPrint, new FileOutputStream(new File(destiny)))

        render('')
    }
}
