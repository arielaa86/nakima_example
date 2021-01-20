package mccorletagencement

import daos.ChartQuestionnaireDAO
import daos.SuiviCommercialDAO
import daos.SuiviGeneralDAO
import dtos.PoseDTO
import dtos.SuiviPoseurDTO
import grails.gorm.transactions.Transactional
import org.springframework.security.core.context.SecurityContextHolder

import java.util.stream.Collectors

@Transactional
class StatistiquesService {

    SuiviGeneralDAO detailsCommerciaux(Date date) {


        def utilisateurRoleList = UtilisateurRole.findAllByRole(Role.findByAuthority("ROLE_COMMERCIAL"))

        List<SuiviCommercialDAO> suiviCommercialDAOS = new ArrayList<>()


        Calendar cal = Calendar.getInstance()
        cal.setTime(date)
        cal.set(Calendar.DAY_OF_MONTH, cal.getActualMinimum(Calendar.DAY_OF_MONTH) - 1)
        Date minDate = cal.getTime()


        cal.setTime(date)
        cal.set(Calendar.DAY_OF_MONTH, cal.getActualMaximum(Calendar.DAY_OF_MONTH) + 1)
        Date maxDate = cal.getTime()


        def totalAttente = 0
        def totalDecline = 0
        def totalFacturesImpayee = 0
        def totalFacturesEnCours = 0
        def totalFacturesAcquittee = 0


        for (utilisateurRole in utilisateurRoleList) {

            def utilisateur = utilisateurRole.getUtilisateur()

            def devisList = Devis.findAllByValide(true)

            def attente = 0
            def decline = 0
            def facturesImpayee = 0
            def facturesEnCours = 0
            def facturesAcquittee = 0


            for (devis in devisList) {

                if (devis.projet.concepteur.equals(utilisateur)) {

                    def etats = Etat.findAllByDevisAndDateLessThan(devis, maxDate)

                    if (etats.size() > 0) {

                        def etat = etats.get(etats.size() - 1)

                        switch (etat.getDescription()) {
                            case "Decline":
                                if (etat.date.after(minDate) && etat.date.before(maxDate)) {
                                    decline++
                                    totalDecline++
                                }
                                break
                            case "Impayee":
                                if (devis.montant > 0) {
                                    facturesImpayee++
                                    totalFacturesImpayee++
                                }

                                break
                            case "En cours":
                                facturesEnCours++
                                totalFacturesEnCours++


                                break
                            case "Acquittee":
                                if (etat.date.after(minDate) && etat.date.before(maxDate)) {
                                    facturesAcquittee++
                                    totalFacturesAcquittee++

                                }
                                break
                            default:
                                attente++
                                totalAttente++
                                break

                        }
                    }

                }

            }


            SuiviCommercialDAO suiviCommerciaux = new SuiviCommercialDAO()
            suiviCommerciaux.setDevisAttente(attente)
            suiviCommerciaux.setDevisDecline(decline)
            suiviCommerciaux.setFacturesImpayees(facturesImpayee)
            suiviCommerciaux.setFacturesEnCours(facturesEnCours)
            suiviCommerciaux.setFacturesAcquitees(facturesAcquittee)
            suiviCommerciaux.setUtilisateur(utilisateur)
            suiviCommerciaux.setCommission(0)

            suiviCommercialDAOS.add(suiviCommerciaux)


        }

        SuiviGeneralDAO suiviGeneralDao = new SuiviGeneralDAO()

        suiviGeneralDao.setInfoComerciaux(suiviCommercialDAOS)
        suiviGeneralDao.setTotalAttente(totalAttente)
        suiviGeneralDao.setTotalDecline(totalDecline)
        suiviGeneralDao.setTotalFacturesImpayee(totalFacturesImpayee)
        suiviGeneralDao.setTotalFacturesEnCours(totalFacturesEnCours)
        suiviGeneralDao.setTotalFacturesAcquittee(totalFacturesAcquittee)
        suiviGeneralDao.setTotalCommission(0)

        return suiviGeneralDao

    }


    ChartQuestionnaireDAO dataListdevisDecline() {

        List<String> labelList = new ArrayList<>();
        List<Integer> dataList = new ArrayList<>();


        for (question in Question.getAll().sort { it.id }) {

            labelList.add(question.getTexte())
            dataList.add(Reponse.countByQuestionAndSelectionne(question, true))
        }

        return new ChartQuestionnaireDAO(labelList, dataList)


    }


