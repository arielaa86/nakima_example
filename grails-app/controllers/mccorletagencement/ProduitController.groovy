package mccorletagencement

import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

@Secured(['ROLE_ADMIN', 'ROLE_DIRECTEUR', 'ROLE_COMMERCIAL'])
class ProduitController {

    ProduitService produitService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        session.controller='produit'
        params.max = Math.min(max ?: 10, 100)
        respond produitService.list(params), model:[produitCount: produitService.count()]
    }

    def show(Long id) {
        session.controller='produit'
        respond produitService.get(id)
    }

    def create() {
        session.controller='produit'
        respond new Produit(params)
    }

    def save(Produit produit) {
        if (produit == null) {
            notFound()
            return
        }

        try {
            produitService.save(produit)
        } catch (ValidationException e) {
            respond produit.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'produit.label', default: 'Produit'), produit.id])
                redirect produit
            }
            '*' { respond produit, [status: CREATED] }
        }
    }

    def edit(Long id) {
        session.controller='produit'
        respond produitService.get(id)
    }

    def update(Produit produit) {
        if (produit == null) {
            notFound()
            return
        }

        try {
            produitService.save(produit)
        } catch (ValidationException e) {
            respond produit.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'produit.label', default: 'Produit'), produit.id])
                redirect produit
            }
            '*'{ respond produit, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        produitService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'produit.label', default: 'Produit'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'produit.label', default: 'Produit'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
