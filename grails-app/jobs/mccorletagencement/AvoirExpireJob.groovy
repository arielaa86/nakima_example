package mccorletagencement

import java.util.stream.Collectors

class AvoirExpireJob {

    DevisService devisService

    static triggers = {
        cron name: 'AvoirExpireJob', cronExpression: "0 30 2 * * ?"
    }

    def execute() {

        Calendar cal = Calendar.getInstance()

        cal.add(Calendar.DATE, -1)
        cal.set(Calendar.HOUR_OF_DAY, 0)
        cal.set(Calendar.MINUTE, 0)
        cal.set(Calendar.SECOND, 0)
        cal.set(Calendar.MILLISECOND, 0)
        Date dateMin = cal.getTime()


        cal = Calendar.getInstance()
        cal.set(Calendar.HOUR_OF_DAY, 0)
        cal.set(Calendar.MINUTE, 0)
        cal.set(Calendar.SECOND, 0)
        cal.set(Calendar.MILLISECOND, 0)
        Date dateMax = cal.getTime()


        def factures = FactureClient.findAll().stream().filter({f -> f.dateValiditeAvoir.after(dateMin) && f.dateValiditeAvoir.before(dateMax)}).collect(Collectors.toList())

        for (def facture in factures){
            def devis = facture.devis

            devis.setVisible(false)
            devis.setExpiration(true)

            devisService.save(devis)

        }


    }
}
