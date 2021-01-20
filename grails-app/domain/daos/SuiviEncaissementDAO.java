package daos;

import mccorletagencement.Paiement;

import java.util.ArrayList;
import java.util.List;

public class SuiviEncaissementDAO {

    List<Paiement> carteBancairePaiements;
    List<Paiement> chequePaiements;
    List<Paiement> especesPaiements;
    List<Paiement> virementPaiements;

    public SuiviEncaissementDAO() {
        carteBancairePaiements = new ArrayList<>();
        chequePaiements = new ArrayList<>();
        especesPaiements = new ArrayList<>();
        virementPaiements = new ArrayList<>();

    }

    public List<Paiement> getCarteBancairePaiements() {
        return carteBancairePaiements;
    }

    public void setCarteBancairePaiements(List<Paiement> carteBancairePaiements) {
        this.carteBancairePaiements = carteBancairePaiements;
    }

    public List<Paiement> getChequePaiements() {
        return chequePaiements;
    }

    public void setChequePaiements(List<Paiement> chequePaiements) {
        this.chequePaiements = chequePaiements;
    }

    public List<Paiement> getEspecesPaiements() {
        return especesPaiements;
    }

    public void setEspecesPaiements(List<Paiement> especesPaiements) {
        this.especesPaiements = especesPaiements;
    }

    public List<Paiement> getVirementPaiements() {
        return virementPaiements;
    }

    public void setVirementPaiements(List<Paiement> virementPaiements) {
        this.virementPaiements = virementPaiements;
    }
}
