package smc

class PaymentMethod {
    String name

    static hasMany = [payments:Payment]
    static constraints = {
        name unique: true
    }

    static mapping = {
        version false
    }
}
