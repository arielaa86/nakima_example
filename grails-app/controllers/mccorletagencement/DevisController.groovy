package mccorletagencement

import com.google.gson.Gson
import com.pusher.rest.Pusher
import dtos.DevisDTO
import grails.plugin.springsecurity.annotation.Secured
import grails.plugins.mail.MailService
import grails.validation.ValidationException
import mccorletagencement.dataServices.DevisDataService
import mccorletagencement.dataServices.EmailDataService
import org.springframework.security.core.context.SecurityContextHolder

import java.text.DecimalFormat
import java.text.NumberFormat
import java.text.SimpleDateFormat

import static org.springframework.http.HttpStatus.*

@Secured(['ROLE_ADMIN', 'ROLE_DIRECTEUR', 'ROLE_COMMERCIAL'])
class DevisController {

    DevisService devisService
    DevisDataService devisDataService
    DocumentOutilsService documentOutilsService
    NotificationService notificationService
    EtatService etatService
    ProjetService projetService
    FactureClientService factureClientService
    PusherService pusherService
    CommentaireService commentaireService
    EmailDataService emailDataService
    TransfertService transfertService


    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index() {
        session.controller = 'gestion_commerciale'
        def id = Long.valueOf(params.idClient)

        List<Devis> devis = new ArrayList<>()

        for (projet in Projet.findAllByClient(Client.get(id))) {

            if (projet.devisClient != null) {
                if (!projet.devisClient.approuve) {
                    devis.add(projet.devisClient)
                }

                if (projet.devisClient.approuve && projet.devisClient.facture.signatureClient == null) {
                    devis.add(projet.devisClient)
                }
            }


        }

        [devisList: devis]
    }


    def suiviDevis() {

        session.controller = 'gestion_commerciale'

        List<DevisDTO> devisReouvert = new ArrayList<>()
        List<DevisDTO> devisNonValides = new ArrayList<>()
        List<DevisDTO> devisAttente = new ArrayList<>()
        List<DevisDTO> devisDecline = new ArrayList<>()
        List<DevisDTO> devisBrouillons = new ArrayList<>()

        devisDataService.obtenirDevis(devisReouvert, devisNonValides, devisAttente, devisDecline, devisBrouillons)


        devisReouvert.sort { d1, d2 -> d2.date <=> d1.date }
        devisNonValides.sort { d1, d2 -> d2.date <=> d1.date }
        devisAttente.sort { d1, d2 -> d2.date <=> d1.date }
        devisDecline.sort { d1, d2 -> d2.date <=> d1.date }
        devisBrouillons.sort { d1, d2 -> d2.date <=> d1.date }


        render(view: 'suiviDevis', model: [devisBrouillons: devisBrouillons, devisAttente: devisAttente, devisDecline: devisDecline, devisNonValides: devisNonValides, devisReouvert: devisReouvert])

    }


    def show(Long id) {
        session.controller = 'gestion_commerciale'

        def devis = devisService.get(id)


        if (devis.facture != null) {
            redirect controller: 'factureClient', action: 'show', id: devis.facture.id
            return
        }

        ['devis': devis, 'references': documentOutilsService.readDocument(devis.getDocumentWord())]

    }


    @Secured(['ROLE_ADMIN', 'ROLE_DIRECTEUR'])
    def showDevisDir(Long id) {
        session.controller = 'gestion_commerciale'

        def devis = devisService.get(id)

        ['devis': devis, 'references': documentOutilsService.readDocument(devis.getDocumentWord())]

    }

    def create() {
        session.controller = 'gestion_commerciale'

        def devis = new Devis(params)
        [devis: devis, client: devis.projet.client]
    }


    def createComplement() {
        session.controller = 'gestion_commerciale'

        def projet = projetService.get(params.projet)

        def devisPrincipal = projet.projetPrincipal.devisClient

        def devis = new Devis(params)

        [devis: devis, devisPrincipal: devisPrincipal]

    }


