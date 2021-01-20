package mccorletagencement.dataServices

import daos.RecetteDepenseDAO
import daos.SuiviCommercialDAO
import grails.gorm.transactions.Transactional
import mccorletagencement.FactureClient
import mccorletagencement.FactureFournisseur
import mccorletagencement.Paiement
import mccorletagencement.Role
import mccorletagencement.StatistiquesService
import mccorletagencement.UtilisateurService

import java.text.SimpleDateFormat
import java.util.stream.Collectors

@Transactional
class StatistiquesDataService {

    UtilisateurService utilisateurService
    StatistiquesService statistiquesService

    def getListeSuiviCommercial(String dateValue) {

        Calendar cal = Calendar.getInstance()
        cal.setTime(new SimpleDateFormat("MMMM yyyy", Locale.FRANCE).parse(dateValue))


        List<SuiviCommercialDAO> listeSuiviCommercial = new ArrayList<>()

        utilisateurService.list()
                .stream()
                .filter({
                    utilisateur ->
                        utilisateur.authorities.contains( Role.findByAuthority("ROLE_COMMERCIAL") )
                })
                .collect(Collectors.toList())
                .forEach({ utilisateur ->
                    listeSuiviCommercial.add( statistiquesService.detailsCommercial(cal.getTime(), utilisateur) )
                })

        return listeSuiviCommercial


    }

    def graphiqueAnnuele(int annee){

        def cal =  Calendar.getInstance()
        cal.setTime(new Date())
        cal.set(Calendar.DATE, 1)
        cal.set(Calendar.MONTH, 0)
        cal.set(Calendar.YEAR, annee)
        cal.set(Calendar.HOUR_OF_DAY, 0)
        cal.set(Calendar.MINUTE, 0)
        cal.set(Calendar.SECOND, 0)

        def minDate =  cal.getTime()

        cal.add(Calendar.YEAR, 1)

        def maxDate =  cal.getTime()

        def totalRecette = 0
        def totalDepense = 0


        List<RecetteDepenseDAO> liste = new ArrayList<>()

        for (i in 1..< 13) {
            liste.add(new RecetteDepenseDAO(i))
        }

        Paiement.findAllByDateBetween(minDate, maxDate).stream()
                .forEach({p ->
                    totalRecette += p.montant
                    getRecetes(p,liste)

        })

        FactureFournisseur.findAllByDateBetween(minDate, maxDate).sort({it.date}).stream()
                .forEach({f ->
                    totalDepense += f.montant
                    getDepenses(f, liste)
                })


        FactureClient.findAllByDateBetween(minDate, maxDate).sort({it.date}).stream()
                .forEach({f ->
                    getGestes(f, liste)
                })


        return liste

    }


    def getRecetes(Paiement paiement, List<RecetteDepenseDAO> liste ){

        def date = paiement.getDate()

        def cal =  Calendar.getInstance()
        cal.setTime(date)
        int mois = cal.get(Calendar.MONTH) + 1

        switch (mois){
            case 1:
                def rd = liste.get(mois-1)
                rd.setRecette(rd.getRecette()+paiement.montant)
                break
            case 2:
                def rd = liste.get(mois-1)
                rd.setRecette(rd.getRecette()+paiement.montant)
                break
            case 3:
                def rd = liste.get(mois-1)
                rd.setRecette(rd.getRecette()+paiement.montant)
                break
            case 4:
                def rd = liste.get(mois-1)
                rd.setRecette(rd.getRecette()+paiement.montant)
                break
            case 5:
                def rd = liste.get(mois-1)
                rd.setRecette(rd.getRecette()+paiement.montant)
                break
            case 6:
                def rd = liste.get(mois-1)
                rd.setRecette(rd.getRecette()+paiement.montant)
                break
            case 7:
                def rd = liste.get(mois-1)
                rd.setRecette(rd.getRecette()+paiement.montant)
                break
            case 8:
                def rd = liste.get(mois-1)
                rd.setRecette(rd.getRecette()+paiement.montant)
                break
            case 9:
                def rd = liste.get(mois-1)
                rd.setRecette(rd.getRecette()+paiement.montant)
                break
            case 10:
                def rd = liste.get(mois-1)
                rd.setRecette(rd.getRecette()+paiement.montant)
                break
            case 11:
                def rd = liste.get(mois-1)
                rd.setRecette(rd.getRecette()+paiement.montant)
                break
            default:
                def rd = liste.get(11)
                rd.setRecette(rd.getRecette()+paiement.montant)
        }

    }


