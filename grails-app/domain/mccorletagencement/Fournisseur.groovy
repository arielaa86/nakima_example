package mccorletagencement

class Fournisseur {

    String nom

    static constraints = {
        nom blank: false, nullable: false
    }

    static mapping = {
        id generator:'sequence', params:[sequence:'fournisseur_id_seq']
    }


    @Override
    public String toString() {
        return nom
    }


}