    def save(Devis devis) {

        if (devis == null) {
            notFound()
            return
        }

        def devisExistent = Devis.findByProjet(devis.projet)

        if (devisExistent) {
            redirect action: 'show', id: devisExistent.id
            return
        }

        try {


            if (params.ancien == null) {
                devis.setAncien(false)
                devis.setDate(new Date())

                try {
                    devis.setAnnulation(Double.valueOf(params.annulationSolde))
                } catch (Exception ex) {
                    devis.setAnnulation(0.0)
                }

            } else {
                devis.setAncien(true)
                devis.getProjet().setDate(devis.date)

                try {
                    devis.setAnnulation(Double.valueOf(params.annulationVerif))
                } catch (Exception ex) {
                    devis.setAnnulation(0.0)
                }

            }


            def validite = params.validite

            Calendar cal = Calendar.getInstance()
            cal = Calendar.getInstance()
            cal.set(Calendar.HOUR_OF_DAY, 0)
            cal.set(Calendar.MINUTE, 0)
            cal.set(Calendar.SECOND, 0)

            switch (validite) {
                case '3 semaines':
                    cal.add(Calendar.DATE, 25)
                    Date dateExpiration = cal.getTime()
                    devis.setExpiration(dateExpiration)
                    break

                case '2 semaines':
                    cal.add(Calendar.DATE, 18)
                    Date dateExpiration = cal.getTime()
                    devis.setExpiration(dateExpiration)
                    break

                default:
                    cal.add(Calendar.DATE, 11)
                    Date dateExpiration = cal.getTime()
                    devis.setExpiration(dateExpiration)
                    break

            }

            def utilisateur = Utilisateur.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName())


            if (utilisateur.authorities.contains(Role.findByAuthority("ROLE_DIRECTEUR"))) {

                devis.setEnvoye(true)
                devis.setValide(true)


                devis.setCodeEmail(devis.getProjet().getIdInsitu().sha256())

                devisService.save(devis)

            } else {


                devis.setCodeEmail(devis.getProjet().getIdInsitu().sha256())
                devisService.save(devis)

                def etat = new Etat()
                etat.setDescription("Attente")
                etat.setDate(new Date())
                etat.setDevis(devis)

                etatService.save(etat)
            }


            if (params.avoirUtilise) {
                def avoir = devisService.get(params.avoirUtilise)
                avoir.setVisible(false)

            }

            devis.setCreePar(utilisateur)

            devisService.save(devis)


        } catch (ValidationException e) {
            respond devis.errors, view: 'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'devis.label', default: 'Devis'), devis.id])
                redirect devis
            }
            '*' { respond devis, [status: CREATED] }
        }
    }


    def declinerSansEnvoyer(Long id) {

        def devis = devisService.get(id)

        devis.setEnvoye(true)
        devis.setValide(true)
        devis.setApprouve(false)
        devis.setDecline(true)

        def avoir = devisService.get(devis.getAvoirUtilise())

        if (avoir) {
            avoir.setVisible(true)

            devisService.save(avoir)

            devis.setaRembourser(0)
            devis.setAvoirUtilise(null)
            devis.setAvoir(0)
            devis.setAvoirUtiliseDecline(avoir.id)

        }

        devisService.save(devis)

        flash.message = "Devis décliné"

        redirect action: 'suiviDevis'

    }


    def saveComplement(Devis devis) {


        if (devis == null) {
            notFound()
            return
        }

        try {

            def prixPlanTravail = params.prixPlanTravail
            def prixOption = params.prixOption

            devis.setDate(new Date())

            devis.setPrixPlanTravail(Double.parseDouble(prixPlanTravail[1]))
            devis.setPrixOption(Double.parseDouble(prixOption[1]))

            def validite = params.validite

            Calendar cal = Calendar.getInstance()
            cal.setTime(devis.date)

            cal.set(Calendar.HOUR_OF_DAY, 0)
            cal.set(Calendar.MINUTE, 0)
            cal.set(Calendar.SECOND, 0)

            switch (validite) {
                case '3 semaines':
                    cal.add(Calendar.DATE, 25)
                    Date dateExpiration = cal.getTime()
                    devis.setExpiration(dateExpiration)
                    break

                case '2 semaines':
                    cal.add(Calendar.DATE, 18)
                    Date dateExpiration = cal.getTime()
                    devis.setExpiration(dateExpiration)
                    break

                default:
                    cal.add(Calendar.DATE, 11)
                    Date dateExpiration = cal.getTime()
                    devis.setExpiration(dateExpiration)
                    break

            }

            def utilisateur = Utilisateur.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName())
            devis.setCreePar(utilisateur)


            if (utilisateur.authorities.contains(Role.findByAuthority("ROLE_DIRECTEUR"))) {

                devis.setEnvoye(true)
                devis.setValide(true)


                devis.setCodeEmail(devis.getProjet().getIdInsitu().sha256())

                devisService.save(devis)

            } else {


                devis.setCodeEmail(devis.getProjet().getIdInsitu().sha256())
                devisService.save(devis)

                def etat = new Etat()
                etat.setDescription("Attente")
                etat.setDate(new Date())
                etat.setDevis(devis)

                etatService.save(etat)
            }


        } catch (ValidationException e) {
            respond devis.errors, view: 'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'devis.label', default: 'Devis'), devis.id])
                redirect devis
            }
            '*' { respond devis, [status: CREATED] }
        }
    }

    def edit(Long id) {
        session.controller = 'gestion_commerciale'
        def devis = devisService.get(id)
        def client = devis.projet.client


        if (devis.envoye && !devis.valide) {
            redirect controller: 'devis', action: 'show', id: devis.id
            return
        }


        if (devis.approuve) {
            redirect controller: 'factureClient', action: 'show', params: [id: devis.facture.id]
            return
        }


        if (devis.decline) {
            redirect controller: 'devis', action: 'suiviDevis'
            return
        }

        [devis: devisService.get(id), client: client]
    }


    def recommencerComplement(Long id) {

        session.controller = 'gestion_commerciale'

        def devis = devisService.get(id)
        def projet = devis.projet

        def etats = Etat.findAllByDevis(devis)
        def commentaires = Commentaire.findAllByDevis(devis)

        for (def etat in etats) {
            etatService.delete(etat.id)
        }

        for (def commentaire in commentaires) {
            commentaireService.delete(commentaire.id)
        }

        devisService.delete(devis.id)


        redirect controller: 'projetComplementaire', action: 'show', id: projet.id

    }


    def update(Devis devis) {

        if (devis == null) {
            notFound()
            return
        }

        try {

            if (params.ancien == null) {
                devis.setAncien(false)
                devis.setDate(new Date())

                try {
                    devis.setAnnulation(Double.valueOf(params.annulationSolde))
                } catch (Exception ex) {
                    devis.setAnnulation(0.0)
                }
            } else {
                devis.setAncien(true)
                try {
                    devis.setAnnulation(Double.valueOf(params.annulationVerif))
                } catch (Exception ex) {
                    devis.setAnnulation(0.0)
                }
            }


            def validite = params.validite

            Calendar cal = Calendar.getInstance()
            cal.setTime(devis.date)


            cal.set(Calendar.HOUR_OF_DAY, 0)
            cal.set(Calendar.MINUTE, 0)
            cal.set(Calendar.SECOND, 0)

            switch (validite) {
                case '3 semaines':
                    cal.add(Calendar.DATE, 25)
                    Date dateExpiration = cal.getTime()
                    devis.setExpiration(dateExpiration)
                    break

                case '2 semaines':
                    cal.add(Calendar.DATE, 18)
                    Date dateExpiration = cal.getTime()
                    devis.setExpiration(dateExpiration)
                    break

                default:
                    cal.add(Calendar.DATE, 11)
                    Date dateExpiration = cal.getTime()
                    devis.setExpiration(dateExpiration)
                    break

            }


            def utilisateur = Utilisateur.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName())

            if (utilisateur.authorities.contains(Role.findByAuthority("ROLE_DIRECTEUR"))) {

                devis.setEnvoye(true)
                devis.setValide(true)

                devisService.save(devis)

            }


            devis.setEnvoye(false)
            devis.setValide(false)

            if (devis.avoirUtilise != null) {

                def avoirUtilise = devisService.get(devis.avoirUtilise)
                avoirUtilise.setVisible(false)
                devisService.save(avoirUtilise)

                devis.setAvoirUtilise(avoirUtilise.id)

                if (params.avoirExistant) {
                    def avoir = devisService.get(params.avoirExistant)
                    avoir.setVisible(true)
                    devisService.save(avoir)
                }

            } else {

                if (params.avoirExistant) {

                    def avoir = devisService.get(params.avoirExistant)
                    avoir.setVisible(true)
                    devisService.save(avoir)


                    devis.setAvoirUtilise(null)
                    devis.setAvoir(0)
                }

            }


            devis.setCreePar(utilisateur)
            devisService.save(devis)


        } catch (ValidationException e) {
            respond devis.errors, view: 'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'devis.label', default: 'Devis'), devis.id])
                redirect devis
            }
            '*' { respond devis, [status: OK] }
        }
    }


    def updatePourLaBanque(Devis devis) {

        if (devis == null) {
            notFound()
            return
        }

        try {


            if (!devis.expire()) {
                devis.setDate(new Date())
            }

            devisService.save(devis)

        } catch (ValidationException e) {
            respond devis.errors, view: 'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = "La date du devis a été actualisée"
                redirect devis
            }
            '*' { respond devis, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        devisService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'devis.label', default: 'Devis'), id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'devis.label', default: 'Devis'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }


    def envoyer(Long id) {

        def devis = devisService.get(id)

        /*

        if (!devis.envoye) {
            devis.setCreePar(devis.getLastUser())
        }

         */

        devis.setEnvoye(true)
        devis.setReouvert(false)
        devis.setNotes(null)
        devisService.save(devis)


        def utilisateur = Utilisateur.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName())

        def notificationList = Notification.findAllByProjetIdInsitu(devis.projet.idInsitu)

        for (notificationInstance in notificationList) {
            notificationInstance.ancienne = true
        }

        Notification notification = new Notification()
        notification.idObjet = devis.getId()
        notification.typeNotification = "devisAttente"
        notification.projetIdInsitu = devis.projet.idInsitu

        if (devis.montant > 0) {
            notification.texte = "Devis No." + devis.projet.idInsitu + " en attente de validation"
        } else {
            notification.texte = "Avoir No." + devis.projet.idInsitu + " en attente de validation"
        }

        def destinataires = []
        def sendTo = []

        def utilisateurs = Utilisateur.findAll()

        for (def user in utilisateurs) {
            if (user.authorities.contains(Role.findByAuthority("ROLE_DIRECTEUR"))) {
                sendTo.add(user.getEmail())
                destinataires.add(user.id)
            }
        }

        notification.date = new Date()
        notification.creator = utilisateur.id
        notification.controleur = controllerName
        notification.action = "show"
        notification.tempsEcoule = notification.obtenirTempsEcoule()
        notification.destinataires = destinataires

        notificationService.save(notification)

        pusherService.push("Notification:" + utilisateur.id + ":" + destinataires.toString())

        try {
            sendMail {
                to sendTo
                subject "Proposition de prix à valider"
                html(view: "/devis/mail", model: ['devis': devis])
            }


            flash.message = "Le devis a été envoyé"

        } catch (Exception ex) {

        }


        if (devis.projet.instanceOf(ProjetCuisine)) {
            redirect action: 'show', controller: 'projetCuisine', params: ['id': devis.projet.id]
            return
        }

        if (devis.projet.instanceOf(ProjetSalleBain)) {
            redirect action: 'show', controller: 'projetSalleBain', params: ['id': devis.projet.id]
            return
        }

        if (devis.projet.instanceOf(ProjetDressing)) {
            redirect action: 'show', controller: 'projetDressing', params: ['id': devis.projet.id]
            return
        }

        if (devis.projet.instanceOf(ProjetPlacard)) {
            redirect action: 'show', controller: 'projetPlacard', params: ['id': devis.projet.id]
            return
        }

        if (devis.projet.instanceOf(ProjetAutre)) {
            redirect action: 'show', controller: 'projetAutre', params: ['id': devis.projet.id]
            return
        }

        if (devis.projet.instanceOf(ProjetComplementaire)) {
            redirect action: 'show', controller: 'projetComplementaire', params: ['id': devis.projet.id]
            return
        }

    }


    def modifierDocuments(Long id) {

        session.actionName = "modifierDocuments"

        def idProjet = params.idProjet
        session.idProjet = idProjet

        def projet = projetService.get(id)

        [projet: projet, idProjet: idProjet]

    }


    def valider(Long id) {


        def utilisateur = Utilisateur.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName())

        def devis = devisService.get(id)
        devis.setValide(true)

        def notificationList = Notification.findAllByProjetIdInsitu(devis.projet.idInsitu)

        for (notificationInstance in notificationList) {
            notificationInstance.ancienne = true
        }

        def array = new Long[1]
        array[0] = devis.getLastUser().id

        Notification notification = new Notification()
        notification.typeNotification = "devisValide"
        notification.projetIdInsitu = devis.projet.idInsitu
        notification.date = new Date()
        notification.creator = utilisateur.id
        notification.action = "show"
        notification.destinataires = array

        if (devis.montant < 0) {

            def facture = new FactureClient()

            def calendar = Calendar.getInstance()
            calendar.setTime(new Date())
            calendar.add(Calendar.YEAR, 1)

            facture.setDate(new Date())
            facture.setDateValiditeAvoir(calendar.getTime())
            facture.setDevis(devis)

            factureClientService.save(facture)

            devis.setApprouve(true)
            devis.setFacture(facture)

            devisService.save(devis)

            notification.idObjet = devis.getFacture().id
            notification.texte = "Avoir No." + devis.projet.idInsitu + " validé"
            notification.controleur = "factureClient"

        } else {

            devisService.save(devis)

            notification.idObjet = devis.id
            notification.texte = "Devis No." + devis.projet.idInsitu + " validé"
            notification.controleur = controllerName

        }

        notification.tempsEcoule = notification.obtenirTempsEcoule()
        notificationService.save(notification)

        pusherService.push("Notification:" + utilisateur.id + ":" + array.toString())

        redirect controller: 'utilisateur', action: 'espace'
        return


    }


    def refuser(Long id) {

        def devis = devisService.get(id)
        devis.setEnvoye(false)
        devisService.save(devis)

        def utilisateur = Utilisateur.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName())

        def notificationList = Notification.findAllByProjetIdInsitu(devis.projet.idInsitu)

        for (notificationInstance in notificationList) {
            notificationInstance.ancienne = true
        }


        def array = new Long[1]
        array[0] = devis.getLastUser().id

        Notification notification = new Notification()
        notification.idObjet = devis.getId()
        notification.typeNotification = "devisRefuse"
        notification.projetIdInsitu = devis.projet.idInsitu
        notification.texte = "Devis No." + devis.projet.idInsitu + " refusé"
        notification.date = new Date()
        notification.controleur = controllerName
        notification.creator = utilisateur.id
        notification.action = "show"
        notification.tempsEcoule = notification.obtenirTempsEcoule()
        notification.destinataires = array

        notificationService.save(notification)

        pusherService.push("Notification:" + utilisateur.id + ":" + array.toString())

        redirect controller: 'utilisateur', action: 'espace'

    }


    def decliner() {

        def devis = devisService.get(params.id)
        devis.setDecline(true)
        devisService.save(devis)


        def utilisateur = Utilisateur.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName())

        Commentaire commentaire = new Commentaire()
        commentaire.setCommentaireRelance(true)
        commentaire.setCommentaireAuto(true)
        commentaire.setDate(new Date())
        commentaire.setCreateur(utilisateur)
        commentaire.setDevis(devis)
        commentaire.setTexte("Le client décline la proposition")

        commentaireService.save(commentaire)

        redirect action: 'show', controller: 'devis', params: ['id': devis.id]
        return
    }


    def devisRefuse() {

    }


    def ajouterEssai() {

        def id = params.idDevis
        def devis = devisService.get(id)

        devis.setTentativeContact(devis.getTentativeContact() + 1)

        devisService.save(devis)


        def utilisateur = Utilisateur.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName())

        Commentaire commentaire = new Commentaire()
        commentaire.setCommentaireRelance(true)
        commentaire.setCommentaireAuto(true)
        commentaire.setDate(new Date())
        commentaire.setCreateur(utilisateur)
        commentaire.setDevis(devis)
        commentaire.setTexte("Le client est injoignable")

        commentaireService.save(commentaire)


        render 'Ok'

    }


    def clientToujoursInteresse() {

        def id = params.idDevis
        def devis = devisService.get(id)

        devis.setTentativeContact(devis.getTentativeContact() + 2)

        Calendar cal = Calendar.getInstance()
        cal.setTime(devis.expiration)
        cal.add(Calendar.DATE, 7)

        devis.setExpiration(cal.getTime())

        devis.setToujoursInteresse(true)

        devisService.save(devis)

        def utilisateur = Utilisateur.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName())

        Commentaire commentaire = new Commentaire()
        commentaire.setCommentaireRelance(true)
        commentaire.setCommentaireAuto(true)
        commentaire.setDate(new Date())
        commentaire.setCreateur(utilisateur)
        commentaire.setDevis(devis)
        commentaire.setTexte("Le client est toujours intéressé")

        commentaireService.save(commentaire)

        render 'Ok'

    }


    def envoyerEmail() {

        String id = params.id

        def devis = devisService.get(id)


        try {


            boolean envoye = emailDataService.sendEmailDevis(devis)

            boolean confirmation = emailDataService.sendEmailConfirmation(devis)

            if (envoye && confirmation) {
                flash.message = "Le devis a bien été envoyé"
            }


        } catch (Exception ex) {

            flash.error = "Il y a eu un problème au moment de l'envoi de l'email. Merci de réessayer dans quelques instants."

        }


        redirect action: 'show', id: devis.id

    }


    @Secured(['permitAll'])
    def showDevis(String codeEmail) {

        def devis = Devis.findByCodeEmail(codeEmail)

        try {
            if (!devis.confirmationLecture) {

                sendMail {
                    to devis.projet.concepteur.email
                    subject "Confirmation de lecture du devis No. " + devis.projet.idInsitu
                    html(view: "/devis/mailConfirmationLecture", model: ['devis': devis])
                }

                devis.setConfirmationLecture(true)

                devisService.save(devis)
            }

        } catch (Exception ex) {

        }


        ['devis': devis, 'references': documentOutilsService.readDocument(devis.getDocumentWord())]


    }


    def showConditions() {

        File file = new File('./grails-app/assets/images/conditions.pdf')

        response.outputStream << file.newInputStream().bytes

        response.outputStream.flush()
        response.outputStream.close()

    }


    def debloquerRemise(long id) {

        def devis = devisService.get(id)

        if (devis.debloquerRemise) {
            devis.setDebloquerRemise(false)
        } else {
            devis.setDebloquerRemise(true)
        }

        devisService.save(devis)

        render "ok"

    }


}
