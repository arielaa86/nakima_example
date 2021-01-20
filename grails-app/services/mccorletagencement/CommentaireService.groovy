package mccorletagencement

import grails.gorm.services.Service

@Service(Commentaire)
interface CommentaireService {

    Commentaire get(Serializable id)

    List<Commentaire> list(Map args)

    Long count()

    void delete(Serializable id)

    Commentaire save(Commentaire commentaire)

}