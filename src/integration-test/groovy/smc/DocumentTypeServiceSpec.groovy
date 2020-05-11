package smc

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class DocumentTypeServiceSpec extends Specification {

    DocumentTypeService documentTypeService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new DocumentType(...).save(flush: true, failOnError: true)
        //new DocumentType(...).save(flush: true, failOnError: true)
        //DocumentType documentType = new DocumentType(...).save(flush: true, failOnError: true)
        //new DocumentType(...).save(flush: true, failOnError: true)
        //new DocumentType(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //documentType.id
    }

    void "test get"() {
        setupData()

        expect:
        documentTypeService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<DocumentType> documentTypeList = documentTypeService.list(max: 2, offset: 2)

        then:
        documentTypeList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        documentTypeService.count() == 5
    }

    void "test delete"() {
        Long documentTypeId = setupData()

        expect:
        documentTypeService.count() == 5

        when:
        documentTypeService.delete(documentTypeId)
        sessionFactory.currentSession.flush()

        then:
        documentTypeService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        DocumentType documentType = new DocumentType()
        documentTypeService.save(documentType)

        then:
        documentType.id != null
    }
}
