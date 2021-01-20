package mccorletagencement

class Transfert implements Comparable<Transfert>{

    Date date
    Utilisateur origine
    Utilisateur destination
    static belongsTo = [projet: Projet]


    static constraints = {

    }

    static mapping = {
        id generator: 'sequence', params: [sequence: 'transfert_id_seq']
        sort id: "desc" // or "asc"
    }

    @Override
    int compareTo(Transfert o) {
        return this.id - o.id
    }
}
