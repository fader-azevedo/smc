package smc

import grails.gorm.services.Service

@Service(Client)
interface ClientService {

    Client get(Serializable id)

    List<Client> list(Map args)

    Long count()

    void delete(Serializable id)

    Client save(Client client)

}