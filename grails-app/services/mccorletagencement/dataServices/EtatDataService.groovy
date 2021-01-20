package mccorletagencement.dataServices

import grails.gorm.transactions.Transactional
import mccorletagencement.Devis
import mccorletagencement.DevisService
import mccorletagencement.EtatService
import mccorletagencement.FactureClient

@Transactional
class EtatDataService {

    EtatService etatService


    def existEtatAcquitte(FactureClient facture){

        for (def etat in facture.devis.etats){
            if(etat.description.equals("Acquittee")){
                return true
            }
        }

        return false

    }




    def existEtatCommissione(Devis devis){

        for (def etat in devis.etats){
            if(etat.commissione == true){
                return true
            }
        }

        return false

    }



    def deleteEtatDate(Date date, Devis devis){


        for (def etat in devis.etats){

            if(date.equals(etat.date)){

                etat.setCommissione(false)
                etatService.save(etat)

            }
        }
    }

}
