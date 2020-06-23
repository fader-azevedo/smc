package smc

class Settings {

    int ano
    String root
    String logo
    String loans
    //institution info
    String name
    String slogan
    String cellPhone
    String cellPhone2
    String email
    String address
    String language

    //loans politics
    boolean sundays = true //jump sundays


    //app settings
    String sidebar

    static constraints = {
        sidebar nullable: true
        slogan nullable: true
        cellPhone2 nullable: true
        email nullable: true
        language nullable: true
    }

    static mapping = {
        version false
    }
}
