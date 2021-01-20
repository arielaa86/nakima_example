package mccorletagencement

class ProjetComplementaire extends Projet {

    String description
    Projet projetPrincipal

    static constraints = {
        projetPrincipal nullable: true
        description maxSize: 512
    }

    static mapping = {
        id generator:'sequence', params:[sequence:'projetComplementaire_id_seq']
    }

}
