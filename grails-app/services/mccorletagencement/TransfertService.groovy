package mccorletagencement

import grails.gorm.services.Service

@Service(Transfert)
interface TransfertService {

    Transfert get(Serializable id)

    List<Transfert> list(Map args)

    Long count()

    void delete(Serializable id)

    Transfert save(Transfert transfert)

}