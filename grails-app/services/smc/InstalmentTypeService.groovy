package smc

import grails.gorm.services.Service

@Service(InstalmentType)
interface InstalmentTypeService {

    InstalmentType get(Serializable id)

    List<InstalmentType> list(Map args)

    Long count()

    void delete(Serializable id)

    InstalmentType save(InstalmentType instalmentType)

}