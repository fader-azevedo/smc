package smc

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class GuaranteeTypeServiceSpec extends Specification {

    GuaranteeTypeService guaranteeTypeService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new GuaranteeType(...).save(flush: true, failOnError: true)
        //new GuaranteeType(...).save(flush: true, failOnError: true)
        //GuaranteeType guaranteeType = new GuaranteeType(...).save(flush: true, failOnError: true)
        //new GuaranteeType(...).save(flush: true, failOnError: true)
        //new GuaranteeType(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //guaranteeType.id
    }

    void "test get"() {
        setupData()

        expect:
        guaranteeTypeService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<GuaranteeType> guaranteeTypeList = guaranteeTypeService.list(max: 2, offset: 2)

        then:
        guaranteeTypeList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        guaranteeTypeService.count() == 5
    }

    void "test delete"() {
        Long guaranteeTypeId = setupData()

        expect:
        guaranteeTypeService.count() == 5

        when:
        guaranteeTypeService.delete(guaranteeTypeId)
        sessionFactory.currentSession.flush()

        then:
        guaranteeTypeService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        GuaranteeType guaranteeType = new GuaranteeType()
        guaranteeTypeService.save(guaranteeType)

        then:
        guaranteeType.id != null
    }
}
