package mccorletagencement.dataServices

import grails.gorm.transactions.Transactional
import mccorletagencement.Projet
import mccorletagencement.Transfert
import mccorletagencement.Utilisateur

@Transactional
class UtilisateurDataService {

    def getProjets(List<Projet> liste, List<Transfert> transferts, Utilisateur utilisateur) {

        def toRender = []

        liste.forEach({ p ->

            def etat = 'Projet'
            def devis = false
            def facture = false

            def devisId = -1
            def facturaId = -1

            def lastCommercialTransfert = p.concepteur.id

            if (p.transferts) {
                lastCommercialTransfert = p.transferts.getAt(0).destination.id
            }

            if (lastCommercialTransfert == p.concepteur.id) {

                if (p.devisClient != null) {
                    etat = 'Devis'
                    devis = true
                    devisId = p.devisClient.id


                    if (p.devisClient.facture != null) {
                        etat = 'BDC'
                        facture = true
                        facturaId = p.devisClient.facture.id

                        if (p.devisClient.facture.isClosed()) {
                            etat = 'Facture'
                        }

                        if (p.devisClient.montant < 0) {
                            etat = 'Avoir'
                        }
                    }
                }

                toRender.add(["id": p.id, "client": p.client.nom, "concepteurId": p.concepteur.id, "idInsitu": p.idInsitu, "typeProjet": p.getType(), "date": p.date,
                              "montant": p.devisClient != null ? p.devisClient.montant : '', "etat": etat, "devis": devis, "facture":facture, "devisId": devisId, "facturaId": facturaId ])

            }
        })


        transferts.forEach({ t ->

            if(t.destination == utilisateur){

                def etat = 'Projet'
                def devis = false
                def facture = false

                def devisId = -1
                def facturaId = -1

                    if (t.projet.devisClient != null) {
                        etat = 'Devis'
                        devis = true

                        devisId = t.projet.devisClient.id

                        if (t.projet.devisClient.facture != null) {
                            etat = 'BDC'
                            facture = true


                            facturaId = t.projet.devisClient.facture.id


                            if (t.projet.devisClient.facture.isClosed()) {
                                etat = 'Facture'
                            }

                            if (t.projet.devisClient.montant < 0) {
                                etat = 'Avoir'
                            }
                        }
                    }

                toRender.add(["id": t.projet.id, "client": t.projet.client.nom, "concepteurId": t.projet.concepteur.id, "idInsitu": t.projet.idInsitu, "typeProjet": t.projet.getType(),
                              "date": t.projet.date, "montant": t.projet.devisClient != null ? t.projet.devisClient.montant : '', "etat": etat, "devis":devis ,"facture":facture,  "devisId": devisId, "facturaId": facturaId ])

            }

        })

        return toRender


    }
}
