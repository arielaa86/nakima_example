package dtos;

import java.util.Date;

public class DevisDTO {

    private long id;
    private String idInsitu;
    private String client;
    private String telephoneClient;
    private Date date;
    private String typeProjet;
    private String concepteur;
    boolean relance;
    boolean expirationEnCours;
    boolean toujoursInteresse;
    boolean questionnaire;
    boolean isQuestionnaireCompleted;
    boolean expireAuto;
    long questionnaireId;
    double montant;

    public DevisDTO() {
        relance = false;
        expirationEnCours = false;
        toujoursInteresse = false;
        questionnaire = false;
        expireAuto = false;
        isQuestionnaireCompleted = false;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getIdInsitu() {
        return idInsitu;
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

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getTypeProjet() {
        return typeProjet;
    }

    public void setTypeProjet(String typeProjet) {
        this.typeProjet = typeProjet;
    }

    public String getConcepteur() {
        return concepteur;
    }

    public void setConcepteur(String concepteur) {
        this.concepteur = concepteur;
    }

    public boolean isRelance() {
        return relance;
    }

    public void setRelance(boolean relance) {
        this.relance = relance;
    }

    public boolean isExpirationEnCours() {
        return expirationEnCours;
    }

    public void setExpirationEnCours(boolean expirationEnCours) {
        this.expirationEnCours = expirationEnCours;
    }

    public boolean isToujoursInteresse() {
        return toujoursInteresse;
    }

    public void setToujoursInteresse(boolean toujoursInteresse) {
        this.toujoursInteresse = toujoursInteresse;
    }

    public boolean isQuestionnaire() {
        return questionnaire;
    }

    public void setQuestionnaire(boolean questionnaire) {
        this.questionnaire = questionnaire;
    }

    public boolean isQuestionnaireCompleted() {
        return isQuestionnaireCompleted;
    }

    public void setQuestionnaireCompleted(boolean questionnaireCompleted) {
        isQuestionnaireCompleted = questionnaireCompleted;
    }

    public long getQuestionnaireId() {
        return questionnaireId;
    }

    public void setQuestionnaireId(long questionnaireId) {
        this.questionnaireId = questionnaireId;
    }

    public boolean isExpireAuto() {
        return expireAuto;
    }

    public void setExpireAuto(boolean expireAuto) {
        this.expireAuto = expireAuto;
    }

    public String getTelephoneClient() {
        return telephoneClient;
    }

    public void setTelephoneClient(String telephoneClient) {
        this.telephoneClient = telephoneClient;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }
}
