package mccorletagencement

import org.codehaus.groovy.ast.ClassHelper

import java.util.stream.Collectors

class Devis {

    Date date
    Date expiration
    byte[] documentWord

    String commentaire
    String accords

    String codeEmail

    String notes
    String motifDecline
    String motifDeclineAutre

    double metreLineaire = 0.0

    double agencementHT
    double remisePourcentage
    double totalHThorsPose
    double prixPlanTravail
    double prixOption
    double soldeProjet //ancienne verification
    double compoQuarante
    double compoSoixante //maintenant 55%
    double verificationChantier // maintenant 5%

    double annulation = 0.0
    double supplementPoseur = 0.0
    double supplementPoseurDirection = 0.0
    double montant
    double annulationSuivi = 0.0

    boolean envoye = false
    boolean valide = false
    boolean approuve = false
    boolean decline = false
    boolean expireAuto = false
    boolean reouvert = false

    int tentativeContact = 0
    boolean toujoursInteresse = false

    String validite
    String optionsDiverses

    boolean ancien = false

    boolean confirmationLecture = false
    boolean debloquerRemise = false


    static hasOne = [facture: FactureClient, questionnaire: Questionnaire, creePar: Utilisateur]
    static hasMany = [etats: Etat, commentaires: Commentaire]

    static belongsTo = [projet: Projet]


    double avoir = 0.0
    Long avoirUtilise
    double aRembourser = 0.0
    boolean visible = true
    boolean avoirExpire = false
    Long avoirUtiliseDecline

    String categoriePrix

    static constraints = {
        date nullable: true
        commentaire maxSize: 1000, nullable: true
        documentWord validator: {
            if (!it) return ['vide']
        }

/*
        agencementHT validator: {
            if(it < 0.000000001){
                return ['vide']
            }
        }
*/

        accords maxSize: 1000, nullable: true
        motifDecline nullable: true, inList: ['Prix trop élevé', 'Choix de matériaux insuffisant', 'Autre']
        motifDeclineAutre nullable: true

        notes nullable: true
        facture nullable: true
        questionnaire nullable: true
        validite inList: ['1 semaine', '2 semaines', '3 semaines']
        expiration nullable: true
        codeEmail nullable: true
        optionsDiverses nullable: true, maxSize: 350
        avoirUtilise nullable: true
        avoirUtiliseDecline nullable: true
        categoriePrix inList: ['F1', 'F2', 'F3', 'F4', 'F5'], nullable: true
        creePar nullable: true

    }


    static mapping = {
        id generator: 'sequence', params: [sequence: 'devis_id_seq']
    }


    def expirationEnCours() {

        Calendar cal = Calendar.getInstance()
        cal.set(Calendar.HOUR_OF_DAY, 0)
        cal.set(Calendar.MINUTE, 0)
        cal.set(Calendar.SECOND, 0)
        cal.set(Calendar.MILLISECOND, 0)
        def today = cal.getTime()

        cal.setTime(expiration)
        cal.add(Calendar.DATE, 1)
        cal.set(Calendar.HOUR_OF_DAY, 0)
        cal.set(Calendar.MINUTE, 0)
        cal.set(Calendar.SECOND, 0)
        cal.set(Calendar.MILLISECOND, 0)
        def dateExpirationPlusUn = cal.getTime()

        cal.setTime(expiration)

        cal.add(Calendar.DATE, -4)
        cal.set(Calendar.HOUR_OF_DAY, 0)
        cal.set(Calendar.MINUTE, 0)
        cal.set(Calendar.SECOND, 0)
        cal.set(Calendar.MILLISECOND, 0)
        Date dateMoins4 = cal.getTime()

        if (today.after(dateMoins4) && today.before(dateExpirationPlusUn)) {
            return true
        }

        return false
    }


    def expire() {

        Calendar cal = Calendar.getInstance()
        def today = cal.getTime()

        cal.setTime(expiration)
        cal.set(Calendar.HOUR_OF_DAY, 23)
        cal.set(Calendar.MINUTE, 59)

        def finExpiration = cal.getTime()


        if (today.after(finExpiration)) {
            return true
        }

        return false
    }


    def obtenirBaseCalcul() {
        return montant - soldeProjet
    }


    def obtenirCommission() {
        return obtenirBaseCalcul() * 3.5 / 100
    }


    boolean montrerTableau() {
        if (this.projet.instanceOf(ProjetCuisine) || this.projet.instanceOf(ProjetSalleBain)) {
            if (this.projet.planTravail.equals("Quartz")) {
                return false
            }
        }

        return true

    }


    String montrerPlanTravail() {
        if (this.projet.instanceOf(ProjetCuisine) || this.projet.instanceOf(ProjetSalleBain)) {
            return "(" + this.projet.planTravail + ")"
        }

        return ""

    }


    boolean isQuestionnaireCompleted() {

        if (questionnaire != null) {

            def total = questionnaire.reponses.stream().filter({ reponse -> reponse.selectionne }).collect(Collectors.counting())

            return total > 0
        }


        return false
    }


    def obtenirAgencementHTavecComplements() {

        def complements = ProjetComplementaire.findAllByProjetPrincipal(this.projet)

        def somme = 0

        for (complement in complements) {
            if (complement.devisClient) {
                somme += complement.devisClient.agencementHT
            }
        }

        return agencementHT + somme

    }


    def obtenirPlanTravailAvecComplements() {

        def complements = ProjetComplementaire.findAllByProjetPrincipal(this.projet)

        def somme = 0

        for (complement in complements) {
            if (complement.devisClient) {
                somme += complement.devisClient.prixPlanTravail
            }
        }

        return prixPlanTravail + somme

    }


    def obtenirOptionsDiversesAvecComplements() {

        def complements = ProjetComplementaire.findAllByProjetPrincipal(this.projet)

        def somme = 0

        for (complement in complements) {
            if (complement.devisClient) {
                somme += complement.devisClient.prixOption
            }
        }

        return prixOption + somme

    }


    def paiementPoseur() {

        double remise = agencementHT * remisePourcentage / 100
        double totalHT = agencementHT - remise

        if (!ancien) {
            return Math.ceil((totalHT * 10 / 100) + supplementPoseur)
        } else {
            return (totalHT * 10 / 100 + supplementPoseur)
        }

    }

    def paiementTotalPoseur() {

        return paiementPoseur() + supplementPoseurDirection

    }


    def getLastUser() {
        if (this.projet.transferts.size() > 0) {

            def transfert = this.projet.transferts[0]
            return transfert.destination

        }

        return this.projet.concepteur
    }


}
