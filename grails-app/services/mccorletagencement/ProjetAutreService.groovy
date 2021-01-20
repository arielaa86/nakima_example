package mccorletagencement

import grails.gorm.services.Service

@Service(ProjetAutre)
interface ProjetAutreService {

    ProjetAutre get(Serializable id)

    List<ProjetAutre> list(Map args)

    Long count()

    void delete(Serializable id)

    ProjetAutre save(ProjetAutre projetAutre)

}