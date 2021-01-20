package mccorletagencement

class ProjetAutre extends Projet {

    String typeProjet

    static constraints = {

    }

    static mapping = {
        id generator:'sequence', params:[sequence:'projetAutre_id_seq']
    }

}
