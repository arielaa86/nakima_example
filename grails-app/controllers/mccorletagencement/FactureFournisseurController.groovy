package mccorletagencement

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException

import java.text.SimpleDateFormat

import static org.springframework.http.HttpStatus.*


@Secured(['ROLE_ADMIN', 'ROLE_DIRECTEUR'])
class FactureFournisseurController {

    FactureFournisseurService factureFournisseurService
    FournisseurService fournisseurService
    CategorieService categorieService


    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index() {

        def factureFournisseur = new FactureFournisseur(params)
        session.controller = 'gestion_financiere'

        [factures: factureFournisseurService.list([sort: "id", order: "desc"]), factureFournisseur: factureFournisseur, listeFournisseurs: fournisseurService.list(), postesDepenses: categorieService.list()]
    }

    def show(Long id) {
        respond factureFournisseurService.get(id)
    }

    def create() {
        respond new FactureFournisseur(params)
    }

    def save(FactureFournisseur factureFournisseur) {
        def montant = 0

        try {
            montant = Double.valueOf(params.montant)
        } catch (Exception ex) {
            montant = 0
        }

        def date = new SimpleDateFormat("yyyy-MM-dd").parse(params.date)

        def calendar = Calendar.getInstance()
        calendar.setTime(date)
        calendar.set(Calendar.HOUR_OF_DAY, 0)
        calendar.set(Calendar.MINUTE, 0)
        calendar.set(Calendar.SECOND, 1)


        factureFournisseur.setDate(calendar.getTime())
        factureFournisseur.setMontant(montant)

        if (params.fournisseur == null) {

            factureFournisseur.setFournisseur(Fournisseur.findByNom(params.chercherFournisseur))

        } else {

            factureFournisseur.setFournisseur(Fournisseur.findById(params.fournisseur))
        }

        def categorie = categorieService.get(params.categorie)

        factureFournisseur.setCategorie(categorie)

        request.getFiles("document").each { file ->

            String fileName = file.originalFilename

            String[] arr = fileName.split("\\.")

            factureFournisseur.setDocumentType(arr[arr.length - 1])

            factureFournisseur.setDocument(file.inputStream.bytes)

        }


        factureFournisseur.setCode(factureFournisseur.id.toString().sha256())

        try {

            factureFournisseurService.save(factureFournisseur)

        } catch (ValidationException e) {
            render template:'errors', model: [factureFournisseur: factureFournisseur]
            return
        }

        flash.message = "Sauvegardé"
        redirect action: 'index'


    }

    def edit(Long id) {
        respond factureFournisseurService.get(id)
    }

    def update(FactureFournisseur factureFournisseur) {
        if (factureFournisseur == null) {
            notFound()
            return
        }

        try {
            factureFournisseurService.save(factureFournisseur)
        } catch (ValidationException e) {
            respond factureFournisseur.errors, view: 'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'factureFournisseur.label', default: 'FactureFournisseur'), factureFournisseur.id])
                redirect factureFournisseur
            }
            '*' { respond factureFournisseur, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        factureFournisseurService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'factureFournisseur.label', default: 'FactureFournisseur'), id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'factureFournisseur.label', default: 'FactureFournisseur'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }


    def showDocument() {

        def factureId = params.id

        def facture = factureFournisseurService.get(factureId)

        response.outputStream << facture.document
        response.outputStream.flush()
        response.outputStream.close()

    }


    def showDocumentComptable(String id) {

        def facture = FactureFournisseur.findByCode(id)
        response.outputStream << facture.document
        response.outputStream.flush()
        response.outputStream.close()

    }

    def obtenir() {

        def idcategorie = params.id

        def factures = FactureFournisseur.findAllByCategorie(categorieService.get(idcategorie))

        render template: '/factureFournisseur/tableauFactures', model: [factures: factures]
    }


    def obtenirAux() {


        def idcategorie = params.id

        def factures = FactureFournisseur.findAllByCategorie(categorieService.get(idcategorie))


        def toRender = factures.collect { f ->
            ["numero": f.numero, "date": f.date.toString(), "fournisseur": f.fournisseur.nom, "description": f.description, "montant": String.valueOf(f.montant)]
        }

        def result = ["data": toRender]
        render result as JSON


    }


}
