package mccorletagencement

import grails.gorm.services.Service

@Service(ProjetComplementaire)
interface ProjetComplementaireService {

    ProjetComplementaire get(Serializable id)

    List<ProjetComplementaire> list(Map args)

    Long count()

    void delete(Serializable id)

    ProjetComplementaire save(ProjetComplementaire projetComplementaire)

}