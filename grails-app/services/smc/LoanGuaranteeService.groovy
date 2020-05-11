package smc

import grails.gorm.services.Service

@Service(LoanGuarantee)
interface LoanGuaranteeService {

    LoanGuarantee get(Serializable id)

    List<LoanGuarantee> list(Map args)

    Long count()

    void delete(Serializable id)

    LoanGuarantee save(LoanGuarantee loanGuarantee)

}