    SuiviCommercialDAO detailsCommercial(Date date, Utilisateur commercial) {

        ArrayList<Devis> liste = new ArrayList<>()

        Calendar cal = Calendar.getInstance()
        cal.setTime(date)
        cal.set(Calendar.HOUR_OF_DAY, 23)
        cal.set(Calendar.MINUTE, 59)
        cal.set(Calendar.SECOND, 59)
        cal.set(Calendar.DAY_OF_MONTH, cal.getActualMinimum(Calendar.DAY_OF_MONTH) - 1)
        Date minDate = cal.getTime()


        cal.setTime(date)
        cal.set(Calendar.HOUR_OF_DAY, 0)
        cal.set(Calendar.MINUTE, 0)
        cal.set(Calendar.SECOND, 0)
        cal.set(Calendar.DAY_OF_MONTH, cal.getActualMaximum(Calendar.DAY_OF_MONTH) + 1)
        Date maxDate = cal.getTime()


        Utilisateur utilisateur = null

        if (commercial == null) {
            utilisateur = Utilisateur.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName())
        } else {
            utilisateur = commercial
        }

        /*
        def devisList = Devis.findAllByValideAndApprouveAndFactureIsNotNull(true, true, true)
                .stream()
                .filter {
                    devis -> devis.facture.totalPaiements() > 0 && devis.projet.concepteur.id == utilisateur.id
                }
                .collect(Collectors.toList())
*/

        def commission = 0.0D
        def totalBaseCalcul = 0.0D


        def etats = Etat.findAllByDateBetweenAndCommissioneAndUtilisateur_commissione(minDate, maxDate, true, utilisateur.id)

        for (etat in etats) {
                commission += etat.devis.obtenirCommission()
                totalBaseCalcul += etat.devis.obtenirBaseCalcul()
                liste.add(etat.devis)
        }


        SuiviCommercialDAO suiviCommerciaux = new SuiviCommercialDAO()
        suiviCommerciaux.setDevisAttente(0)
        suiviCommerciaux.setDevisDecline(0)
        suiviCommerciaux.setFacturesImpayees(0)
        suiviCommerciaux.setFacturesEnCours(0)
        suiviCommerciaux.setFacturesAcquitees(0)
        suiviCommerciaux.setUtilisateur(utilisateur)
        suiviCommerciaux.setCommission(commission)
        suiviCommerciaux.setTotalBaseCalcul(totalBaseCalcul)
        suiviCommerciaux.setDevisListe(liste)

        return suiviCommerciaux


    }


    def getSuiviPoseur(Date date) {


        List<SuiviPoseurDTO> previsionnelles = new ArrayList<>()
        List<SuiviPoseurDTO> realisees = new ArrayList<>()

        double totalSupplement = 0
        double totalPaiements = 0

        Calendar cal = Calendar.getInstance()
        cal.setTime(date)
        cal.set(Calendar.HOUR_OF_DAY, 23)
        cal.set(Calendar.MINUTE, 59)
        cal.set(Calendar.SECOND, 59)
        cal.set(Calendar.DAY_OF_MONTH, cal.getActualMinimum(Calendar.DAY_OF_MONTH) - 1)
        Date minDate = cal.getTime()


        cal.setTime(date)
        cal.set(Calendar.HOUR_OF_DAY, 0)
        cal.set(Calendar.MINUTE, 0)
        cal.set(Calendar.SECOND, 0)
        cal.set(Calendar.DAY_OF_MONTH, cal.getActualMaximum(Calendar.DAY_OF_MONTH) + 1)
        Date maxDate = cal.getTime()


        OrdreProduction.findAllByLivraisonBetween(minDate, maxDate).forEach({ ordre ->

            if (Math.floor(ordre.factureClient.devis.paiementPoseur()) > 0) {
                if (ordre.pretLivraison && !ordre.livre) {
                    previsionnelles.add(obtenirInfoPose(ordre))

                }

                if (ordre.pretLivraison && ordre.livre) {
                    realisees.add(obtenirInfoPose(ordre))
                    totalSupplement += ordre.factureClient.devis.supplementPoseurDirection
                    totalPaiements += ordre.factureClient.devis.paiementTotalPoseur()
                }
            }

        })

        return new PoseDTO(previsionnelles, realisees, totalSupplement, totalPaiements)

    }


    private SuiviPoseurDTO obtenirInfoPose(OrdreProduction ordre) {

        SuiviPoseurDTO suiviPoseurDTO = new SuiviPoseurDTO()

        suiviPoseurDTO.setIdDevis(ordre.factureClient.devis.id)
        suiviPoseurDTO.setIdInsitu(ordre.factureClient.devis.projet.idInsitu)
        suiviPoseurDTO.setClient(ordre.factureClient.devis.projet.client.toString())
        suiviPoseurDTO.setTypeProjet(ordre.factureClient.devis.projet.getType())
        suiviPoseurDTO.setMontant(ordre.factureClient.devis.paiementPoseur())
        suiviPoseurDTO.setSupplement(ordre.factureClient.devis.supplementPoseurDirection)
        suiviPoseurDTO.setTotal(ordre.factureClient.devis.paiementTotalPoseur())
        suiviPoseurDTO.setDate(ordre.livraison)

        return suiviPoseurDTO


    }


}
