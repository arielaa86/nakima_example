package dtos;


import mccorletagencement.Client;
import mccorletagencement.Devis;
import mccorletagencement.Projet;
import mccorletagencement.Utilisateur;

import java.util.ArrayList;
import java.util.Date;


public class SuiviPoseurDTO {

    private long idDevis;
    private String idInsitu;
    private String client;
    private String typeProjet;
    private double montant;
    private double supplement;
    private double total;
    private Date date;

    public SuiviPoseurDTO() {
    }

    public String getIdInsitu() {
        return idInsitu;
    }

    public Date getDate() {
        return date;
    }

    public long getIdDevis() {
        return idDevis;
    }

    public void setIdDevis(long idDevis) {
        this.idDevis = idDevis;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public void setIdInsitu(String idInsitu) {
        this.idInsitu = idInsitu;
    }

    public String getClient() {
        return client;
    }

    public void setClient(String client) {
        this.client = client;
    }

    public String getTypeProjet() {
        return typeProjet;
    }

    public void setTypeProjet(String typeProjet) {
        this.typeProjet = typeProjet;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }

    public double getSupplement() {
        return supplement;
    }

    public void setSupplement(double supplement) {
        this.supplement = supplement;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }
}
