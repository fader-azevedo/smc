package smc

class Settings {

    int ano
    String root
    String logo
    String loans
    String contract
    String contractHeader
    //institution info
    String lender
    String name
    String slogan
    String cellPhone
    String cellPhone2
    String email
    String nuit
    String address
    String language
    //loans politics
    boolean sundays = true //jump sundays
    //app settings
    String sidebar

    static constraints = {
        ano unique: true
        sidebar nullable: true
        slogan nullable: true
        cellPhone2 nullable: true
        email nullable: true
        language nullable: true
        contract nullable: true
        nuit nullable: true
    }

    static mapping = {
        version false
        contract type: 'text'
        contractHeader type: 'text'
    }
}