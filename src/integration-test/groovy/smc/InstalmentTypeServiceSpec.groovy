package smc

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class InstalmentTypeServiceSpec extends Specification {

    InstalmentTypeService instalmentTypeService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new InstalmentType(...).save(flush: true, failOnError: true)
        //new InstalmentType(...).save(flush: true, failOnError: true)
        //InstalmentType instalmentType = new InstalmentType(...).save(flush: true, failOnError: true)
        //new InstalmentType(...).save(flush: true, failOnError: true)
        //new InstalmentType(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //instalmentType.id
    }

    void "test get"() {
        setupData()

        expect:
        instalmentTypeService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<InstalmentType> instalmentTypeList = instalmentTypeService.list(max: 2, offset: 2)

        then:
        instalmentTypeList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        instalmentTypeService.count() == 5
    }

    void "test delete"() {
        Long instalmentTypeId = setupData()

        expect:
        instalmentTypeService.count() == 5

        when:
        instalmentTypeService.delete(instalmentTypeId)
        sessionFactory.currentSession.flush()

        then:
        instalmentTypeService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        InstalmentType instalmentType = new InstalmentType()
        instalmentTypeService.save(instalmentType)

        then:
        instalmentType.id != null
    }
}
