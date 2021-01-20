package mccorletagencement

import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException
import mccorletagencement.dataServices.PlanningDataService
import org.springframework.security.core.context.SecurityContextHolder

import java.text.SimpleDateFormat
import java.util.stream.Collector
import java.util.stream.Collectors

import static org.springframework.http.HttpStatus.*


@Secured(['ROLE_ADMIN', 'ROLE_DIRECTEUR', 'ROLE_TECHNICIEN', 'ROLE_COMMERCIAL'])
class OrdreProductionController {


    OrdreProductionService ordreProductionService
    PlanService planService
    DocumentOutilsService documentOutilsService
    TacheService tacheService
    ProjetService projetService

    PlanningDataService planningDataService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index() {
        session.controller = 'production'

        def ordres = new ArrayList()
        def ordresEnCours = new ArrayList()
        def ordresPrets = new ArrayList()
        def ordresPretsLivraison = new ArrayList()
        def ordresLivre = new ArrayList()


        ordreProductionService.list().forEach(
                        { ordre ->

                            if(ordre.getFactureClient().lancerProduction) {
                                if (!ordre.enCours && !ordre.pret && !ordre.pretLivraison && !ordre.livre) {
                                    ordres.add(ordre)
                                }

                                if (ordre.enCours && !ordre.pret && !ordre.pretLivraison && !ordre.livre) {
                                    ordresEnCours.add(ordre)
                                }

                                if (ordre.pret && !ordre.pretLivraison && !ordre.livre) {
                                    ordresPrets.add(ordre)
                                }

                                if (ordre.pretLivraison && !ordre.livre) {
                                    ordresPretsLivraison.add(ordre)
                                }

                                if (ordre.livre) {
                                    ordresLivre.add(ordre)
                                }
                            }
                        })

        ordres.sort{it.factureClient.devis.projet.semaine}
        ordresEnCours.sort{it.factureClient.devis.projet.semaine}
        ordresPrets.sort{it.factureClient.devis.projet.semaine}
        ordresPretsLivraison.sort{it.factureClient.devis.projet.semaine}
        ordresLivre.sort{ordre1,ordre2 -> ordre1.factureClient.devis.projet.idInsitu <=> ordre2.factureClient.devis.projet.idInsitu }



        [ordres: ordres, ordresEnCours: ordresEnCours, ordresPretsVerification: ordresPrets, ordresPretsLivraison: ordresPretsLivraison, ordresLivre: ordresLivre]

    }


    def show(Long id) {
        session.controller = 'production'

        def user = Utilisateur.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName())

        def facture = ordreProductionService.get(id).factureClient

        def count = facture.getAllComplements().size()

        def document = null

        if (count > 0) {

            def lastProjet = facture.getAllComplements().sort({ it.date }).get(count - 1)
            document = documentOutilsService.readDocument(lastProjet.devisClient.getDocumentWord())

        } else {
            document = documentOutilsService.readDocument(facture.devis.getDocumentWord())
        }

