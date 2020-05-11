package smc

import grails.gorm.services.Service

@Service(DocumentType)
interface DocumentTypeService {

    DocumentType get(Serializable id)

    List<DocumentType> list(Map args)

    Long count()

    void delete(Serializable id)

    DocumentType save(DocumentType documentType)

}