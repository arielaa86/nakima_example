package mccorletagencement

import grails.gorm.services.Service

@Service(ProjetDressing)
interface ProjetDressingService {

    ProjetDressing get(Serializable id)

    List<ProjetDressing> list(Map args)

    Long count()

    void delete(Serializable id)

    ProjetDressing save(ProjetDressing projetDressing)

}