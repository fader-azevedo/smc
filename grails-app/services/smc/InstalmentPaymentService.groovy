package smc

import grails.gorm.services.Service

@Service(InstalmentPayment)
interface InstalmentPaymentService {

    InstalmentPayment get(Serializable id)

    List<InstalmentPayment> list(Map args)

    Long count()

    void delete(Serializable id)

    InstalmentPayment save(InstalmentPayment instalmentPayment)

}