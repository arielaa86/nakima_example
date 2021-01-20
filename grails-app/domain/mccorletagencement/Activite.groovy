package mccorletagencement

class Activite {

    String description
    boolean active = true
    static hasOne = [createur: Utilisateur]

    static constraints = {
        description blank: false
        createur nullable: true
    }

    static mapping = {
        id generator:'sequence', params:[sequence:'activite_id_seq']
        sort id: "asc" // or "asc"
    }
}
