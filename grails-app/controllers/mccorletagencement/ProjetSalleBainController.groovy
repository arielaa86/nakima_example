package mccorletagencement

import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException
import org.springframework.security.core.context.SecurityContextHolder

import java.text.SimpleDateFormat

import static org.springframework.http.HttpStatus.*

@Secured(['ROLE_ADMIN', 'ROLE_DIRECTEUR', 'ROLE_COMMERCIAL'])
class ProjetSalleBainController {

    ProjetSalleBainService projetSalleBainService
    DevisService devisService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        session.controller='gestion_commerciale'
        params.max = Math.min(max ?: 10, 100)
        respond projetSalleBainService.list(params), model:[projetSalleBainCount: projetSalleBainService.count()]
    }

    def show(Long id) {
        session.controller='gestion_commerciale'
        respond projetSalleBainService.get(id)
    }

    def create() {
        Date date = new Date()

        Calendar calendar = Calendar.getInstance()
        calendar.setTime(date)
        calendar.set(Calendar.MONTH, calendar.get(Calendar.MONTH))
        calendar.set(Calendar.YEAR, calendar.get(Calendar.YEAR))

        String actualDate = new SimpleDateFormat("yyyy-ww", Locale.FRANCE).format(date)

        session.controller = 'gestion_commerciale'
        [projetSalleBain:  new ProjetSalleBain(params), actualDate:actualDate,minDateSelect: actualDate ]

    }

    def save(ProjetSalleBain projetSalleBain) {
        if (projetSalleBain == null) {
            notFound()
            return
        }

        try {


            if(params.devisRadio.equals("oui")){
                projetSalleBain.setDevis(true)
            }else {
                projetSalleBain.setDevis(false)
            }

            if(params.poigneesTexteRadio.equals("oui")){
                projetSalleBain.setPoignees(true)
            }else {
                projetSalleBain.setPoignees(false)
            }

            if(params.laveLinge != null){
                projetSalleBain.setLaveLinge(true)
            }else {
                projetSalleBain.setLaveLinge(false)
            }

            projetSalleBain.setDate(new Date())

            def concepteur =  Utilisateur.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName())
            projetSalleBain.setConcepteur(concepteur)

            String delai = params.dateDelai
            def dateDelaiString = delai.replace('W', '')
            int semaine = Integer.valueOf( dateDelaiString.split('-')[1] )

            Date dateDelai = new SimpleDateFormat("yyyy-ww", Locale.FRANCE).parse(dateDelaiString)
            projetSalleBain.setDelaiRealisation(dateDelai)
            projetSalleBain.setSemaine(semaine)

            projetSalleBainService.save(projetSalleBain)

        } catch (ValidationException e) {
            respond projetSalleBain.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'projetSalleBain.label', default: 'ProjetSalleBain'), projetSalleBain.id])
                redirect projetSalleBain
            }
            '*' { respond projetSalleBain, [status: CREATED] }
        }
    }

    def edit(Long id) {
        Date date = new Date()

        Calendar calendar = Calendar.getInstance()
        calendar.setTime(date)
        calendar.set(Calendar.MONTH, calendar.get(Calendar.MONTH))
        calendar.set(Calendar.YEAR, calendar.get(Calendar.YEAR))

        String actualDate = new SimpleDateFormat("yyyy-ww", Locale.FRANCE).format(projetSalleBainService.get(id).getDelaiRealisation())
        String minDateSelect = new SimpleDateFormat("yyyy-ww", Locale.FRANCE).format(date)

        session.controller = 'gestion_commerciale'
        [projetSalleBain: projetSalleBainService.get(id), actualDate:actualDate,minDateSelect: minDateSelect ]

    }

    def update(ProjetSalleBain projetSalleBain) {
        if (projetSalleBain == null) {
            notFound()
            return
        }

        try {


            if(params.devisRadio.equals("oui")){
                projetSalleBain.setDevis(true)
            }else {
                projetSalleBain.setDevis(false)
            }

            if(params.poigneesTexteRadio.equals("oui")){
                projetSalleBain.setPoignees(true)
            }else {
                projetSalleBain.setPoignees(false)
            }

            if(params.laveLinge != null){
                projetSalleBain.setLaveLinge(true)
            }else {
                projetSalleBain.setLaveLinge(false)
            }

            String delai = params.dateDelai
            def dateDelaiString = delai.replace('W', '')
            int semaine = Integer.valueOf( dateDelaiString.split('-')[1] )

            Date dateDelai = new SimpleDateFormat("yyyy-ww", Locale.FRANCE).parse(dateDelaiString)
            projetSalleBain.setDelaiRealisation(dateDelai)
            projetSalleBain.setSemaine(semaine)

            String planTravail = params.planTravailAux
            String optionMeuble = params.optionMeubleAux
            String poigneesModele = params.poigneesModeleAux

            if(projetSalleBain.devisClient != null){
                if(projetSalleBain.devisClient.facture == null) {

                    if (!planTravail.equals(projetSalleBain.planTravail) || !optionMeuble.equals(projetSalleBain.optionMeuble) || !poigneesModele.equals(projetSalleBain.poigneesModele)) {

                        def devis = devisService.get(projetSalleBain.devisClient.id)

                        devis.setValide(false)
                        devis.setEnvoye(false)

                        devisService.save(devis)

                        projetSalleBainService.save(projetSalleBain)

                        flash.error = "Les éléments que vous avez modifié impactent le prix. Veuillez à présent actualiser les montants du devis avant envoi pour nouvelle validation."
                        redirect controller: 'devis', action: 'edit',  id: devis.id

                        return

                    }
                }else{


                    if( projetSalleBain.isDirty("delaiRealisation") ||
                            projetSalleBain.isDirty("poigneesModele") ||
                            projetSalleBain.isDirty("poigneesModele") ||
                            projetSalleBain.isDirty("facadeBoisCouleur") ||
                            projetSalleBain.isDirty("facadeLaqueeCouleur")||
                            projetSalleBain.isDirty("planTravailCouleur")
                    ){
                        projetSalleBainService.save(projetSalleBain)
                        flash.message = "Actualisé"
                        redirect controller: 'projetSalleBain', action: 'show', id: projetSalleBain.id
                        return
                    }



                    flash.error = "Ce projet est déjà en état de Bon de commande et ne peut être modifié. Veuillez créer un Bon de commande complémentaire."
                    redirect controller: 'projetCuisine', action: 'show', id: projetSalleBain.id
                    return
                }

            }


            projetSalleBainService.save(projetSalleBain)

        } catch (ValidationException e) {
            respond projetSalleBain.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'projetSalleBain.label', default: 'ProjetSalleBain'), projetSalleBain.id])
                redirect projetSalleBain
            }
            '*'{ respond projetSalleBain, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        projetSalleBainService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'projetSalleBain.label', default: 'ProjetSalleBain'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'projetSalleBain.label', default: 'ProjetSalleBain'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
