package mccorletagencement

import grails.gorm.services.Service

@Service(ProjetCuisine)
interface ProjetCuisineService {

    ProjetCuisine get(Serializable id)

    List<ProjetCuisine> list(Map args)

    Long count()

    void delete(Serializable id)

    ProjetCuisine save(ProjetCuisine projetCuisine)

}