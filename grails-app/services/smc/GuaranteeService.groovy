package smc

import grails.gorm.services.Service

@Service(Guarantee)
interface GuaranteeService {

    Guarantee get(Serializable id)

    List<Guarantee> list(Map args)

    Long count()

    void delete(Serializable id)

    Guarantee save(Guarantee guarantee)

}