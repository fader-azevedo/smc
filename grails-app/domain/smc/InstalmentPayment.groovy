package smc

class InstalmentPayment extends Parameter{

    double amountPaid
    String reference

    static belongsTo = [instalment:Instalment,payment:Payment]
    static constraints = {
        code nullable: true
        reference nullable: true
    }
}
