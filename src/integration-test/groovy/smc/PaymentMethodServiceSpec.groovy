package smc

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class PaymentMethodServiceSpec extends Specification {

    PaymentMethodService paymentMethodService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new PaymentMethod(...).save(flush: true, failOnError: true)
        //new PaymentMethod(...).save(flush: true, failOnError: true)
        //PaymentMethod paymentMethod = new PaymentMethod(...).save(flush: true, failOnError: true)
        //new PaymentMethod(...).save(flush: true, failOnError: true)
        //new PaymentMethod(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //paymentMethod.id
    }

    void "test get"() {
        setupData()

        expect:
        paymentMethodService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<PaymentMethod> paymentMethodList = paymentMethodService.list(max: 2, offset: 2)

        then:
        paymentMethodList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        paymentMethodService.count() == 5
    }

    void "test delete"() {
        Long paymentMethodId = setupData()

        expect:
        paymentMethodService.count() == 5

        when:
        paymentMethodService.delete(paymentMethodId)
        sessionFactory.currentSession.flush()

        then:
        paymentMethodService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        PaymentMethod paymentMethod = new PaymentMethod()
        paymentMethodService.save(paymentMethod)

        then:
        paymentMethod.id != null
    }
}
