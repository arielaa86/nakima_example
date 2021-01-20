package mccorletagencement

import daos.Result
import grails.plugin.springsecurity.annotation.Secured
import mccorletagencement.dataServices.SearchDataService

@Secured(['ROLE_ADMIN', 'ROLE_DIRECTEUR', 'ROLE_COMMERCIAL', 'ROLE_TECHNICIEN'])
class SearchController {

    SearchDataService searchDataService

    def searchAll() {

        String description = params.description

        ArrayList<Result> resultats = new ArrayList<>()

        searchDataService.getResults(resultats, description.trim())

        render template: '/search/listeResultats', model: [resultats:resultats]

    }


}
