package mccorletagencement

import grails.gorm.services.Service

@Service(Etape)
interface EtapeService {

    Etape get(Serializable id)

    List<Etape> list(Map args)

    Long count()

    void delete(Serializable id)

    Etape save(Etape etape)

}