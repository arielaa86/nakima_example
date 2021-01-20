package mccorletagencement

import grails.gorm.services.Service

@Service(Reponse)
interface ReponseService {

    Reponse get(Serializable id)

    List<Reponse> list(Map args)

    Long count()

    void delete(Serializable id)

    Reponse save(Reponse reponse)

}