package mccorletagencement

import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

class ReponseController {

    ReponseService reponseService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond reponseService.list(params), model:[reponseCount: reponseService.count()]
    }

    def show(Long id) {
        respond reponseService.get(id)
    }

    def create() {
        respond new Reponse(params)
    }

    def save(Reponse reponse) {
        if (reponse == null) {
            notFound()
            return
        }

        try {
            reponseService.save(reponse)
        } catch (ValidationException e) {
            respond reponse.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'reponse.label', default: 'Reponse'), reponse.id])
                redirect reponse
            }
            '*' { respond reponse, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond reponseService.get(id)
    }

    def update(Reponse reponse) {
        if (reponse == null) {
            notFound()
            return
        }

        try {
            reponseService.save(reponse)
        } catch (ValidationException e) {
            respond reponse.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'reponse.label', default: 'Reponse'), reponse.id])
                redirect reponse
            }
            '*'{ respond reponse, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        reponseService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'reponse.label', default: 'Reponse'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'reponse.label', default: 'Reponse'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
