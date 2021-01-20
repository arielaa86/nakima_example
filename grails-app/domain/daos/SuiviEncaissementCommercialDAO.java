package daos;

import mccorletagencement.Utilisateur;

public class SuiviEncaissementCommercialDAO {

    private Utilisateur utilisateur;
    private double carteBleu;
    private double cheque;
    private double especes;
    private double virement;

    private double total;

    public SuiviEncaissementCommercialDAO() {
    }

    public Utilisateur getUtilisateur() {
        return utilisateur;
    }

    public void setUtilisateur(Utilisateur utilisateur) {
        this.utilisateur = utilisateur;
    }

    public double getCarteBleu() {
        return carteBleu;
    }

    public void setCarteBleu(double carteBleu) {
        this.carteBleu = carteBleu;
    }

    public double getCheque() {
        return cheque;
    }

    public void setCheque(double cheque) {
        this.cheque = cheque;
    }

    public double getEspeces() {
        return especes;
    }

    public void setEspeces(double especes) {
        this.especes = especes;
    }

    public double getVirement() {
        return virement;
    }

    public void setVirement(double virement) {
        this.virement = virement;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }
}
