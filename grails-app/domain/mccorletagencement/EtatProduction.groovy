package mccorletagencement

class EtatProduction {

    int indice
    Date date
    Date dateModification
    Etape etape
    String note
    boolean active = false

    static belongsTo = [ordre: OrdreProduction]

    static constraints = {
        date nullable: true
        dateModification nullable: true
        note nullable: true, maxSize: 500
    }
}
