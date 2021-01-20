package mccorletagencement

import grails.gorm.services.Service

@Service(FactureFournisseur)
interface FactureFournisseurService {

    FactureFournisseur get(Serializable id)

    List<FactureFournisseur> list(Map args)

    Long count()

    void delete(Serializable id)

    FactureFournisseur save(FactureFournisseur factureFournisseur)

}