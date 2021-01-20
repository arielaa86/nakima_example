package mccorletagencement

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException
import mccorletagencement.dataServices.CommentairesDataService
import org.springframework.security.core.context.SecurityContextHolder

import java.text.SimpleDateFormat

import static org.springframework.http.HttpStatus.*

@Secured(['ROLE_ADMIN', 'ROLE_DIRECTEUR', 'ROLE_COMMERCIAL'])
class CommentaireController {

    CommentaireService commentaireService
    DevisService devisService

    CommentairesDataService commentairesDataService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond commentaireService.list(params), model: [commentaireCount: commentaireService.count()]
    }

    def show(Long id) {
        respond commentaireService.get(id)
    }

    def create() {
        respond new Commentaire(params)
    }

    def edit(Long id) {
        respond commentaireService.get(id)
    }

    def update(Commentaire commentaire) {
        if (commentaire == null) {
            notFound()
            return
        }

        try {
            commentaireService.save(commentaire)
        } catch (ValidationException e) {
            respond commentaire.errors, view: 'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'commentaire.label', default: 'Commentaire'), commentaire.id])
                redirect commentaire
            }
            '*' { respond commentaire, [status: OK] }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'commentaire.label', default: 'Commentaire'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }



    def save() {

        def id = params.devisId
        def devis = devisService.get(id)
        def createur = Utilisateur.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName())

        def commentaire = new Commentaire()
        commentaire.setDate(new Date())
        commentaire.setTexte(params.texte)
        commentaire.setDevis(devis)
        commentaire.setCreateur(createur)

        boolean isRelance = false

        if(params.isCommentaireRelance == 'true'){
            isRelance = true
            commentaire.setCommentaireRelance(true)
        }

        commentaireService.save(commentaire)

        def commentaires = commentairesDataService.getCommentaires(devis, isRelance )

        render template: '/devis/showCommentaires', model: [commentaires: commentaires]
    }



    def delete() {

        def commentaire = commentaireService.get(params.commentaireId)
        def devis = commentaire.devis
        commentaire.setSupprime(true)
        commentaireService.save(commentaire)

        boolean isRelance = false

        if(commentaire.commentaireRelance){
            isRelance = true
        }

        def commentaires = commentairesDataService.getCommentaires(devis, isRelance)

        render template: '/devis/showCommentaires', model: [commentaires: commentaires]
    }


    def list(Long id) {

        def devis = devisService.get(id)

        def commentaires = commentairesDataService.getCommentaires(devis, false)

        render template: '/devis/showCommentaires', model: [commentaires: commentaires]


    }



    def listCommentairesRelance(Long id) {

        def devis = devisService.get(id)

        def commentaires = commentairesDataService.getCommentaires(devis, true)

        render template: '/devis/showCommentaires', model: [commentaires: commentaires]


    }




}
