package mccorletagencement

import daos.SuiviCommercialDAO
import daos.SuiviGeneralDAO
import daos.TacheJourDTO
import dtos.SuiviPoseurDTO
import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException
import mccorletagencement.dataServices.EmailDataService
import mccorletagencement.dataServices.RapportDataService
import mccorletagencement.dataServices.StatistiquesDataService
import mccorletagencement.dataServices.TacheDataService
import mccorletagencement.dataServices.UtilisateurDataService
import org.springframework.security.core.context.SecurityContextHolder

import java.text.SimpleDateFormat
import java.util.stream.Collector
import java.util.stream.Collectors

import static org.springframework.http.HttpStatus.*


@Secured(['ROLE_ADMIN'])
class UtilisateurController {

    UtilisateurService utilisateurService
    UtilisateurRoleService utilisateurRoleService
    StatistiquesService statistiquesService
    StatistiquesDataService statistiquesDataService
    RapportDataService rapportDataService
    RapportComptableService rapportComptableService
    FactureClientService factureClientService
    EmailDataService emailDataService
    TacheDataService tacheDataService
    DevisService devisService
    ProjetService projetService
    TransfertService transfertService
    UtilisateurDataService utilisateurDataService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    @Secured(['ROLE_ADMIN', 'ROLE_DIRECTEUR', 'ROLE_COMMERCIAL', 'ROLE_TECHNICIEN'])
    def espace() {
        session.controller = 'home'

        def utilisateur = Utilisateur.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName())

        def taches = new ArrayList<Tache>()
        def tachesSemaine = new ArrayList<TacheJourDTO>()

        def joursDelaSemaine = tacheDataService.obtenirTaches(utilisateur, taches, tachesSemaine)

