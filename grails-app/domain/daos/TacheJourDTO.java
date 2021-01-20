package daos;

import mccorletagencement.Tache;

import java.util.ArrayList;

public class TacheJourDTO {

    private int jour;
    private ArrayList<Tache> taches;

    public TacheJourDTO(int jour) {
        this.jour = jour;
        taches = new ArrayList<>();
    }

    public int getJour() {
        return jour;
    }

    public void setJour(int jour) {
        this.jour = jour;
    }

    public ArrayList<Tache> getTaches() {
        return taches;
    }

}
