package smc

class LoanGuarantee extends Parameter{

    String observation
    String status = 'Activo'
    double latitude = 0
    double longitude = 0

    static belongsTo = [loan:Loan, guarantee:Guarantee]
    static constraints = {
        status inList: ['Activo','Inactivo','Penhorado']
        observation nullable: true
        code nullable: true
    }

    static mapping = {
        observation type: 'text'
    }
}
