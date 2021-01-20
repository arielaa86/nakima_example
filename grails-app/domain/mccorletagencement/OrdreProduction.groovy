package mccorletagencement

class OrdreProduction {

    Date date
    static hasMany = [etats: EtatProduction]
    boolean enCours = false
    boolean pret = false
    boolean pretLivraison = false
    boolean livre = false
    boolean incomplete = false
    boolean anonyme = false
    Date verification
    Date livraison

    byte[] photoPose

    String commentairesPourTechnicien

    static belongsTo = [factureClient: FactureClient]

    static constraints = {
        date nullable: true
        commentairesPourTechnicien nullable: true, maxSize: 1200
        livraison nullable: true
        verification nullable: true
        photoPose nullable: true, maxSize: 25 * 1024 * 1024
    }


    static mapping = {
        id generator:'sequence', params:[sequence:'ordreProduction_id_seq']
        sort date: "asc" // or "asc"
    }





}
