package mccorletagencement

class Question {

    String texte

    static hasMany = [questionaires: Questionnaire]
    static belongsTo = Questionnaire

    static constraints = {

    }

    static mapping = {
        id generator:'sequence', params:[sequence:'question_id_seq']

    }

}
