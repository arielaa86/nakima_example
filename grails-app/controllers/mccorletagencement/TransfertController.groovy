package mccorletagencement

import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

class TransfertController {

    TransfertService transfertService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
/*
    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond transfertService.list(params), model:[transfertCount: transfertService.count()]
    }

    def show(Long id) {
        respond transfertService.get(id)
    }

    def create() {
        respond new Transfert(params)
    }

    def save(Transfert transfert) {
        if (transfert == null) {
            notFound()
            return
        }

        try {
            transfertService.save(transfert)
        } catch (ValidationException e) {
            respond transfert.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'transfert.label', default: 'Transfert'), transfert.id])
                redirect transfert
            }
            '*' { respond transfert, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond transfertService.get(id)
    }

    def update(Transfert transfert) {
        if (transfert == null) {
            notFound()
            return
        }

        try {
            transfertService.save(transfert)
        } catch (ValidationException e) {
            respond transfert.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'transfert.label', default: 'Transfert'), transfert.id])
                redirect transfert
            }
            '*'{ respond transfert, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        transfertService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'transfert.label', default: 'Transfert'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'transfert.label', default: 'Transfert'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }


 */
}
