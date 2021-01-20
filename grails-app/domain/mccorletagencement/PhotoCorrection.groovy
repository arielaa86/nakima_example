package mccorletagencement

class PhotoCorrection {

    Date date
    byte[] document
    String documentType
    static belongsTo = [correction:Correction]

    static constraints = {
        date nullable: true
    }
}
