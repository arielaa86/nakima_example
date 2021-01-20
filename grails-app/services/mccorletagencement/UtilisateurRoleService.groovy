package mccorletagencement

import grails.gorm.services.Service

@Service(UtilisateurRole)
interface UtilisateurRoleService {

    UtilisateurRole get(Serializable id)

    List<UtilisateurRole> list(Map args)

    Long count()

    void delete(Serializable id)

    UtilisateurRole save(UtilisateurRole utilisateurRole)

}