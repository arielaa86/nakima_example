package mccorletagencement.dataServices

import daos.PlanningMois
import grails.gorm.transactions.Transactional
import mccorletagencement.FactureClient
import mccorletagencement.Projet
import mccorletagencement.ProjetComplementaire

import java.util.stream.Collector
import java.util.stream.Collectors

@Transactional
class PlanningDataService {

    def obtenirPlanningParMois(Date startDate, Date lastDate ) {

        def listeProjets =  Projet.findAllByDelaiRealisationBetween(startDate, lastDate)
                .stream().filter({p -> cestValide(p)}).collect(Collectors.toList())

        def listeBDC =  new ArrayList<FactureClient>()

        listeProjets.stream().forEach({p -> listeBDC.add(p.devisClient.facture)})


        List<PlanningMois> planningMoisList = new ArrayList<>()

        planningMoisList.add(new PlanningMois(0,"Janvier"))
        planningMoisList.add(new PlanningMois(1,"Février"))
        planningMoisList.add(new PlanningMois(2,"Mars"))
        planningMoisList.add(new PlanningMois(3,"Avril"))
        planningMoisList.add(new PlanningMois(4,"Mai"))
        planningMoisList.add(new PlanningMois(5,"Juin"))
        planningMoisList.add(new PlanningMois(6,"Juillet"))
        planningMoisList.add(new PlanningMois(7,"Août"))
        planningMoisList.add(new PlanningMois(8,"Septembre"))
        planningMoisList.add(new PlanningMois(9,"Octobre"))
        planningMoisList.add(new PlanningMois(10,"Novembre"))
        planningMoisList.add(new PlanningMois(11,"Décembre"))

        listeBDC.stream().forEach({
            bdc -> obtenirMois(bdc, planningMoisList)
        })


        return planningMoisList

    }


    def cestValide(Projet projet){

        if(projet instanceof ProjetComplementaire){
            return false
        }

        if(projet.devisClient != null){
            return projet.devisClient.facture != null
        }

        return false
    }


    def obtenirMois(FactureClient bdc,  List<PlanningMois> planningMoisList){

        Date dateLivraison = bdc.devis.projet.delaiRealisation

        def cal = Calendar.getInstance()
        cal.setTime(dateLivraison)
        def mois = cal.get(Calendar.MONTH)
        def annee = cal.get(Calendar.YEAR)

        planningMoisList.get(mois).getListeBDC().add(bdc)

    }



}
