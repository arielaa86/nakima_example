package mccorletagencement

import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException
import org.springframework.security.core.context.SecurityContextHolder

import java.text.SimpleDateFormat

import static org.springframework.http.HttpStatus.*

@Secured(['ROLE_ADMIN', 'ROLE_DIRECTEUR', 'ROLE_COMMERCIAL'])
class ProjetPlacardController {

    ProjetPlacardService projetPlacardService
    DevisService devisService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        session.controller='gestion_commerciale'
        params.max = Math.min(max ?: 10, 100)
        respond projetPlacardService.list(params), model:[projetPlacardCount: projetPlacardService.count()]
    }

    def show(Long id) {
        session.controller='gestion_commerciale'
        respond projetPlacardService.get(id)
    }

    def create() {
        Date date = new Date()

        Calendar calendar = Calendar.getInstance()
        calendar.setTime(date)
        calendar.set(Calendar.MONTH, calendar.get(Calendar.MONTH))
        calendar.set(Calendar.YEAR, calendar.get(Calendar.YEAR))

        String actualDate = new SimpleDateFormat("yyyy-ww", Locale.FRANCE).format(date)


        session.controller = 'gestion_commerciale'
        [projetPlacard: new ProjetPlacard(params), actualDate:actualDate, minDateSelect: actualDate ]

    }

    def save(ProjetPlacard projetPlacard) {
        if (projetPlacard == null) {
            notFound()
            return
        }

        try {

            if(params.devisRadio.equals("oui")){
                projetPlacard.setDevis(true)
            }else {
                projetPlacard.setDevis(false)
            }

            if(params.poigneesTexteRadio.equals("oui")){
                projetPlacard.setPoignees(true)
            }else {
                projetPlacard.setPoignees(false)
            }

            projetPlacard.setDate(new Date())

            def concepteur =  Utilisateur.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName())
            projetPlacard.setConcepteur(concepteur)


            String delai = params.dateDelai
            def dateDelaiString = delai.replace('W', '')
            int semaine = Integer.valueOf( dateDelaiString.split('-')[1] )

            Date dateDelai = new SimpleDateFormat("yyyy-ww", Locale.FRANCE).parse(dateDelaiString)
            projetPlacard.setDelaiRealisation(dateDelai)
            projetPlacard.setSemaine(semaine)


            projetPlacardService.save(projetPlacard)

        } catch (ValidationException e) {
            respond projetPlacard.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'projetPlacard.label', default: 'ProjetPlacard'), projetPlacard.id])
                redirect projetPlacard
            }
            '*' { respond projetPlacard, [status: CREATED] }
        }
    }

    def edit(Long id) {

        Date date = new Date()

        Calendar calendar = Calendar.getInstance()
        calendar.setTime(date)
        calendar.set(Calendar.MONTH, calendar.get(Calendar.MONTH))
        calendar.set(Calendar.YEAR, calendar.get(Calendar.YEAR))

        String actualDate = new SimpleDateFormat("yyyy-ww", Locale.FRANCE).format(projetPlacardService.get(id).getDelaiRealisation())
        String minDateSelect = new SimpleDateFormat("yyyy-ww", Locale.FRANCE).format(date)

        session.controller = 'gestion_commerciale'
        [projetPlacard: projetPlacardService.get(id), actualDate:actualDate,minDateSelect: minDateSelect ]

    }

    def update(ProjetPlacard projetPlacard) {
        if (projetPlacard == null) {
            notFound()
            return
        }

        try {

            if(params.devisRadio.equals("oui")){
                projetPlacard.setDevis(true)
            }else {
                projetPlacard.setDevis(false)
            }

            if(params.poigneesTexteRadio.equals("oui")){
                projetPlacard.setPoignees(true)
            }else {
                projetPlacard.setPoignees(false)
            }

            String delai = params.dateDelai
            def dateDelaiString = delai.replace('W', '')
            int semaine = Integer.valueOf( dateDelaiString.split('-')[1] )

            Date dateDelai = new SimpleDateFormat("yyyy-ww", Locale.FRANCE).parse(dateDelaiString)
            projetPlacard.setDelaiRealisation(dateDelai)
            projetPlacard.setSemaine(semaine)

            projetPlacard.setDelaiRealisation(dateDelai)


            String optionMeuble = params.optionMeubleAux
            String poigneesModele = params.poigneesModeleAux

            if(projetPlacard.devisClient != null){
                if(projetPlacard.devisClient.facture == null) {

                    if (!optionMeuble.equals(projetPlacard.optionMeuble) || !poigneesModele.equals(projetPlacard.poigneesModele)) {

                        def devis = devisService.get(projetPlacard.devisClient.id)

                        devis.setValide(false)
                        devis.setEnvoye(false)

                        devisService.save(devis)

                        projetPlacardService.save(projetPlacard)

                        flash.error = "Les éléments que vous avez modifié impactent le prix. Veuillez à présent actualiser les montants du devis avant envoi pour nouvelle validation."
                        redirect controller: 'devis', action: 'edit',  id: devis.id
                        return

                    }
                }else{


                    if( projetPlacard.isDirty("delaiRealisation") ||
                            projetPlacard.isDirty("poigneesModele") ||
                            projetPlacard.isDirty("poigneesModele") ||
                            projetPlacard.isDirty("facadeBoisCouleur") ||
                            projetPlacard.isDirty("facadeLaqueeCouleur")
                    ){
                        projetPlacardService.save(projetPlacard)
                        flash.message = "Actualisé"
                        redirect controller: 'projetPlacard', action: 'show', id: projetPlacard.id
                        return
                    }


                    flash.error = "Ce projet est déjà en état de Bon de commande et ne peut être modifié. Veuillez créer un Bon de commande complémentaire."
                    redirect controller: 'projetCuisine', action: 'show', id: projetPlacard.id
                    return
                }

            }

            projetPlacardService.save(projetPlacard)
        } catch (ValidationException e) {
            respond projetPlacard.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'projetPlacard.label', default: 'ProjetPlacard'), projetPlacard.id])
                redirect projetPlacard
            }
            '*'{ respond projetPlacard, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        projetPlacardService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'projetPlacard.label', default: 'ProjetPlacard'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'projetPlacard.label', default: 'ProjetPlacard'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
