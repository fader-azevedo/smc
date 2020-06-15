package smc

class Payment extends Parameter{

    String receipt
    double totalPaid
    static hasMany = [instalmentPayments:InstalmentPayment]
    static belongsTo = [loan:Loan]

    static constraints = {
        receipt nullable: true
        totalPaid min: new Double(0)
    }

    static mapping = {
        version false
    }
}
