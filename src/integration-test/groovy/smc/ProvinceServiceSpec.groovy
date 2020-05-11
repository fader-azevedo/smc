package smc

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class ProvinceServiceSpec extends Specification {

    ProvinceService provinceService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new Province(...).save(flush: true, failOnError: true)
        //new Province(...).save(flush: true, failOnError: true)
        //Province province = new Province(...).save(flush: true, failOnError: true)
        //new Province(...).save(flush: true, failOnError: true)
        //new Province(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //province.id
    }

    void "test get"() {
        setupData()

        expect:
        provinceService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<Province> provinceList = provinceService.list(max: 2, offset: 2)

        then:
        provinceList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        provinceService.count() == 5
    }

    void "test delete"() {
        Long provinceId = setupData()

        expect:
        provinceService.count() == 5

        when:
        provinceService.delete(provinceId)
        sessionFactory.currentSession.flush()

        then:
        provinceService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        Province province = new Province()
        provinceService.save(province)

        then:
        province.id != null
    }
}
