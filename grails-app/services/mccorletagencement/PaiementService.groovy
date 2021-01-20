package mccorletagencement

import grails.gorm.services.Service

@Service(Paiement)
interface PaiementService {

    Paiement get(Serializable id)

    List<Paiement> list(Map args)

    Long count()

    void delete(Serializable id)

    Paiement save(Paiement paiement)

}