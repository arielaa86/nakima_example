function viderChampPrincipal(id) {
    var value = document.getElementById(id).value;

    if (value == 0.0 || value == 0.00) {
        document.getElementById(id).value = "";
    }
}

function formatChampPrincipal(id) {
    var value = document.getElementById(id).value;

    if (value === "" || value === "0.0") {

        document.getElementById(id).value = "0.00";
    }
}


function obtenirPrixMinPrincipal() {

    try {
        var metreLineaire = document.getElementById("metreLineairePrincipal").value;

        var element = document.getElementById("resultatPrincipal");

        var nombre = metreLineaire * 1250;

        element.innerHTML = nombre.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$& ') + " €";
    } catch (e) {

    }

}


function obtenirPrixProjetPrincipal() {

    var agencementHT = document.getElementById("agencementHTPrincipal").value;

    var remisePourcentage = document.getElementById("remisePourcentagePrincipal").value;

    var remiseMontantElement = document.getElementById("remiseMontantPrincipal");
    var remiseMontant = agencementHT * remisePourcentage / 100;
    remiseMontantElement.innerHTML = remiseMontant.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$& ') + " €";

    var totalHtElement = document.getElementById("totalHTPrincipal");
    var totalHT = agencementHT - remiseMontant;
    totalHtElement.innerHTML = totalHT.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$& ') + " €";

    var tvaNonRecuperableElement = document.getElementById("tvaNonRecuperablePrincipal");
    var tvaNonRecuperable = totalHT * 8.5 / 100;
    tvaNonRecuperableElement.innerHTML = tvaNonRecuperable.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$& ') + " €";

    var octroiDeMerElement = document.getElementById("octroiDeMerPrincipal");
    var octroiDeMer = totalHT * 1.5 / 100;
    octroiDeMerElement.innerHTML = octroiDeMer.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$& ') + " €";

    var taxeEcoMobElement = document.getElementById("taxeEcoMobPrincipal");
    var taxeEcoMob = totalHT * 1 / 100;
    taxeEcoMobElement.innerHTML = taxeEcoMob.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$& ') + " €";

    var totalHtHorsPoseElement = document.getElementById("totalHtHorsPosePrincipal");
    var totalHtHorsPose = totalHT * 1 + octroiDeMer * 1 + taxeEcoMob * 1;
    totalHtHorsPoseElement.innerHTML = totalHtHorsPose.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$& ') + " €";

    var logistiqueElement = document.getElementById("logistiquePrincipal");
    var logistique = totalHT * 2.5 / 100;
    logistiqueElement.innerHTML = logistique.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$& ') + " €";

    var prixPlanTravail = document.getElementById("prixPlanTravailPrincipal").value;
    var prixOption = document.getElementById("prixOptionPrincipal").value;


    var verificationElement = document.getElementById("verificationPrincipal");
    var verification = Math.floor(agencementHT * 5.2857 / 100);
    verificationElement.innerHTML = verification.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$& ') + " €";








    var totalComplexeElement = document.getElementById("totalComplexePrincipal");
    var totalComplexe = Math.floor(totalHtHorsPose * 1 + prixPlanTravail * 1 + prixOption * 1 + logistique * 1 + verification * 1);



    try {

        var value = document.querySelector("input[id=avoirPrincipal]").value*-1;

        totalComplexe =  totalComplexe - value;

    }catch(ex){

    }


    totalComplexeElement.innerHTML = totalComplexe.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$& ') + " €";

    var acompteElement = document.getElementById("acomptePrincipal");
    var acompte = totalComplexe * 40 / 100;
    acompteElement.innerHTML = acompte.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$& ') + " €";


    var soldeElement = document.getElementById("soldePrincipal");
    var solde = totalComplexe * 55 / 100;
    soldeElement.innerHTML = solde.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$& ') + " €";


    var finInstallationElement = document.getElementById("finInstallationPrincipal");
    var finInstallation = totalComplexe * 5 / 100;
    finInstallationElement.innerHTML = finInstallation.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$& ') + " €";


    var totalMCCorlet = totalComplexe
    var totalMCCorletElement = document.getElementById("totalMCCorletPrincipal");
    totalMCCorletElement.innerHTML = totalMCCorlet.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$& ') + " €";


    var supplementPoseur = document.getElementById("supplementPoseurPrincipal").value;

    var livraisonElement = document.getElementById("livraisonPrincipal");
    var livraison = Math.ceil((totalHT * 10 / 100) + supplementPoseur * 1);
    livraisonElement.innerHTML = livraison.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$& ') + " €";


    var totalTTCElement = document.getElementById("totalTTCPrincipal");
    var totalTTC = totalComplexe * 1 + livraison * 1;
    totalTTCElement.innerHTML = totalTTC.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$& ') + " €";



    try {

        var totalPieceEauElement = document.getElementById("totalPieceEauPrincipal");
        var quantitePieceEau = document.getElementById("quantitePieceEauPrincipal").value;
        var totalPieceEau = Math.floor(totalTTC * quantitePieceEau);
        totalPieceEauElement.innerHTML = totalPieceEau.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$& ') + " €";

    } catch (e) {

    }

    try {

        var totalQuantiteHabitationElement = document.getElementById("totalQuantiteHabitationPrincipal");
        var quantiteHabitation = document.getElementById("quantiteHabitationPrincipal").value;
        var totalQuantiteHabitation = Math.floor(totalTTC * quantiteHabitation);
        totalQuantiteHabitationElement.innerHTML = totalQuantiteHabitation.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$& ') + " €";

    } catch (e) {

    }


    try {

        var totalPieceEauLivraisonElement = document.getElementById("totalPieceEauLivraisonPrincipal");
        var totalPieceEauLivraison = Math.floor(livraison * quantitePieceEau);
        totalPieceEauLivraisonElement.innerHTML = totalPieceEauLivraison.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$& ') + " €";

    } catch (e) {

    }


    try {

        var totalPieceEauLivraisonElement = document.getElementById("totalPieceEauLivraisonPrincipal");
        var totalPieceEauLivraison = Math.floor(livraison * quantitePieceEau);
        totalPieceEauLivraisonElement.innerHTML = totalPieceEauLivraison.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$& ') + " €";

    } catch (e) {

    }

    try {

        var totalQuantiteHabitationLivraisonElement = document.getElementById("totalQuantiteHabitationLivraisonPrincipal");
        var totalQuantiteHabitationLivraison = Math.floor(livraison * quantiteHabitation);
        totalQuantiteHabitationLivraisonElement.innerHTML = totalQuantiteHabitationLivraison.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$& ') + " €";

    } catch (e) {

    }


    try {

        var totalPieceEauMccorletElement = document.getElementById("totalPieceEauMccorletPrincipal");
        var totalPieceEauMccorlet = totalMCCorlet * 1 * quantitePieceEau;
        totalPieceEauMccorletElement.innerHTML = totalPieceEauMccorlet.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$& ') + " €";

    } catch (e) {

    }

    try {

        var totalQuantiteHabitationMccorletElement = document.getElementById("totalQuantiteHabitationMccorletPrincipal");
        var totalQuantiteHabitationMccorlet = totalMCCorlet * 1 * quantiteHabitation;
        totalQuantiteHabitationMccorletElement.innerHTML = totalQuantiteHabitationMccorlet.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$& ') + " €";

    } catch (e) {

    }


    document.getElementById("montantPrincipal").value = totalMCCorlet.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&');


}


