package mccorletagencement

import grails.plugin.springsecurity.annotation.Secured
import mccorletagencement.dataServices.EmailDataService
import mccorletagencement.dataServices.OrdreProductionDataService
import org.springframework.security.core.context.SecurityContextHolder

import java.util.stream.Collector
import java.util.stream.Collectors

@Secured(['ROLE_ADMIN', 'ROLE_DIRECTEUR', 'ROLE_COMMERCIAL', 'ROLE_TECHNICIEN'])
class PoseController {
    OrdreProductionService ordreProductionService
    OrdreProductionDataService ordreProductionDataService


    def suiviPoseClient() {


        def ordres = OrdreProduction.findAllByPretLivraisonAndLivreAndLivraisonNotEqual(true, false, null)

        [ordres: ordres]

    }


    @Secured(['ROLE_ADMIN'])
    def suiviPoseClientAdmin() {

        def ordres = OrdreProduction.findAllByPretLivraisonAndLivraisonNotEqual(true, null)

        [ordres: ordres]

    }


    def details(long id) {
        def ordre = ordreProductionService.get(id)

        def dateLivraison = ordre.livraison

        def cal = Calendar.getInstance()
        cal.setTime(new Date())

        cal.set(Calendar.HOUR_OF_DAY, 0)
        cal.set(Calendar.MINUTE, 0)
        cal.set(Calendar.SECOND, 0)

        def today = cal.getTime()

        def formVisisble = false

        if (today.equals(dateLivraison) || today.after(dateLivraison)) {
            formVisisble = true
        }

        [ordre: ordre, formVisisble: formVisisble]

    }


    def informerPoseComplete() {

        def id = params.idPose
        def incomplete = Boolean.valueOf(params.etat)

        def ordre = ordreProductionService.get(id)

        String fileName = ""

        request.getFiles("foto").each { file ->
            fileName = file.originalFilename
            ordre.setPhotoPose(file.inputStream.bytes)
        }

        ordre.setIncomplete(incomplete)
        ordre.setLivre(true)


        OrdreProduction.withTransaction {
            ordreProductionService.save(ordre)
            it.flush()
        }

        String emailSubject = "Projet livré posé"
        String textEmail = "Un nouveau projet a été livré et posé ce jour. Cliquez sur le bouton ci-dessous pour voir les détails"
        ordreProductionDataService.sendNotificationsPoseComplete(ordre, emailSubject, textEmail, "poseComplete")

        render "ok"
    }


    def formPrint() {

        def user = Utilisateur.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName())

        def id = params.id

        [ordre: ordreProductionService.get(id) , user:user]


    }


}
