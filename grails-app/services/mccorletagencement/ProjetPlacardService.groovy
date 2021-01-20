package mccorletagencement

import grails.gorm.services.Service

@Service(ProjetPlacard)
interface ProjetPlacardService {

    ProjetPlacard get(Serializable id)

    List<ProjetPlacard> list(Map args)

    Long count()

    void delete(Serializable id)

    ProjetPlacard save(ProjetPlacard projetPlacard)

}