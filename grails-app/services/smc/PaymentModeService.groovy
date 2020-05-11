package smc

import grails.gorm.services.Service

@Service(PaymentMode)
interface PaymentModeService {

    PaymentMode get(Serializable id)

    List<PaymentMode> list(Map args)

    Long count()

    void delete(Serializable id)

    PaymentMode save(PaymentMode paymentMode)

}