package smc

class Instalment extends Parameter{

    String status = 'Pendente'
    String type = 'Renda Normal'
    Date dueDate
    double amountPayable

    static belongsTo = [loan:Loan, owner:Instalment]
    static hasMany = [instalments:Instalment, instalmentPayments:InstalmentPayment]

    static constraints = {
        status inList: ['Pendente','Pago','Validado']
        type inList: ['Renda Normal','Parcela','Multa']
        owner nullable: true
        amountPayable min:  new Double(0)
    }
}
