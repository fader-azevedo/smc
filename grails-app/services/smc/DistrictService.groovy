package smc

import grails.gorm.services.Service

@Service(District)
interface DistrictService {

    District get(Serializable id)

    List<District> list(Map args)

    Long count()

    void delete(Serializable id)

    District save(District district)

}