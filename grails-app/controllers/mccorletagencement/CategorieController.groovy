package mccorletagencement

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException
import mccorletagencement.dataServices.StatistiquesDataService

import java.text.SimpleDateFormat

import static org.springframework.http.HttpStatus.*


@Secured(['ROLE_ADMIN', 'ROLE_DIRECTEUR'])
class CategorieController {

    CategorieService categorieService
    FournisseurService fournisseurService
    FactureFournisseurService factureFournisseurService
    StatistiquesDataService statistiquesDataService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index() {

        def date = new Date()

        def actualDateString = new SimpleDateFormat("MMMM yyyy", Locale.FRANCE).format(date)

        def cal = Calendar.getInstance()
        cal.setTime(date)
        def anne = cal.get(Calendar.YEAR)

        session.controller = 'gestion_financiere'

        def chartData = statistiquesDataService.graphiqueAnnuele(anne)

        def dataArray = []

        def totalRecette = 0
        def totalDepense = 0
        def totalGain = 0

        for (def data in chartData) {
            totalRecette+= data.getRecette()
            totalDepense+= data.getDepense()

            dataArray.add(data.getMois().toString() + ":" + data.getRecette().toString() + ":" + data.getDepense().toString() + ":" + (data.recette - data.depense).toString())
        }

        totalGain = totalRecette - totalDepense

        [categories: categorieService.list(), factures: factureFournisseurService.list(), chartData: dataArray,
         actualDateString: actualDateString, actualDate: date, totalRecette: totalRecette, totalDepense: totalDepense, totalGain: totalGain ]
    }


    def indexAjax() {

        def date = new SimpleDateFormat("MMMM yyyy", Locale.FRANCE).parse(params.date)

        def cal = Calendar.getInstance()
        cal.setTime(date)


        render template: 'listeCategories', model: [categories: categorieService.list(), actualDate: date]

    }

    def getTotal(){
        def totalRecette = 0
        def totalDepense = 0
        def totalGain = 0

        def anne = Integer.parseInt(params.date)

        def chartData = statistiquesDataService.graphiqueAnnuele(anne)

        for (def data in chartData) {
            totalRecette+= data.getRecette()
            totalDepense+= data.getDepense()
        }

        totalGain = totalRecette - totalDepense

        render template: 'total', model: [totalRecette: totalRecette, totalDepense:totalDepense,  totalGain: totalGain]
    }


    def getCharData() {

        def date = Integer.parseInt(params.date)
        def chartData = statistiquesDataService.graphiqueAnnuele(date)

        def dataArray = []

        for (def data in chartData) {
            dataArray.add(data.getMois().toString() + ":" + data.getRecette().toString() + ":" + data.getDepense().toString() + ":" + (data.recette - data.depense).toString())
        }


       render dataArray.toString()

    }


    def create() {
        respond new Categorie(params)
    }

    def save() {

        def categorie = new Categorie()
        categorie.setDescription(params.description)


        if (params.icon) {
            categorie.setIcon(params.icon)
        } else {
            categorie.setIcon("fa-certificate")
        }

        try {
            categorieService.save(categorie)
        } catch (ValidationException e) {

            render template: '/categorie/errors', model: [categorie: categorie]
            return
        }


        render template: '/categorie/listeCategories', model: [categories: categorieService.list(), actualDate: new Date()]


    }


    def obtenir() {

        def categorie = categorieService.get(params.id)

        def map = [description: categorie.description, icon: categorie.icon]

        render map as JSON
    }

    def edit(Long id) {
        respond categorieService.get(id)
    }

    def update() {

        def categorie = categorieService.get(params.id)
        categorie.setDescription(params.description)
        categorie.setIcon(params.icon)


        try {
            categorieService.save(categorie)
        } catch (ValidationException e) {

            render template: '/categorie/errors', model: [categorie: categorie]
            return
        }

        render template: '/categorie/categorie', model: [categorie: categorie, actualDate: new Date()]

    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        categorieService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'categorie.label', default: 'Categorie'), id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'categorie.label', default: 'Categorie'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
