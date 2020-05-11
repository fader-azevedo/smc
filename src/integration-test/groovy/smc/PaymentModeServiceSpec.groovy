package smc

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class PaymentModeServiceSpec extends Specification {

    PaymentModeService paymentModeService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new PaymentMode(...).save(flush: true, failOnError: true)
        //new PaymentMode(...).save(flush: true, failOnError: true)
        //PaymentMode paymentMode = new PaymentMode(...).save(flush: true, failOnError: true)
        //new PaymentMode(...).save(flush: true, failOnError: true)
        //new PaymentMode(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //paymentMode.id
    }

    void "test get"() {
        setupData()

        expect:
        paymentModeService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<PaymentMode> paymentModeList = paymentModeService.list(max: 2, offset: 2)

        then:
        paymentModeList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        paymentModeService.count() == 5
    }

    void "test delete"() {
        Long paymentModeId = setupData()

        expect:
        paymentModeService.count() == 5

        when:
        paymentModeService.delete(paymentModeId)
        sessionFactory.currentSession.flush()

        then:
        paymentModeService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        PaymentMode paymentMode = new PaymentMode()
        paymentModeService.save(paymentMode)

        then:
        paymentMode.id != null
    }
}
