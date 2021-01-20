package mccorletagencement

import grails.plugin.springsecurity.annotation.Secured
import mccorletagencement.dataServices.RapportDataService
import mccorletagencement.dataServices.StatistiquesDataService

import java.text.SimpleDateFormat

class RapportComptableController {

    RapportComptableService rapportComptableService
    StatistiquesDataService statistiquesDataService
    RapportDataService rapportDataService


    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    /*
    @Secured(['permitAll'])
    def rapport() {

        def rapport = RapportComptable.findByCodeEmail(params.numero)

        def listeFacturesAcquittees = rapportDataService.getFacturesAcquitteesComptable(rapport.date)

        def listeFacturesFournisseurs = rapportDataService.getFacturesFournisseurs(rapport.date)

        String actualDate = new SimpleDateFormat("MMMM yyyy", Locale.FRANCE).format(rapport.date)

        def listeSuiviCommercial = statistiquesDataService.getListeSuiviCommercial(actualDate)



        [rapportComptable: rapport, listeSuiviCommercial: listeSuiviCommercial, listeFacturesAcquittees: listeFacturesAcquittees, listeFacturesFournisseurs: listeFacturesFournisseurs]


    }
    */


}
