package smc

class PaymentMethod {
    String name

    static hasMany = [instalmentPayments:InstalmentPayment]
    static constraints = {
        name unique: true
    }

    static mapping = {
        version false
    }
}
