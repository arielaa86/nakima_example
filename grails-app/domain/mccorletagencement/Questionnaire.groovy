package mccorletagencement

import grails.plugin.springsecurity.annotation.Secured

import java.util.stream.Collectors

@Secured(['ROLE_ADMIN', 'ROLE_DIRECTEUR'])
class Questionnaire {

    static belongsTo = [devis:Devis]
    static hasMany = [reponses:Reponse]

    static constraints = {

    }
    static mapping = {
        id generator:'sequence', params:[sequence:'questionnaire_id_seq']
    }


}
