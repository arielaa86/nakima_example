package mccorletagencement

import grails.gorm.services.Service

@Service(FactureClient)
interface FactureClientService {

    FactureClient get(Serializable id)

    List<FactureClient> list(Map args)

    Long count()

    void delete(Serializable id)

    FactureClient save(FactureClient factureClient)

}