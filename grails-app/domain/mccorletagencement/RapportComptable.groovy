package mccorletagencement

class RapportComptable {


    Date date
    String codeEmail
    static hasMany = [facturesAcquittees : FactureClient]

    static constraints = {
       facturesAcquittees nullable: true
        codeEmail maxSize: 1000
    }

    static mapping = {
        id generator:'sequence', params:[sequence:'rapportCompatble_id_seq']
    }
}
