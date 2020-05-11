package smc

import grails.gorm.services.Service

@Service(GuaranteeType)
interface GuaranteeTypeService {

    GuaranteeType get(Serializable id)

    List<GuaranteeType> list(Map args)

    Long count()

    void delete(Serializable id)

    GuaranteeType save(GuaranteeType guaranteeType)

}