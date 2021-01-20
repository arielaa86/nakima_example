package mccorletagencement

import java.text.SimpleDateFormat

class Paiement {

    Date date
    double montant
    String moyen
    byte[] pieceJointe
    String documentType
    String commentaire

    Date dateProchaineEcheance
    boolean encaisse = true
    boolean supprime = false

    def FactureClient facture
    static belongsTo = [FactureClient]

    Utilisateur utilisateur


    int quantite = 0
    boolean multiple = false

    static hasMany = [encaissements: Encaissement]

    static constraints = {

        moyen inList: ['Carte bancaire', 'Chèque', 'Espèces', 'Virement']
        montant min: 1.0D
        commentaire nullable: true
        dateProchaineEcheance nullable: true
        pieceJointe nullable: true
        documentType nullable: true
        utilisateur nullable: true
    }


    static mapping = {
        id generator: 'sequence', params: [sequence: 'paiement_id_seq']
    }


    boolean pretPourEncaisser (){
        if( this.dateProchaineEcheance != null){
/*
            SimpleDateFormat sdf = new SimpleDateFormat('yyyy-MM-dd HH:mm')

            def todayStr = sdf.format(new Date())

            def echeanceStr = sdf.format(this.dateProchaineEcheance)
*/
            def today = new Date()
            def echeance = this.dateProchaineEcheance

            if(today.after(echeance)){
                return true
            }
        }

        return false
    }


    double regleCeJour() {

        double totalPaye = 0.0D

        if (multiple) {

            for (encaissement in encaissements) {

                def calendar = Calendar.getInstance()

                calendar.setTime(new Date())
                calendar.set(Calendar.HOUR_OF_DAY, 23)
                calendar.set(Calendar.MINUTE, 59)

                if (encaissement.date.before(calendar.getTime())) {
                    totalPaye += encaissement.montant
                }

            }

            return totalPaye


        } else {
            return montant
        }


    }


    def obtenirDateProchaineEcheance(Date date, int increment) {

        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date)
        calendar.add(Calendar.MONTH, increment);

        return calendar.getTime()

    }


    def permetreEfasser(){

        def calendar = Calendar.getInstance()
        calendar.setTime(new Date())

        calendar.add(Calendar.DATE, -15)
        calendar.set(Calendar.HOUR_OF_DAY, 0)
        calendar.set(Calendar.MINUTE, 0)
        calendar.set(Calendar.SECOND, 0)
        calendar.set(Calendar.MILLISECOND, 0)

        def dateMoisQuinceJour = calendar.getTime()



        return this.date.after(dateMoisQuinceJour)
    }


}
