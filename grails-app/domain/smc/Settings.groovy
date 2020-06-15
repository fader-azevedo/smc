package smc

class Settings {

    int ano
    String root
    String logo
    String loans
    String sidebar
    boolean sundays = true

    static constraints = {
        sidebar nullable: true
    }

    static mapping = {
        version false
    }
}
