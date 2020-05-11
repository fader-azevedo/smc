package smc

class DocumentType {

    String name

    static hasMany = [clients:Client]

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
