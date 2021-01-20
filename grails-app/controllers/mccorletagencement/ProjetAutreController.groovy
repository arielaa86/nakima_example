package mccorletagencement

import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException
import org.springframework.security.core.context.SecurityContextHolder

import java.text.SimpleDateFormat

import static org.springframework.http.HttpStatus.*

@Secured(['ROLE_ADMIN', 'ROLE_DIRECTEUR', 'ROLE_COMMERCIAL'])
class ProjetAutreController {

    ProjetAutreService projetAutreService
    DevisService devisService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        session.controller='gestion_commerciale'
        params.max = Math.min(max ?: 10, 100)
        respond projetAutreService.list(params), model:[projetAutreCount: projetAutreService.count()]
    }

    def show(Long id) {
        session.controller='gestion_commerciale'
        respond projetAutreService.get(id)
    }

    def create() {

        Date date = new Date()

        Calendar calendar = Calendar.getInstance()
        calendar.setTime(date)
        calendar.set(Calendar.MONTH, calendar.get(Calendar.MONTH))
        calendar.set(Calendar.YEAR, calendar.get(Calendar.YEAR))

        String actualDate = new SimpleDateFormat("yyyy-ww", Locale.FRANCE).format(date)


        session.controller = 'gestion_commerciale'
        [projetAutre: new ProjetAutre(params), actualDate:actualDate, minDateSelect: actualDate ]

    }

    def save(ProjetAutre projetAutre) {
        if (projetAutre == null) {
            notFound()
            return
        }

        try {


            if(params.devisRadio.equals("oui")){
                projetAutre.setDevis(true)
            }else {
                projetAutre.setDevis(false)
            }

            if(params.poigneesTexteRadio.equals("oui")){
                projetAutre.setPoignees(true)
            }else {
                projetAutre.setPoignees(false)
            }

            projetAutre.setDate(new Date())


            String delai = params.dateDelai
            def dateDelaiString = delai.replace('W', '')
            int semaine = Integer.valueOf( dateDelaiString.split('-')[1] )

            Date dateDelai = new SimpleDateFormat("yyyy-ww", Locale.FRANCE).parse(dateDelaiString)
            projetAutre.setDelaiRealisation(dateDelai)
            projetAutre.setSemaine(semaine)

           def concepteur =  Utilisateur.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName())
            projetAutre.setConcepteur(concepteur)

            projetAutreService.save(projetAutre)

        } catch (ValidationException e) {
            respond projetAutre.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'projetAutre.label', default: 'ProjetAutre'), projetAutre.id])
                redirect projetAutre
            }
            '*' { respond projetAutre, [status: CREATED] }
        }
    }

    def edit(Long id) {

        Date date = new Date()

        Calendar calendar = Calendar.getInstance()
        calendar.setTime(date)
        calendar.set(Calendar.MONTH, calendar.get(Calendar.MONTH))
        calendar.set(Calendar.YEAR, calendar.get(Calendar.YEAR))

        String actualDate = new SimpleDateFormat("yyyy-ww", Locale.FRANCE).format(projetAutreService.get(id).getDelaiRealisation())
        String minDateSelect = new SimpleDateFormat("yyyy-ww", Locale.FRANCE).format(date)


        session.controller = 'gestion_commerciale'
        [projetAutre:projetAutreService.get(id), actualDate:actualDate,minDateSelect: minDateSelect ]

    }

    def update(ProjetAutre projetAutre) {
        if (projetAutre == null) {
            notFound()
            return
        }

        try {


            if(params.devisRadio.equals("oui")){
                projetAutre.setDevis(true)
            }else {
                projetAutre.setDevis(false)
            }

            if(params.poigneesTexteRadio.equals("oui")){
                projetAutre.setPoignees(true)
            }else {
                projetAutre.setPoignees(false)
            }

            String delai = params.dateDelai
            def dateDelaiString = delai.replace('W', '')
            int semaine = Integer.valueOf( dateDelaiString.split('-')[1] )

            Date dateDelai = new SimpleDateFormat("yyyy-ww", Locale.FRANCE).parse(dateDelaiString)
            projetAutre.setDelaiRealisation(dateDelai)
            projetAutre.setSemaine(semaine)

            String optionMeuble = params.optionMeubleAux
            String poigneesModele = params.poigneesModeleAux

            if(projetAutre.devisClient != null){
                if(projetAutre.devisClient.facture == null) {

                    if (!optionMeuble.equals(projetAutre.optionMeuble) || !poigneesModele.equals(projetAutre.poigneesModele)) {

                        def devis = devisService.get(projetAutre.devisClient.id)

                        devis.setValide(false)
                        devis.setEnvoye(false)

                        devisService.save(devis)

                        projetAutreService.save(projetAutre)

                        flash.error = "Les éléments que vous avez modifié impactent le prix. Veuillez à présent actualiser les montants du devis avant envoi pour nouvelle validation."
                        redirect controller: 'devis', action: 'edit',  id: devis.id
                        return

                    }
                }else{

                    if( projetAutre.isDirty("delaiRealisation") ||
                            projetAutre.isDirty("poigneesModele") ||
                            projetAutre.isDirty("poigneesModele") ||
                            projetAutre.isDirty("facadeBoisCouleur") ||
                            projetAutre.isDirty("facadeLaqueeCouleur") ){

                        projetAutreService.save(projetAutre)
                        flash.message = "Actualisé"
                        redirect controller: 'projetAutre', action: 'show', id: projetAutre.id
                        return
                    }

                    flash.error = "Ce projet est déjà en état de Bon de commande et ne peut être modifié. Veuillez créer un Bon de commande complémentaire."
                    redirect controller: 'projetCuisine', action: 'show', id: projetAutre.id
                    return
                }

            }


            projetAutreService.save(projetAutre)

        } catch (ValidationException e) {
            respond projetAutre.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'projetAutre.label', default: 'ProjetAutre'), projetAutre.id])
                redirect projetAutre
            }
            '*'{ respond projetAutre, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        projetAutreService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'projetAutre.label', default: 'ProjetAutre'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'projetAutre.label', default: 'ProjetAutre'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
