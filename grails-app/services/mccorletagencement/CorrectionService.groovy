package mccorletagencement

import grails.gorm.services.Service

@Service(Correction)
interface CorrectionService {

    Correction get(Serializable id)

    List<Correction> list(Map args)

    Long count()

    void delete(Serializable id)

    Correction save(Correction correction)

}