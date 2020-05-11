package smc

class Instalment extends Parameter{

    String status = 'Pendente'
    Date dueDate
    double amountPayable

    static belongsTo = [loan:Loan, type: InstalmentType, owner:Instalment]
    static hasMany = [instalments:Instalment, instalmentPayments:InstalmentPayment]

    static constraints = {
        status inList: ['Pendente','Pago','Validado']
        owner nullable: true
        amountPayable min:  new Double(0)
    }
}
