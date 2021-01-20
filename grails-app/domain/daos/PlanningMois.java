package daos;

import mccorletagencement.FactureClient;

import java.util.ArrayList;
import java.util.List;

public class PlanningMois {

    private int id;
    private String mois;
    private List<FactureClient> listeBDC;


    public PlanningMois(int id, String mois) {
        this.id = id;
        this.mois = mois;
        listeBDC =  new ArrayList<>();

    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getMois() {
        return mois;
    }

    public void setMois(String mois) {
        this.mois = mois;
    }

    public List<FactureClient> getListeBDC() {
        return listeBDC;
    }

    public void setListeBDC(List<FactureClient> listeBDC) {
        this.listeBDC = listeBDC;
    }
}
