package smc

class GuaranteeType {

    String name

    static hasMany = [guarantees:Guarantee]

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
