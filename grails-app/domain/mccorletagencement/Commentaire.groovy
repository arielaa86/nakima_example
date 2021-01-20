package mccorletagencement

class Commentaire {

    Date date
    Utilisateur createur
    String texte
    static belongsTo = [devis: Devis]
    boolean supprime = false
    boolean commentaireRelance = false
    boolean commentaireAuto = false


    static constraints = {
        date nullable: true
        createur nullable: true
        texte nullable: true, blank: false
    }

    static mapping = {
        id generator:'sequence', params:[sequence:'commentaire_id_seq']
       // sort date: "desc" // or "asc"
    }

}
