package mccorletagencement

import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException

import java.text.SimpleDateFormat

import static org.springframework.http.HttpStatus.*

@Secured(['ROLE_ADMIN', 'ROLE_DIRECTEUR', 'ROLE_COMMERCIAL'])
class ProjetController {

    ProjetService projetService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]


    def show(Long id) {

        def projet = projetService.get(id)

        if(projet.instanceOf(ProjetCuisine)) {
            redirect action: 'show', controller: 'projetCuisine', params: ['id': projet.id]
            return
        }

        if(projet.instanceOf(ProjetSalleBain)) {
            redirect action: 'show', controller: 'projetSalleBain', params: ['id': projet.id]
            return
        }

        if(projet.instanceOf(ProjetDressing)) {
            redirect action: 'show', controller: 'projetDressing', params: ['id': projet.id]
            return
        }

        if(projet.instanceOf(ProjetPlacard)) {
            redirect action: 'show', controller: 'projetPlacard', params: ['id': projet.id]
            return
        }

        if(projet.instanceOf(ProjetAutre)) {
            redirect action: 'show', controller: 'projetAutre', params: ['id': projet.id]
            return
        }

        if(projet.instanceOf(ProjetComplementaire)) {
            redirect action: 'show', controller: 'projetComplementaire', params: ['id': projet.id]
            return
        }

    }



    def saveNumeroDossier() {

        def id = params.id
        def idInsitu = params.idInsitu

        def projet = projetService.get(id)
        projet.setIdInsitu(idInsitu)
        projetService.save(projet)

        if(projet.instanceOf(ProjetCuisine)) {

            redirect action: 'show', controller: 'projetCuisine', params: ['id': projet.id]
            return
        }

        if(projet.instanceOf(ProjetSalleBain)) {
            redirect action: 'show', controller: 'projetSalleBain', params: ['id': projet.id]
            return
        }

        if(projet.instanceOf(ProjetDressing)) {
            redirect action: 'show', controller: 'projetDressing', params: ['id': projet.id]
            return
        }

        if(projet.instanceOf(ProjetPlacard)) {
            redirect action: 'show', controller: 'projetPlacard', params: ['id': projet.id]
            return
        }

        if(projet.instanceOf(ProjetAutre)) {
            redirect action: 'show', controller: 'projetAutre', params: ['id': projet.id]
            return
        }

        if(projet.instanceOf(ProjetComplementaire)) {
            redirect action: 'show', controller: 'projetComplementaire', params: ['id': projet.id]
            return
        }


    }


    def verifierDisponibilite(){

        String delai = params.dateDelai
        def dateDelaiString = delai.replace('W', '')
        def year = dateDelaiString.split('-')[0]
        int semaine = Integer.valueOf( dateDelaiString.split('-')[1] )

        def total = 0

        Projet.findAllBySemaine(semaine)
                .stream().filter({
                p -> p.delaiRealisation.toString().contains(year) && p.devisClient != null

        }).forEach({
            p -> if (p.devisClient.valide && p.devisClient.facture != null){
                total ++
            }
        })


        def disponible = total < 5


        if(!disponible){
            render template: '/projet/disponibilite'
            return
        }

        render 'disponible'

    }

}
