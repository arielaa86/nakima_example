package mccorletagencement

import grails.gorm.services.Service

@Service(Devis)
interface DevisService {

    Devis get(Serializable id)

    List<Devis> list(Map args)

    Long count()

    void delete(Serializable id)

    Devis save(Devis devis)

}