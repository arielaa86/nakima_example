package mccorletagencement

import com.pusher.rest.Pusher
import dtos.BdcDTO
import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException
import mccorletagencement.dataServices.EmailDataService
import mccorletagencement.dataServices.EtatDataService
import org.springframework.security.core.context.SecurityContextHolder

import java.util.stream.Collectors

import static org.springframework.http.HttpStatus.*


@Secured(['ROLE_ADMIN', 'ROLE_DIRECTEUR', 'ROLE_COMMERCIAL'])
class FactureClientController {

    FactureClientService factureClientService
    DevisService devisService
    EtatService etatService
    PlanService planService
    FactureClientDataService factureClientDataService
    DocumentOutilsService documentOutilsService
    OrdreProductionService ordreProductionService
    PusherService pusherService
    EtatDataService etatDataService
    EtatProductionService etatProductionService
    NotificationService notificationService

    EmailDataService emailDataService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index() {

        session.controller = 'gestion_commerciale'

        def id = Long.valueOf(params.idClient)

        List<FactureClient> factures = new ArrayList<>()

        for (projet in Projet.findAllByClient(Client.get(id))) {

            if (projet.devisClient?.facture != null) {
                factures.add(projet.devisClient.facture)
            }
        }

        [factures: factures]
    }


    def suiviFactures() {

        session.controller = 'gestion_commerciale'

        List<BdcDTO> facturesAcquittees = new ArrayList<>()
        List<BdcDTO> facturesAvoir = new ArrayList<>()

        factureClientDataService.obtenirFactures(facturesAcquittees, facturesAvoir)

        [facturesAcquittees: facturesAcquittees.sort{it.date }, facturesAvoir: facturesAvoir.sort{it.date }]

    }


    def suiviBDC() {

        session.controller = 'gestion_commerciale'

        List<BdcDTO> facturesImpayees = new ArrayList<>()
        List<BdcDTO> factures = new ArrayList<>()

        factureClientDataService.obtenirFacturesEnCoursEtImpayees(factures, facturesImpayees)

        [facturesImpayees: facturesImpayees, factures: factures]


        [facturesImpayees: facturesImpayees.sort {bdc1,bdc2 -> bdc2.idInsitu <=> bdc1.idInsitu },
         factures: factures.sort { bdc1,bdc2 -> bdc2.idInsitu <=> bdc1.idInsitu  }]



    }

    @Secured(['ROLE_ADMIN', 'ROLE_DIRECTEUR', 'ROLE_COMMERCIAL'])
    def show(Long id) {
        session.controller = 'gestion_commerciale'

        def facture = factureClientService.get(id)

        if (facture.isClosed()) {

            if (facture.devis.montant == 0) {

            } else {

                redirect action: 'factureAcquittee', id: facture.id
                return
            }
        }

        ['factureClient': facture, 'references': documentOutilsService.readDocument(facture.devis.getDocumentWord())]
    }


    @Secured(['ROLE_ADMIN', 'ROLE_DIRECTEUR'])
    def showFacture(Long id) {
        session.controller = 'gestion_commerciale'

        def facture = factureClientService.get(id)

        ['factureClient': facture, 'references': documentOutilsService.readDocument(facture.devis.getDocumentWord())]
    }

    def create() {
        session.controller = 'gestion_commerciale'

        def devisId = params."devis.id"

        def devis = Devis.findById(devisId)

        if (devis.facture == null) {

            def facture = new FactureClient(params)

            if (!facture.devis.valide) {

                redirect controller: 'devis', action: 'show', params: [id: facture.devis.id]
                return
            }

            ['factureClient': facture, 'references': documentOutilsService.readDocument(facture.devis.getDocumentWord())]


        } else {

            redirect action: 'show', id: devis.facture.id
            return
        }

    }


    def edit(Long id) {
        respond factureClientService.get(id)
    }


