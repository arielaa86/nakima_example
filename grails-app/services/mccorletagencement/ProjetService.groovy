package mccorletagencement

import grails.gorm.services.Service

@Service(Projet)
interface ProjetService {

    Projet get(Serializable id)

    List<Projet> list(Map args)

    Long count()

    void delete(Serializable id)

    Projet save(Projet projet)

}