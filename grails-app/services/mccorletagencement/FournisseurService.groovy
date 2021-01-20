package mccorletagencement

import grails.gorm.services.Service

@Service(Fournisseur)
interface FournisseurService {

    Fournisseur get(Serializable id)

    List<Fournisseur> list(Map args)

    Long count()

    void delete(Serializable id)

    Fournisseur save(Fournisseur fournisseur)

}