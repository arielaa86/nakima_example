package mccorletagencement

import grails.gorm.services.Service

@Service(OrdreProduction)
interface OrdreProductionService {

    OrdreProduction get(Serializable id)

    List<OrdreProduction> list(Map args)

    Long count()

    void delete(Serializable id)

    OrdreProduction save(OrdreProduction ordreProduction)

}