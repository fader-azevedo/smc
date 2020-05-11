package smc

class Payment extends Parameter{

    String receipt
    double totalPaid
    static belongsTo = [paymentMothod:PaymentMethod]
    static hasMany = [instalmentPayments:InstalmentPayment]

    static constraints = {
        receipt nullable: true
        totalPaid min: new Double(0)
    }

    static mapping = {
        version false
    }
}
