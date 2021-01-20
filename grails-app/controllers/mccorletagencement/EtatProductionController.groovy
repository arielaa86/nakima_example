package mccorletagencement

import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException
import mccorletagencement.dataServices.OrdreProductionDataService
import org.springframework.security.core.context.SecurityContextHolder

import static org.springframework.http.HttpStatus.*

@Secured(['ROLE_ADMIN', 'ROLE_DIRECTEUR', 'ROLE_TECHNICIEN'])
class EtatProductionController {

    EtatProductionService etatProductionService
    OrdreProductionService ordreProductionService
    OrdreProductionDataService ordreProductionDataService
    PusherService pusherService
    NotificationService notificationService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def changerStatut(Long id) {

        def etatProduction = etatProductionService.get(id)
        def utilisateur = Utilisateur.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName())


        def ordre = etatProduction.ordre
        def concepteur = ordre.factureClient.devis.projet.concepteur

        if (!etatProduction.active) {
            etatProduction.setActive(true)
            etatProduction.setDate(new Date())

            if(!ordre.enCours && !ordre.pret  && !ordre.pretLivraison && !ordre.livre ){
                ordre.setEnCours(true)
            }


            if(ordre.enCours && !ordre.pret && !ordre.pretLivraison && etatProduction.etape.description == "Prêt pour vérification" ){
                ordre.setPret(true)
            }


            if(ordre.pret && !ordre.pretLivraison && etatProduction.etape.description == "Prêt pour livraison" ){
                ordre.setPretLivraison(true)
            }

            if(ordre.pret && !ordre.pretLivraison){

                String subjectEmail = "Vérification du projet à l'atelier"
                String texte = "Le projet No." + ordre.factureClient.devis.projet.idInsitu + " est prêt pour la vérification en atelier"
                String typeNotification =  "verificationAtelier"

                ordreProductionDataService.sendNotifications(ordre, utilisateur, subjectEmail, texte, typeNotification )

            }


            if(ordre.pret && ordre.pretLivraison){

                String subjectEmail = "Projet prêt pour livraison"
                String texte = "Le projet No." + ordre.factureClient.devis.projet.idInsitu + " est prêt pour livraison"
                String typeNotification =  "pretLivraison"
                ordreProductionDataService.sendNotifications(ordre, utilisateur, subjectEmail, texte, typeNotification )
            }



        }else{

            etatProduction.setActive(false)

            if(etatProduction.etape.description == "Prise de RDV"){
                ordre.setEnCours(true)
                ordre.setPret(false)
                ordre.setPretLivraison(false)
            }

            if(etatProduction.etape.description == "Prêt pour vérification"){
                ordre.setEnCours(true)
                ordre.setPret(false)
                ordre.setPretLivraison(false)


                String subjectEmail = "Erreur à la verification"
                String texte = "Il y a eu des problèmes lors de la vérification du projet No. " + ordre.factureClient.devis.projet.idInsitu
                String typeNotification =  "erreurVerfication"
                ordreProductionDataService.sendNotifications(ordre, utilisateur, subjectEmail, texte, typeNotification )


            }


            if(etatProduction.etape.description == "Prêt pour livraison"){
                ordre.setPret(true)
                ordre.setPretLivraison(false)
            }


        }


        etatProductionService.save(etatProduction)

        ordreProductionService.save(ordre)








        ordreProductionService.save(ordre)


        render template: '/ordreProduction/showEtatProduction', model: [etatsProduction: etatProduction.ordre.getEtats(), user: utilisateur ]
    }





    @Secured(['ROLE_ADMIN', 'ROLE_DIRECTEUR', 'ROLE_TECHNICIEN', 'ROLE_COMMERCIAL'])
    def sauvegarderNote() {

        def user = Utilisateur.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName())

        def id = params.id
        def note = params.note

        def etatProduction = etatProductionService.get(id)

        if(note) {

            etatProduction.setNote(note)


            Notification notification = new Notification()
            notification.idObjet = etatProduction.ordre.id
            notification.typeNotification = "commentaireProd"
            notification.projetIdInsitu = etatProduction.ordre.factureClient.devis.projet.idInsitu
            notification.texte = "Nouveau commentaire dans l'ordre de production No. "+etatProduction.ordre.factureClient.devis.projet.idInsitu
            notification.date = new Date()
            notification.creator = user.id
            notification.controleur = "ordreProduction"
            notification.action = "show"
            notification.tempsEcoule = notification.obtenirTempsEcoule()

            def destinataires = []

            def utilisateurs = Utilisateur.findAll()


            if(user.authorities.contains(Role.findByAuthority("ROLE_COMMERCIAL"))){

                for (def utilisateur in utilisateurs) {

                    if(utilisateur.authorities.contains(Role.findByAuthority("ROLE_DIRECTEUR")) || utilisateur.authorities.contains(Role.findByAuthority("ROLE_TECHNICIEN")) ){
                        destinataires.add(utilisateur.id)
                    }
                }


            }else{
                destinataires.add(etatProduction.ordre.factureClient.devis.projet.concepteur.id)
            }



            notification.destinataires = destinataires

            notificationService.save(notification)

            pusherService.push("Notification:" + user.id + ":" + destinataires.toString())


        }else{
            etatProduction.setNote("Rien à signaler")
        }

        etatProduction.setDateModification(new Date())
        etatProductionService.save(etatProduction)

        render template: '/ordreProduction/showEtatProduction', model: [etatsProduction: etatProduction.ordre.getEtats(), user: user]
    }


}
