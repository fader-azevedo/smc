package smc

class Guarantee {

    String description
    String image

    static belongsTo = [type:GuaranteeType]
    static hasMany = [loanGuarantees:LoanGuarantee]

    static constraints = {
        image nullable: true
    }

    static mapping = {
        description type: 'text'
    }
}
