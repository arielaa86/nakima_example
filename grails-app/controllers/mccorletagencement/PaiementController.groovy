package mccorletagencement

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException
import mccorletagencement.dataServices.EtatDataService
import org.grails.datastore.mapping.model.types.Simple
import org.springframework.security.core.context.SecurityContextHolder

import java.text.SimpleDateFormat

import static org.springframework.http.HttpStatus.*

@Secured(['ROLE_ADMIN', 'ROLE_DIRECTEUR', 'ROLE_COMMERCIAL'])
class PaiementController {

    PaiementService paiementService
    DevisService devisService
    EtatService etatService
    PaiementsService paiementsService
    EtatDataService etatDataService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        session.controller = 'gestion_commerciale'
        params.max = Math.min(max ?: 10, 100)
        respond paiementService.list(params), model: [paiementCount: paiementService.count()]
    }

    def show(Long id) {
        respond paiementService.get(id)
    }

    def create() {

        session.controller = 'gestion_commerciale'
        def paiement = new Paiement(params)

        def facture = FactureClient.get(params.facture.id)

        [paiement: paiement, facture: facture]
    }

    def save(Paiement paiement) {
        if (paiement == null) {
            notFound()
            return
        }


        try {
            def montant = Double.parseDouble(params.montant)
            paiement.setMontant(montant)

            def multiple = params.multiple
            def caution = params.dateProchaineEcheance

            if (multiple != null) {
                paiement.setMultiple(true)
            }

            if (montant - 0.2 > paiement.facture.restantDu()) {

                flash.error = "Le montant saisi ne peut être supérieur au reste à payer. Veuillez vérifier les informations."

                redirect action: 'create', params: ['facture.id': paiement.facture.id, 'montant': montant]
                return


            }
        } catch (Exception e) {

            flash.error = "Le format de votre saisie est incorrect."

            redirect action: 'create', params: ['facture.id': paiement.facture.id, 'montant': params.montant]
            return

        }

        try {


            def uploadedFileName = request.getFile("pieceJointe")
            String fileName = uploadedFileName.originalFilename

            String[] arr = fileName.split("\\.")

            paiement.setDocumentType(arr[arr.length - 1])

            def dateEnregistrement = new Date()

            paiement.setDate(dateEnregistrement)

            def utilisateur = Utilisateur.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName())

            paiement.setUtilisateur(utilisateur)



            if (paiement.dateProchaineEcheance) {
                paiement.setEncaisse(false)
                paiementService.save(paiement)
            }else {


                paiementService.save(paiement)


                if (paiement.facture.restantDu() > 0) {


                    def regleCeJour = paiement.facture.regleCeJour() + paiement.montant
                    def totalApayer = paiement.facture.totalPayer()

                    def etat = new Etat()

                    if (regleCeJour == totalApayer) {
                        etat.setDescription("Acquittee")

                        if (!etatDataService.existEtatCommissione(paiement.facture.devis)) {
                            etat.setCommissione(true)
                            def lastUser = paiement.facture.devis.projet.getLastTransfertUser().id
                            etat.setUtilisateur_commissione(lastUser)
                        }

                    } else {

                        etat.setDescription("En cours")

                        if (!etatDataService.existEtatCommissione(paiement.facture.devis) && regleCeJour >= (paiement.facture.devis.compoQuarante - 0.01)) {
                            etat.setCommissione(true)
                            def lastUser = paiement.facture.devis.projet.getLastTransfertUser().id
                            etat.setUtilisateur_commissione(lastUser)
                        }

                    }


                    etat.setDate(dateEnregistrement)
                    etat.setDevis(paiement.facture.devis)

                    etatService.save(etat)
                }
            }

            flash.message = "Paiement enregistré"

            redirect action: 'create', params: ['facture.id': paiement.facture.id]
            return

        } catch (ValidationException e) {
            //respond paiement.errors, view: 'create', params: ['facture.id': paiement.facture.id, 'montant': params.montant]
            flash.error = "Le montant est inférieur à la valeur minimum permise"

            redirect action: 'create', params: ['facture.id': paiement.facture.id, 'montant': params.montant]
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'paiement.label', default: 'Paiement'), paiement.id])
                redirect paiement
            }
            '*' { respond paiement, [status: CREATED] }
        }
    }

    def edit(Long id) {
        session.controller = 'gestion_commerciale'
        respond paiementService.get(id)
    }

    def update(Paiement paiement) {
        if (paiement == null) {
            notFound()
            return
        }

        try {
            paiementService.save(paiement)
        } catch (ValidationException e) {
            respond paiement.errors, view: 'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'paiement.label', default: 'Paiement'), paiement.id])
                redirect paiement
            }
            '*' { respond paiement, [status: OK] }
        }
    }

    def delete(Long id) {

        if (id == null) {
            notFound()
            return
        }

        def idFacture = paiementService.get(id).getFacture().id
        def paiement = paiementService.get(id)
        paiement.setSupprime(true)
        paiementService.save(paiement)


        etatDataService.deleteEtatDate(paiement.date, paiement.facture.devis)


        if (paiement.facture.totalPaiements() == 0) {

            def etat = new Etat()
            etat.setDescription("Impayee")
            etat.setDate(new Date())
            etat.setDevis(paiement.facture.devis)
            etatService.save(etat)

        }


        render template: 'tableauPaiement', model: [facture: FactureClient.get(idFacture)]
        return

        /*
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'paiement.label', default: 'Paiement'), id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }*/
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'paiement.label', default: 'Paiement'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }


    def montrerPieceJointe() {


        def id = params.id

        def paiement = paiementService.get(id)

        response.outputStream << paiement.pieceJointe

        response.outputStream.flush()
        response.outputStream.close()

    }


    @Secured(['ROLE_ADMIN', 'ROLE_DIRECTEUR'])
    def suiviEncaissement() {
        session.controller = 'gestion_financiere'


        def date = new Date()

        String actualDate = new SimpleDateFormat("dd MMMM yyyy", Locale.FRANCE).format(date)

        date = new SimpleDateFormat("dd MMMM yyyy", Locale.FRANCE).parse(actualDate)

        def paiementsDAO = paiementsService.getAllPaymentsByDate(date)

        def resumeCommerciaux = paiementsService.getResumeCommercial(date)


        [paiementsDAO: paiementsDAO, resumeCommerciaux: resumeCommerciaux, actualDate: actualDate]

    }


    @Secured(['ROLE_ADMIN', 'ROLE_DIRECTEUR'])
    def suiviEncaissementAjax() {


        Date date = new SimpleDateFormat("dd MMMM yyyy", Locale.FRANCE).parse(params.date)

        def paiementsDAO = paiementsService.getAllPaymentsByDate(date)

        def resumeCommerciaux = paiementsService.getResumeCommercial(date)

        render template: 'encaissementTemplate', model: [paiementsDAO: paiementsDAO, resumeCommerciaux: resumeCommerciaux]

    }


    def encaisser(){


        def dateEnregistrement = new Date()
        def paiement = paiementService.get(params.id)
        paiement.setEncaisse(true)
        paiement.setDate(dateEnregistrement)
        paiementService.save(paiement)


        if (paiement.facture.restantDu() > 0) {


            def regleCeJour = paiement.facture.regleCeJour() + paiement.montant
            def totalApayer = paiement.facture.totalPayer()

            def etat = new Etat()

            if (regleCeJour == totalApayer) {
                etat.setDescription("Acquittee")

                if (!etatDataService.existEtatCommissione(paiement.facture.devis) ){
                    etat.setCommissione(true)
                }

            } else {

                etat.setDescription("En cours")

                if (!etatDataService.existEtatCommissione(paiement.facture.devis) && regleCeJour >= (paiement.facture.devis.compoQuarante - 0.01)) {
                    etat.setCommissione(true)
                }

            }


            etat.setDate(dateEnregistrement)
            etat.setDevis(paiement.facture.devis)

            etatService.save(etat)
        }




        render 'ok'
    }


    def sauvegarder(){
        def paiement = paiementService.get(params.id)
        Date date = new SimpleDateFormat("yyyy-MM-dd", Locale.FRANCE).parse(params.date)
        paiement.setDateProchaineEcheance(date)
        paiementService.save(paiement)

        render 'ok'
    }


    def annuler(){
        def paiement = paiementService.get(params.id)
        paiement.setSupprime(true)
        paiementService.save(paiement)

        render 'ok'
    }



    def getDetailsPaiement(){

        def paiement = paiementService.get(params.id)

        def jsonMap = [id: paiement.id,
                       montant: paiement.montant,
                       date: new SimpleDateFormat('yyyy-MM-dd').format(paiement.dateProchaineEcheance),
                       minDate: new SimpleDateFormat('yyyy-MM-dd').format(new Date())]

        render jsonMap as JSON

    }


}
