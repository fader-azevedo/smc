package smc

import grails.gorm.services.Service

@Service(Guarantor)
interface GuarantorService {

    Guarantor get(Serializable id)

    List<Guarantor> list(Map args)

    Long count()

    void delete(Serializable id)

    Guarantor save(Guarantor guarantor)

}