var baseURL = window.location.origin;



function ajouterEssai(idDevis, quantite) {

        $.ajax({
            type: 'post',
            url: baseURL + '/devis/ajouterEssai',
            data: {
                'idDevis': idDevis
            },
            success: function (data) {

                $('#infoContact'+idDevis).modal('hide');

            },
            error: function () {
                showAlertDanger('Erreur');
            }
        });

}


function clientToujoursInteresse(idDevis) {


    $.ajax({
        type: 'post',
        url: baseURL + '/devis/clientToujoursInteresse',
        data: {
            'idDevis': idDevis
        },
        success: function (data) {

            $('#infoContact'+idDevis).modal('hide');
            $("#pageTitle").load(window.location.href + " #pageTitle");
            $('#dropdown-menu'+idDevis).load(window.location.href + " #dropdown-menu" +idDevis);
            $('#icon'+idDevis).load(window.location.href + " #icon" +idDevis);

            document.querySelector("div[id=actions-buttons"+idDevis+"]").style.display = 'none';

        },
        error: function () {
            showAlertDanger('Erreur');
        }
    });

}



function declinerDevis(idDevis) {

    $.ajax({
        type: 'post',
        url: baseURL + '/devis/decliner',
        data: {
            'id': idDevis
        },
        success: function (data) {

            $('#infoContact'+idDevis).modal('hide');
            window.location.reload();

        },
        error: function () {
            showAlertDanger('Erreur');
        }
    });

}


function getCommentairesRelance(id) {

    var commentairesRelance = document.querySelector("div[id=commentairesRelance"+id+"]");

    fetch(baseURL+"/commentaire/listCommentairesRelance/" + id, {
        "method": "GET"
    })
        .then(response => {
            return response.text()
        })
        .then(data => {

            commentairesRelance.innerHTML = data;
            commentairesRelance.scrollTop = commentairesRelance.scrollHeight - commentairesRelance.clientHeight;
        })
        .catch((error) => {
            alert('Error:' + error);
        });

}


function saveCommentaireRelance(id) {

    var commentairesRelance = document.querySelector("div[id=commentairesRelance"+id+"]");

    var texte = document.querySelector("input[id=texteCommentaireRelance"+id+"]")

    if(texte.value) {

        const formData = new FormData();
        formData.append('texte', texte.value);
        formData.append('devisId', id);
        formData.append('isCommentaireRelance', true);

        fetch(baseURL + "/commentaire/save", {
            "method": "POST",
            body: formData
        }).then(response => {
            return response.text();
        }).then(data => {

            commentairesRelance.innerHTML = data;
            commentairesRelance.scrollTop = commentairesRelance.scrollHeight - commentairesRelance.clientHeight;
            texte.value = "";
        }).catch((error) => {
            alert('Error:' + error);
        });
    }

}

function deleteCommentaireRelance(id, devisId) {

    var confirmation = confirm("Etes-vous sûr de vouloir supprimer ?");

    var commentairesRelance = document.querySelector("div[id=commentairesRelance" + devisId + "]");

    if (confirmation) {

        const formData = new FormData();
        formData.append('commentaireId', id);

        fetch(baseURL + "/commentaire/delete", {
            "method": "DELETE",
            body: formData
        }).then(response => {
            return response.text();
        }).then(data => {

                commentairesRelance.innerHTML = data;
                commentairesRelance.scrollTop = commentairesRelance.scrollHeight - commentairesRelance.clientHeight;

        }).catch((error) => {
            alert('Error:' + error);
        });
    }
}








