var baseURL = window.location.origin;
var etatsProduction = document.querySelector("ul[id=etatsProduction]");


function changerStatut(id, status) {
    var confirmation ;

    if(status == true){
        confirmation = confirm("Confirmez-vous annuler cette étape ?");
    }else{
        confirmation = confirm("Confirmez-vous cette étape ?");
    }


    if (confirmation) {

        fetch(baseURL + "/etatProduction/changerStatut/" + id, {
            "method": "POST"
        })
            .then(response => {
                return response.text();
            })
            .then(data => {

                etatsProduction.innerHTML = data;

            })
            .catch((error) => {
                alert('Error:' + error);
            });
    }

}


function saveDateDelivery() {

    var id = document.querySelector("input[name=ordreId]").value;
    var date = document.querySelector("input[name=date]").value;

    const formData = new FormData();
    formData.append('id', id);
    formData.append('date', date);

    fetch(baseURL + "/ordreProduction/saveDateDelivery", {
        "method": "POST",
        body: formData
    }).then(response => {
        return response.text();
    }).then(data => {

        etatsProduction.innerHTML = data;


    }).catch((error) => {
        alert('Error:' + error);
    });


    $('#myModal2').modal('toggle');


}


function editNote(id) {

    var idNote = id.split('-')[1]
    var action = id.split('-')[0]

    var note =  document.querySelector("input[name=noteTexte" + idNote + "]").value;

    if (note === 'Rien à signaler') {
        note = '';
    }


    var noteElement = document.querySelector("div[id=note" + idNote + "]");


    noteElement.innerHTML = "<textarea class='form-control' id='textNote" + idNote + "'>" + note + "</textarea>";

    var editElement = document.querySelector("i[id=" + id + "]");
    editElement.style.display = 'none';

    var saveElement = document.querySelector("i[id=save-" + idNote + "]");
    saveElement.style.display = 'block';

}


function saveNote(id) {

    document.querySelector("i[id=" + id+"]").style.display = 'none';

    var idNote = id.split('-')[1]

    var note = document.querySelector("textarea[id=textNote" + idNote + "]").value;

    const formData = new FormData();
    formData.append('id', idNote);
    formData.append('note', note);

    fetch(baseURL + "/etatProduction/sauvegarderNote", {
        "method": "POST",
        body: formData
    }).then(response => {
        return response.text();
    }).then(data => {
        etatsProduction.innerHTML = data;
    }).catch((error) => {
        alert('Error:' + error);
    });

}


function saveCorrection() {

    var customSwal = Swal.mixin({
        confirmButtonClass: 'btn btn-primary',
        cancelButtonClass: 'btn btn-secondary',
        buttonsStyling: false
    });


    customSwal.fire({
        title: 'Enregistrement en cours. Veuillez patienter',
        html: '',
        timer: 3000,
        customClass: 'content-actions-center',
        buttonsStyling: true,
        onOpen: () => {
            swal.showLoading()
            timerInterval = setInterval(() => {
                swal.getContent().querySelector('strong')
                    .textContent = swal.getTimerLeft()
            }, 100)
        },
        onClose: () => {
            clearInterval(timerInterval)
        }
    }).then((result) => {
        if (
            // Read more about handling dismissals
            result.dismiss === swal.DismissReason.timer
        ) {
            console.log('I was closed by the timer')
        }
    });

    var form = document.getElementById('correction-form');

    form.onsubmit = function () {

        const formData = new FormData(form);

        fetch(baseURL + "/correction/save", {
            method: "POST",
            body: formData
        }).then(response => {
            return response.text();
        }).then(data => {
            document.querySelector("textarea[name=description]").value = "";
            document.querySelector("span[id=parcourir]").innerHTML = "Parcourir ...";
            document.querySelector("input[id=file-1]").value = "";

            $("#listeCorrections").load(window.location.href + " #listeCorrections");
        }).catch((error) => {
            alert('Error:' + error);
        });

        return false; // To avoid actual submission of the form
    }

}


