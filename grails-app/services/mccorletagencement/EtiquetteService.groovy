package mccorletagencement

import grails.gorm.services.Service

@Service(Etiquette)
interface EtiquetteService {

    Etiquette get(Serializable id)

    List<Etiquette> list(Map args)

    Long count()

    void delete(Serializable id)

    Etiquette save(Etiquette etiquette)

}