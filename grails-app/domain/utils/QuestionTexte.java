package utils;

import java.util.ArrayList;

public class QuestionTexte {

    private ArrayList<String> questions;

    public QuestionTexte() {
        questions = new ArrayList<>();

        questions.add("Il n'y a pas eu de suivi commercial");
        questions.add("Le tarif proposé est trop onéreux par rapport au budget que je me suis fixé(e)");
        questions.add("Les options proposées ne correspondent pas à mes attentes");
        questions.add("Le catalogue de couleurs n’est pas suffisamment étoffé");
        questions.add("Il y a eu une mauvaise compréhension de mon besoin");
        questions.add("Je n’ai pas apprécié le contact commercial");
        questions.add("Mon projet est annulé");
        questions.add("J’ai changé d’avis");
        questions.add("Autre");
    }


    public ArrayList<String> getQuestions() {
        return questions;
    }
}