function deletePhoto(id) {

    var confirmation = confirm("Etes-vous sûr de vouloir supprimer ?");

    if (confirmation) {
        var photoId = document.querySelector("input[id=" + id + "]").value;

        const formData = new FormData();

        formData.append('id', photoId);

        fetch(baseURL + "/photoCorrection/delete", {
            method: "DELETE",
            body: formData
        }).then(response => {
            return response.text();
        }).then(data => {
            $("#listeCorrections").load(window.location.href + " #listeCorrections");
        }).catch((error) => {
            alert('Error:' + error);
        });
    }

}


function supprimerCorrection(id) {

    var confirmation = confirm("Etes-vous sûr de vouloir supprimer ?");

    if (confirmation) {
        const formData = new FormData();

        formData.append('id', id);

        fetch(baseURL + "/correction/delete", {
            method: "DELETE",
            body: formData
        }).then(response => {
            return response.text();
        }).then(data => {
            $("#listeCorrections").load(window.location.href + " #listeCorrections");
        }).catch((error) => {
            alert('Error:' + error);
        });
    }

}


function setCorrige(id) {

    const formData = new FormData();
    formData.append('id', id);

    fetch(baseURL + "/correction/update", {
        method: "PUT",
        body: formData
    }).then(response => {
        return response.text();
    }).then(data => {
        $("#infoTech").load(window.location.href + " #infoTech");
    }).catch((error) => {
        alert('Error:' + error);
    });
}


function sendNotification(id) {

    document.querySelector("button[name=btnInfoTech]").disabled = true;

    const formData = new FormData();
    formData.append('id', id);

    fetch(baseURL + "/factureClient/infoTech", {
        method: "POST",
        body: formData
    }).then(response => {
        return response.text();
    }).then(data => {

        showAlert('L\'information a bien été envoyée');
        setTimeout(function () {
        }, 2000);

        $("#infoTech").load(window.location.href + " #infoTech");

    }).catch((error) => {
        alert('Error:' + error);
    });

}


function sendNotificationCorrectionAfaire(id) {

    document.querySelector("button[name=btnInfoCommercial]").disabled = true;

    const formData = new FormData();
    formData.append('id', id);

    fetch(baseURL + "/factureClient/infoCommercial", {
        method: "POST",
        body: formData
    }).then(response => {
        return response.text();
    }).then(data => {

        showAlert('L\'information a bien été envoyée');
        setTimeout(function () {
        }, 2000);

        $("#infoTech").load(window.location.href + " #infoTech");
    }).catch((error) => {
        alert('Error:' + error);
    });

}


function getPlanning(annee) {

    let tableauPlanning = document.querySelector("div[id=tableauPlanning]");


    const formData = new FormData();
    formData.append('annee', annee);

    fetch(baseURL + "/ordreProduction/getPlanning", {
        method: "POST",
        body: formData
    }).then(response => {
        return response.text();
    }).then(data => {

        tableauPlanning.innerHTML = data;

    }).catch((error) => {
        alert('Error:' + error);
    });


}


function informerPoseComplete(incomplete) {

    document.querySelector('input[name=etat]').value = incomplete;
    var id = document.querySelector('input[name=idPose]').value;
    var form = document.getElementById('formPose');

    form.onsubmit = function () {

        var confirmation = confirm( "Le dossier va être envoyé aux équipes");

        if(confirmation) {
            showAlertWait('Envoi en cours. Veuillez patienter', 10000)

            const formData = new FormData(form);

            fetch(baseURL + "/pose/informerPoseComplete", {
                method: "POST",
                body: formData
            }).then(response => {
                return response.text();
            }).then(data => {

                location.replace(baseURL + "/ordreProduction/index");

            }).catch((error) => {
               alert('Error:' + error);
            });

            return false;
        }

        return false; // To avoid actual submission of the form
    }

}


function saveDateVerification() {

    var id = document.querySelector("input[name=ordreId]").value;
    var date = document.querySelector("input[name=date2]").value;

    const formData = new FormData();
    formData.append('id', id);
    formData.append('date', date);

    fetch(baseURL + "/ordreProduction/saveDateVerification", {
        "method": "POST",
        body: formData
    }).then(response => {
        return response.text();
    }).then(data => {

        etatsProduction.innerHTML = data;

    }).catch((error) => {
        alert('Error:' + error);
    });


    $('#myModal3').modal('toggle');


}






