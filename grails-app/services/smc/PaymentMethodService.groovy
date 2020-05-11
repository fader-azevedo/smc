package smc

import grails.gorm.services.Service

@Service(PaymentMethod)
interface PaymentMethodService {

    PaymentMethod get(Serializable id)

    List<PaymentMethod> list(Map args)

    Long count()

    void delete(Serializable id)

    PaymentMethod save(PaymentMethod paymentMethod)

}