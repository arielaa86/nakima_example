var baseURL = window.location.origin;


function verifierDisponibilite() {

    var dateDelai = document.querySelector("input[name=dateDelai]");
    var disponibiliteDiv = document.querySelector("div[id=disponibilite]");

    const formData = new FormData();
    formData.append('dateDelai', dateDelai.value);


    fetch(baseURL + "/projet/verifierDisponibilite/", {
        "method": "POST",
        body: formData
    })
        .then(response => {
            return response.text()
        })
        .then(data => {

            if (!data.includes('disponible')) {
                disponibiliteDiv.innerHTML = data
            }else{
                disponibiliteDiv.innerHTML = ''
            }

        })
        .catch((error) => {
            alert('Error:' + error);
        });

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
