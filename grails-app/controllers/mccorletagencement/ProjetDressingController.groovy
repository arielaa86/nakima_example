package mccorletagencement

import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException
import org.springframework.security.core.context.SecurityContextHolder

import java.text.SimpleDateFormat

import static org.springframework.http.HttpStatus.*

@Secured(['ROLE_ADMIN', 'ROLE_DIRECTEUR', 'ROLE_COMMERCIAL'])
class ProjetDressingController {

    ProjetDressingService projetDressingService
    DevisService devisService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        session.controller='gestion_commerciale'
        params.max = Math.min(max ?: 10, 100)
        respond projetDressingService.list(params), model:[projetDressingCount: projetDressingService.count()]
    }

    def show(Long id) {
        session.controller='gestion_commerciale'
        respond projetDressingService.get(id)
    }

    def create() {
        Date date = new Date()

        Calendar calendar = Calendar.getInstance()
        calendar.setTime(date)
        calendar.set(Calendar.MONTH, calendar.get(Calendar.MONTH))
        calendar.set(Calendar.YEAR, calendar.get(Calendar.YEAR))


        String actualDate = new SimpleDateFormat("yyyy-ww", Locale.FRANCE).format(date)


        session.controller = 'gestion_commerciale'
        [projetDressing: new ProjetDressing(params), actualDate:actualDate,minDateSelect: actualDate ]

    }

    def save(ProjetDressing projetDressing) {
        if (projetDressing == null) {
            notFound()
            return
        }

        try {

            if(params.devisRadio.equals("oui")){
                projetDressing.setDevis(true)
            }else {
                projetDressing.setDevis(false)
            }

            if(params.poigneesTexteRadio.equals("oui")){
                projetDressing.setPoignees(true)
            }else {
                projetDressing.setPoignees(false)
            }

            projetDressing.setDate(new Date())

            def concepteur =  Utilisateur.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName())
            projetDressing.setConcepteur(concepteur)


            String delai = params.dateDelai
            def dateDelaiString = delai.replace('W', '')
            int semaine = Integer.valueOf( dateDelaiString.split('-')[1] )

            Date dateDelai = new SimpleDateFormat("yyyy-ww", Locale.FRANCE).parse(dateDelaiString)
            projetDressing.setDelaiRealisation(dateDelai)
            projetDressing.setSemaine(semaine)



            projetDressingService.save(projetDressing)

        } catch (ValidationException e) {
            respond projetDressing.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'projetDressing.label', default: 'ProjetDressing'), projetDressing.id])
                redirect projetDressing
            }
            '*' { respond projetDressing, [status: CREATED] }
        }
    }

    def edit(Long id) {

        Date date = new Date()

        Calendar calendar = Calendar.getInstance()
        calendar.setTime(date)
        calendar.set(Calendar.MONTH, calendar.get(Calendar.MONTH))
        calendar.set(Calendar.YEAR, calendar.get(Calendar.YEAR))

        String actualDate = new SimpleDateFormat("yyyy-ww", Locale.FRANCE).format(projetDressingService.get(id).getDelaiRealisation())
        String minDateSelect = new SimpleDateFormat("yyyy-ww", Locale.FRANCE).format(date)

        session.controller = 'gestion_commerciale'

        [projetDressing: projetDressingService.get(id), actualDate:actualDate,minDateSelect: minDateSelect ]

    }

    def update(ProjetDressing projetDressing) {
        if (projetDressing == null) {
            notFound()
            return
        }

        try {


            if(params.devisRadio.equals("oui")){
                projetDressing.setDevis(true)
            }else {
                projetDressing.setDevis(false)
            }

            if(params.poigneesTexteRadio.equals("oui")){
                projetDressing.setPoignees(true)
            }else {
                projetDressing.setPoignees(false)
            }


            String delai = params.dateDelai
            def dateDelaiString = delai.replace('W', '')
            int semaine = Integer.valueOf( dateDelaiString.split('-')[1] )

            Date dateDelai = new SimpleDateFormat("yyyy-ww", Locale.FRANCE).parse(dateDelaiString)
            projetDressing.setDelaiRealisation(dateDelai)
            projetDressing.setSemaine(semaine)

            projetDressing.setDelaiRealisation(dateDelai)

            String optionMeuble = params.optionMeubleAux
            String poigneesModele = params.poigneesModeleAux


            if(projetDressing.devisClient != null){
                if(projetDressing.devisClient.facture == null) {

                    if (!optionMeuble.equals(projetDressing.optionMeuble) || !poigneesModele.equals(projetDressing.poigneesModele)) {

                        def devis = devisService.get(projetDressing.devisClient.id)

                        devis.setValide(false)
                        devis.setEnvoye(false)

                        devisService.save(devis)

                        projetDressingService.save(projetDressing)

                        flash.error = "Les éléments que vous avez modifié impactent le prix. Veuillez à présent actualiser les montants du devis avant envoi pour nouvelle validation."
                        redirect controller: 'devis', action: 'edit',  id: devis.id
                        return
                    }

                }else{



                    if( projetDressing.isDirty("delaiRealisation") ||
                            projetDressing.isDirty("poigneesModele") ||
                            projetDressing.isDirty("poigneesModele") ||
                            projetDressing.isDirty("facadeBoisCouleur") ||
                            projetDressing.isDirty("facadeLaqueeCouleur")
                    ){

                        projetDressingService.save(projetDressing)
                        flash.message = "Actualisé"
                        redirect controller: 'projetDressing', action: 'show', id: projetDressing.id
                        return
                    }

                    flash.error = "Ce projet est déjà en état de Bon de commande et ne peut être modifié. Veuillez créer un Bon de commande complémentaire."
                    redirect controller: 'projetCuisine', action: 'show', id: projetDressing.id
                    return
                }

            }



            projetDressingService.save(projetDressing)
        } catch (ValidationException e) {
            respond projetDressing.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'projetDressing.label', default: 'ProjetDressing'), projetDressing.id])
                redirect projetDressing
            }
            '*'{ respond projetDressing, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        projetDressingService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'projetDressing.label', default: 'ProjetDressing'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'projetDressing.label', default: 'ProjetDressing'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
