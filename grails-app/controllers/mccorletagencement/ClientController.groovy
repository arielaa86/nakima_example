package mccorletagencement

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

@Secured(['ROLE_ADMIN', 'ROLE_DIRECTEUR', 'ROLE_COMMERCIAL'])
class ClientController {

    ClientService clientService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        session.controller='gestion_commerciale'

        def liste = Client.findAll()

        def toRender = liste.stream().collect( { c ->
            ["id": c.id,  "nom": c.nom, "prenom": c.prenom , "telephone": c.telephone, "adresse": c.adresse, "codePostal": c.codePostal,
             "ville": c.ville]
        })

        [clientList: toRender]
    }


    def show(Long id) {
        session.controller='gestion_commerciale'
        respond clientService.get(id)
    }

    def create() {
        session.controller='gestion_commerciale'
        respond new Client(params)
    }

    def save(Client client) {
        if (client == null) {
            notFound()
            return
        }

        try {
            clientService.save(client)
        } catch (ValidationException e) {
            respond client.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'client.label', default: 'Client'), client.id])
                redirect client
            }
            '*' { respond client, [status: CREATED] }
        }
    }

    def edit(Long id) {
        session.controller='gestion_commerciale'
        respond clientService.get(id)
    }

    def update(Client client) {
        if (client == null) {
            notFound()
            return
        }

        try {
            clientService.save(client)
        } catch (ValidationException e) {
            respond client.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'client.label', default: 'Client'), client.id])
                redirect client
            }
            '*'{ respond client, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        clientService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'client.label', default: 'Client'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'client.label', default: 'Client'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
