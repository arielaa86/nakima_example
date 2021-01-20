package mccorletagencement

import grails.gorm.services.Service

@Service(Questionnaire)
interface QuestionnaireService {

    Questionnaire get(Serializable id)

    List<Questionnaire> list(Map args)

    Long count()

    void delete(Serializable id)

    Questionnaire save(Questionnaire questionnaire)

}