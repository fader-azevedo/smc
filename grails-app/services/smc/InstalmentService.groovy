package smc

import grails.gorm.services.Service

@Service(Instalment)
interface InstalmentService {

    Instalment get(Serializable id)

    List<Instalment> list(Map args)

    Long count()

    void delete(Serializable id)

    Instalment save(Instalment instalment)

}