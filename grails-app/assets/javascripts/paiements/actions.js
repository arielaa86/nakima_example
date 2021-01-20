var baseURL = window.location.origin;



function showMessage(texte) {


    // $("#savePaiement").load(window.location.href + " #savePaiement");

    setTimeout(function () {
        showAlert(texte);
    }, 150);

}


function calculerTotal(montant, quantite, idPaiement) {


    var sum = 0;
    var cont = 0;
    for (i = 0; i < quantite; i++) {
        var montantAux = $("#montant" + i + idPaiement).val() * 1

        if (montantAux == 0) {
            cont++;
        }
        sum += montantAux;
    }


     document.getElementById('create'+idPaiement).disabled = true;

    var dif = montant - sum

    if ( dif <= 0.10 && dif >= -0.10  ) {
        document.getElementById('create'+idPaiement).disabled = false;
    }



}


function calculerTotalMultiple(montant, quantite, id, idPaiement) {

    var sum = 0;
    var cont = 0;
    for (i = id; i < id + quantite * 1; i++) {

        var montantAux = $("#montant" + i).val() * 1

        if (montantAux == 0) {
            cont++;
        }
        sum += montantAux;

    }


        document.getElementById('save'+idPaiement).disabled = true;


    var dif = montant - sum

    if ( dif <= 0.10 && dif >= -0.10  ) {
        document.getElementById('save'+idPaiement).disabled = false;
    }

}


function rotate(id) {
    var img = document.getElementById(id);
    var rotate = img.style.transform;
    var degrees = 0;

    if (rotate !== null) {

        degrees = 90 + parseInt(rotate.split('(')[1].split('d')[0]);

    }

    img.style.transform = 'rotate(' + degrees + 'deg)';

}


function rotateLeft(id) {
    var img = document.getElementById(id);
    var rotate = img.style.transform;
    var degrees = 0;

    if (rotate !== null) {

        degrees = parseInt(rotate.split('(')[1].split('d')[0]) - 90;

    }

    img.style.transform = 'rotate(' + degrees + 'deg)';


}


function zoomin(id) {
    var GFG = document.getElementById(id);
    var currWidth = GFG.clientWidth;
    GFG.style.width = (currWidth + 80) + "px";
}

function zoomout(id) {

    var GFG = document.getElementById(id);
    var currWidth = GFG.clientWidth;
    GFG.style.width = (currWidth - 80) + "px";

}


function up(id) {

    var img = document.getElementById(id);
    var up = img.style.marginTop;
    var qty = 0;

    if (up !== null) {
        qty = parseInt(up.split('px')[0]) - 30;
    }

    img.style.marginTop = qty + "px";

}


function down(id) {

    var img = document.getElementById(id);
    var up = img.style.marginTop;
    var qty = 0;

    if (up !== null) {
        qty = parseInt(up.split('px')[0]) + 30;
    }

    img.style.marginTop = qty + "px";

}

function addRequired() {

    let pieceJointe = document.getElementById("pieceJointe");

    let inputElement = document.getElementById("file-1");

    let options = document.getElementById("moyen");


    document.getElementById('quantiteLabel').style.display = "none"
    document.getElementById('quantiteInput').style.display = "none"

    document.getElementById('dateInput').value='';
    document.getElementById('dateInput').required = false;
    document.getElementById("dateLabel").style.display = 'none';
    document.getElementById("dateInput").style.display = 'none';



    if (options.value !== "Espèces") {
        pieceJointe.style.display = "inline";
        inputElement.required = true;
    } else {
        pieceJointe.style.display = "none";
        inputElement.required = false;
    }


    let checkbox = document.getElementById("checkboxMultiple");

    if (options.value === "Carte bancaire") {
        checkbox.style.display = "block";
        showQuantite('multiple');
    } else {
        checkbox.style.display = "none";
    }



    var checkboxCaution = document.getElementById("checkboxCaution");

    if (options.value === "Chèque") {
        checkboxCaution.style.display = "block";
        document.getElementById("caution").checked = false;
    } else {
        checkboxCaution.style.display = "none";
    }

    document.getElementById("caution").checked = false;
    document.getElementById("multiple").checked = false;


}
const caution = document.getElementById("caution");

caution.addEventListener("change", (e) =>{

    if (e.target.checked) {
        document.getElementById('dateLabel').style.display = "block"
        document.getElementById('dateInput').style.display = "block"
        document.getElementById('dateInput').required = true;
    } else {
        document.getElementById('dateInput').value='';
        document.getElementById('dateInput').required = false;
        document.getElementById('dateLabel').style.display = "none"
        document.getElementById('dateInput').style.display = "none"
    }
})





