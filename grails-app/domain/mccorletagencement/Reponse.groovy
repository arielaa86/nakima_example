package mccorletagencement

class Reponse {

    static belongsTo = [questionaire: Questionnaire]
    Question question
    boolean selectionne

    String texteAutre

    static constraints = {
        texteAutre nullable: true
    }


    static mapping = {
        id generator:'sequence', params:[sequence:'reponse_id_seq']
    }




}
