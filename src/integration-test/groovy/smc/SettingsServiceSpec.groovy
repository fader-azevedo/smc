package smc

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class SettingsServiceSpec extends Specification {

    SettingsService settingsService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new Settings(...).save(flush: true, failOnError: true)
        //new Settings(...).save(flush: true, failOnError: true)
        //Settings settings = new Settings(...).save(flush: true, failOnError: true)
        //new Settings(...).save(flush: true, failOnError: true)
        //new Settings(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //settings.id
    }

    void "test get"() {
        setupData()

        expect:
        settingsService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<Settings> settingsList = settingsService.list(max: 2, offset: 2)

        then:
        settingsList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        settingsService.count() == 5
    }

    void "test delete"() {
        Long settingsId = setupData()

        expect:
        settingsService.count() == 5

        when:
        settingsService.delete(settingsId)
        sessionFactory.currentSession.flush()

        then:
        settingsService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        Settings settings = new Settings()
        settingsService.save(settings)

        then:
        settings.id != null
    }
}
