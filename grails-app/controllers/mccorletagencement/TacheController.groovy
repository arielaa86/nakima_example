package mccorletagencement

import com.google.gson.Gson
import com.pusher.rest.Pusher
import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException
import org.springframework.messaging.handler.annotation.MessageMapping
import org.springframework.messaging.handler.annotation.SendTo
import org.springframework.security.core.context.SecurityContextHolder

import java.text.SimpleDateFormat

import static org.springframework.http.HttpStatus.*

@Secured(['ROLE_ADMIN', 'ROLE_DIRECTEUR', 'ROLE_COMMERCIAL', 'ROLE_TECHNICIEN'])
class TacheController {

    TacheService tacheService
    NotificationService notificationService
    PusherService pusherService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]


    def show(Long id) {

        def utilisateur = Utilisateur.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName())

        def tache = tacheService.get(id)

        if (tache != null) {

            if (tache.creator == utilisateur || tache.getVisibilite() == "publique" || tache.getParticipants().contains(utilisateur)) {
                respond tache
                return
            }

        }

        redirect controller: 'utilisateur', action: 'espace'

    }

    def create() {
        respond new Tache(params)
    }


    def save(Tache tache) {
        if (tache == null) {
            notFound()
            return
        }

        try {

            Date date = new SimpleDateFormat("dd MMMM yyyy", Locale.FRANCE).parse(params.dateTache)

            def journee = params.journee

            if (journee == null) {

                Date heureDebut = new SimpleDateFormat("HH:mm").parse(params.heureDebutTache)

                Date heureFin = new SimpleDateFormat("HH:mm").parse(params.heureFinTache)

                tache.setHeureDebut(heureDebut)
                tache.setHeureFin(heureFin)


            } else {

                tache.setJournee(true)
                tache.setHeureDebut(null)
                tache.setHeureFin(null)

            }


            def utilisateur = Utilisateur.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName())


            def etiquette = Etiquette.get(params.evenement)


            String visibilite = params.visibilite


            if (visibilite.equals("publique") || visibilite.equals("privée")) {
                tache.setParticipants(null)
            }


            tache.setCreator(utilisateur)
            tache.setDate(date)
            tache.setEtiquette(etiquette)


            tacheService.save(tache)


            def array = new Long[20]

            if(tache.visibilite.equals("publique")){
                def lista =  Utilisateur.findAllByUsernameNotEqual("admin")

                for (int i=0; i < lista.size(); i++) {
                    array[i] = lista.get(i).getId()
                }
            }


            if(tache.visibilite.equals("personnalisée")){
                def lista = tache.getParticipants()

                for (int i=0; i < lista.size(); i++) {
                    array[i] = lista.getAt(i).getId()
                }
            }


            Notification notification = new Notification()
            notification.idObjet = tache.getId()
            notification.typeNotification = "calendrier"
            notification.texte = "Vous êtes participant à un nouvel évènement"
            notification.date = new Date()
            notification.controleur = controllerName
            notification.creator = utilisateur.id
            notification.action = "show"
            notification.tache = tache.id
            notification.destinataires = array


            notificationService.save(notification)

            pusherService.push("newTask:" + utilisateur.id+":"+array.toString())

            redirect controller: 'utilisateur', action: 'espace'
            return


        } catch (ValidationException e) {
            respond tache.errors, view: 'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'tache.label', default: 'Tache'), tache.id])
                redirect tache
            }
            '*' { respond tache, [status: CREATED] }
        }
    }

    def edit(Long id) {

        def utilisateur = Utilisateur.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName())

        def tache = tacheService.get(id)

        if (tache.creator.equals(utilisateur)) {
            respond tache
            return
        }

        redirect controller: 'utilisateur', action: 'espace'


    }

    def update(Tache tache) {
        if (tache == null) {
            notFound()
            return
        }

        try {


            Date date = new SimpleDateFormat("dd MMMM yyyy", Locale.FRANCE).parse(params.dateTache)

            String dateModifie = new SimpleDateFormat("dd MMMM yyyy", Locale.FRANCE).format(tache.getDate())

            def journee = params.journee


            if (journee == null) {

                Date heureDebut = new SimpleDateFormat("HH:mm").parse(params.heureDebutTache)

                Date heureFin = new SimpleDateFormat("HH:mm").parse(params.heureFinTache)

                tache.setHeureDebut(heureDebut)
                tache.setHeureFin(heureFin)

                tache.setJournee(false)


            } else {

                tache.setJournee(true)
                tache.setHeureDebut(null)
                tache.setHeureFin(null)

            }


            def utilisateur = Utilisateur.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName())


            def etiquette = Etiquette.get(params.evenement)

            String visibilite = params.visibilite


            if (visibilite.equals("publique") || visibilite.equals("privée")) {
                tache.setParticipants(null)
            }


            def array = new Long[20]

            if(tache.visibilite.equals("publique")){
                def lista =  Utilisateur.findAllByUsernameNotEqual("admin")

                for (int i=0; i < lista.size(); i++) {
                    array[i] = lista.get(i).getId()
                }
            }


            if(tache.visibilite.equals("personnalisée")){
                def lista = tache.getParticipants()

                for (int i=0; i < lista.size(); i++) {
                    array[i] = lista.getAt(i).getId()
                }
            }


            tache.setCreator(utilisateur)
            tache.setDate(date)
            tache.setEtiquette(etiquette)


            tacheService.save(tache)


            Notification notification = new Notification()
            notification.idObjet = tache.getId()
            notification.typeNotification = "calendrier"
            notification.texte = "L'évènement du " + dateModifie + " a été modifié"
            notification.date = new Date()
            notification.controleur = controllerName
            notification.creator = utilisateur.id
            notification.action = "show"
            notification.destinataires = array


            notificationService.save(notification)

            pusherService.push("TaskUpdated:" + utilisateur.id+":"+array.toString())


        } catch (ValidationException e) {
            respond tache.errors, view: 'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'tache.label', default: 'Tache'), tache.id])
                redirect tache
            }
            '*' { respond tache, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }


        def utilisateur = Utilisateur.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName())
        def tache = tacheService.get(id)

        String date = new SimpleDateFormat("dd MMMM yyyy", Locale.FRANCE).format(tache.getDate())


        def listeNotifications = Notification.findAllByTache(id)

        for (notification in listeNotifications) {
            notificationService.delete(notification.id)
        }



        def array = new Long[20]

        if(tache.visibilite.equals("publique")){
            def lista =  Utilisateur.findAllByUsernameNotEqual("admin")

            for (int i=0; i < lista.size(); i++) {
                array[i] = lista.get(i).getId()
            }
        }


        if(tache.visibilite.equals("personnalisée")){
            def lista = tache.getParticipants()

            for (int i=0; i < lista.size(); i++) {
                array[i] = lista.getAt(i).getId()
            }
        }


        Notification notification = new Notification()
        notification.idObjet = tache.getId()
        notification.typeNotification = "tacheAnnule"
        notification.texte = "Annulation de l'évènement " + tache.etiquette.evenement + " du " + date
        notification.date = new Date()
        notification.controleur = controllerName
        notification.creator = utilisateur.id
        notification.action = "show"
        notification.destinataires = array

        notificationService.save(notification)

        tacheService.delete(id)

        pusherService.push("TaskDeleted:" + utilisateur.id+":"+array.toString())

        redirect controller: 'utilisateur', action: 'espace'
        return


        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'tache.label', default: 'Tache'), id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'tache.label', default: 'Tache'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }


    def getTachesByDay() {


        def utilisateur = Utilisateur.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName())

        def taches = new ArrayList()

        if (params.date != null) {

            Date date = new SimpleDateFormat("dd MMMM yyyy", Locale.FRANCE).parse(params.date)


            taches = Tache.findAllByDate(date).stream().filter({
                tache -> tache.participe(utilisateur) == true
            }).collect {
                tache -> return tache
            }


        }

        render template: '/utilisateur/agenda', model: [taches: taches]


    }




}
