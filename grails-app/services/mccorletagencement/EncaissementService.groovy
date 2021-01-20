package mccorletagencement

import grails.gorm.services.Service

@Service(Encaissement)
interface EncaissementService {

    Encaissement get(Serializable id)

    List<Encaissement> list(Map args)

    Long count()

    void delete(Serializable id)

    Encaissement save(Encaissement encaissement)

}