        ['factureClient': facture, 'references': document, corrections: facture.corrections, user: user]
    }


    def create() {
        respond new OrdreProduction(params)
    }

    def save(OrdreProduction ordreProduction) {
        if (ordreProduction == null) {
            notFound()
            return
        }

        try {
            ordreProductionService.save(ordreProduction)
        } catch (ValidationException e) {
            respond ordreProduction.errors, view: 'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'ordreProduction.label', default: 'OrdreProduction'), ordreProduction.id])
                redirect ordreProduction
            }
            '*' { respond ordreProduction, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond ordreProductionService.get(id)
    }

    def update(OrdreProduction ordreProduction) {
        if (ordreProduction == null) {
            notFound()
            return
        }

        try {
            ordreProductionService.save(ordreProduction)
        } catch (ValidationException e) {
            respond ordreProduction.errors, view: 'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'ordreProduction.label', default: 'OrdreProduction'), ordreProduction.id])
                redirect ordreProduction
            }
            '*' { respond ordreProduction, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        ordreProductionService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'ordreProduction.label', default: 'OrdreProduction'), id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'ordreProduction.label', default: 'OrdreProduction'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }


    def printImage() {

        def id = params.id

        def plan = planService.get(id)

        render template: 'printImage', model: [id: id, factureClient: plan.getProjet().getDevisClient().facture]

    }


    def suiviGeneral() {


        def user = Utilisateur.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName())

        session.controller = 'production'

        def calendar = Calendar.getInstance()
        def actuelle = calendar.get(Calendar.YEAR)

        calendar.add(calendar.YEAR, 1)
        def prochaine = calendar.get(Calendar.YEAR)


        def cal = Calendar.getInstance()
        cal.setTime(new Date())

        cal.set(Calendar.DAY_OF_YEAR, 1)
        cal.set(Calendar.HOUR_OF_DAY, 0)
        cal.set(Calendar.MINUTE, 0)
        cal.add(Calendar.MINUTE, -1)
        cal.set(Calendar.SECOND, 0)
        cal.set(Calendar.MILLISECOND, 0)


        Date startDate = cal.getTime()

        cal.add(Calendar.MINUTE, 1)
        cal.add(Calendar.SECOND, -1)
        cal.add(Calendar.YEAR, 1)
        Date lastDate = cal.getTime()

        def planning = planningDataService.obtenirPlanningParMois(startDate, lastDate)

        [actuelle: actuelle, prochaine: prochaine, planning: planning, user: user]

    }


    def getPlanning() {

        def user = Utilisateur.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName())

        def annee = Integer.valueOf(params.annee)

        def cal = Calendar.getInstance()
        cal.set(Calendar.YEAR, annee)
        cal.set(Calendar.DAY_OF_YEAR, 1)
        cal.set(Calendar.HOUR_OF_DAY, 0)
        cal.set(Calendar.MINUTE, 0)
        cal.set(Calendar.SECOND, 0)
        cal.set(Calendar.MILLISECOND, 0)
        cal.add(Calendar.MINUTE, -1)

        Date startDate = cal.getTime()

        cal.add(Calendar.MINUTE, 1)
        cal.add(Calendar.SECOND, -1)
        cal.set(Calendar.YEAR, annee + 1)
        Date lastDate = cal.getTime()


        def planning = planningDataService.obtenirPlanningParMois(startDate, lastDate)

        render template: '/ordreProduction/suiviMois', model: [planning: planning, user: user]
    }


    def saveDateDelivery() {

        def id = params.id
        def date = params.date

        def utilisateur = Utilisateur.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName())

        def newDate = new SimpleDateFormat("dd MMMM yyyy", Locale.FRANCE).parse(date)


        def ordre = ordreProductionService.get(id)
        ordre.setLivraison(newDate)
        ordreProductionService.save(ordre)

        def calendar = Calendar.getInstance()
        calendar.setTime(newDate)
        calendar.set(Calendar.DATE, 1)
        calendar.set(Calendar.HOUR, 0)
        calendar.set(Calendar.MINUTE, 0)
        calendar.set(Calendar.SECOND, 0)

        def projet = projetService.get(ordre.factureClient.devis.projet.id)
        projet.setDelaiRealisation(calendar.getTime())
        projetService.save(projet)


        Tache tache = new Tache()
        tache.setEtiquette(Etiquette.findByEvenement("Autre"))
        tache.setDate(ordre.livraison)
        tache.setJournee(true)
        tache.setVisibilite("publique")
        tache.setDescription("Livraison ce jour du projet No." + ordre.factureClient.devis.projet.idInsitu +" - "+ordre.factureClient.devis.projet.client)
        tache.setCreator(Utilisateur.findByEmail("direction.mccorlet@gmail.com"))

        tacheService.save(tache)

        render template: '/ordreProduction/showEtatProduction', model: [etatsProduction: ordre.getEtats(), user: utilisateur ]

    }


    @Secured(['ROLE_ADMIN', 'ROLE_DIRECTEUR', 'ROLE_COMMERCIAL', 'ROLE_TECHNICIEN' ])
    def showFormulaire(){

        def id = params.id

        def ordre = ordreProductionService.get(id)

        response.outputStream << ordre.photoPose

        response.outputStream.flush()
        response.outputStream.close()

    }


    @Secured(['ROLE_ADMIN', 'ROLE_DIRECTEUR', 'ROLE_TECHNICIEN' ])
    def livraisonComplete(){

        def ordre = ordreProductionService.get(params.id)
        ordre.setIncomplete(false)
        ordreProductionService.save(ordre)
        render 'ok'

    }


    @Secured(['ROLE_ADMIN', 'ROLE_DIRECTEUR', 'ROLE_TECHNICIEN', 'ROLE_COMMERCIAL'])
    def formulaire(long id){

        session.controller = 'production'

        [ordre: ordreProductionService.get(id)]

    }


    def saveDateVerification() {

        def id = params.id
        def date = params.date


        def utilisateur = Utilisateur.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName())

        def newDate = new SimpleDateFormat("dd MMMM yyyy", Locale.FRANCE).parse(date)


        def ordre = ordreProductionService.get(id)
        ordre.setVerification(newDate)
        ordreProductionService.save(ordre)


        Tache tache = new Tache()
        tache.setEtiquette(Etiquette.findByEvenement("Vérification à l'atelier"))
        tache.setDate(ordre.verification)
        tache.setJournee(true)
        tache.setVisibilite("publique")
        tache.setDescription("Le client " + ordre.factureClient.devis.projet.client.toString() + " viendra pour vérifier le projet No." + ordre.factureClient.devis.projet.idInsitu)
        tache.setCreator(Utilisateur.findByEmail("direction.mccorlet@gmail.com"))

        tacheService.save(tache)


        render template: '/ordreProduction/showEtatProduction', model: [etatsProduction: ordre.getEtats(), user: utilisateur ]

    }


}