    def getDepenses(FactureFournisseur facture, List<RecetteDepenseDAO> liste ){

        def date = facture.getDate()

        def cal =  Calendar.getInstance()
        cal.setTime(date)
        int mois = cal.get(Calendar.MONTH) + 1

        switch (mois){
            case 1:
                def rd = liste.get(mois-1)
                rd.setDepense(rd.getDepense()+ facture.getMontant())
                break
            case 2:
                def rd = liste.get(mois-1)
                rd.setDepense(rd.getDepense()+ facture.getMontant())
                break
            case 3:
                def rd = liste.get(mois-1)
                rd.setDepense(rd.getDepense()+ facture.getMontant())
                break
            case 4:
                def rd = liste.get(mois-1)
                rd.setDepense(rd.getDepense()+ facture.getMontant())
                break
            case 5:
                def rd = liste.get(mois-1)
                rd.setDepense(rd.getDepense()+ facture.getMontant())
                break
            case 6:
                def rd = liste.get(mois-1)
                rd.setDepense(rd.getDepense()+ facture.getMontant())
                break
            case 7:
                def rd = liste.get(mois-1)
                rd.setDepense(rd.getDepense()+ facture.getMontant())
                break
            case 8:
                def rd = liste.get(mois-1)
                rd.setDepense(rd.getDepense()+ facture.getMontant())
                break
            case 9:
                def rd = liste.get(mois-1)
                rd.setDepense(rd.getDepense()+ facture.getMontant())
                break
            case 10:
                def rd = liste.get(mois-1)
                rd.setDepense(rd.getDepense()+ facture.getMontant())
                break
            case 11:
                def rd = liste.get(mois-1)
                rd.setDepense(rd.getDepense()+ facture.getMontant())
                break
            default:
                def rd = liste.get(11)
                rd.setDepense(rd.getDepense()+ facture.getMontant())
        }



    }

    def getGestes(FactureClient facture, List<RecetteDepenseDAO> liste ){

        def date = facture.getDate()

        def cal =  Calendar.getInstance()
        cal.setTime(date)
        int mois = cal.get(Calendar.MONTH) + 1

        switch (mois){
            case 1:
                def rd = liste.get(mois-1)
                rd.setDepense(rd.getDepense() + facture.annulationDirection)
                break
            case 2:
                def rd = liste.get(mois-1)
                rd.setDepense(rd.getDepense() + facture.annulationDirection)
                break
            case 3:
                def rd = liste.get(mois-1)
                rd.setDepense(rd.getDepense() + facture.annulationDirection)
                break
            case 4:
                def rd = liste.get(mois-1)
                rd.setDepense(rd.getDepense() + facture.annulationDirection)
                break
            case 5:
                def rd = liste.get(mois-1)
                rd.setDepense(rd.getDepense() + facture.annulationDirection)
                break
            case 6:
                def rd = liste.get(mois-1)
                rd.setDepense(rd.getDepense() + facture.annulationDirection)
                break
            case 7:
                def rd = liste.get(mois-1)
                rd.setDepense(rd.getDepense() + facture.annulationDirection)
                break
            case 8:
                def rd = liste.get(mois-1)
                rd.setDepense(rd.getDepense() + facture.annulationDirection)
                break
            case 9:
                def rd = liste.get(mois-1)
                rd.setDepense(rd.getDepense() + facture.annulationDirection)
                break
            case 10:
                def rd = liste.get(mois-1)
                rd.setDepense(rd.getDepense() + facture.annulationDirection)
                break
            case 11:
                def rd = liste.get(mois-1)
                rd.setDepense(rd.getDepense() + facture.annulationDirection)
                break
            default:
                def rd = liste.get(11)
                rd.setDepense(rd.getDepense() + facture.annulationDirection)
        }



    }









}
