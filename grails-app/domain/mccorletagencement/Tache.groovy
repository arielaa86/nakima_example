package mccorletagencement

class Tache {


    Date date

    Date heureDebut
    Date heureFin

    String description
    String visibilite

    boolean journee = false


    static hasOne = [etiquette: Etiquette]
    static hasMany = [participants: Utilisateur]
    static belongsTo = [creator: Utilisateur]


    static mappedBy = [participants: 'none']


    static constraints = {

        date nullable: true
        heureDebut nullable: true
        heureFin nullable: true
        date nullable: true
        description blank: false
        creator nullable: true
        visibilite inList: ['publique', 'privée', 'personnalisée']

    }
    static mapping = {
        id generator: 'sequence', params: [sequence: 'tache_id_seq']
    }


    def participe(Utilisateur utilisateur) {

        if ( this.visibilite.equals("publique") ) {
            return true
        }

        if (utilisateur.equals(creator)) {
            return true
        }


        for (def participant in participants) {
            if (participant.equals(utilisateur)) {
                return true
            }
        }

        return false

    }



}