        ['utilisateur': utilisateur, taches: taches, tachesSemaine: tachesSemaine.sort({ it.jour }), joursDelaSemaine: joursDelaSemaine]
    }


    @Secured(['ROLE_ADMIN', 'ROLE_DIRECTEUR', 'ROLE_COMMERCIAL'])
    def portefeuille() {
        session.controller = 'gestion_commerciale'

        def utilisateur = Utilisateur.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName())

        def liste = Projet.findAllByConcepteur(utilisateur)

        def transferts = Transfert.findAllByDestination(utilisateur)

        def toRender = utilisateurDataService.getProjets(liste, transferts, utilisateur)

        toRender.sort { d1, d2 -> d2.date <=> d1.date }

        [projetListe: toRender]

    }


    @Secured(['ROLE_ADMIN', 'ROLE_DIRECTEUR'])
    def portefeuillePersonnel() {
        session.controller = 'gestion_commerciale'

        def utilisateur = Utilisateur.get(params.id)

        def liste = Projet.findAllByConcepteur(utilisateur)

        def transferts = Transfert.findAllByDestination(utilisateur)

        def toRender = utilisateurDataService.getProjets(liste, transferts, utilisateur)


        toRender.sort { d1, d2 -> d2.date <=> d1.date }

        render template: 'portefeuilleTableau', model: ['projetListe': toRender, transfert: true]

    }

    @Secured(['ROLE_ADMIN', 'ROLE_DIRECTEUR'])
    def gestionTransfert() {
        session.controller = 'gestion_commerciale'

        def commerciaux = []

        Utilisateur.findAll().forEach({ utilisateur ->

            if (utilisateur.authorities.contains(Role.findByAuthority("ROLE_COMMERCIAL"))) {
                commerciaux.add(["id": utilisateur.id, "nom": utilisateur.toString()])
            }
        })

        [commerciaux: commerciaux]

    }


    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        session.controller = 'parametres'
        respond utilisateurService.list(params), model: [utilisateurCount: utilisateurService.count()]
    }

    def show(Long id) {
        session.controller = 'parametres'
        respond utilisateurService.get(id)
    }

    def create() {
        session.controller = 'parametres'
        respond new Utilisateur(params)
    }

    def save(Utilisateur utilisateur) {
        if (utilisateur == null) {
            notFound()
            return
        }

        String password = params.password
        String repassword = params.repassword

        if (password == repassword) {

            try {

                if (params.signatureValue) {

                    String stringValue = params.signatureValue

                    byte[] signatureinBytes = Base64.getDecoder().decode(new String(stringValue.substring(stringValue.indexOf(",") + 1)).getBytes("UTF-8"))

                    utilisateur.setSignature(signatureinBytes)
                }

                utilisateurService.save(utilisateur)

                def role = Role.get(params.role.id)

                def utilisateurRole = UtilisateurRole.findByUtilisateur(utilisateur)

                if (utilisateurRole) {

                    def listDelete = UtilisateurRole.findAllByUtilisateur(utilisateur)
                    UtilisateurRole.deleteAll(listDelete)

                }

                utilisateurRole = new UtilisateurRole()
                utilisateurRole.setRole(role)
                utilisateurRole.setUtilisateur(utilisateur)

                utilisateurRoleService.save(utilisateurRole)


            } catch (ValidationException e) {
                respond utilisateur.errors, view: 'create'
                return
            }


        } else {

            flash.error = "Les mots de passe ne correspondent pas"
            redirect controller: 'utilisateur', action: 'create', params: params
            return

        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'utilisateur.label', default: 'Utilisateur'), utilisateur.id])
                redirect utilisateur
            }
            '*' { respond utilisateur, [status: CREATED] }
        }
    }

    def edit(Long id) {

        session.controller = 'parametres'
        def utilisateur = utilisateurService.get(id)

        def roleId = UtilisateurRole.findByUtilisateur(utilisateur).getRole().id

        ['utilisateur': utilisateur, 'roleId': roleId]


    }

    def update(Utilisateur utilisateur) {
        if (utilisateur == null) {
            notFound()
            return
        }

        String password = params.password
        String repassword = params.repassword

        if (password == repassword) {

            try {


                if (params.signatureValue) {

                    String stringValue = params.signatureValue

                    byte[] signatureinBytes = Base64.getDecoder().decode(new String(stringValue.substring(stringValue.indexOf(",") + 1)).getBytes("UTF-8"))

                    utilisateur.setSignature(signatureinBytes)
                }


                utilisateurService.save(utilisateur)


                def role = Role.get(params.role.id)

                if (UtilisateurRole.findByUtilisateur(utilisateur).role.id != role.id) {


                    UtilisateurRole.withTransaction {
                        UtilisateurRole.deleteAll(UtilisateurRole.findAllByUtilisateur(utilisateur))
                        it.flush()
                    }


                    def utilisateurRole = new UtilisateurRole()
                    utilisateurRole.setRole(role)
                    utilisateurRole.setUtilisateur(utilisateur)

                    utilisateurRoleService.save(utilisateurRole)

                }


            } catch (ValidationException e) {
                respond utilisateur.errors, view: 'create'
                return
            }


        } else {

            flash.error = "Les mots de passe ne correspondent pas"
            redirect controller: 'utilisateur', action: 'create', params: params
            return

        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'utilisateur.label', default: 'Utilisateur'), utilisateur.id])
                redirect utilisateur
            }
            '*' { respond utilisateur, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }


        UtilisateurRole.withTransaction {
            UtilisateurRole.deleteAll(UtilisateurRole.findAllByUtilisateur(utilisateurService.get(id)))
            it.flush()
        }

        utilisateurService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'utilisateur.label', default: 'Utilisateur'), id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'utilisateur.label', default: 'Utilisateur'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }


    def activer(Utilisateur utilisateur) {

        utilisateur.setEnabled(true)
        utilisateurService.save(utilisateur)

        flash.message = "Ce compte utilisateur a bien été activé"

    }

    def desactiver(Utilisateur utilisateur) {

        utilisateur.setEnabled(false)
        utilisateurService.save(utilisateur)
        flash.message = "Ce compte utilisateur a bien été désactivé"

    }


    @Secured(['ROLE_ADMIN', 'ROLE_DIRECTEUR', 'ROLE_COMMERCIAL', 'ROLE_TECHNICIEN'])
    def showSignature() {

        def id = params.id

        def utilisateur = utilisateurService.get(id)

        response.outputStream << utilisateur.signature

        response.outputStream.flush()
        response.outputStream.close()

    }


    @Secured(['permitAll'])
    def showSignaturePermiteAll(String id) {

        def devis = Devis.findByCodeEmail(id)

        def utilisateur = null

        if(devis.envoye) {
            utilisateur = utilisateurService.get(devis.creePar.id)
        }else{
            utilisateur = utilisateurService.get(devis.getLastUser().id)
        }

        response.outputStream << utilisateur.signature
        response.outputStream.flush()
        response.outputStream.close()

    }


    @Secured(['ROLE_ADMIN', 'ROLE_DIRECTEUR'])
    def statistiques() {
        session.controller = 'gestion_financiere'

        Date date = new Date()

        SuiviGeneralDAO suiviGeneralCommerciaux = statistiquesService.detailsCommerciaux(date)


        String actualDate = new SimpleDateFormat("MMMM yyyy", Locale.FRANCE).format(date)

        Calendar calendar = Calendar.getInstance()
        calendar.setTime(date)
        calendar.set(Calendar.MONTH, calendar.get(Calendar.MONTH))
        calendar.set(Calendar.YEAR, calendar.get(Calendar.YEAR))

        String maxDateSelect = new SimpleDateFormat("MMMM yyyy", Locale.FRANCE).format(calendar.getTime())

        calendar.set(Calendar.MONTH, 0)
        calendar.set(Calendar.YEAR, calendar.get(Calendar.YEAR) - 1)

        String minDateSelect = new SimpleDateFormat("MMMM yyyy", Locale.FRANCE).format(calendar.getTime())

        def chartQuestionnaireDAO = statistiquesService.dataListdevisDecline()


        List<SuiviCommercialDAO> listeSuiviCommercial = new ArrayList<>()

        utilisateurService.list()
                .stream()
                .filter({
                    utilisateur ->
                        utilisateur.authorities.contains(Role.findByAuthority("ROLE_COMMERCIAL"))
                })
                .collect(Collectors.toList())
                .forEach({ utilisateur ->
                    listeSuiviCommercial.add(statistiquesService.detailsCommercial(date, utilisateur))
                })


        [suiviGeneralCommerciaux: suiviGeneralCommerciaux, listeSuiviCommercial: listeSuiviCommercial, dataInfo: chartQuestionnaireDAO, minDate: minDateSelect, maxDate: maxDateSelect, actualDate: actualDate]

    }


    @Secured(['ROLE_ADMIN', 'ROLE_DIRECTEUR'])
    def statistiquesAjax() {
        session.controller = 'gestion_financiere'


        String dateValue = params.date

        Calendar cal = Calendar.getInstance()
        cal.setTime(new SimpleDateFormat("MMMM yyyy", Locale.FRANCE).parse(dateValue))

        SuiviGeneralDAO suiviGeneralCommerciaux = statistiquesService.detailsCommerciaux(cal.getTime())

        List<SuiviCommercialDAO> listeSuiviCommercial = new ArrayList<>()

        utilisateurService.list()
                .stream()
                .filter({
                    utilisateur ->
                        utilisateur.authorities.contains(Role.findByAuthority("ROLE_COMMERCIAL"))
                })
                .collect(Collectors.toList())
                .forEach({ utilisateur ->
                    listeSuiviCommercial.add(statistiquesService.detailsCommercial(cal.getTime(), utilisateur))
                })


        render template: 'statistiquesTemplate', model: [suiviGeneralCommerciaux: suiviGeneralCommerciaux, listeSuiviCommercial: listeSuiviCommercial]

    }


    @Secured(['ROLE_ADMIN', 'ROLE_DIRECTEUR'])
    def suiviCommission() {
        session.controller = 'gestion_financiere'

        Date date = new Date()

        String actualDate = new SimpleDateFormat("MMMM yyyy", Locale.FRANCE).format(date)

        Calendar calendar = Calendar.getInstance()
        calendar.setTime(date)
        calendar.set(Calendar.MONTH, calendar.get(Calendar.MONTH))
        calendar.set(Calendar.YEAR, calendar.get(Calendar.YEAR))

        String maxDateSelect = new SimpleDateFormat("MMMM yyyy", Locale.FRANCE).format(calendar.getTime())

        calendar.set(Calendar.MONTH, 0)
        calendar.set(Calendar.YEAR, calendar.get(Calendar.YEAR) - 1)

        String minDateSelect = new SimpleDateFormat("MMMM yyyy", Locale.FRANCE).format(calendar.getTime())


        List<SuiviCommercialDAO> listeSuiviCommercial = new ArrayList<>()

        utilisateurService.list()
                .stream()
                .filter({
                    utilisateur ->
                        utilisateur.authorities.contains(Role.findByAuthority("ROLE_COMMERCIAL"))
                })
                .collect(Collectors.toList())
                .forEach({ utilisateur ->
                    listeSuiviCommercial.add(statistiquesService.detailsCommercial(date, utilisateur))
                })


        [listeSuiviCommercial: listeSuiviCommercial, minDate: minDateSelect, maxDate: maxDateSelect, actualDate: actualDate]

    }


    @Secured(['ROLE_ADMIN', 'ROLE_DIRECTEUR'])
    def suiviCommissionAjax() {
        session.controller = 'gestion_financiere'

        String dateValue = params.date

        def listeSuiviCommercial = statistiquesDataService.getListeSuiviCommercial(dateValue)

        render template: 'commissionGeneralTemplate', model: [listeSuiviCommercial: listeSuiviCommercial]

    }


    @Secured(['ROLE_ADMIN', 'ROLE_DIRECTEUR'])
    def suiviDesPoses() {
        session.controller = 'gestion_financiere'

        Date date = new Date()

        String actualDate = new SimpleDateFormat("MMMM yyyy", Locale.FRANCE).format(date)

        Calendar calendar = Calendar.getInstance()
        calendar.setTime(date)
        calendar.set(Calendar.MONTH, calendar.get(Calendar.MONTH))
        calendar.set(Calendar.YEAR, calendar.get(Calendar.YEAR))

        String maxDateSelect = new SimpleDateFormat("MMMM yyyy", Locale.FRANCE).format(calendar.getTime())

        calendar.set(Calendar.MONTH, 0)
        calendar.set(Calendar.YEAR, calendar.get(Calendar.YEAR) - 1)

        String minDateSelect = new SimpleDateFormat("MMMM yyyy", Locale.FRANCE).format(calendar.getTime())


        def poseDTO = statistiquesService.getSuiviPoseur(date)


        [previsionnelles: poseDTO.previsionnelles, realisees: poseDTO.realisees, totalSupplement: poseDTO.totalSupplement, totalPaiements: poseDTO.totalPaiements, minDate: minDateSelect, maxDate: maxDateSelect, actualDate: actualDate]

    }

    @Secured(['ROLE_ADMIN', 'ROLE_DIRECTEUR'])
    def suiviDesPosesAjax() {
        session.controller = 'gestion_financiere'

        String dateValue = params.date

        def date = new SimpleDateFormat("MMMM yyyy", Locale.FRANCE).parse(dateValue)

        def poseDTO = statistiquesService.getSuiviPoseur(date)


        render template: 'posesTemplate', model: [previsionnelles: poseDTO.previsionnelles, realisees: poseDTO.realisees, totalSupplement: poseDTO.totalSupplement, totalPaiements: poseDTO.totalPaiements]

    }


    @Secured(['ROLE_ADMIN', 'ROLE_DIRECTEUR'])
    def changerSupplementPoseur() {
        session.controller = 'gestion_financiere'

        String devisId = params.devisId
        double supplement = Double.valueOf(params.supplement)
        String dateValue = params.date

        def devis = devisService.get(devisId)
        devis.setSupplementPoseurDirection(supplement)

        devisService.save(devis)

        def date = new SimpleDateFormat("MMMM yyyy", Locale.FRANCE).parse(dateValue)

        def poseDTO = statistiquesService.getSuiviPoseur(date)


        render template: 'posesTemplate', model: [previsionnelles: poseDTO.previsionnelles, realisees: poseDTO.realisees, totalSupplement: poseDTO.totalSupplement, totalPaiements: poseDTO.totalPaiements]

    }

    @Secured(['ROLE_ADMIN', 'ROLE_DIRECTEUR'])
    def getSupplementDevis() {
        session.controller = 'gestion_financiere'

        String devisId = params.devisId
        def devis = devisService.get(devisId)

        render devis.supplementPoseurDirection


    }


    @Secured(['ROLE_ADMIN', 'ROLE_DIRECTEUR', 'ROLE_COMMERCIAL', 'ROLE_TECHNICIEN'])
    def toDoList() {

        def utilisateur = Utilisateur.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName())

        def activites = Activite.findAllByCreateur(utilisateur)

        [activites: activites]

    }


    @Secured(['ROLE_ADMIN', 'ROLE_DIRECTEUR', 'ROLE_COMMERCIAL', 'ROLE_TECHNICIEN'])
    def editAcces(Long id) {

        def utilisateur = Utilisateur.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName())

        if (utilisateur.id == id) {
            [utilisateur: utilisateurService.get(id)]
        } else {
            redirect controller: 'utilisateur', action: 'espace'
        }
    }


    @Secured(['ROLE_ADMIN', 'ROLE_DIRECTEUR', 'ROLE_COMMERCIAL', 'ROLE_TECHNICIEN'])
    def saveAcces(Utilisateur utilisateur) {

        String password = params.password
        String repassword = params.repassword

        if (!password.isBlank()) {

            if (password == repassword) {

                utilisateur.setPassword(password)

                utilisateurService.save(utilisateur)

                flash.message = "Vos accès ont bien été modifiés"

                redirect controller: 'utilisateur', action: 'monCompte', id: utilisateur.id
                return


            } else {

                flash.error = "Les mots de passe ne correspondent pas"

                redirect controller: 'utilisateur', action: 'editAcces', id: utilisateur.id
                return

            }

        } else {

            flash.error = "Le mot de passe ne peut pas être vide"

            redirect controller: 'utilisateur', action: 'editAcces', id: utilisateur.id
            return

        }
    }


    @Secured(['ROLE_ADMIN', 'ROLE_DIRECTEUR', 'ROLE_COMMERCIAL', 'ROLE_TECHNICIEN'])
    def monCompte(Long id) {

        def utilisateur = Utilisateur.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName())

        if (utilisateur.id == id) {
            session.controller = 'home'


            Date date = new Date()

            def suiviCommercialDAO = statistiquesService.detailsCommercial(date, null)


            String actualDate = new SimpleDateFormat("MMMM yyyy", Locale.FRANCE).format(date)

            Calendar calendar = Calendar.getInstance()
            calendar.setTime(date)
            calendar.set(Calendar.MONTH, calendar.get(Calendar.MONTH))
            calendar.set(Calendar.YEAR, calendar.get(Calendar.YEAR))

            String maxDateSelect = new SimpleDateFormat("MMMM yyyy", Locale.FRANCE).format(calendar.getTime())

            calendar.set(Calendar.MONTH, 0)
            calendar.set(Calendar.YEAR, calendar.get(Calendar.YEAR) - 1)

            String minDateSelect = new SimpleDateFormat("MMMM yyyy", Locale.FRANCE).format(calendar.getTime())


            [utilisateur: utilisateurService.get(id), suiviCommercialDAO: suiviCommercialDAO, minDate: minDateSelect, maxDate: maxDateSelect, actualDate: actualDate]


        } else {
            redirect controller: 'utilisateur', action: 'espace'
        }
    }


    @Secured(['ROLE_ADMIN', 'ROLE_DIRECTEUR', 'ROLE_COMMERCIAL'])
    def obtenirCommissionAjax() {
        session.controller = 'home'

        String dateValue = params.date

        Calendar cal = Calendar.getInstance()
        cal.setTime(new SimpleDateFormat("MMMM yyyy", Locale.FRANCE).parse(dateValue))

        def suiviCommercialDAO = statistiquesService.detailsCommercial(cal.getTime(), null)


        render template: 'commissionTemplate', model: [suiviCommercialDAO: suiviCommercialDAO]

    }


    @Secured(['ROLE_ADMIN', 'ROLE_DIRECTEUR'])
    def rapportComptable() {

        session.controller = 'gestion_financiere'

        Date date = new Date()

        def listeEncaissements = rapportDataService.getListeEncaissements(date)


        Calendar calendar = Calendar.getInstance()
        String actualDate = new SimpleDateFormat("MMMM yyyy", Locale.FRANCE).format(date)


        calendar.setTime(date)
        calendar.set(Calendar.MONTH, calendar.get(Calendar.MONTH))
        calendar.set(Calendar.YEAR, calendar.get(Calendar.YEAR))

        String maxDateSelect = new SimpleDateFormat("MMMM yyyy", Locale.FRANCE).format(calendar.getTime())

        calendar.set(Calendar.MONTH, 0)
        calendar.set(Calendar.YEAR, calendar.get(Calendar.YEAR) - 1)


        def listeSuiviCommercial = statistiquesDataService.getListeSuiviCommercial(actualDate)

        [listeSuiviCommercial: listeSuiviCommercial,  listeEncaissements: listeEncaissements, maxDate: maxDateSelect, actualDate: actualDate]


    }


    @Secured(['ROLE_ADMIN', 'ROLE_DIRECTEUR'])
    def rapportComptableAjax() {
        session.controller = 'gestion_financiere'

        String dateValue = params.date

        def date = new SimpleDateFormat("MMMM yyyy", Locale.FRANCE).parse(dateValue)

        def listeEncaissements = rapportDataService.getListeEncaissements(date)

        def listeSuiviCommercial = statistiquesDataService.getListeSuiviCommercial(dateValue)

        render template: 'commissionGeneralComptable', model: [listeSuiviCommercial: listeSuiviCommercial, listeEncaissements: listeEncaissements]

    }


    @Secured(['ROLE_ADMIN', 'ROLE_DIRECTEUR'])
    def addToReport() {
        session.controller = 'gestion_financiere'

        String dateValue = params.date
        def facture = factureClientService.get(params.id)


        def date = new SimpleDateFormat("MMMM yyyy", Locale.FRANCE).parse(dateValue)

        def calendar = Calendar.getInstance()
        calendar.setTime(date)
        calendar.set(Calendar.DATE, 1)
        calendar.set(Calendar.HOUR_OF_DAY, 0)
        calendar.set(Calendar.MINUTE, 0)
        calendar.set(Calendar.MILLISECOND, 0)


        def rapport = RapportComptable.findByDate(calendar.getTime())

        if (!facture.selectionCompta) {
            facture.setSelectionCompta(true)

            if (rapport) {
                rapport.addToFacturesAcquittees(facture)
                rapportComptableService.save(rapport)
            } else {
                rapport = new RapportComptable()
                rapport.setCodeEmail(calendar.getTime().toString().sha256())
                rapport.setDate(date)
                rapport.addToFacturesAcquittees(facture)
                rapportComptableService.save(rapport)

            }

        } else {

            facture.setSelectionCompta(false)
            factureClientService.save(facture)
            rapport.removeFromFacturesAcquittees(facture)
            rapportComptableService.save(rapport)


        }

        render template: '/utilisateur/selecteur', model: [facture: facture]

    }


    @Secured(['ROLE_ADMIN', 'ROLE_DIRECTEUR'])
    def envoyerRapport() {

        String dateValue = params.date

        def date = new SimpleDateFormat("MMMM yyyy", Locale.FRANCE).parse(dateValue)

        def calendar = Calendar.getInstance()
        calendar.setTime(date)
        calendar.set(Calendar.DATE, 1)
        calendar.set(Calendar.HOUR_OF_DAY, 0)
        calendar.set(Calendar.MINUTE, 0)
        calendar.set(Calendar.MILLISECOND, 0)

        def rapport = RapportComptable.findByDate(calendar.getTime())

        if (rapport == null) {

            rapport = new RapportComptable()
            rapport.setCodeEmail(calendar.getTime().toString().sha256())
            rapport.setDate(calendar.getTime())
            rapportComptableService.save(rapport)

        }


        emailDataService.sendEmailRapport(rapport)

    }


    @Secured(['permitAll'])
    def forgotPassword() {

    }


    @Secured(['permitAll'])
    def restorePassword() {

        String email = params.email

        def utilisateur = Utilisateur.findByEmail(email.trim())

        if (utilisateur != null) {
            emailDataService.emailRecupererMotPasse(utilisateur)
            flash.message = "Nous vous avons envoyé un email avec les intructions pour changer votre mot de passe"
            return
        }

        flash.error = "Il n'existe aucun compte lié à l'email renseigné"
        return

    }


    @Secured(['permitAll'])
    def changerPassword() {

        def code = params.code
        def utilisateur = null

        if (code) {
            utilisateur = Utilisateur.findByCode(code)
        }

        if (utilisateur == null) {
            redirect controller: 'utilisateur', action: 'espace'
            return
        }

        [utilisateur: utilisateur]

    }


    @Secured(['permitAll'])
    def savePassword(Utilisateur utilisateur) {

        String username = params.username
        String password = params.password
        String repassword = params.repassword

        if (!username.isBlank()) {

            if (!password.isBlank()) {

                if (password == repassword) {

                    utilisateur.setUsername(username)
                    utilisateur.setPassword(password)
                    utilisateur.setCode(null)


                    utilisateurService.save(utilisateur)

                    flash.message = "Vos accès ont bien été modifiés"

                    redirect controller: 'utilisateur', action: 'espace'
                    return


                } else {

                    flash.error = "Les mots de passe ne correspondent pas"

                    redirect controller: 'utilisateur', action: 'changerPassword', params: [code: utilisateur.code]
                    return

                }

            } else {

                flash.error = "Le mot de passe ne peut pas être vide"

                redirect controller: 'utilisateur', action: 'changerPassword', params: [code: utilisateur.code]
                return

            }
        } else {

            flash.error = "L'identifiant ne peut pas être vide"

            redirect controller: 'utilisateur', action: 'changerPassword', params: [code: utilisateur.code]
            return

        }


    }


    @Secured(['ROLE_ADMIN', 'ROLE_DIRECTEUR'])
    def transfererDossier() {

        def commercialOrigine = utilisateurService.get(params.origine)
        def commercialDestination = utilisateurService.get(params.destination)
        def projet = projetService.get(params.projet)

        def transfert = Transfert.findByProjet(projet)
        boolean deleted = false

        if (transfert == null) {
            transfert = new Transfert()
        } else {
            if (transfert.projet.concepteur.id == commercialDestination.id) {
                transfertService.delete(transfert.id)
                deleted = true
            }
        }

        if(!deleted){
            transfert.setProjet(projet)
            transfert.setDate(new Date())
            transfert.setOrigine(commercialOrigine)
            transfert.setDestination(commercialDestination)
            transfertService.save(transfert)
        }




        def transferts = Transfert.findAllByDestination(commercialOrigine)

        def liste = Projet.findAllByConcepteur(commercialOrigine)

        def toRender = utilisateurDataService.getProjets(liste, transferts, commercialOrigine)

        toRender.sort { d1, d2 -> d2.date <=> d1.date }

        render template: 'portefeuilleTableau', model: ['projetListe': toRender, transfert: true]


    }


}
