package mccorletagencement

import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*


@Secured(['ROLE_ADMIN'])
class EtiquetteController {

    EtiquetteService etiquetteService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond etiquetteService.list(params), model:[etiquetteCount: etiquetteService.count()]
    }

    def show(Long id) {
        respond etiquetteService.get(id)
    }

    def create() {
        respond new Etiquette(params)
    }

    def save(Etiquette etiquette) {
        if (etiquette == null) {
            notFound()
            return
        }

        try {
            etiquetteService.save(etiquette)
        } catch (ValidationException e) {
            respond etiquette.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'etiquette.label', default: 'Etiquette'), etiquette.id])
                redirect etiquette
            }
            '*' { respond etiquette, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond etiquetteService.get(id)
    }

    def update(Etiquette etiquette) {
        if (etiquette == null) {
            notFound()
            return
        }

        try {
            etiquetteService.save(etiquette)
        } catch (ValidationException e) {
            respond etiquette.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'etiquette.label', default: 'Etiquette'), etiquette.id])
                redirect etiquette
            }
            '*'{ respond etiquette, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        etiquetteService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'etiquette.label', default: 'Etiquette'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'etiquette.label', default: 'Etiquette'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
