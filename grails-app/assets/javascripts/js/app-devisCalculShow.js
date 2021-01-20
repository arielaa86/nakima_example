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

        var element = document.querySelector("td[id=resultat]")

        var nombre = metreLineaire * 1250;

        element.innerHTML = nombre.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$& ') + " €";
    } catch (e) {

    }

}


function obtenirPrixProjet() {


    var ancien = document.querySelector("input[name=ancien]").checked;


    if (!ancien) {

        document.querySelector("td[id=verificationAtelier]").innerHTML = "A la vérification en atelier (55% du prix total)";
        document.querySelector("tr[id=soldeProjetRow]").style.visibility = "visible";
        document.querySelector("tr[id=soldeProjetRow]").style.height = "42px";

        document.querySelector("tr[id=finInstallationRow]").style.visibility = "visible";
        document.querySelector("tr[id=finInstallationRow]").style.height = "42px";

        document.querySelector("tr[id=verificationRow]").style.visibility = "collapse";


    } else {

        document.querySelector("td[id=verificationAtelier]").innerHTML = "A la vérification en atelier (60% du prix total)";

        document.querySelector("tr[id=soldeProjetRow]").style.visibility = "collapse";

        document.querySelector("tr[id=finInstallationRow]").style.visibility = "collapse";

        document.querySelector("tr[id=verificationRow]").style.visibility = "visible";
        document.querySelector("tr[id=verificationRow]").style.height = "42px";

    }


    var agencementHT = document.getElementById("agencementHT").value;

    var remisePourcentage = document.getElementById("remisePourcentage").value;

    var remiseMontantElement = document.getElementById("remiseMontant");
    var remiseMontant = agencementHT * remisePourcentage / 100;
    remiseMontantElement.innerHTML = remiseMontant.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$& ') + " €";

    var totalHtElement = document.getElementById("totalHT");
    var totalHT = agencementHT - remiseMontant;
    totalHtElement.innerHTML = totalHT.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$& ') + " €";

    var tvaNonRecuperableElement = document.getElementById("tvaNonRecuperable");
    var tvaNonRecuperable = totalHT * 8.5 / 100;
    tvaNonRecuperableElement.innerHTML = tvaNonRecuperable.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$& ') + " €";

    var octroiDeMerElement = document.getElementById("octroiDeMer");
    var octroiDeMer = totalHT * 1.5 / 100;
    octroiDeMerElement.innerHTML = octroiDeMer.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$& ') + " €";

    var taxeEcoMobElement = document.getElementById("taxeEcoMob");
    var taxeEcoMob = totalHT * 1 / 100;
    taxeEcoMobElement.innerHTML = taxeEcoMob.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$& ') + " €";

    var totalHtHorsPoseElement = document.getElementById("totalHtHorsPose");
    var totalHtHorsPose = totalHT * 1 + octroiDeMer * 1 + taxeEcoMob * 1;
    totalHtHorsPoseElement.innerHTML = totalHtHorsPose.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$& ') + " €";

    var logistiqueElement = document.getElementById("logistique");
    var logistique = totalHT * 2.5 / 100;
    logistiqueElement.innerHTML = logistique.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$& ') + " €";

    var prixPlanTravail = document.getElementById("prixPlanTravail").value;
    var prixOption = document.getElementById("prixOption").value;


    var verificationElement = document.getElementById("verification");


    var verification;
    var annulation = 0.0;

    if (!ancien) {


        try {
            annulation = document.querySelector("input[id=annulation]").value * 1;

        } catch (ex) {

            annulation = document.querySelector("input[id=annulationSolde]").value * 1;
        }

    } else {

        try {
            annulation = document.querySelector("input[id=annulation]").value * 1;

        } catch (ex) {
            annulation = document.querySelector("input[id=annulationVerif]").value * 1;
        }


    }

    verification = Math.floor(agencementHT * 5.2857 / 100);

    if (annulation <= 0 && annulation * (-1) <= verification) {
        verification = annulation + verification;
    }

    verificationElement.innerHTML = verification.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$& ') + " €";

    document.querySelector("td[id=verificationValue]").innerHTML = verification.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$& ') + " €";
    ;


    var totalComplexeElement = document.getElementById("totalComplexe");
    var totalComplexe;

    if (!ancien) {
        totalComplexe = Math.floor(totalHtHorsPose * 1 + prixPlanTravail * 1 + prixOption * 1 + logistique * 1 + verification * 1);
    } else {
        totalComplexe = totalHtHorsPose * 1 + prixPlanTravail * 1 + prixOption * 1 + logistique * 1;
    }


    var select = document.querySelector("select[id=selectAvoirs]");

    //Element exist!

    if (typeof (select) != 'undefined' && select != null) {

        var avoir = select.options[select.selectedIndex].text;

        var avoirId = select.options[select.selectedIndex].value;

        if (avoir !== '---') {
            var value = avoir.split(":")[1].trim().split(" ")[0] * 1;
            totalComplexe = totalComplexe - value;

            document.querySelector("input[id=avoir]").value = value * -1;
            document.querySelector("input[id=avoirUtilise]").value = avoirId;

            document.querySelector("input[id=aRembourser]").value = totalComplexe;

            if (totalComplexe < 0) {

                document.querySelector("input[id=annulationSolde]").value = "0.00";
                document.querySelector("input[id=annulationVerif]").value = "0.00";

                totalComplexe = 0;
                totalMCCorlet = 0;

            } else {

                document.querySelector("input[id=aRembourser]").value = "0.00";

            }


        } else {
            document.querySelector("input[id=avoirUtilise]").value = "";
        }


    } else {
        //Element does not exist!

        var inputAvoir = document.querySelector("input[id=avoir]");

        if (typeof (inputAvoir) != 'undefined' && inputAvoir != null) {

            var value = inputAvoir.value * -1;
            totalComplexe = totalComplexe - value;

            document.querySelector("input[id=avoir]").value * -1;

            if (totalComplexe <= 0 && value != 0) {

                document.querySelector("input[id=annulationSolde]").value = "0.00";
                document.querySelector("input[id=annulationVerif]").value = "0.00";

                totalComplexe = 0;
                totalMCCorlet = 0;

            }

        }
    }


    var avoirUtiliseDeclineIdInsituElement = document.querySelector("input[id=avoirUtiliseDeclineIdInsitu]");
    var avoirUtiliseDeclineMontantElement = document.querySelector("input[id=avoirUtiliseDeclineMontant]");


    if (typeof (avoirUtiliseDeclineIdInsituElement) != 'undefined' && avoirUtiliseDeclineIdInsituElement != null) {

        var avoirutilise = avoirUtiliseDeclineMontantElement.value * -1;
        totalComplexe = totalComplexe - avoirutilise;

        if (totalComplexe < 0) {

            document.querySelector("input[id=annulationSolde]").value = "0.00";
            document.querySelector("input[id=annulationVerif]").value = "0.00";

            totalComplexe = 0;
            totalMCCorlet = 0;

        }

    }


    totalComplexeElement.innerHTML = totalComplexe.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$& ') + " €";

    var acompteElement = document.getElementById("acompte");
    var acompte = totalComplexe * 40 / 100;
    acompteElement.innerHTML = acompte.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$& ') + " €";


    var soldeElement = document.getElementById("solde");
    var solde;

    if (!ancien) {
        solde = totalComplexe * 55 / 100;
    } else {
        solde = totalComplexe * 60 / 100;
    }

    soldeElement.innerHTML = solde.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$& ') + " €";


    var finInstallationElement = document.getElementById("finInstallation");
    var finInstallation = totalComplexe * 5 / 100;
    finInstallationElement.innerHTML = finInstallation.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$& ') + " €";

    var totalMCCorlet;

    if (!ancien) {
        totalMCCorlet = totalComplexe;
    } else {
        totalMCCorlet = totalComplexe + verification;
    }

    var totalMCCorletElement = document.getElementById("totalMCCorlet");
    totalMCCorletElement.innerHTML = totalMCCorlet.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$& ') + " €";

    if (totalMCCorlet < 0) {
        document.querySelector("tr[id=finInstallationRow]").style.visibility = "collapse";
    }
    var supplementPoseur = document.getElementById("supplementPoseur").value;

    var livraisonElement = document.getElementById("livraison");

    var livraison;
    if (!ancien) {
        livraison = Math.ceil((totalHT * 10 / 100) + supplementPoseur * 1);
    } else {
        livraison = (totalHT * 10 / 100) + supplementPoseur * 1;
    }

    livraisonElement.innerHTML = livraison.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$& ') + " €";


    var totalTTCElement = document.getElementById("totalTTC");
    var totalTTC = totalComplexe * 1 + livraison * 1;
    if (!ancien) {
        totalTTC = totalComplexe * 1 + livraison * 1;
    } else {
        totalTTC = totalMCCorlet * 1 + livraison * 1;
    }

    totalTTCElement.innerHTML = totalTTC.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$& ') + " €";

    try {

        document.getElementById("totalHThorsPose").value = totalHtHorsPose;
        document.getElementById("soldeProjet").value = verification;
        document.getElementById("compoQuarante").value = acompte;
        document.getElementById("compoSoixante").value = solde;
        document.getElementById("verificationChantier").value = finInstallation;

    } catch (e) {

    }


    try {

        var totalPieceEauElement = document.getElementById("totalPieceEau");
        var quantitePieceEau = document.getElementById("quantitePieceEau").value;
        var totalPieceEau;
        if (!ancien) {

            totalPieceEau = Math.floor(totalTTC * quantitePieceEau);

        } else {

            totalPieceEau = totalTTC * quantitePieceEau;

        }

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

        var totalPieceEauLivraison;
        if (!ancien) {
            totalPieceEauLivraison = Math.floor(livraison * quantitePieceEau);
        } else {
            totalPieceEauLivraison = livraison * quantitePieceEau;
        }

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


    document.getElementById("montant").value = totalMCCorlet.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&');


}



