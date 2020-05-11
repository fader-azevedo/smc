package smc

class InstalmentType {

    String name

    static hasMany = [instalments:Instalment]

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
