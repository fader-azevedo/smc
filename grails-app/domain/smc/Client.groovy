package smc

class Client extends Parameter{

    String image
    String fullName
    String maritalStatus
    String documentNumber
    String address
    String contact
    String email
    Date birthDate

    static belongsTo = [documentType:DocumentType,district:District]
    static hasMany = [loans:Loan, guarantors:Guarantor]

    static constraints = {
        image nullable: true
        email nullable: true
        maritalStatus inList: ['Solteiro(a)','Casado(a)','Divorciado(a)','Viúvo(a)','Separado(a)']
        birthDate validator: {
            if(it.after(new Date())){
                return false
            }
        }
    }

    static mapping = {

    }

    @Override
    String toString() {
        return fullName
    }
}
