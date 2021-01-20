package daos;


import mccorletagencement.Devis;
import mccorletagencement.Utilisateur;
import org.apache.tools.ant.Project;

import java.util.ArrayList;


public class SuiviCommercialDAO {

    private Utilisateur utilisateur;
    private int devisAttente;
    private int devisDecline;
    private int facturesImpayees;
    private int facturesEnCours;
    private int facturesAcquitees;
    private double commission;
    private double totalBaseCalcul;
    private ArrayList<Devis> devisListe;

    public SuiviCommercialDAO() {
        devisListe = new ArrayList<>();
    }

    public int getDevisAttente() {
        return devisAttente;
    }

    public void setDevisAttente(int devisAttente) { this.devisAttente = devisAttente; }

    public int getDevisDecline() {
        return devisDecline;
    }

    public void setDevisDecline(int devisDecline) {
        this.devisDecline = devisDecline;
    }

    public int getFacturesImpayees() { return facturesImpayees; }

    public void setFacturesImpayees(int facturesImpayees) { this.facturesImpayees = facturesImpayees; }

    public int getFacturesAcquitees() { return facturesAcquitees; }

    public void setFacturesAcquitees(int facturesAcquitees) { this.facturesAcquitees = facturesAcquitees; }

    public int getFacturesEnCours() {
        return facturesEnCours;
    }

    public void setFacturesEnCours(int facturesEnCours) {
        this.facturesEnCours = facturesEnCours;
    }

    public Utilisateur getUtilisateur() {
        return utilisateur;
    }

    public void setUtilisateur(Utilisateur utilisateur) {
        this.utilisateur = utilisateur;
    }

    public double getCommission() { return commission; }

    public void setCommission(double commission) { this.commission = commission; }

    public ArrayList<Devis> getDevisListe() {
        return devisListe;
    }

    public void setDevisListe(ArrayList<Devis> devisListe) {
        this.devisListe = devisListe;
    }

    public double getTotalBaseCalcul() {
        return totalBaseCalcul;
    }

    public void setTotalBaseCalcul(double totalBaseCalcul) {
        this.totalBaseCalcul = totalBaseCalcul;
    }
}
