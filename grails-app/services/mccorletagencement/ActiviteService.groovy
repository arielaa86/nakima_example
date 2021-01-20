package mccorletagencement

import grails.gorm.services.Service

@Service(Activite)
interface ActiviteService {

    Activite get(Serializable id)

    List<Activite> list(Map args)

    Long count()

    void delete(Serializable id)

    Activite save(Activite activite)

}