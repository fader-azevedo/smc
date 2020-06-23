package smc

class Guarantor {

    static belongsTo = [client:Client,loan:Loan]

    static constraints = {

    }

    static mapping = {
        version false
    }
}
