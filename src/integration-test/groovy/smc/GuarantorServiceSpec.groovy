package smc

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class GuarantorServiceSpec extends Specification {

    GuarantorService guarantorService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new Guarantor(...).save(flush: true, failOnError: true)
        //new Guarantor(...).save(flush: true, failOnError: true)
        //Guarantor guarantor = new Guarantor(...).save(flush: true, failOnError: true)
        //new Guarantor(...).save(flush: true, failOnError: true)
        //new Guarantor(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //guarantor.id
    }

    void "test get"() {
        setupData()

        expect:
        guarantorService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<Guarantor> guarantorList = guarantorService.list(max: 2, offset: 2)

        then:
        guarantorList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        guarantorService.count() == 5
    }

    void "test delete"() {
        Long guarantorId = setupData()

        expect:
        guarantorService.count() == 5

        when:
        guarantorService.delete(guarantorId)
        sessionFactory.currentSession.flush()

        then:
        guarantorService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        Guarantor guarantor = new Guarantor()
        guarantorService.save(guarantor)

        then:
        guarantor.id != null
    }
}
