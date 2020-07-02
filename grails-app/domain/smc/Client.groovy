package smc

import auth.User

class Client extends Parameter{

    String image
    String contact
    String contact2
    String email
    String address

    String docNumber
    Date docEmissionDate
    Date docDueDate

    static belongsTo = [user:User,documentType:DocumentType,district:District]
    static hasMany = [loans:Loan, loanguarantors:Loan]

    static constraints = {
        contact maxSize: 15
        contact2 nullable: true, maxSize: 15
        email nullable: true
        image nullable: true
        user nullable: false, blank: false, unique: true
    }

    @Override
    String toString() {
        return user?.fullName
    }
}