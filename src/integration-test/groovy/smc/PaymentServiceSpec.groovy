package smc

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class PaymentServiceSpec extends Specification {

    PaymentService paymentService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new Payment(...).save(flush: true, failOnError: true)
        //new Payment(...).save(flush: true, failOnError: true)
        //Payment payment = new Payment(...).save(flush: true, failOnError: true)
        //new Payment(...).save(flush: true, failOnError: true)
        //new Payment(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //payment.id
    }

    void "test get"() {
        setupData()

        expect:
        paymentService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<Payment> paymentList = paymentService.list(max: 2, offset: 2)

        then:
        paymentList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        paymentService.count() == 5
    }

    void "test delete"() {
        Long paymentId = setupData()

        expect:
        paymentService.count() == 5

        when:
        paymentService.delete(paymentId)
        sessionFactory.currentSession.flush()

        then:
        paymentService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        Payment payment = new Payment()
        paymentService.save(payment)

        then:
        payment.id != null
    }
}
