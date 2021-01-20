package mccorletagencement.dataServices

import grails.gorm.transactions.Transactional
import mccorletagencement.Encaissement
import mccorletagencement.EncaissementService
import mccorletagencement.PaiementService

import java.text.SimpleDateFormat

@Transactional
class EncaissementDataService {

    PaiementService paiementService
    EncaissementService encaissementService

    def saveEncaissements(def params) {

        def id = params.idPaiement

        def paiement = paiementService.get(id)

        for (int i = 0; i < paiement.quantite ; i++) {

            String param = "montant"+i+paiement.id

            def montant = Double.parseDouble( params.list(param)[0])


            def paramDate = "date"+i
            param = paramDate + paiement.id

           def dateString = params.list(param)[0]

           Date date = new SimpleDateFormat("yyyy-MM-dd").parse(dateString)


            def encaissement =  new Encaissement()
            encaissement.setMontant(montant)
            encaissement.setDate(date)
            encaissement.setPaiement(paiement)

            encaissementService.save(encaissement)


        }

    }




    def actualiserEncaissements(def params) {

        def id = params.idPaiement

        def paiement = paiementService.get(id)

        for (encaissement in paiement.getEncaissements() ) {

            String param = "montant"+encaissement.getId()

            def montant = Double.parseDouble( params.list(param)[0] )

            param = "date"+encaissement.getId()

            def dateString = params.list(param)[0]

            Date date = new SimpleDateFormat("yyyy-MM-dd").parse(dateString)

            encaissement.setMontant(montant)
            encaissement.setDate(date)

            encaissementService.save(encaissement)


        }

    }




}
