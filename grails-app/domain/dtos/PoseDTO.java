package dtos;

import java.util.ArrayList;

public class PoseDTO {


    private ArrayList<SuiviPoseurDTO> previsionnelles;
    private ArrayList<SuiviPoseurDTO> realisees;
    private double totalSupplement;
    private double totalPaiements;

    public PoseDTO(ArrayList<SuiviPoseurDTO> previsionnelles, ArrayList<SuiviPoseurDTO> realisees, double totalSupplement, double totalPaiements) {
        this.previsionnelles = previsionnelles;
        this.realisees = realisees;
        this.totalSupplement = totalSupplement;
        this.totalPaiements = totalPaiements;
    }

    public ArrayList<SuiviPoseurDTO> getPrevisionnelles() {
        return previsionnelles;
    }

    public ArrayList<SuiviPoseurDTO> getRealisees() {
        return realisees;
    }

    public double getTotalSupplement() {
        return totalSupplement;
    }

    public double getTotalPaiements() {
        return totalPaiements;
    }
}
