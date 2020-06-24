package smc

class Client extends Parameter{

    String image
    String fullName
    String gender
    String maritalStatus
    String address
    String contact
    String email
    Date birthDate
    String documentNumber


    static belongsTo = [documentType:DocumentType,district:District]
    static hasMany = [loans:Loan, guarantors:Guarantor]

    static constraints = {
        image nullable: true
        email nullable: true
        maritalStatus inList: ['Solteiro(a)','Casado(a)','Divorciado(a)','Viúvo(a)','Separado(a)']
        gender inList: ['Feminino','Masculino']
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
