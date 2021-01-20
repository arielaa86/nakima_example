package mccorletagencement

import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

class EtatController {

    EtatService etatService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond etatService.list(params), model:[etatCount: etatService.count()]
    }

    def show(Long id) {
        respond etatService.get(id)
    }

    def create() {
        respond new Etat(params)
    }

    def save(Etat etat) {
        if (etat == null) {
            notFound()
            return
        }

        try {
            etatService.save(etat)
        } catch (ValidationException e) {
            respond etat.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'etat.label', default: 'Etat'), etat.id])
                redirect etat
            }
            '*' { respond etat, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond etatService.get(id)
    }

    def update(Etat etat) {
        if (etat == null) {
            notFound()
            return
        }

        try {
            etatService.save(etat)
        } catch (ValidationException e) {
            respond etat.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'etat.label', default: 'Etat'), etat.id])
                redirect etat
            }
            '*'{ respond etat, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        etatService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'etat.label', default: 'Etat'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'etat.label', default: 'Etat'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
