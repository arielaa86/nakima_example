package mccorletagencement

class Correction {

    Date date
    String description

    boolean corrige = false
    Utilisateur utilisateur

    static belongsTo = [factureClient: FactureClient]
    static hasMany = [photos: PhotoCorrection]

    static constraints = {
        description blank: false, nullable: false
        date nullable: true
        utilisateur nullable: true
        description maxSize: 1000
    }

    static mapping = {
        id generator:'sequence', params:[sequence:'verification_id_seq']
    }

}
