package mccorletagencement

import grails.gorm.services.Service

@Service(Etat)
interface EtatService {

    Etat get(Serializable id)

    List<Etat> list(Map args)

    Long count()

    void delete(Serializable id)

    Etat save(Etat etat)

}