    def factureAcquittee(Long id) {

        session.controller = 'gestion_commerciale'

        def facture = factureClientService.get(id)

        if (!facture.isClosed()) {

            redirect controller: 'factureClient', action: 'show', params: [id: facture.id]
            return

        }


        if (!etatDataService.existEtatAcquitte(facture)) {

            def etat = new Etat()
            etat.setDescription("Acquittee")
            etat.setDate(new Date())
            etat.setDevis(facture.devis)
            etatService.save(etat)

            def listaProjets = facture.getAllComplements()

            for (def projet in listaProjets) {

                def bdc = projet.devisClient.facture
                bdc.setClosed(true)
                factureClientService.save(bdc)

            }


            facture.setDate(new Date())


            factureClientService.save(facture)

        }


        def count = facture.getAllComplements().size()

        def document = null

        if (count > 0) {

            def lastProjet = facture.getAllComplements().sort({ it.date }).get(count - 1)
            document = documentOutilsService.readDocument(lastProjet.devisClient.getDocumentWord())

        } else {
            document = documentOutilsService.readDocument(facture.devis.getDocumentWord())
        }

        ['factureClient': facture, 'references': document]

    }


    def save(FactureClient factureClient) {


        if (factureClient == null) {
            notFound()
            return
        }

        try {

            def devis = devisService.get(factureClient.devis.id)
            def facture = FactureClient.findByDevis(devis)

            if (facture == null) {

                if (devis.projet.instanceOf(ProjetSalleBain) && devis.projet.typeHabitation.equals("Maison")) {
                    def montant = devis.montant
                    devis.montant = montant * devis.projet.quantitePieceEau
                }


                if (devis.projet.typeHabitation.equals("Immeuble")) {
                    def montant = devis.montant
                    devis.montant = montant * devis.projet.quantiteHabitation
                }

                devis.setApprouve(true)


                def utilisateur = Utilisateur.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName())

                devisService.save(devis)

                factureClient.withNewSession {
                    factureClient.setDate(new Date())
                    factureClient.setSignePar(utilisateur)
                    factureClientService.save(factureClient)
                }

            } else {
                redirect action: 'show', id: devis.facture.id
                return
            }


        } catch (ValidationException e) {
            respond factureClient.errors, view: 'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = "Le bon de commande a été créé avec succès"
                redirect factureClient
            }
            '*' { respond factureClient, [status: CREATED] }
        }
    }


    def update(FactureClient factureClient) {


        if (factureClient == null) {
            notFound()
            return
        }

        try {

            factureClient.setDate(new Date())


            factureClient.setLivraisonIncluse(params.livraisonIncluse != null ? true : false)
            factureClient.setHorsLivraison(params.horsLivraison != null ? true : false)
            factureClient.setPoseIncluse(params.poseIncluse != null ? true : false)
            factureClient.setHorsPose(params.horsPose != null ? true : false)
            factureClient.setEnlevement(params.enlevement != null ? true : false)
            factureClient.setLivraisonMC(params.livraisonMC != null ? true : false)


            factureClientService.save(factureClient)


        } catch (ValidationException e) {
            respond factureClient.errors, view: 'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = "Le bon de commande a été modifié avec succès"
                redirect factureClient
            }
            '*' { respond factureClient, [status: CREATED] }
        }
    }


    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        factureClientService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'factureClient.label', default: 'FactureClient'), id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'factureClient.label', default: 'FactureClient'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }


    def update2(FactureClient factureClient) {
        if (factureClient == null) {
            notFound()
            return
        }

        try {

            if (!factureClient.signatureClient) {

                if (params.client) {

                    String stringValue = params.client

                    byte[] signatureinBytes = Base64.getDecoder().decode(new String(stringValue.substring(stringValue.indexOf(",") + 1)).getBytes("UTF-8"))

                    factureClient.setSignatureClient(signatureinBytes)
                }

                def etat = new Etat()
                etat.setDescription("Impayee")
                etat.setDate(new Date())
                etat.setDevis(factureClient.devis)
                etatService.save(etat)

                factureClientService.save(factureClient)

                pusherService.push("signature")

                def devis = factureClient.devis
                devis.setConfirmationLecture(false)

                devisService.save(devis)

                flash.message = "Transfert réussi"
                redirect controller: 'utilisateur', action: 'espace'
                return

            } else {
                flash.message = "Bon de commande déjà signé"
                redirect controller: 'factureClient', action: 'show', id: factureClient.id
                return
            }


        } catch (ValidationException e) {
            respond factureClient.errors, view: 'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'factureClient.label', default: 'FactureClient'), factureClient.id])
                redirect factureClient
            }
            '*' { respond factureClient, [status: OK] }
        }
    }


    def update3(FactureClient factureClient) {
        if (factureClient == null) {
            notFound()
            return
        }

        try {

            if (!factureClient.signatureClient) {
                if (params.client) {

                    String stringValue = params.client

                    byte[] signatureinBytes = Base64.getDecoder().decode(new String(stringValue.substring(stringValue.indexOf(",") + 1)).getBytes("UTF-8"))

                    factureClient.setSignatureDirectuer(signatureinBytes)
                }


                factureClientService.save(factureClient)

                pusherService.push("signature")


                flash.message = "Transfert réussi"
                redirect action: 'signaturePad', id: factureClient.id
                return
            } else {
                flash.message = "Bon de commande déjà signé"
                redirect controller: 'factureClient', action: 'show', id: factureClient.id
                return
            }


        } catch (ValidationException e) {
            respond factureClient.errors, view: 'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'factureClient.label', default: 'FactureClient'), factureClient.id])
                redirect factureClient
            }
            '*' { respond factureClient, [status: OK] }
        }
    }


    def signaturePad(Long id) {

        def facture = factureClientService.get(id)
        if (facture.signatureClient) {

            flash.message = "Bon de commande déjà signé"
            redirect controller: 'factureClient', action: 'show', params: [id: facture.id]
            return
        }

        ['factureClient': facture]
    }


    def signaturePadDirecteur(Long id) {

        def facture = factureClientService.get(id)

        if (facture.signatureDirecteur) {

            redirect controller: 'factureClient', action: 'show', params: [id: facture.id]
            return
        }

        ['factureClient': facture]
    }


    def signatureSucces() {

        flash.message = "Transfert réussi"

        pusherService.push("signature")

        redirect controller: 'utilisateur', action: 'espace'

    }


    @Secured(['ROLE_ADMIN', 'ROLE_DIRECTEUR', 'ROLE_COMMERCIAL', 'ROLE_TECHNICIEN'])
    def showSignatureClient() {

        def id = params.id

        def facture = factureClientService.get(id)

        response.outputStream << facture.signatureClient

        response.outputStream.flush()
        response.outputStream.close()

    }

    def showSignatureDirecteur() {

        def id = params.id

        def facture = factureClientService.get(id)

        response.outputStream << facture.signatureDirecteur

        response.outputStream.flush()
        response.outputStream.close()

    }

    def showSignatureCommercial() {

        def id = params.id

        def concepteur = factureClientService.get(id).signePar

        response.outputStream << concepteur.signature

        response.outputStream.flush()
        response.outputStream.close()

    }

    def signer() {

        def id = params.id

        def facture = factureClientService.get(id)


        def utilisateur = Utilisateur.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName())


        sendMail {
            to utilisateur.getEmail()
            subject "Facture client à signer"
            html(view: "/factureClient/signature", model: ['factureClient': facture])
        }

    }

    def signerDirecteur() {

        def id = params.id

        def facture = factureClientService.get(id)


        def utilisateur = Utilisateur.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName())


        sendMail {
            to utilisateur.getEmail()
            subject "Facture client à signer"
            html(view: "/factureClient/signature", model: ['factureClient': facture])
        }

    }

    @Secured(['ROLE_ADMIN', 'ROLE_DIRECTEUR', 'ROLE_COMMERCIAL', 'ROLE_TECHNICIEN'])
    def printImage() {

        def id = params.id

        def plan = planService.get(id)

        render template: 'printImage', model: [id: id, factureClient: plan.getProjet().getDevisClient().facture]

    }


    def printFactureComplementaire() {

        def id = params.id

        def facture = factureClientService.get(id)

        [factureClient: facture, 'references': documentOutilsService.readDocument(facture.devis.getDocumentWord())]

    }


    def lancerProduction(Long id) {

        def utilisateur = Utilisateur.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName())


        def facture = factureClientService.get(id)

        if (!facture.lancerProduction) {

            facture.setLancerProduction(true)
            factureClientService.save(facture)

            def ordreProduction = new OrdreProduction()
            ordreProduction.setDate(new Date())
            ordreProduction.setCommentairesPourTechnicien(params.commentairesTechnicien)
            ordreProduction.setFactureClient(facture)

            if(params.anonyme == 'true') {
                ordreProduction.setAnonyme(true)
            }


            ordreProductionService.save(ordreProduction)

            for (def etape in Etape.findAll()) {
                def etatProd = new EtatProduction()
                etatProd.setEtape(etape)
                etatProd.setOrdre(ordreProduction)

                etatProductionService.save(etatProd)

            }

            def destinataires = []

            def utilisateurs = Utilisateur.findAll()

            for (def user in utilisateurs) {
                if (user.authorities.contains(Role.findByAuthority("ROLE_TECHNICIEN"))) {
                    destinataires.add(user.id)
                }
            }

            Notification notification = new Notification()
            notification.idObjet = ordreProduction.id
            notification.typeNotification = "nouvelOrdre"
            notification.projetIdInsitu = facture.devis.projet.idInsitu
            notification.texte = "Vous avez reçu un nouvel ordre de production No." + facture.devis.projet.idInsitu
            notification.date = new Date()
            notification.controleur = "ordreProduction"
            notification.creator = utilisateur.id
            notification.action = "show"
            notification.tempsEcoule = notification.obtenirTempsEcoule()
            notification.destinataires = destinataires


            notificationService.save(notification)

            pusherService.push("Notification:" + utilisateur.id + ":" + destinataires.toString())


            emailDataService.sendEmailOrdre(ordreProduction)


        }


        render template: '/factureClient/selecteur', model: [facture: facture]


    }

    def signatureManual() {
        def id = params.id
        def facture = factureClientService.get(id)

        request.getFiles("signature").each { file ->

            facture.setSignatureClient(file.inputStream.bytes)

            factureClientService.save(facture)

        }


        def etat = new Etat()
        etat.setDescription("Impayee")
        etat.setDate(new Date())
        etat.setDevis(facture.devis)

        etatService.save(etat)


        def devis = facture.devis
        devis.setConfirmationLecture(false)

        devisService.save(devis)


        redirect action: 'show', id: facture.id

    }


    def envoyerEmail() {

        String id = params.id

        def devis = devisService.get(id)


        try {


            boolean envoye = emailDataService.sendEmailFactureAcquitte(devis)

            boolean confirmation = emailDataService.sendEmailConfirmationFactureAcquittee(devis)

            if (envoye && confirmation) {
                flash.message = "La facture a bien été envoyée"
            }


        } catch (Exception ex) {

            flash.error = "Il y a eu un problème au moment de l'envoi de l'email. Merci de réessayer dans quelques instants."

        }


        redirect action: 'show', id: devis.id

    }


    @Secured(['permitAll'])
    def showFactureAcquittee(String codeEmail) {

        def devis = Devis.findByCodeEmail(codeEmail)

        try {
            if (!devis.confirmationLecture) {

                sendMail {
                    to devis.projet.concepteur.email
                    subject "Confirmation de lecture de la facture acquittée No. " + devis.projet.idInsitu
                    html(view: "/factureClient/mailConfirmationLecture", model: ['devis': devis])
                }

                devis.setConfirmationLecture(true)

                devisService.save(devis)
            }

        } catch (Exception ex) {

        }


        ['factureClient': devis.facture, 'references': documentOutilsService.readDocument(devis.getDocumentWord())]


    }


    def infoTech() {

        def utilisateur = Utilisateur.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName())

        def facture = factureClientService.get(params.id)

        def destinataires = []

        def utilisateurs = Utilisateur.findAll()

        for (def user in utilisateurs) {
            if (user.authorities.contains(Role.findByAuthority("ROLE_TECHNICIEN"))) {
                destinataires.add(user.id)
            }
        }


        Notification notification = new Notification()
        notification.idObjet = facture.ordreProduction.id
        notification.typeNotification = "correctionsEffectuees"
        notification.projetIdInsitu = facture.devis.projet.idInsitu
        notification.texte = "Les corrections du projet No." + facture.devis.projet.idInsitu + " ont été effectuées"
        notification.date = new Date()
        notification.controleur = "ordreProduction"
        notification.creator = utilisateur.id
        notification.action = "show"
        notification.tempsEcoule = notification.obtenirTempsEcoule()
        notification.destinataires = destinataires


        notificationService.save(notification)

        pusherService.push("Notification:" + utilisateur.id + ":" + destinataires.toString())


    }


    @Secured(['ROLE_ADMIN', 'ROLE_DIRECTEUR', 'ROLE_TECHNICIEN'])
    def infoCommercial() {

        def utilisateur = Utilisateur.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName())

        def facture = factureClientService.get(params.id)

        def destinataires = []

        destinataires.add(facture.devis.getLastUser().id)


        Notification notification = new Notification()
        notification.idObjet = facture.ordreProduction.id
        notification.typeNotification = "correctionsAfaire"
        notification.projetIdInsitu = facture.devis.projet.idInsitu
        notification.texte = "Il y a des corrections à faire sur le projet No." + facture.devis.projet.idInsitu
        notification.date = new Date()
        notification.controleur = "ordreProduction"
        notification.creator = utilisateur.id
        notification.action = "show"
        notification.tempsEcoule = notification.obtenirTempsEcoule()
        notification.destinataires = destinataires


        notificationService.save(notification)

        pusherService.push("Notification:" + utilisateur.id + ":" + destinataires.toString())


    }


    @Secured(['ROLE_ADMIN', 'ROLE_DIRECTEUR'])
    def annulationDirection() {
        def facture = factureClientService.get(params.id)


        def geste = 0
        try {
            geste = Double.parseDouble(params.geste)
        } catch (Exception ex) {

        }

        facture.setAnnulationDirection(geste)
        factureClientService.save(facture)


    }

    @Secured(['ROLE_ADMIN', 'ROLE_DIRECTEUR', 'ROLE_COMMERCIAL', 'ROLE_TECHNICIEN'])
    def showDecharge() {

        def id = params.id

        def facture = factureClientService.get(id)

        response.outputStream << facture.photoDecharge

        response.outputStream.flush()
        response.outputStream.close()

    }


    @Secured(['ROLE_ADMIN', 'ROLE_DIRECTEUR', 'ROLE_COMMERCIAL'])
    def dechargeResponsabilite(long id) {
        [facture: factureClientService.get(id)]
    }


    @Secured(['ROLE_ADMIN', 'ROLE_DIRECTEUR', 'ROLE_COMMERCIAL'])
    def enregistrerDecharge() {

        def id = params.idFacture

        def facture = factureClientService.get(id)

        request.getFiles("document").each { file ->

            String fileName = file.originalFilename

            String[] arr = fileName.split("\\.")

            facture.setDocumentType(arr[arr.length - 1])
            facture.setPhotoDecharge(file.inputStream.bytes)
        }

        factureClientService.save(facture)

        render "ok"
    }

    @Secured(['ROLE_ADMIN', 'ROLE_DIRECTEUR', 'ROLE_COMMERCIAL'])
    def deleteDecharge() {

        def id = params.idFacture

        def facture = factureClientService.get(id)

        facture.setPhotoDecharge(null)
        facture.setDocumentType(null)

        factureClientService.save(facture)

        render "ok"
    }


}




