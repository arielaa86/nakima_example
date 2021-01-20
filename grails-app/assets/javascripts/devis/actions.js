var baseURL = window.location.origin;


function valider() {

    var confirmation = confirm("Confirmez-vous la validation du devis ?");

    if (confirmation) {
        var devisId = document.querySelector("input[name=devisId]");

        fetch(baseURL + "/devis/valider/" + devisId.value, {
            "method": "POST"
        })
            .then(response => {
                // return response.text()
            })
            .then(data => {
                showAlert('Le devis a été validé');
                setTimeout(function () {
                    window.location.href = baseURL + '/devis/suiviDevis'
                }, 2000);


            })
            .catch((error) => {
                alert('Error:' + error);
            });
    }

}


function refuser() {

    var confirmation = confirm("Confirmez-vous le refus du devis ?");

    if (confirmation) {
        var devisId = document.querySelector("input[name=devisId]");

        fetch(baseURL + "/devis/refuser/" + devisId.value, {
            "method": "POST"
        })
            .then(response => {
                // return response.text()
            })
            .then(data => {
                showAlert('Le devis a été refusé');
                setTimeout(function () {
                    window.location.href = baseURL + '/devis/suiviDevis'
                }, 2000);

            })
            .catch((error) => {
                alert('Error:' + error);
            });
    }

}


function debloquerRemise() {

    var checkBoxRemise = document.querySelector("input[id=debloquerRemise]")


    if(checkBoxRemise.checked === true) {
        var confirmation = confirm("Etes-vous sûr de vouloir autoriser une remise supérieure à 20% ?");

        if (confirmation) {

           changervValuer();

        } else {
            checkBoxRemise.checked = false;
        }

    }else{
        changervValuer();
        checkBoxRemise.checked = false;
    }

}

function changervValuer(){

    var devisId = document.querySelector("input[name=devisId]");

    fetch(baseURL + "/devis/debloquerRemise/" + devisId.value, {
        "method": "POST"
    }).then(response => {
        // return response.text()

    }).then(data => {

    }).catch((error) => {
        alert('Error:' + error);
    });
}
