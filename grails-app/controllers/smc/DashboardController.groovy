package smc

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured
import org.grails.web.json.JSONArray
import org.grails.web.json.JSONObject

import java.text.SimpleDateFormat

@Secured(['ROLE_ADMIN','ROLE_USER','ROLE_CLIENT'])
class DashboardController {

    SettingsService settingsService
    def sdfMes = new SimpleDateFormat('MM')
    def sdfAno = new SimpleDateFormat('YYYY')
    def monthsInt = ['01','02','03','04','05','06','07','08','09','10','11','12']
    def months = ['Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho','Julho','Agosto','Setembro','Outubro','Novembro','Dezembro']

    def index() {
        disableSessions()
        render view: 'index'
    }

    def private static getBar(String month, int a, int b, int c){
        def bar = new JSONObject()
        bar.put("m", month)
        bar.put("a", a)
        bar.put("b", b)
        bar.put("c", c)
        return bar
    }

    def private static line(String month, int value){
        def line = new JSONObject()
        line.put("month", month)
        line.put("value", value)
        return line
    }

    def barChart(){
        def values = new JSONArray()
        def ano = params.ano.toString()
        for(String mes: monthsInt){
            def indexMonth = new Integer(mes)-1
            def month = months.get(indexMonth)
            def a = 0
            def b = 0
            def c = 0
            Loan.list().each {loan->
                if(mes.equalsIgnoreCase(sdfMes.format(loan.signatureDate) .toString()) && sdfAno.format(loan.signatureDate).toString() == ano){

                    if(loan.status.equalsIgnoreCase('aberto')){
                        a+=1
                    }
                    if(loan.status.equalsIgnoreCase('vencido')){
                        b+=1
                    }
                    if(loan.status.equalsIgnoreCase('fechado')){
                        c+=1
                    }
                }
            }
            values.put(getBar(month,a,b,c))
        }
        render values as JSON
    }
    def lineChart(){
        def values = new JSONArray()
        def ano = params.ano.toString()
        for(String mes: monthsInt){
            def indexMonth = new Integer(mes)-1
            def month = months.get(indexMonth)
            def value = 0
            Loan.list().each {loan->
                if(mes.equalsIgnoreCase(sdfMes.format(loan.signatureDate) .toString()) && sdfAno.format(loan.signatureDate).toString() == ano){
                    value+=1
                }
            }
            values.put(line(month,value))
        }
        render values as JSON
    }

    def sidebar(){
        def settings = Settings.all.first()
        settings.setSidebar(params.sidebar.toString())
        settingsService.save(settings)
        render('updated')
    }

    def getSidebar(){
        render(Settings.all.first().sidebar)
    }

    def disableSessions(){
        session.setAttribute('loanID',null)
    }
}
