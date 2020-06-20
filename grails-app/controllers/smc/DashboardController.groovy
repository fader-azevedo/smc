package smc

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured
import org.grails.web.json.JSONArray
import org.grails.web.json.JSONObject

import java.text.Normalizer
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

    def codeGenerator(domain){
        def length = domain.count+1.toString().length()
        def code = ''
        for(def i=length; i<5; i++){
            code += '0'
        }
        return code.concat(domain.count+1.toString())
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
//        settingsService.save(settings)
        render('updated')
    }

    def getSidebar(){
//        render(Settings.all.first().sidebar)
        render('')
    }

    def disableSessions(){
        session.setAttribute('loanID',null)
    }

    def static formatDateTime(def data){
        Calendar calendar = Calendar.getInstance()
        calendar.setTime(data)
        def mes = (calendar.get(Calendar.MONTH)+1)
        if(mes.toString().length() == 1){
            mes =0+''+mes
        }
        return calendar.get(Calendar.DAY_OF_MONTH)+'/'+mes+'/'+calendar.get(Calendar.YEAR)+' '+
                calendar.get(Calendar.HOUR_OF_DAY)+':'+calendar.get(Calendar.MINUTE)
    }

    def static removeAccents(String s) {
        return Normalizer.normalize(s, Normalizer.Form.NFD).replaceAll("[\\p{InCombiningDiacriticalMarks}]", "");
    }

    @Secured('permitAll')
    def getBytes(file) {

        def bytes = file.length()
        if (bytes == 0){
            return  '0 Bytes'
        }else{
            def k = 1024;
            def sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB']

            def i = Math.floor(Math.log(bytes) / Math.log(k))
            return  (round(bytes / Math.pow(k, i), 2)) + ' ' + sizes.get((int) i)
        }
    }

    private static double round(double value, int places) {
        if (places < 0) throw new IllegalArgumentException()

        long factor = (long) Math.pow(10, places)
        value = value * factor
        long tmp = Math.round(value)
        return (double) tmp / factor
    }

}
