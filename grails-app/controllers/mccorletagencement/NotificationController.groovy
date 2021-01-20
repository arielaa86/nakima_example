package mccorletagencement

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException
import org.springframework.security.core.context.SecurityContextHolder

import static org.springframework.http.HttpStatus.*

class NotificationController {

    NotificationService notificationService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond notificationService.list(params), model: [notificationCount: notificationService.count()]
    }

    def show(Long id) {
        respond notificationService.get(id)
    }

    def create() {
        respond new Notification(params)
    }

    def save(Notification notification) {
        if (notification == null) {
            notFound()
            return
        }

        try {
            notificationService.save(notification)
        } catch (ValidationException e) {
            respond notification.errors, view: 'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'notification.label', default: 'Notification'), notification.id])
                redirect notification
            }
            '*' { respond notification, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond notificationService.get(id)
    }

    def update(Notification notification) {
        if (notification == null) {
            notFound()
            return
        }

        try {
            notificationService.save(notification)
        } catch (ValidationException e) {
            respond notification.errors, view: 'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'notification.label', default: 'Notification'), notification.id])
                redirect notification
            }
            '*' { respond notification, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        notificationService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'notification.label', default: 'Notification'), id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'notification.label', default: 'Notification'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }

    @Secured(['ROLE_ADMIN', 'ROLE_DIRECTEUR', 'ROLE_COMMERCIAL', 'ROLE_TECHNICIEN'])
    def obtenirNotifications() {

        def utilisateur = Utilisateur.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName())

        if (utilisateur.getAuthorities().contains(Role.findByAuthority("ROLE_COMMERCIAL"))) {

            def list = Notification.findAllByAncienneAndCreatorNotEqualAndDestinatairesIsNotNull(false, utilisateur.id)


            def notifications = list.stream().filter { notification ->
                notification.destinataires.contains(utilisateur.id) && (
                        notification.typeNotification.equals("devisValide") ||
                                notification.typeNotification.equals("devisRefuse") ||
                                notification.typeNotification.equals("devisExpiration") ||
                                notification.typeNotification.equals("devisReouvert") ||
                                notification.typeNotification.equals("calendrier") ||
                                notification.typeNotification.equals("tacheAnnule") ||
                                notification.typeNotification.equals("verificationAtelier") ||
                                notification.typeNotification.equals("correctionsAfaire") ||
                                notification.typeNotification.equals("pretLivraison") ||
                                notification.typeNotification.equals("poseComplete") ||
                                notification.typeNotification.equals("commentaireProd") ||
                                notification.typeNotification.equals("erreurVerfication")




                )


            }
                    .peek { notification -> notification.setTempsEcoule(notification.obtenirTempsEcoule()) }
                    .collect {
                        notification -> return notification
                    }


            render template: '/notification/lista', model: [notifications: notifications]
            return
        }


        if (utilisateur.getAuthorities().contains(Role.findByAuthority("ROLE_DIRECTEUR"))) {

            def list = Notification.findAllByAncienneAndCreatorNotEqual(false, utilisateur.id)


            def notifications = list.stream().filter { notification ->
                notification.typeNotification.equals("devisAttente") ||
                        notification.typeNotification.equals("devisExpiration") ||
                        notification.typeNotification.equals("calendrier") ||
                        notification.typeNotification.equals("tacheAnnule") ||
                        notification.typeNotification.equals("poseComplete")||
                        notification.typeNotification.equals("commentaireProd")||
                        notification.typeNotification.equals("erreurVerfication")
            }
                    .peek { notification -> notification.setTempsEcoule(notification.obtenirTempsEcoule()) }
                    .collect { notification -> return notification }


            render template: '/notification/lista', model: [notifications: notifications]
            return
        }


        if (utilisateur.getAuthorities().contains(Role.findByAuthority("ROLE_TECHNICIEN"))) {

            def list = Notification.findAllByAncienneAndCreatorNotEqualAndDestinatairesIsNotNull(false, utilisateur.id)


            def notifications = list.stream().filter { notification ->
                notification.destinataires.contains(utilisateur.id) && (
                                notification.typeNotification.equals("calendrier") ||
                                notification.typeNotification.equals("tacheAnnule") ||
                                notification.typeNotification.equals("correctionsEffectuees") ||
                                notification.typeNotification.equals("nouvelOrdre") ||
                                        notification.typeNotification.equals("poseComplete")||
                                        notification.typeNotification.equals("commentaireProd")



                )


            }
                    .peek { notification -> notification.setTempsEcoule(notification.obtenirTempsEcoule()) }
                    .collect {
                        notification -> return notification
                    }


            render template: '/notification/lista', model: [notifications: notifications]
            return
        }


    }


}
