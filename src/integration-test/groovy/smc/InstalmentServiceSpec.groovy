package smc

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class InstalmentServiceSpec extends Specification {

    InstalmentService instalmentService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new Instalment(...).save(flush: true, failOnError: true)
        //new Instalment(...).save(flush: true, failOnError: true)
        //Instalment instalment = new Instalment(...).save(flush: true, failOnError: true)
        //new Instalment(...).save(flush: true, failOnError: true)
        //new Instalment(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //instalment.id
    }

    void "test get"() {
        setupData()

        expect:
        instalmentService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<Instalment> instalmentList = instalmentService.list(max: 2, offset: 2)

        then:
        instalmentList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        instalmentService.count() == 5
    }

    void "test delete"() {
        Long instalmentId = setupData()

        expect:
        instalmentService.count() == 5

        when:
        instalmentService.delete(instalmentId)
        sessionFactory.currentSession.flush()

        then:
        instalmentService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        Instalment instalment = new Instalment()
        instalmentService.save(instalment)

        then:
        instalment.id != null
    }
}
