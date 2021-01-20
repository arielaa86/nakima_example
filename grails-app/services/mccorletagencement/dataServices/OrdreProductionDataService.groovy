package mccorletagencement.dataServices

import grails.gorm.transactions.Transactional
import mccorletagencement.Notification
import mccorletagencement.NotificationService
import mccorletagencement.OrdreProduction
import mccorletagencement.PusherService
import mccorletagencement.Role
import mccorletagencement.Utilisateur

@Transactional
class OrdreProductionDataService {

    NotificationService notificationService
    PusherService pusherService

    def sendNotifications(OrdreProduction ordre, Utilisateur utilisateur, String subjectEmail, String texte, def typeNotification) {


        def destinataires = []
        def directeurs = []

        def utilisateurs = Utilisateur.findAll()

        for (def user in utilisateurs) {
            if (user.authorities.contains(Role.findByAuthority("ROLE_DIRECTEUR"))) {
                directeurs.add(user.getEmail())
            }
        }

        destinataires.add(ordre.factureClient.devis.projet.concepteur.id)


        Notification notification = new Notification()
        notification.idObjet = ordre.getId()
        notification.typeNotification = typeNotification
        notification.texte = texte
        notification.date = new Date()
        notification.controleur = "ordreProduction"
        notification.creator = utilisateur.id
        notification.action = "show"
        notification.destinataires = destinataires

        notificationService.save(notification)

        pusherService.push("Notification:" + utilisateur.id + ":" + destinataires.toString())

        sendMail {
            async true
            to ordre.factureClient.devis.projet.concepteur.email
            cc directeurs
            subject subjectEmail
            html(view: "/ordreProduction/mail", model: [ordre: ordre, texte: texte])
        }
    }


    def sendNotificationsPoseComplete(OrdreProduction ordre, String subjectEmail, String texte, def typeNotification) {

        def destinataires = []
        def directeurs = []

        Utilisateur.findAll().stream()
                .forEach({ user ->
                    if (user.username != "admin") {
                        if (user.id == ordre.factureClient.devis.projet.concepteur.id ||
                                user.authorities.contains(Role.findByAuthority("ROLE_DIRECTEUR")) ||
                                user.authorities.contains(Role.findByAuthority("ROLE_TECHNICIEN"))) {

                            directeurs.add(user.getEmail())
                            destinataires.add(user.id)
                        }

                    }
                })


        Notification notification = new Notification()
        notification.idObjet = ordre.id
        notification.typeNotification = typeNotification
        notification.texte = "Projet No. " + ordre.factureClient.devis.projet.idInsitu + " livré posé"
        notification.date = new Date()
        notification.controleur = "ordreProduction"
        notification.creator = Utilisateur.findByUsername("admin").id
        notification.action = "formulaire"
        notification.destinataires = destinataires

        notificationService.save(notification)

        pusherService.push("Notification:" + notification.creator + ":" + destinataires.toString())

        sendMail {
            async true
            to directeurs
            subject subjectEmail
            html(view: "/ordreProduction/mailPose", model: [ordre: ordre, texte: texte])
        }


    }
}
