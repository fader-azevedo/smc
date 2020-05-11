package smc

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class GuaranteeServiceSpec extends Specification {

    GuaranteeService guaranteeService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new Guarantee(...).save(flush: true, failOnError: true)
        //new Guarantee(...).save(flush: true, failOnError: true)
        //Guarantee guarantee = new Guarantee(...).save(flush: true, failOnError: true)
        //new Guarantee(...).save(flush: true, failOnError: true)
        //new Guarantee(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //guarantee.id
    }

    void "test get"() {
        setupData()

        expect:
        guaranteeService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<Guarantee> guaranteeList = guaranteeService.list(max: 2, offset: 2)

        then:
        guaranteeList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        guaranteeService.count() == 5
    }

    void "test delete"() {
        Long guaranteeId = setupData()

        expect:
        guaranteeService.count() == 5

        when:
        guaranteeService.delete(guaranteeId)
        sessionFactory.currentSession.flush()

        then:
        guaranteeService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        Guarantee guarantee = new Guarantee()
        guaranteeService.save(guarantee)

        then:
        guarantee.id != null
    }
}
