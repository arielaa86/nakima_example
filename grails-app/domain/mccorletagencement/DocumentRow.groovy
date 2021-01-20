package mccorletagencement

class DocumentRow {

    String nombre = ""
    String reference =""
    String colonneF =""
    String descriptif =""
    String profondeur
    String longueur
    String hauteur
    String quantite


    static constraints = {

    }


    @Override
    public String toString() {
        return "nombre= " + nombre  +
                ", reference= " + reference  +
                ", colonneF= " + colonneF  +
                ", descriptif= " + descriptif  +
                ", profondeur= " + profondeur +
                ", longueur= " + longueur +
                ", hauteur= " + hauteur +
                ", quantite= " + quantite

    }
}
