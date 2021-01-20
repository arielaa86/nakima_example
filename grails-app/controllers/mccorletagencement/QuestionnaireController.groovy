package mccorletagencement

import com.pusher.rest.Pusher
import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException
import org.springframework.security.core.context.SecurityContextHolder

import static org.springframework.http.HttpStatus.*

@Secured(['ROLE_ADMIN', 'ROLE_DIRECTEUR'])
class QuestionnaireController {

    DevisService devisService
    NotificationService notificationService

    QuestionnaireService questionnaireService
    PusherService pusherService

    ReponseService reponseService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond questionnaireService.list(params), model: [questionnaireCount: questionnaireService.count()]
    }

    def show(Long id) {
        session.controller = 'gestion_commerciale'
        respond questionnaireService.get(id)
    }

    def create() {
        def questionaire = new Questionnaire(params)

            questionnaireService.save(questionaire)

            for (question in Question.getAll().sort { it.id }) {

                def reponse = new Reponse()
                reponse.setQuestion(question)
                reponse.setQuestionaire(questionaire)
                reponseService.save(reponse)

            }



        redirect(controller: 'questionnaire', action: 'edit', params: [id: questionaire.id])
    }

    def save(Questionnaire questionnaire) {
        if (questionnaire == null) {
            notFound()
            return
        }

        try {

            questionnaireService.save(questionnaire)

        } catch (ValidationException e) {
            respond questionnaire.errors, view: 'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'questionnaire.label', default: 'Questionnaire'), questionnaire.id])
                redirect questionnaire
            }
            '*' { respond questionnaire, [status: CREATED] }
        }
    }

    def edit(Long id) {
        session.controller = 'gestion_commerciale'
        respond questionnaireService.get(id)
    }

    def update(Questionnaire questionnaire) {
        if (questionnaire == null) {
            notFound()
            return
        }

        int cont = 0

        try {

            def reponses = questionnaire.getReponses().sort { it.id }

            for (int i = 0; i < reponses.size(); i++) {
                String param = "question" + i

                def reponse = reponses.getAt(i)

                if (params.list(param)[0] != null) {
                    String motif = params.texteAutre

                    if (motif) {
                        reponse.setTexteAutre(motif)
                    }

                    reponse.setSelectionne(true)
                    cont++

                } else {
                    reponse.setTexteAutre(null)
                    reponse.setSelectionne(false)
                }

            }

            if (cont > 0) {
                for (int i = 0; i < reponses.size(); i++) {
                    def reponse = reponses.getAt(i)
                    reponseService.save(reponse)
                }
            } else {

                flash.error = "Veuillez sélectionner au moins une réponse"
                redirect controller: 'questionnaire', action: 'edit', id: questionnaire.id
                return

            }


        } catch (ValidationException e) {
            respond questionnaire.errors, view: 'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'questionnaire.label', default: 'Questionnaire'), questionnaire.id])
                redirect questionnaire
            }
            '*' { respond questionnaire, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        questionnaireService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'questionnaire.label', default: 'Questionnaire'), id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'questionnaire.label', default: 'Questionnaire'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }


    def reouvrirDevis() {


        def id = params.id

        def devisInstance = Devis.findById(id)

        devisInstance.setEnvoye(false)
        devisInstance.setValide(false)
        devisInstance.setApprouve(false)
        devisInstance.setDecline(false)
        devisInstance.setToujoursInteresse(false)
        devisInstance.setReouvert(true)


        devisInstance.setaRembourser(0)
        devisInstance.setAvoir(0)
        devisInstance.setAvoirUtilise(null)
        devisInstance.setAvoirUtiliseDecline(null)

        devisService.save(devisInstance)


        def notificationList = Notification.findAllByProjetIdInsitu(devisInstance.projet.idInsitu)

        for (notificationInstance in notificationList) {
            notificationInstance.ancienne = true
        }

        def utilisateur = Utilisateur.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName())

        def array = new Long[1]
        array[0] = devisInstance.projet.concepteur.id

        Notification notification = new Notification()
        notification.idObjet = devisInstance.getId()
        notification.typeNotification = "devisReouvert"
        notification.projetIdInsitu = devisInstance.projet.idInsitu
        notification.texte = "Devis No." + devisInstance.projet.idInsitu + " à été réouvert"
        notification.date = new Date()
        notification.controleur = "devis"
        notification.action = "show"
        notification.creator = utilisateur.id
        notification.tempsEcoule = notification.obtenirTempsEcoule()
        notification.destinataires = array

        notificationService.save(notification)

        pusherService.push("Notification:"+utilisateur.id+":"+array.toString())

        redirect controller: 'devis', action: 'suiviDevis'


    }


}
