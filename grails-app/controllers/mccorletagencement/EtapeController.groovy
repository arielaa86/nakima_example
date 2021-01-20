package mccorletagencement

import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*


@Secured(['ROLE_ADMIN'])
class EtapeController {

    EtapeService etapeService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond etapeService.list(params), model:[etapeCount: etapeService.count()]
    }

    def show(Long id) {
        respond etapeService.get(id)
    }

    def create() {
        respond new Etape(params)
    }

    def save(Etape etape) {
        if (etape == null) {
            notFound()
            return
        }

        try {
            etapeService.save(etape)
        } catch (ValidationException e) {
            respond etape.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'etape.label', default: 'Etape'), etape.id])
                redirect etape
            }
            '*' { respond etape, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond etapeService.get(id)
    }

    def update(Etape etape) {
        if (etape == null) {
            notFound()
            return
        }

        try {
            etapeService.save(etape)
        } catch (ValidationException e) {
            respond etape.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'etape.label', default: 'Etape'), etape.id])
                redirect etape
            }
            '*'{ respond etape, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        etapeService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'etape.label', default: 'Etape'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'etape.label', default: 'Etape'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
