package dtos;


import java.util.Date;

public class BdcDTO {

    private long id;
    private Date date;
    private long idClient;
    private boolean closed;
    private boolean signatureClient;
    private String idInsitu;
    private boolean lancerProduction;
    private boolean pretPourLancerProduction;
    private String type;
    private double totalPayer;
    private double montant;
    private double restantDuAvecGesteCommercial;
    private String client;
    private String concepteur;
    private boolean projetComplementaire;
    private Date delaiRealisation;
    private boolean ordreProduction;
    private Date ordreProductionDate;
    private boolean devisVisible;
    private Date dateValiditeAvoir;

    public BdcDTO() {
    }

    public Date getDateValiditeAvoir() {
        return dateValiditeAvoir;
    }

    public void setDateValiditeAvoir(Date dateValiditeAvoir) {
        this.dateValiditeAvoir = dateValiditeAvoir;
    }

    public boolean isDevisVisible() {
        return devisVisible;
    }

    public void setDevisVisible(boolean devisVisible) {
        this.devisVisible = devisVisible;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public boolean isClosed() {
        return closed;
    }

    public void setClosed(boolean closed) {
        this.closed = closed;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public long getIdClient() {
        return idClient;
    }

    public void setIdClient(long idClient) {
        this.idClient = idClient;
    }

    public boolean isSignatureClient() {
        return signatureClient;
    }

    public void setSignatureClient(boolean signatureClient) {
        this.signatureClient = signatureClient;
    }

    public String getIdInsitu() {
        return idInsitu;
    }

    public void setIdInsitu(String idInsitu) {
        this.idInsitu = idInsitu;
    }

    public boolean isLancerProduction() {
        return lancerProduction;
    }

    public void setLancerProduction(boolean lancerProduction) {
        this.lancerProduction = lancerProduction;
    }

    public boolean isPretPourLancerProduction() {
        return pretPourLancerProduction;
    }

    public void setPretPourLancerProduction(boolean pretPourLancerProduction) {
        this.pretPourLancerProduction = pretPourLancerProduction;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public double getTotalPayer() {
        return totalPayer;
    }

    public void setTotalPayer(double totalPayer) {
        this.totalPayer = totalPayer;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }

    public double getRestantDuAvecGesteCommercial() {
        return restantDuAvecGesteCommercial;
    }

    public void setRestantDuAvecGesteCommercial(double restantDuAvecGesteCommercial) {
        this.restantDuAvecGesteCommercial = restantDuAvecGesteCommercial;
    }

    public String getClient() {
        return client;
    }

    public void setClient(String client) {
        this.client = client;
    }

    public String getConcepteur() {
        return concepteur;
    }

    public void setConcepteur(String concepteur) {
        this.concepteur = concepteur;
    }


    public Date getDelaiRealisation() {
        return delaiRealisation;
    }

    public void setDelaiRealisation(Date delaiRealisation) {
        this.delaiRealisation = delaiRealisation;
    }

    public boolean isOrdreProduction() {
        return ordreProduction;
    }

    public void setOrdreProduction(boolean ordreProduction) {
        this.ordreProduction = ordreProduction;
    }

    public Date getOrdreProductionDate() {
        return ordreProductionDate;
    }

    public void setOrdreProductionDate(Date ordreProductionDate) {
        this.ordreProductionDate = ordreProductionDate;
    }

    public boolean isProjetComplementaire() {
        return projetComplementaire;
    }

    public void setProjetComplementaire(boolean projetComplementaire) {
        this.projetComplementaire = projetComplementaire;
    }
}
