
var baseURL = window.location.origin;

function changerEtat(confirmation) {

    let id = document.querySelector("input[name=factureId]").value
    const anonyme = document.querySelector("input[id=anonyme]")



    if(confirmation){

        var commentaires = document.querySelector("textarea[name=commentairesPourTechnicien]").value

        const formData = new FormData();
        formData.append('id', id);
        formData.append('anonyme', anonyme.checked);
        formData.append('commentairesTechnicien', commentaires);

        fetch(baseURL + "/factureClient/lancerProduction/", {
            "method": "POST",
            body: formData
        })
            .then(response => {
                return response.text()
            })
            .then(data => {

                showAlert('Le projet a bien été transmis à la production');

                var selecteur = document.querySelector("div[id=switch-button" + id + "]");
                selecteur.innerHTML = data;
                anonyme.checked = false;

                $('#envoiProd'+id).load(window.location.href + ' #envoiProd'+id);


            })
            .catch((error) => {
                alert('Error:' + error);
            });


    }else{

    document.querySelector("input[id=swt" + id + "]").checked = false;


    }


}


function obtenirFactureId(id) {

        var selecteur =  document.querySelector("input[id=swt" + id + "]");
        selecteur.checked = false;

        var confirmation = confirm("Confirmez-vous le démarrage de la production ?");
        if (confirmation) {
            document.querySelector("input[name=factureId]").value = id;
            $('#commentaireTechnicien').modal('show');
            return true;
        }


    return false;

}


function livraisonComplete(id){

    var confirmation = confirm("Confirmez-vous que le nécessaire a été fait ?");


    if(confirmation) {

        const formData = new FormData();
        formData.append('id', id);

        fetch(baseURL + "/ordreProduction/livraisonComplete", {
            method: "POST",
            body: formData
        }).then(response => {
            return response.text();
        }).then(data => {


            document.querySelector("td[id=sav" + id + "]").innerHTML = "<i class='fa fa-circle' style='font-size: 16px; color: #509834'></i>";

        }).catch((error) => {
            alert('Error:' + error);
        });

    }

}


function enregistrerDecharge() {

    var form = document.getElementById('formDecharge');
    var id = document.querySelector('input[name=idFacture]').value;

    form.onsubmit = function () {

        var confirmation = confirm( "Etes-vous sûr de vouloir continuer ?");

        if(confirmation) {
            showAlertWait('Enregistrement en cours. Veuillez patienter', 3000);

            const formData = new FormData(form);

            fetch(baseURL + "/factureClient/enregistrerDecharge", {
                method: "POST",
                body: formData
            }).then(response => {
                return response.text();
            }).then(data => {


                $("#buttonTrash").load(window.location.href + " #buttonTrash");
                $("#pageTitle").load(window.location.href + " #pageTitle");
                $("#documentView").load(window.location.href + " #documentView");
                document.querySelector("span[id=parcourir]").innerHTML = "Parcourir ...";
                document.querySelector("input[id=document]").value = "";


            }).catch((error) => {
                alert('Error:' + error);
            });

            return false;
        }

        return false; // To avoid actual submission of the form
    }

}


function deleteDecharge(){

    var id = document.querySelector('input[name=idFacture]').value;

    var confirmation = confirm( "Etes-vous sûr de vouloir supprimer ?");

    if(confirmation) {

        const formData = new FormData();

        formData.append('idFacture', id);

        fetch(baseURL + "/factureClient/deleteDecharge", {
            method: "POST",
            body: formData
        }).then(response => {
            return response.text();
        }).then(data => {


            $("#buttonTrash").load(window.location.href + " #buttonTrash");
            $("#pageTitle").load(window.location.href + " #pageTitle");
            $("#documentView").load(window.location.href + " #documentView");


        }).catch((error) => {
            alert('Error:' + error);
        });

        return false;
    }

}
