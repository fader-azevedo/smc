package smc

class Loan extends Parameter{

    String status = 'Aberto'
    String paymentMode
    Date signatureDate = new Date()
    Date payDate
    Date dueDate
    double borrowedAmount
    double interestRate
    double amountPayable
    int instalmentsNumber = 1
    String witnesses
    String directory

    static belongsTo = [client:Client,guarantor:Client]
    static hasMany = [loanGuarantees:LoanGuarantee, instalments:Instalment, payments: Payment]
    static constraints = {
        status inList: ['Aberto','Vencido','Fechado']
        paymentMode inList:  ['Diaria','Semanal','Quinzenal','Mensal']
        amountPayable min:  new Double(0)
        borrowedAmount min:  new Double(0)
        instalmentsNumber min: 1
        witnesses nullable: true
        directory nullable: true
        guarantor nullable: true
    }

    static mapping = {
        witnesses type: 'text'
    }
}