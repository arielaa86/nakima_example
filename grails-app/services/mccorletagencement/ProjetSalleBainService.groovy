package mccorletagencement

import grails.gorm.services.Service

@Service(ProjetSalleBain)
interface ProjetSalleBainService {

    ProjetSalleBain get(Serializable id)

    List<ProjetSalleBain> list(Map args)

    Long count()

    void delete(Serializable id)

    ProjetSalleBain save(ProjetSalleBain projetSalleBain)

}