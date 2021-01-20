package mccorletagencement

class Etiquette {

    int indice
    String evenement
    String couleur
    static hasMany = [taches:Tache]

    static constraints = {
        evenement blank: false
        couleur blank: false
    }

    static mapping = {
        id generator:'sequence', params:[sequence:'etiquette_id_seq']
    }
}
