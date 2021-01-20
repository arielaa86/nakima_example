package mccorletagencement

import grails.gorm.services.Service

@Service(RapportComptable)
interface RapportComptableService {

    RapportComptable get(Serializable id)

    List<RapportComptable> list(Map args)

    Long count()

    void delete(Serializable id)

    RapportComptable save(RapportComptable rapportComptable)

}