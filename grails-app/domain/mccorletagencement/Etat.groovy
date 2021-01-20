package mccorletagencement

class Etat {

    String description
    Date date
    boolean commissione = false
    long utilisateur_commissione = 0

    static belongsTo = [devis: Devis]


    static constraints = {
        description inList: ['Attente','Decline','Impayee', 'En cours', 'Acquittee']
    }
}
