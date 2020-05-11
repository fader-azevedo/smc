package smc

import grails.testing.gorm.DomainUnitTest
import grails.testing.web.controllers.ControllerUnitTest
import grails.validation.ValidationException
import spock.lang.*

class DocumentTypeControllerSpec extends Specification implements ControllerUnitTest<DocumentTypeController>, DomainUnitTest<DocumentType> {

    def populateValidParams(params) {
        assert params != null

        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
        assert false, "TODO: Provide a populateValidParams() implementation for this generated test suite"
    }

    void "Test the index action returns the correct model"() {
        given:
        controller.documentTypeService = Mock(DocumentTypeService) {
            1 * list(_) >> []
            1 * count() >> 0
        }

        when:"The index action is executed"
        controller.index()

        then:"The model is correct"
        !model.documentTypeList
        model.documentTypeCount == 0
    }

    void "Test the create action returns the correct model"() {
        when:"The create action is executed"
        controller.create()

        then:"The model is correctly created"
        model.documentType!= null
    }

    void "Test the save action with a null instance"() {
        when:"Save is called for a domain instance that doesn't exist"
        request.contentType = FORM_CONTENT_TYPE
        request.method = 'POST'
        controller.save(null)

        then:"A 404 error is returned"
        response.redirectedUrl == '/documentType/index'
        flash.message != null
    }

    void "Test the save action correctly persists"() {
        given:
        controller.documentTypeService = Mock(DocumentTypeService) {
            1 * save(_ as DocumentType)
        }

        when:"The save action is executed with a valid instance"
        response.reset()
        request.contentType = FORM_CONTENT_TYPE
        request.method = 'POST'
        populateValidParams(params)
        def documentType = new DocumentType(params)
        documentType.id = 1

        controller.save(documentType)

        then:"A redirect is issued to the show action"
        response.redirectedUrl == '/documentType/show/1'
        controller.flash.message != null
    }

    void "Test the save action with an invalid instance"() {
        given:
        controller.documentTypeService = Mock(DocumentTypeService) {
            1 * save(_ as DocumentType) >> { DocumentType documentType ->
                throw new ValidationException("Invalid instance", documentType.errors)
            }
        }

        when:"The save action is executed with an invalid instance"
        request.contentType = FORM_CONTENT_TYPE
        request.method = 'POST'
        def documentType = new DocumentType()
        controller.save(documentType)

        then:"The create view is rendered again with the correct model"
        model.documentType != null
        view == 'create'
    }

    void "Test the show action with a null id"() {
        given:
        controller.documentTypeService = Mock(DocumentTypeService) {
            1 * get(null) >> null
        }

        when:"The show action is executed with a null domain"
        controller.show(null)

        then:"A 404 error is returned"
        response.status == 404
    }

    void "Test the show action with a valid id"() {
        given:
        controller.documentTypeService = Mock(DocumentTypeService) {
            1 * get(2) >> new DocumentType()
        }

        when:"A domain instance is passed to the show action"
        controller.show(2)

        then:"A model is populated containing the domain instance"
        model.documentType instanceof DocumentType
    }

    void "Test the edit action with a null id"() {
        given:
        controller.documentTypeService = Mock(DocumentTypeService) {
            1 * get(null) >> null
        }

        when:"The show action is executed with a null domain"
        controller.edit(null)

        then:"A 404 error is returned"
        response.status == 404
    }

    void "Test the edit action with a valid id"() {
        given:
        controller.documentTypeService = Mock(DocumentTypeService) {
            1 * get(2) >> new DocumentType()
        }

        when:"A domain instance is passed to the show action"
        controller.edit(2)

        then:"A model is populated containing the domain instance"
        model.documentType instanceof DocumentType
    }


    void "Test the update action with a null instance"() {
        when:"Save is called for a domain instance that doesn't exist"
        request.contentType = FORM_CONTENT_TYPE
        request.method = 'PUT'
        controller.update(null)

        then:"A 404 error is returned"
        response.redirectedUrl == '/documentType/index'
        flash.message != null
    }

    void "Test the update action correctly persists"() {
        given:
        controller.documentTypeService = Mock(DocumentTypeService) {
            1 * save(_ as DocumentType)
        }

        when:"The save action is executed with a valid instance"
        response.reset()
        request.contentType = FORM_CONTENT_TYPE
        request.method = 'PUT'
        populateValidParams(params)
        def documentType = new DocumentType(params)
        documentType.id = 1

        controller.update(documentType)

        then:"A redirect is issued to the show action"
        response.redirectedUrl == '/documentType/show/1'
        controller.flash.message != null
    }

    void "Test the update action with an invalid instance"() {
        given:
        controller.documentTypeService = Mock(DocumentTypeService) {
            1 * save(_ as DocumentType) >> { DocumentType documentType ->
                throw new ValidationException("Invalid instance", documentType.errors)
            }
        }

        when:"The save action is executed with an invalid instance"
        request.contentType = FORM_CONTENT_TYPE
        request.method = 'PUT'
        controller.update(new DocumentType())

        then:"The edit view is rendered again with the correct model"
        model.documentType != null
        view == 'edit'
    }

    void "Test the delete action with a null instance"() {
        when:"The delete action is called for a null instance"
        request.contentType = FORM_CONTENT_TYPE
        request.method = 'DELETE'
        controller.delete(null)

        then:"A 404 is returned"
        response.redirectedUrl == '/documentType/index'
        flash.message != null
    }

    void "Test the delete action with an instance"() {
        given:
        controller.documentTypeService = Mock(DocumentTypeService) {
            1 * delete(2)
        }

        when:"The domain instance is passed to the delete action"
        request.contentType = FORM_CONTENT_TYPE
        request.method = 'DELETE'
        controller.delete(2)

        then:"The user is redirected to index"
        response.redirectedUrl == '/documentType/index'
        flash.message != null
    }
}






