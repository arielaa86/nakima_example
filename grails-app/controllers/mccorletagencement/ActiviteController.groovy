package mccorletagencement

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException
import org.springframework.security.core.context.SecurityContextHolder

import static org.springframework.http.HttpStatus.*

@Secured(['ROLE_ADMIN', 'ROLE_DIRECTEUR', 'ROLE_COMMERCIAL','ROLE_TECHNICIEN'])
class ActiviteController {

    ActiviteService activiteService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]



    def show(Long id) {
        respond activiteService.get(id)
    }

    def create() {
        respond new Activite(params)
    }

    def save(Activite activite) {
        if (activite == null) {
            notFound()
            return
        }

        try {
            activiteService.save(activite)
        } catch (ValidationException e) {
            respond activite.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'activite.label', default: 'Activite'), activite.id])
                redirect activite
            }
            '*' { respond activite, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond activiteService.get(id)
    }

    def update(Activite activite) {
        if (activite == null) {
            notFound()
            return
        }

        try {
            activiteService.save(activite)
        } catch (ValidationException e) {
            respond activite.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'activite.label', default: 'Activite'), activite.id])
                redirect activite
            }
            '*'{ respond activite, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        activiteService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'activite.label', default: 'Activite'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'activite.label', default: 'Activite'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }


    def enregistrer(){

        def utilisateur = Utilisateur.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName())

        def activite = new Activite()
        activite.setCreateur(utilisateur)
        activite.setDescription(params.description)
        activiteService.save(activite)


        render activite as JSON
    }

    def effacer() {

        activiteService.delete(params.id)

        render "ok"

    }

    def barre() {

        def activite = activiteService.get(params.id)

        if(activite.active) {
            activite.setActive(false)
        }else{
            activite.setActive(true)
        }

        activiteService.save(activite)

        render "ok"

    }



}
