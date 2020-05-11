package smc

class PaymentMode {

    String name

    static hasMany = [loans:Loan]

    static constraints = {
        name unique: true
    }

    static mapping = {
        version false
    }

    @Override
    String toString() {
        return name
    }
}
