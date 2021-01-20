package mccorletagencement

import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException
import mccorletagencement.dataServices.EncaissementDataService

import static org.springframework.http.HttpStatus.*

@Secured(['ROLE_ADMIN', 'ROLE_DIRECTEUR', 'ROLE_COMMERCIAL'])
class EncaissementController {

    EncaissementService encaissementService
    EncaissementDataService encaissementDataService
    PaiementService paiementService


    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond encaissementService.list(params), model:[encaissementCount: encaissementService.count()]
    }

    def show(Long id) {
        respond encaissementService.get(id)
    }

    def create() {
        respond new Encaissement(params)
    }

    def save(Encaissement encaissement) {
        if (encaissement == null) {
            notFound()
            return
        }

        try {
            encaissementService.save(encaissement)
        } catch (ValidationException e) {
            respond encaissement.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'encaissement.label', default: 'Encaissement'), encaissement.id])
                redirect encaissement
            }
            '*' { respond encaissement, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond encaissementService.get(id)
    }

    def update(Encaissement encaissement) {
        if (encaissement == null) {
            notFound()
            return
        }

        try {
            encaissementService.save(encaissement)
        } catch (ValidationException e) {
            respond encaissement.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'encaissement.label', default: 'Encaissement'), encaissement.id])
                redirect encaissement
            }
            '*'{ respond encaissement, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        encaissementService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'encaissement.label', default: 'Encaissement'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'encaissement.label', default: 'Encaissement'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }


    def saveEncaissements(){

        try {

            encaissementDataService.saveEncaissements(params)

            flash.message = "Sauvegardé"

            redirect controller: 'paiement', action: 'create', params:['facture.id': paiementService.get(params.idPaiement).facture.id]
            return

        }catch(Exception e){

            flash.error = "Le format de votre saisie est incorrect."
            redirect controller: 'paiement', action: 'create', params:['facture.id': paiementService.get(params.idPaiement).facture.id]
            return

        }

    }



    def actualiserEncaissements(){

        try {

            encaissementDataService.actualiserEncaissements(params)

            flash.message = "Enregistré"

            redirect controller: 'paiement', action: 'create', params:['facture.id': paiementService.get(params.idPaiement).facture.id]
            return

        }catch(Exception e){

            flash.error = "Le format de votre saisie est incorrect."
            redirect controller: 'paiement', action: 'create', params:['facture.id': paiementService.get(params.idPaiement).facture.id]
            return

        }

    }
}
