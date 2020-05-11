package smc

import grails.gorm.services.Service

@Service(Settings)
interface SettingsService {

    Settings get(Serializable id)

    List<Settings> list(Map args)

    Long count()

    void delete(Serializable id)

    Settings save(Settings settings)

}