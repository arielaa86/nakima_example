package mccorletagencement

import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException
import org.springframework.security.core.context.SecurityContextHolder

import static org.springframework.http.HttpStatus.*

@Secured(['ROLE_ADMIN', 'ROLE_DIRECTEUR', 'ROLE_COMMERCIAL'])
class ProjetComplementaireController {

    ProjetComplementaireService projetComplementaireService
    ProjetService projetService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        session.controller='gestion_commerciale'
        params.max = Math.min(max ?: 10, 100)
        respond projetComplementaireService.list(params), model:[projetAutreCount: projetComplementaireService.count()]
    }

    def show(Long id) {
        session.controller='gestion_commerciale'
        respond projetComplementaireService.get(id)
    }

    def create() {
        session.controller='gestion_commerciale'

        def id = params.projet

        def projetPrincipal = projetService.get(id)


        def projetComplementaire = new ProjetComplementaire(params)


        [projetComplementaire: projetComplementaire, projetPrincipal: projetPrincipal ]
    }

    def save(ProjetComplementaire projetComplementaire) {

        if (projetComplementaire == null) {
            notFound()
            return
        }

        try {


            if(params.devisRadio.equals("oui")){
                projetComplementaire.setDevis(true)
            }else {
                projetComplementaire.setDevis(false)
            }

            if(params.poigneesTexteRadio.equals("oui")){
                projetComplementaire.setPoignees(true)
            }else {
                projetComplementaire.setPoignees(false)
            }

            projetComplementaire.setDate(new Date())


            def concepteur =  Utilisateur.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName())
            projetComplementaire.setConcepteur(concepteur)

            projetComplementaireService.save(projetComplementaire)

        } catch (ValidationException e) {
            respond projetComplementaire.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'projetComplementaire.label', default: 'ProjetComplementaire'), projetComplementaire.id])
                redirect projetComplementaire
            }
            '*' { respond projetComplementaire, [status: CREATED] }
        }
    }

    def edit(Long id) {

        session.controller='gestion_commerciale'

        def projetComplementaire = projetService.get(id)

        def projetPrincipal = projetComplementaire.projetPrincipal

        [projetComplementaire: projetComplementaire, projetPrincipal: projetPrincipal ]
    }

    def update(ProjetComplementaire projetComplementaire) {
        if (projetComplementaire == null) {
            notFound()
            return
        }

        try {


            if(params.devisRadio.equals("oui")){
                projetComplementaire.setDevis(true)
            }else {
                projetComplementaire.setDevis(false)
            }

            if(params.poigneesTexteRadio.equals("oui")){
                projetComplementaire.setPoignees(true)
            }else {
                projetComplementaire.setPoignees(false)
            }


            projetComplementaireService.save(projetComplementaire)
        } catch (ValidationException e) {
            respond projetComplementaire.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'projetComplementaire.label', default: 'ProjetComplementaire'), projetComplementaire.id])
                redirect projetComplementaire
            }
            '*'{ respond projetComplementaire, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        projetComplementaireService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'projetComplementaire.label', default: 'ProjetComplementaire'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'projetComplementaire.label', default: 'ProjetComplementaire'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
