package smc

class Province {

    String name

    static hasMany = [districts:District]

    static constraints = {
        name unique: true
    }

    static mapping = {
        version false
    }

    @Override
    String toString() {
        name
    }
}
