package mccorletagencement

import grails.gorm.services.Service

@Service(EtatProduction)
interface EtatProductionService {

    EtatProduction get(Serializable id)

    List<EtatProduction> list(Map args)

    Long count()

    void delete(Serializable id)

    EtatProduction save(EtatProduction etatProduction)

}