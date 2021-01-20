package daos;

public class RecetteDepenseDAO {

    private double recette;
    private double depense;
    private int mois;


    public RecetteDepenseDAO(int mois) {
        this.mois = mois;
        recette = 0;
        depense = 0;

    }

    public double getRecette() {
        return recette;
    }

    public void setRecette(double recette) {
        this.recette = recette;
    }

    public double getDepense() {
        return depense;
    }

    public void setDepense(double depense) {
        this.depense = depense;
    }


    public int getMois() {
        return mois;
    }

    public void setMois(int mois) {
        this.mois = mois;
    }


}
