function viderChamp(id) {
    var value = document.getElementById(id).value;

    if (value == 0.0 || value == 0.00) {
        document.getElementById(id).value = "";
    }
}

function formatChamp(id) {
    var value = document.getElementById(id).value;

    if (value === "" || value === "0.0") {

        document.getElementById(id).value = "0.00";
    }
}


function obtenirPrixMin() {

    try {
        var metreLineaire = document.getElementById("metreLineaire").value;

        var element = document.getElementById("resultat");

        var nombre = metreLineaire * 1250;

        element.innerHTML = nombre.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$& ') + " €";
    } catch (e) {

    }

}


function obtenirPrixProjet() {

    var agencementHT = document.getElementById("agencementHTData").value;

    var remisePourcentage = document.getElementById("remisePourcentage").value;

    var remiseMontantElement = document.getElementById("remiseMontant");
    var remiseMontant = agencementHT * remisePourcentage / 100;
    remiseMontantElement.innerHTML = remiseMontant.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$& ') + " €";


    var agencementHTAux = document.getElementById("agencementHTPrincipal").value;
    var agencementHT2Final = agencementHT*1 - agencementHTAux*1;
    document.getElementById("agencementHTFinalDisplay").innerHTML = agencementHT2Final.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$& ') + " €";;


    var totalHtElement = document.getElementById("totalHT");
    var totalHT = agencementHT - remiseMontant;
    totalHtElement.innerHTML = totalHT.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$& ') + " €";


    document.getElementById("remisePorcentageAux").innerHTML = document.getElementById("remisePourcentage").value + '%';

    var remiseMontantElementAux = document.getElementById("remiseMontantAux");
    var remiseMontantAux = agencementHT2Final * remisePourcentage / 100;
    remiseMontantElementAux.innerHTML = remiseMontantAux.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$& ') + " €";

    var totalHtElementAux = document.getElementById("totalHTAux");
    var totalHTAux = agencementHT2Final - remiseMontantAux;
    totalHtElementAux.innerHTML = totalHTAux.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$& ') + " €";


    var tvaNonRecuperableElement = document.getElementById("tvaNonRecuperable");
    var tvaNonRecuperable = totalHT * 8.5 / 100;
    tvaNonRecuperableElement.innerHTML = tvaNonRecuperable.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$& ') + " €";

    var tvaNonRecuperableElementAux = document.getElementById("tvaNonRecuperableAux");
    var tvaNonRecuperableAux = totalHTAux * 8.5 / 100;
    tvaNonRecuperableElementAux.innerHTML = tvaNonRecuperableAux.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$& ') + " €";


    var octroiDeMerElement = document.getElementById("octroiDeMer");
    var octroiDeMer = totalHT * 1.5 / 100;
    octroiDeMerElement.innerHTML = octroiDeMer.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$& ') + " €";

    var octroiDeMerElementAux = document.getElementById("octroiDeMerAux");
    var octroiDeMerAux = totalHTAux * 1.5 / 100;
    octroiDeMerElementAux.innerHTML = octroiDeMerAux.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$& ') + " €";


    var taxeEcoMobElement = document.getElementById("taxeEcoMob");
    var taxeEcoMob = totalHT * 1 / 100;
    taxeEcoMobElement.innerHTML = taxeEcoMob.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$& ') + " €";


    var taxeEcoMobElementAux = document.getElementById("taxeEcoMobAux");
    var taxeEcoMobAux = totalHTAux * 1 / 100;
    taxeEcoMobElementAux.innerHTML = taxeEcoMobAux.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$& ') + " €";


    var totalHtHorsPoseElement = document.getElementById("totalHtHorsPose");
    var totalHtHorsPose = totalHT * 1 + octroiDeMer * 1 + taxeEcoMob * 1;
    totalHtHorsPoseElement.innerHTML = totalHtHorsPose.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$& ') + " €";

    var totalHtHorsPoseElementAux = document.getElementById("totalHtHorsPoseAux");
    var totalHtHorsPoseAux = totalHTAux * 1 + octroiDeMerAux * 1 + taxeEcoMobAux * 1;
    totalHtHorsPoseElementAux.innerHTML = totalHtHorsPoseAux.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$& ') + " €";


    var logistiqueElement = document.getElementById("logistique");
    var logistique = totalHT * 2.5 / 100;
    logistiqueElement.innerHTML = logistique.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$& ') + " €";

    var logistiqueElementAux = document.getElementById("logistiqueAux");
    var logistiqueAux = totalHTAux * 2.5 / 100;
    logistiqueElementAux.innerHTML = logistiqueAux.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$& ') + " €";


    var prixPlanTravail = document.getElementById("prixPlanTravailData").value;
    var prixOption = document.getElementById("prixOptionData").value;

    var prixPlanTravailPrincipal = document.getElementById("prixPlanTravailPrincipal").value;

    var prixOptionPrincipal = document.getElementById("prixOptionPrincipal").value;

    var prixPlanTravailAux = (prixPlanTravailPrincipal - prixPlanTravail)*-1;

    var prixOptionAux = (prixOptionPrincipal - prixOption)*-1;

    document.getElementById("prixPlanTravailAux").innerHTML = prixPlanTravailAux +" €";
    document.getElementById("prixOptionAux").innerHTML = prixOptionAux+" €";


    var verificationElement = document.getElementById("verification");
    var verification = Math.floor(agencementHT * 5.2857 / 100);
    verificationElement.innerHTML = verification.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$& ') + " €";


    var verificationElementAux = document.getElementById("verificationAux");
    var annulationSoldeElement = document.getElementById("annulationSolde");

    var  annulationSolde = annulationSoldeElement.value * 1;
    var verificationAux = Math.floor(agencementHT2Final * 5.2857 / 100);

    if(annulationSolde <= 0  && annulationSolde*(-1) <= verificationAux ){
       verificationAux = annulationSolde + verificationAux;
    }


    verificationElementAux.innerHTML = verificationAux.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$& ') + " €";
    document.getElementById("annulation").value = annulationSolde;


    var totalComplexeElement = document.getElementById("totalComplexe");
    var totalComplexe = Math.floor(totalHtHorsPose * 1 + prixPlanTravail * 1 + prixOption * 1 + logistique * 1 + verification * 1);
    totalComplexeElement.innerHTML = totalComplexe.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$& ') + " €";

    var totalComplexeElementAux = document.getElementById("totalComplexeAux");
    var totalComplexeAux = Math.floor(totalHtHorsPoseAux * 1 + prixPlanTravailAux * 1 + prixOptionAux * 1 + logistiqueAux * 1 + verificationAux * 1);
    totalComplexeElementAux.innerHTML = totalComplexeAux.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$& ') + " €";





    var acompteElement = document.getElementById("acompte");
    var acompte = totalComplexe * 40 / 100;
    acompteElement.innerHTML = acompte.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$& ') + " €";


    var acompteElementAux = document.getElementById("acompteAux");
    var acompteAux = totalComplexeAux * 40 / 100;
    acompteElementAux.innerHTML = acompteAux.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$& ') + " €";


    var soldeElement = document.getElementById("solde");
    var solde = totalComplexe * 55 / 100;
    soldeElement.innerHTML = solde.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$& ') + " €";

    var soldeElementAux = document.getElementById("soldeAux");
    var soldeAux = totalComplexeAux * 55 / 100;
    soldeElementAux.innerHTML = soldeAux.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$& ') + " €";


    var finInstallationElement = document.getElementById("finInstallation");
    var finInstallation = totalComplexe * 5 / 100;
    finInstallationElement.innerHTML = finInstallation.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$& ') + " €";

    var finInstallationElementAux = document.getElementById("finInstallationAux");
    var finInstallationAux = totalComplexeAux * 5 / 100;
    finInstallationElementAux.innerHTML = finInstallationAux.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$& ') + " €";


    var totalMCCorlet = totalComplexe
    var totalMCCorletElement = document.getElementById("totalMCCorlet");
    totalMCCorletElement.innerHTML = totalMCCorlet.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$& ') + " €";

    var totalMCCorletAux = totalComplexeAux
    var totalMCCorletElementAux = document.getElementById("totalMCCorletAux");
    totalMCCorletElementAux.innerHTML = totalMCCorletAux.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$& ') + " €";


    var supplementPoseur = document.getElementById("supplementPoseur").value * 1;

    var livraisonElement = document.getElementById("livraison");

    var livraison = Math.ceil((totalHTAux * 10 / 100));

    if(supplementPoseur < 0  && supplementPoseur * (-1) == livraison ) {
        livraison = livraison + supplementPoseur;
    }

     if(supplementPoseur >= 0)   {
        livraison = supplementPoseur + livraison;
    }




    livraisonElement.innerHTML = livraison.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$& ') + " €";

    var totalTTCElement = document.getElementById("totalTTC");
    var totalTTC = totalMCCorletAux * 1 + livraison * 1;
    totalTTCElement.innerHTML = totalTTC.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$& ') + " €";





    try {



        document.getElementById("agencementHT").value = agencementHT2Final;
        document.getElementById("totalHThorsPose").value = totalHtHorsPoseAux;
        document.getElementById("soldeProjet").value = verificationAux;
        document.getElementById("compoQuarante").value = acompteAux;
        document.getElementById("compoSoixante").value = soldeAux;
        document.getElementById("verificationChantier").value = finInstallationAux;


    } catch (e) {

    }


    try {

        var totalPieceEauElement = document.getElementById("totalPieceEau");
        var quantitePieceEau = document.getElementById("quantitePieceEau").value;
        var totalPieceEau = Math.floor(totalTTC * quantitePieceEau);
        totalPieceEauElement.innerHTML = totalPieceEau.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$& ') + " €";

    } catch (e) {

    }

    try {

        var totalQuantiteHabitationElement = document.getElementById("totalQuantiteHabitation");
        var quantiteHabitation = document.getElementById("quantiteHabitation").value;
        var totalQuantiteHabitation = Math.floor(totalTTC * quantiteHabitation);
        totalQuantiteHabitationElement.innerHTML = totalQuantiteHabitation.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$& ') + " €";

    } catch (e) {

    }


    try {

        var totalPieceEauLivraisonElement = document.getElementById("totalPieceEauLivraison");
        var totalPieceEauLivraison = Math.floor(livraison * quantitePieceEau);
        totalPieceEauLivraisonElement.innerHTML = totalPieceEauLivraison.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$& ') + " €";

    } catch (e) {

    }


    try {

        var totalPieceEauLivraisonElement = document.getElementById("totalPieceEauLivraison");
        var totalPieceEauLivraison = Math.floor(livraison * quantitePieceEau);
        totalPieceEauLivraisonElement.innerHTML = totalPieceEauLivraison.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$& ') + " €";

    } catch (e) {

    }

    try {

        var totalQuantiteHabitationLivraisonElement = document.getElementById("totalQuantiteHabitationLivraison");
        var totalQuantiteHabitationLivraison = Math.floor(livraison * quantiteHabitation);
        totalQuantiteHabitationLivraisonElement.innerHTML = totalQuantiteHabitationLivraison.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$& ') + " €";

    } catch (e) {

    }


    try {

        var totalPieceEauMccorletElement = document.getElementById("totalPieceEauMccorlet");
        var totalPieceEauMccorlet = totalMCCorlet * 1 * quantitePieceEau;
        totalPieceEauMccorletElement.innerHTML = totalPieceEauMccorlet.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$& ') + " €";

    } catch (e) {

    }

    try {

        var totalQuantiteHabitationMccorletElement = document.getElementById("totalQuantiteHabitationMccorlet");
        var totalQuantiteHabitationMccorlet = totalMCCorlet * 1 * quantiteHabitation;
        totalQuantiteHabitationMccorletElement.innerHTML = totalQuantiteHabitationMccorlet.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$& ') + " €";

    } catch (e) {

    }



    document.getElementById("montant").value = totalComplexeAux;
    document.getElementById("prixPlanTravail").value = prixPlanTravailAux
    document.getElementById("prixOption").value = prixOptionAux

}


