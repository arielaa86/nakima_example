package mccorletagencement

import daos.SuiviEncaissementCommercialDAO
import daos.SuiviEncaissementDAO
import grails.gorm.transactions.Transactional

import java.util.stream.Collectors

@Transactional
class PaiementsService {

    UtilisateurService utilisateurService

    def getAllPaymentsByDate(Date date) {

        def cal = Calendar.getInstance()
        cal.setTime(date)

        cal.set(Calendar.HOUR_OF_DAY, 0)
        cal.set(Calendar.SECOND, 0)
        cal.set(Calendar.MINUTE, 0)

        def today = cal.getTime()


        cal.add(Calendar.DATE, 1)

        def tomorrow = cal.getTime()

        SuiviEncaissementDAO suiviEncaissementDAO = new SuiviEncaissementDAO()

        def paiements = Paiement.findAllByDateBetween(today, tomorrow)

        for (def paiement in paiements) {
            switch (paiement.moyen) {
                case "Carte bancaire": suiviEncaissementDAO.getCarteBancairePaiements().add(paiement)
                    break
                case "Chèque": suiviEncaissementDAO.getChequePaiements().add(paiement)
                    break
                case "Virement": suiviEncaissementDAO.getVirementPaiements().add(paiement)
                    break
                default: suiviEncaissementDAO.getEspecesPaiements().add(paiement)

            }
        }

        return suiviEncaissementDAO

    }


    def getResumeCommercial(Date date) {

        List<SuiviEncaissementCommercialDAO> resume = new ArrayList<>()


        def cal = Calendar.getInstance()
        cal.setTime(date)

        cal.set(Calendar.HOUR_OF_DAY, 0)
        cal.set(Calendar.SECOND, 0)
        cal.set(Calendar.MINUTE, 0)

        def today = cal.getTime()

        cal.add(Calendar.DATE, 1)

        def tomorrow = cal.getTime()

        utilisateurService.list()
                .stream()
                .filter({
                    utilisateur ->
                        utilisateur.authorities.contains(Role.findByAuthority("ROLE_COMMERCIAL"))
                })
                .collect(Collectors.toList())
                .forEach({ utilisateur ->

                    def paiements = Paiement.findAllByDateBetweenAndUtilisateurAndSupprime(today, tomorrow, utilisateur, false)
                    double  cartesBleu = 0.0
                    double cheques = 0.0
                    double especes = 0.0
                    double virements = 0.0

                   for(def paiement in paiements) {

                       switch (paiement.getMoyen()) {

                           case "Carte bancaire":
                               cartesBleu += paiement.montant
                               break
                           case "Chèque":
                               cheques += paiement.montant
                               break
                           case "Espèces":
                               especes += paiement.montant
                               break
                           default:
                               virements += paiement.montant
                               break

                       }
                   }


                    SuiviEncaissementCommercialDAO resumeCommercial = new SuiviEncaissementCommercialDAO()

                    resumeCommercial.setCarteBleu(cartesBleu)
                    resumeCommercial.setEspeces(especes)
                    resumeCommercial.setVirement(virements)
                    resumeCommercial.setCheque(cheques)
                    resumeCommercial.setTotal(cartesBleu + especes + cheques + virements)
                    resumeCommercial.setUtilisateur(utilisateur)

                    resume.add(resumeCommercial)

                })


        return resume


    }



}
