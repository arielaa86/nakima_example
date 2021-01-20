package mccorletagencement

import java.sql.Timestamp
import java.text.SimpleDateFormat
import java.time.LocalDate
import java.time.Period

abstract class Projet {

    String idInsitu
    Date date
    boolean devis
    String devisOui
    String typeHabitation
    String typeTravail
    String budget
    String budgetAutre
    String financement
    String financementAutre
    String style
    boolean poignees
    String poigneesModele
    String facadeLaquee
    String facadeBois
    String facadeLaqueeCouleur
    String facadeBoisCouleur
    String poigneesAutre
    int quantiteHabitation = 2
    String optionMeuble
    Date delaiRealisation
    int semaine


    def Client client
    static belongsTo = [Client]
    static hasMany = [plans: Plan, transferts: Transfert]

    static hasOne = [devisClient: Devis, concepteur: Utilisateur]

    static constraints = {

        date nullable: true
        devisOui blank: true, nullable: true
        typeHabitation inList: ['Appartement', 'Maison', 'Immeuble']
        typeTravail inList: ['Changement', 'Construction', 'Rénovation']
        budget inList: ['5 000 € à 7 000 €', '7 000 € à 9 000 €', '9 000 € à 11 000 €', '11 000 € à 15 000 €', 'Autre']
        budgetAutre blank: true, nullable: true
        financement inList: ['Comptant', 'PNF (4 fois CB)', 'Credit', 'Autre']
        financementAutre blank: true, nullable: true
        style inList: ['Design', 'Moderne', 'Classique']
        facadeLaquee inList: ['Néant', 'Mate', 'Satiné', 'Brillant']
        facadeBois inList: ['Néant', 'Muria', 'Mahogany', 'Poirier']
        facadeLaqueeCouleur nullable: true
        facadeBoisCouleur nullable: true
        poigneesModele inList: ['GOLF', 'P2T 020', 'PBS 010', 'PCB 060', 'PCD 050', 'PG1 030', 'PLC 080', 'PPC 070', 'Autre']
        poigneesAutre nullable: true
        idInsitu nullable: true, unique: true
        quantiteHabitation min: 2
        optionMeuble inList: ['Sur pieds', 'Suspendu', 'Posé au sol']
        delaiRealisation nullable: true
        devisClient nullable: true
        concepteur nullable: true

    }

    static mapping = {
        id generator: 'sequence', params: [sequence: 'projet_id_seq']
    }


    public String getDelaiRestant() {

        LocalDate dateCreation = LocalDate.parse(new SimpleDateFormat("yyyy-MM-dd").format(date))

        LocalDate dateLivraison = LocalDate.parse(new SimpleDateFormat("yyyy-MM-dd").format(delaiRealisation))

        Period period = Period.between(dateCreation, dateLivraison)

        int jours = period.getDays()
        int mois = period.getMonths()
        int annees = period.getYears()

        String message = ""

        if (annees >= 1) {
            message += annees + " année "
        }

        if (mois >= 1) {
            message += mois + " mois "
        }

        if (jours > 1) {
            message += jours + " jours "
        }

        if (jours == 1) {
            message += jours + " jour "
        }


        return message

    }


    boolean sameClass(String className) {

        return this.getClass().toString().equals(className)

    }


    def existDevis() {
        if (this.devisClient == null) {
            return false
        }

        return true
    }


    def isFactureClosed() {
        if (this.devisClient == null) {
            return false
        }

        if (this.devisClient.facture == null) {
            return false
        }

        if (!this.devisClient.facture.isClosed()) {
            return false
        }


        return true

    }


    String getType(){
        if(this instanceof ProjetCuisine)
            return "Cuisine"

        if(this instanceof ProjetDressing)
            return "Dressing"


        if(this instanceof ProjetPlacard)
            return "Placard"

        if(this instanceof ProjetSalleBain)
            return "Salle de bain"

        if(this instanceof ProjetAutre)
            return ((ProjetAutre)this).typeProjet

        if(this instanceof ProjetComplementaire)
            return ((ProjetComplementaire)this).description

        return ""

    }

    String delaiFormated(){
        String minDate = new SimpleDateFormat("dd MMM yyyy", Locale.FRANCE).format(delaiRealisation)

        def cal = Calendar.getInstance()
        cal.setTime(delaiRealisation)
        cal.add(Calendar.DATE, 6)

        String maxDate = new SimpleDateFormat("dd MMM yyyy", Locale.FRANCE).format(cal.getTime())


        return  minDate + " - " + maxDate
    }


    String getPlanDeTravail(){
        if(this instanceof ProjetCuisine)
            return ((ProjetCuisine) this).planTravail

        if(this instanceof ProjetSalleBain)
            return ((ProjetSalleBain) this).planTravail


        return "Néant"

    }


    def getLastTransfertUser(){

        if(transferts.size() > 0){
            return transferts.getAt(0).destination
        }

        return this.concepteur
    }


    boolean isTransfered(){
        return transferts.size() > 0
    }




}