function showRequired() {

    var requiredText = document.getElementById("fileMissing");

    var inputFile = document.getElementById("file-1");

    if (inputFile.value === "") {
        requiredText.style.display = "block";
    }

}


function showQuantite(id) {

    if (document.getElementById(id).checked) {
        document.getElementById('quantiteLabel').style.display = "block"
        document.getElementById('quantiteInput').style.display = "block"
    } else {
        document.getElementById('quantiteLabel').style.display = "none"
        document.getElementById('quantiteInput').style.display = "none"
    }

}




function activateSave(montant, quantite, id, idForm) {


    document.getElementById('update'+idForm).disabled = true
    document.getElementById('save'+idForm).disabled = false
    calculerTotalMultiple(montant, quantite, id, idForm);

    enableForm(idForm);
}

function activateUpdate(idForm) {


    document.getElementById('update'+idForm).disabled = false
    document.getElementById('save'+idForm).disabled = true

    disableForm(idForm);

}

function disableForm(idForm) {
    //   $("#formBody"+idForm+" :input").attr("disabled", true);

    $("#formBody"+idForm).find('input').attr('disabled', true);
}

function enableForm(idForm) {


    // $("#formBody"+idForm+" :input").attr("disabled", false);

    $("#formBody"+idForm).find('input').attr('disabled', false);
}




function annulationDirection() {

    let geste = document.querySelector("input[name=geste]").value;
    let id = document.querySelector("input[name=idFacture]").value;

    const formData = new FormData();
    formData.append('geste', geste);
    formData.append('id', id);

    fetch(baseURL + "/factureClient/annulationDirection", {
        method: "POST",
        body: formData
    }).then(response => {
        return response.text();
    }).then(data => {

        $("#detailsPaiements").load(window.location.href + " #detailsPaiements");

        $('#gesteCommercial').modal('hide');

    }).catch((error) => {
        alert('Error:' + error);
    });


}



function getDetailsPaiement(id){

    const montant = document.getElementById('montantPaiement')
    const datePaiement = document.getElementById('datePaiement')
    const paiementId = document.getElementById('paiementId')



    fetch(baseURL + "/paiement/getDetailsPaiement/" + id, {
        "method": "GET"
    })
        .then(response => {
            return response.json();
        })
        .then(data => {

            paiementId.value = data.id
            datePaiement.value = data.date
            datePaiement.min = data.minDate
            montant.textContent = `${data.montant} €`

        })
        .catch((error) => {
            alert('Error:' + error);
        });


}


const sauvegarder =  document.getElementById('sauvegarder');
const annuler =  document.getElementById('annuler');
const encaisser =  document.getElementById('encaisser');

sauvegarder.addEventListener('click', () =>{

    const paiementId = document.getElementById('paiementId').value
    const datePaiement = document.getElementById('datePaiement').value


    const formData = new FormData();
    formData.append('id', paiementId);
    formData.append('date', datePaiement);

        fetch(baseURL + "/paiement/sauvegarder/", {
            method: "POST",
            body: formData
        })
            .then(response => {
                return response.text();
            })
            .then(data => {
                $('#chequeCaution').modal('hide');
                $("#paiements").load(window.location.href + " #paiements");
            })
            .catch((error) => {
                alert('Error:' + error);
            });

})

annuler.addEventListener('click', () => {

    const paiementId = document.getElementById('paiementId')
    let confirme = confirm("Confirmez-vous l'annulation de ce chèque ?")

    if (confirme) {

        fetch(baseURL + "/paiement/annuler/" + paiementId.value, {
            "method": "POST"
        })
            .then(response => {
                return response.text();
            })
            .then(data => {

                $('#chequeCaution').modal('hide');
                $("#paiements").load(window.location.href + " #paiements");


            })
            .catch((error) => {
                alert('Error:' + error);
            });
    }

})

encaisser.addEventListener('click', () => {


    const paiementId = document.getElementById('paiementId')
    let confirme = confirm("Confirmez-vous l'encaissement de ce chèque ?")


    if (confirme) {

        fetch(baseURL + "/paiement/encaisser/" + paiementId.value, {
            "method": "POST"
        })
            .then(response => {
                return response.text();
            })
            .then(data => {

                $('#chequeCaution').modal('hide');
                $("#paiements").load(window.location.href + " #paiements");


            })
            .catch((error) => {
                alert('Error:' + error);
            });
    }

})





