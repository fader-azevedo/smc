package smc

class District {

    String name

    static belongsTo = [province:Province]
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
