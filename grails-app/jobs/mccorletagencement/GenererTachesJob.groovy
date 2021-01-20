package mccorletagencement

class GenererTachesJob {

    TacheService tacheService

    private static boolean isRunning = false

    static triggers = {
        cron name: 'GenererTachesJob', cronExpression: "0 0 2 * * ?"
    }

    def execute() {


        if (!isRunning) {
            isRunning = true

            Calendar cal = Calendar.getInstance()

            cal.set(Calendar.HOUR_OF_DAY, 0)
            cal.set(Calendar.MINUTE, 0)
            cal.set(Calendar.SECOND, 0)
            cal.set(Calendar.MILLISECOND, 0)
            Date date = cal.getTime()


            Devis.findAllByValideAndApprouveAndDeclineAndExpireAuto(true, false, false, false).forEach({devis ->

                if (devis.expirationEnCours() && devis.tentativeContact < 1) {

                    Tache tache = new Tache()
                    tache.setEtiquette(Etiquette.findByEvenement("Relance"))
                    tache.setDate(date)
                    tache.setJournee(true)
                    tache.setVisibilite("publique")
                    tache.setDescription("Contacter le client " + devis.getProjet().getClient().toString() + " concernant le devis " + devis.getProjet().getIdInsitu())
                    tache.setCreator(Utilisateur.findByEmail("direction.mccorlet@gmail.com"))

                    tacheService.save(tache)

                }

            })


            Paiement.findAllByEncaisse(false).forEach({paiement ->


                if(paiement.dateProchaineEcheance.equals(date)) {

                    Tache tache = new Tache()
                    tache.setEtiquette(Etiquette.findByEvenement("Autre"))
                    tache.setDate(date)
                    tache.setJournee(true)
                    tache.setVisibilite("publique")
                    tache.setDescription("Contacter le client " + paiement.facture.devis.getProjet().getClient().toString() + " concernant la caution du BDC " + paiement.facture.devis.getProjet().getIdInsitu())
                    tache.setCreator(Utilisateur.findByEmail("direction.mccorlet@gmail.com"))

                    tacheService.save(tache)
                }



            })



            try {
                Thread.sleep(3000)
            }
            catch (InterruptedException ex) {
                Thread.currentThread().interrupt();
            }

            isRunning = false

        }

    }



}
