package daos;


import java.util.ArrayList;
import java.util.List;

public class SuiviGeneralDAO {

    private List<SuiviCommercialDAO> infoComerciaux;
    private int totalAttente;
    private int totalDecline;
    private int totalFacturesImpayee;
    private int totalFacturesEnCours;
    private int totalFacturesAcquittee;
    private double totalCommission;

    public SuiviGeneralDAO() {
    }

    public List<SuiviCommercialDAO> getInfoComerciaux() {
        return infoComerciaux;
    }

    public void setInfoComerciaux(List<SuiviCommercialDAO> infoComerciaux) {
        this.infoComerciaux = infoComerciaux;
    }

    public int getTotalAttente() {
        return totalAttente;
    }

    public void setTotalAttente(int totalAttente) {
        this.totalAttente = totalAttente;
    }

    public int getTotalDecline() {
        return totalDecline;
    }

    public void setTotalDecline(int totalDecline) {
        this.totalDecline = totalDecline;
    }

    public int getTotalFacturesImpayee() {
        return totalFacturesImpayee;
    }

    public void setTotalFacturesImpayee(int totalFacturesImpayee) {
        this.totalFacturesImpayee = totalFacturesImpayee;
    }

    public int getTotalFacturesEnCours() {
        return totalFacturesEnCours;
    }

    public void setTotalFacturesEnCours(int totalFacturesEnCours) {
        this.totalFacturesEnCours = totalFacturesEnCours;
    }

    public int getTotalFacturesAcquittee() { return totalFacturesAcquittee; }

    public void setTotalFacturesAcquittee(int totalFacturesAcquittee) { this.totalFacturesAcquittee = totalFacturesAcquittee; }

    public double getTotalCommission() { return totalCommission; }

    public void setTotalCommission(double totalCommission) { this.totalCommission = totalCommission; }
}
