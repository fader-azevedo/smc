package smc

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class InstalmentPaymentServiceSpec extends Specification {

    InstalmentPaymentService instalmentPaymentService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new InstalmentPayment(...).save(flush: true, failOnError: true)
        //new InstalmentPayment(...).save(flush: true, failOnError: true)
        //InstalmentPayment instalmentPayment = new InstalmentPayment(...).save(flush: true, failOnError: true)
        //new InstalmentPayment(...).save(flush: true, failOnError: true)
        //new InstalmentPayment(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //instalmentPayment.id
    }

    void "test get"() {
        setupData()

        expect:
        instalmentPaymentService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<InstalmentPayment> instalmentPaymentList = instalmentPaymentService.list(max: 2, offset: 2)

        then:
        instalmentPaymentList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        instalmentPaymentService.count() == 5
    }

    void "test delete"() {
        Long instalmentPaymentId = setupData()

        expect:
        instalmentPaymentService.count() == 5

        when:
        instalmentPaymentService.delete(instalmentPaymentId)
        sessionFactory.currentSession.flush()

        then:
        instalmentPaymentService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        InstalmentPayment instalmentPayment = new InstalmentPayment()
        instalmentPaymentService.save(instalmentPayment)

        then:
        instalmentPayment.id != null
    }
}
