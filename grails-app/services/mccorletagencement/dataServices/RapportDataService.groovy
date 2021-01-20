package mccorletagencement.dataServices

import grails.gorm.transactions.Transactional
import mccorletagencement.Encaissement
import mccorletagencement.FactureClient
import mccorletagencement.FactureFournisseur
import mccorletagencement.Paiement

import java.util.stream.Collectors

@Transactional
class RapportDataService {

    def getListeEncaissements(Date date) {


        Calendar calendar = Calendar.getInstance()
        calendar.setTime(date)
        calendar.set(Calendar.DATE, calendar.getActualMinimum(Calendar.DATE))
        //calendar.add(Calendar.DATE, -1)
        calendar.set(Calendar.HOUR_OF_DAY, 0)
        calendar.set(Calendar.MINUTE, 0)
        calendar.set(Calendar.SECOND, 0)
        calendar.set(Calendar.MILLISECOND, 0)
        def minDate = calendar.getTime()

        calendar.add(Calendar.DATE, 1)
        calendar.set(Calendar.DATE, calendar.getActualMaximum(Calendar.DATE))
        calendar.add(Calendar.DATE, 1)
        def maxDate = calendar.getTime()



        def listeEncaissements = Paiement.findAllByDateBetweenAndSupprime(minDate, maxDate, false)


        return listeEncaissements.sort{it.date}

    }

/*
    def getFacturesAcquitteesComptable(Date date) {


        Calendar calendar = Calendar.getInstance()
        calendar.setTime(date)
        calendar.set(Calendar.DATE, calendar.getActualMinimum(Calendar.DATE))
        calendar.add(Calendar.DATE, -1)
        calendar.set(Calendar.HOUR_OF_DAY, 0)
        calendar.set(Calendar.MINUTE, 0)
        calendar.set(Calendar.SECOND, 0)
        calendar.set(Calendar.MILLISECOND, 0)
        def minDate = calendar.getTime()

        calendar.add(Calendar.DATE, 1)
        calendar.set(Calendar.DATE, calendar.getActualMaximum(Calendar.DATE))
        calendar.add(Calendar.DATE, 1)
        def maxDate = calendar.getTime()



        def listeFacturesAcquittees = FactureClient.findAllByDateBetween(minDate, maxDate).stream()
                .filter({f -> f.isClosed() && f.selectionCompta})
                .collect(Collectors.toList())

        return listeFacturesAcquittees

    }
*/

    def getFacturesFournisseurs(Date date) {


        Calendar calendar = Calendar.getInstance()
        calendar.setTime(date)
        calendar.set(Calendar.DATE, calendar.getActualMinimum(Calendar.DATE))
        calendar.add(Calendar.DATE, -1)
        calendar.set(Calendar.HOUR_OF_DAY, 0)
        calendar.set(Calendar.MINUTE, 0)
        calendar.set(Calendar.SECOND, 0)
        calendar.set(Calendar.MILLISECOND, 0)
        def minDate = calendar.getTime()

        calendar.add(Calendar.DATE, 1)
        calendar.set(Calendar.DATE, calendar.getActualMaximum(Calendar.DATE))
        calendar.add(Calendar.DATE, 1)
        def maxDate = calendar.getTime()



        def listeFacturesFournisseurs = FactureFournisseur.findAllByDateBetween(minDate, maxDate)


        return listeFacturesFournisseurs

    }
}
