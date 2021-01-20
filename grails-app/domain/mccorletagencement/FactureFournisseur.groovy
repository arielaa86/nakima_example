package mccorletagencement

class FactureFournisseur {

    Date date
    String numero
    String description
    double montant
    byte[] document
    String documentType
    Fournisseur fournisseur
    String code
    static belongsTo = [categorie: Categorie]


    static constraints = {
        date nullable: true
        numero blank: false, nullable: false
        montant min: 1.0D
        document nullable: true, maxSize: 25 * 1024 * 1024
        fournisseur nullable: false
        code maxSize: 700, nullable: true

    }


    static mapping = {
        id generator:'sequence', params:[sequence:'factureFournisseur_id_seq']
    }
}
