package mccorletagencement

class Plan {

    Projet projet
    static belongsTo = [Projet]

    byte[] document
    String documentType
    Date date

    static constraints = {
      projet nullable: true
      document maxSize: 25 * 1024 * 1024
        documentType nullable: true
        date nullable: true
    }


    static mapping = {
       id generator:'sequence', params:[sequence:'plan_id_seq']
    }
}
