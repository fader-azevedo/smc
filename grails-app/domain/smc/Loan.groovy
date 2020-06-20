package smc

class Loan extends Parameter{

    String status = 'Aberto'
    Date signatureDate = new Date()
    Date payDate
    Date dueDate
    double borrowedAmount
    double interestRate
    double amountPayable
    int instalmentsNumber = 1
    String witnesses
    String directory

    static belongsTo = [client:Client,paymentMode:PaymentMode]
    static hasMany = [loanGuarantees:LoanGuarantee, instalments:Instalment, guarantors:Guarantor,payments: Payment]
    static constraints = {
        status inList: ['Aberto','Vencido','Fechado']
        amountPayable min:  new Double(0)
        borrowedAmount min:  new Double(0)
        instalmentsNumber min: 1
        witnesses nullable: true
        directory nullable: true
    }

    static mapping = {
        witnesses type: 'text'
    }
}