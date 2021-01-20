package mccorletagencement

import dtos.BdcDTO
import grails.gorm.transactions.Transactional

import java.util.stream.Collectors

@Transactional
class FactureClientDataService {

    FactureClientService factureClientService

    def obtenirFacturesEnCoursEtImpayees(List<BdcDTO> encours, List<BdcDTO> impayees) {


        FactureClient.findAll().forEach({
            facture ->

                if (facture.devis.montant > 0 && facture.totalPaiements() == 0) {

                    def bdc = obtenirInfo(facture)
                    impayees.add(bdc)
                }

                if ( facture.totalPaiements() > 0 && !facture.isClosed() && facture.devis.montant > 0) {

                    def bdc = obtenirInfo(facture)
                    encours.add(bdc)
                }
        })

    }





    def obtenirFactures(List<BdcDTO> facturesAcquittees, List<BdcDTO> facturesAvoir) {


        FactureClient.findAll().forEach({
            facture ->
                if (facture.isClosed()) {

                    def bdc = obtenirInfo(facture)

                    facturesAcquittees.add(bdc)
                }

                if (facture.devis.montant < 0) {

                    def bdc = obtenirInfo(facture)
                    facturesAvoir.add(bdc)
                }
        })


    }







    private BdcDTO obtenirInfo(FactureClient facture){
        BdcDTO bdc = new BdcDTO()

        bdc.setId(facture.id)
        bdc.setDate(facture.date)
        bdc.setIdInsitu(facture.devis.projet.idInsitu)
        bdc.setIdClient(facture.devis.projet.client.id)
        bdc.setSignatureClient(facture.signatureClient == null ? false : true)
        bdc.setDateValiditeAvoir(facture.dateValiditeAvoir)
        bdc.setDevisVisible(facture.devis.visible)
        bdc.setLancerProduction(facture.lancerProduction)
        bdc.setClosed(facture.isClosed())
        bdc.setPretPourLancerProduction(facture.pretPourLancerProduction())
        bdc.setType(facture.devis.projet.getType())
        bdc.setTotalPayer(facture.totalPayer())
        bdc.setMontant(facture.devis.montant)
        bdc.setRestantDuAvecGesteCommercial(facture.restantDuAvecGesteCommercial())
        bdc.setClient(facture.devis.projet.client.toString())
        //bdc.setConcepteur(facture.devis.projet.concepteur.toString())
        bdc.setConcepteur(facture.getLastUser().toString())
        bdc.setProjetComplementaire(facture.devis.projet.instanceOf(ProjetComplementaire))
        bdc.setDelaiRealisation(facture.devis.projet.delaiRealisation)
        bdc.setOrdreProduction(facture.ordreProduction == null ? false : true)

        if(bdc.isOrdreProduction()) {
            bdc.setOrdreProductionDate(facture.ordreProduction.date == null ? null : facture.ordreProduction.date)
        }

        return bdc
    }



}
