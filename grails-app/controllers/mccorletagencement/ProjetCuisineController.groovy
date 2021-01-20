package mccorletagencement

import daos.SuiviGeneralDAO
import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException
import org.springframework.security.core.context.SecurityContextHolder

import java.text.SimpleDateFormat

import static org.springframework.http.HttpStatus.*

@Secured(['ROLE_ADMIN', 'ROLE_DIRECTEUR', 'ROLE_COMMERCIAL'])
class ProjetCuisineController {

    ProjetCuisineService projetCuisineService
    DevisService devisService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond projetCuisineService.list(params), model: [projetCuisineCount: projetCuisineService.count()]
    }

    def show(Long id) {
        session.controller = 'gestion_commerciale'
        respond projetCuisineService.get(id)
    }

    def create() {

        Date date = new Date()

        Calendar calendar = Calendar.getInstance()
        calendar.setTime(date)
        calendar.set(Calendar.MONTH, calendar.get(Calendar.MONTH))
        calendar.set(Calendar.YEAR, calendar.get(Calendar.YEAR))

        String actualDate = new SimpleDateFormat("yyyy-ww", Locale.FRANCE).format(date)

        session.controller = 'gestion_commerciale'
        [projetCuisine: new ProjetCuisine(params), actualDate:actualDate, minDateSelect: actualDate ]
    }

    def save(ProjetCuisine projetCuisine) {
        if (projetCuisine == null) {
            notFound()
            return
        }

        try {

            if (params.devisRadio.equals("oui")) {
                projetCuisine.setDevis(true)
            } else {
                projetCuisine.setDevis(false)
            }

            if (params.coinRepasRadio.equals("oui")) {
                projetCuisine.setCoinRepas(true)
            } else {
                projetCuisine.setCoinRepas(false)
            }

            if (params.poigneesTexteRadio.equals("oui")) {
                projetCuisine.setPoignees(true)
            } else {
                projetCuisine.setPoignees(false)
            }


            if (params.congelateur != null) {
                projetCuisine.setCongelateur(true)
            } else {
                projetCuisine.setCongelateur(false)
            }

            if (params.microondes != null) {
                projetCuisine.setMicroondes(true)
            } else {
                projetCuisine.setMicroondes(false)
            }

            if (params.hotte != null) {
                projetCuisine.setHotte(true)
            } else {
                projetCuisine.setHotte(false)
            }

            if (params.laveLinge != null) {
                projetCuisine.setLaveLinge(true)
            } else {
                projetCuisine.setLaveLinge(false)
            }

            if (params.four != null) {
                projetCuisine.setFour(true)
            } else {
                projetCuisine.setFour(false)
            }

            if (params.laveVaisselle != null) {
                projetCuisine.setLaveVaisselle(true)
            } else {
                projetCuisine.setLaveVaisselle(false)
            }

            projetCuisine.setDate(new Date())

            def concepteur = Utilisateur.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName())
            projetCuisine.setConcepteur(concepteur)

            String delai = params.dateDelai
            def dateDelaiString = delai.replace('W', '')
            int semaine = Integer.valueOf( dateDelaiString.split('-')[1] )

            Date dateDelai = new SimpleDateFormat("yyyy-ww", Locale.FRANCE).parse(dateDelaiString)
            projetCuisine.setDelaiRealisation(dateDelai)
            projetCuisine.setSemaine(semaine)

            projetCuisineService.save(projetCuisine)


        } catch (ValidationException e) {
            respond projetCuisine.errors, view: 'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'projetCuisine.label', default: 'ProjetCuisine'), projetCuisine.id])
                redirect projetCuisine
            }
            '*' { respond projetCuisine, [status: CREATED] }
        }
    }

    def edit(Long id) {
        session.controller = 'gestion_commerciale'

        Date date = new Date()

        Calendar calendar = Calendar.getInstance()
        calendar.setTime(date)

        String actualDate = new SimpleDateFormat("yyyy-ww", Locale.FRANCE).format(projetCuisineService.get(id).getDelaiRealisation())
        String minDateSelect = new SimpleDateFormat("yyyy-ww", Locale.FRANCE).format(date)


        session.controller = 'gestion_commerciale'
        session.delai = projetCuisineService.get(id).delaiRealisation

        [projetCuisine: projetCuisineService.get(id), actualDate:actualDate, minDateSelect: minDateSelect ]


    }

    def update(ProjetCuisine projetCuisine) {
        if (projetCuisine == null) {
            notFound()
            return
        }

        try {

            if (params.devisRadio.equals("oui")) {
                projetCuisine.setDevis(true);
            } else {
                projetCuisine.setDevis(false);
            }


            if (params.coinRepasRadio.equals("oui")) {
                projetCuisine.setCoinRepas(true);
            } else {
                projetCuisine.setCoinRepas(false);
            }

            if (params.poigneesTexteRadio.equals("oui")) {
                projetCuisine.setPoignees(true);
            } else {
                projetCuisine.setPoignees(false);
            }


            if (params.congelateur != null) {
                projetCuisine.setCongelateur(true);
            } else {
                projetCuisine.setCongelateur(false);
            }

            if (params.microondes != null) {
                projetCuisine.setMicroondes(true);
            } else {
                projetCuisine.setMicroondes(false);
            }

            if (params.hotte != null) {
                projetCuisine.setHotte(true);
            } else {
                projetCuisine.setHotte(false);
            }

            if (params.laveLinge != null) {
                projetCuisine.setLaveLinge(true);
            } else {
                projetCuisine.setLaveLinge(false);
            }

            if (params.four != null) {
                projetCuisine.setFour(true);
            } else {
                projetCuisine.setFour(false);
            }

            if (params.laveVaisselle != null) {
                projetCuisine.setLaveVaisselle(true);
            } else {
                projetCuisine.setLaveVaisselle(false);
            }

            String delai = params.dateDelai
            def dateDelaiString = delai.replace('W', '')
            int semaine = Integer.valueOf( dateDelaiString.split('-')[1] )

            Date dateDelai = new SimpleDateFormat("yyyy-ww", Locale.FRANCE).parse(dateDelaiString)
            projetCuisine.setDelaiRealisation(dateDelai)
            projetCuisine.setSemaine(semaine)

            projetCuisine.setDelaiRealisation(dateDelai)

            String planTravail = params.planTravailAux
            String optionMeuble = params.optionMeubleAux
            String poigneesModele = params.poigneesModeleAux

            if(projetCuisine.devisClient != null){
                if(projetCuisine.devisClient.facture == null) {

                    if (!planTravail.equals(projetCuisine.planTravail) || !optionMeuble.equals(projetCuisine.optionMeuble) || !poigneesModele.equals(projetCuisine.poigneesModele)) {

                        def devis = devisService.get(projetCuisine.devisClient.id)

                        devis.setValide(false)
                        devis.setEnvoye(false)



                        devisService.save(devis)

                        projetCuisineService.save(projetCuisine)

                        flash.error = "Les éléments que vous avez modifié impactent le prix. Veuillez à présent actualiser les montants du devis avant envoi pour nouvelle validation."
                        redirect controller: 'devis', action: 'edit',  id: devis.id
                        return

                    }
                }else{

                    if( projetCuisine.isDirty("delaiRealisation") ||
                            projetCuisine.isDirty("poigneesModele") ||
                            projetCuisine.isDirty("poigneesModele") ||
                            projetCuisine.isDirty("facadeBoisCouleur") ||
                            projetCuisine.isDirty("facadeLaqueeCouleur") ||
                            projetCuisine.isDirty("planTravailCouleur")){
                        projetCuisineService.save(projetCuisine)
                        flash.message = "Actualisé"
                        redirect controller: 'projetCuisine', action: 'show', id: projetCuisine.id
                        return

                    }

                    flash.error = "Ce projet est déjà en état de Bon de commande et ne peut être modifié. Veuillez créer un Bon de commande complémentaire."
                    redirect controller: 'projetCuisine', action: 'show', id: projetCuisine.id
                    return
                }

            }


            projetCuisineService.save(projetCuisine)


        } catch (ValidationException e) {
            respond projetCuisine.errors, view: 'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'projetCuisine.label', default: 'ProjetCuisine'), projetCuisine.id])
                redirect projetCuisine
            }
            '*' { respond projetCuisine, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        projetCuisineService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'projetCuisine.label', default: 'ProjetCuisine'), id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'projetCuisine.label', default: 'ProjetCuisine'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }


    def plan(Long id) {
        respond projetCuisineService.get(id)
    }


    def editPlan() {
        def projetCuisine = projetCuisineService.get(params.id)
        projetCuisine.setPlan(params.plan)

        respond projetCuisineService.get(id)
    }



}
