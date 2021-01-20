try {
    var commentaires = document.querySelector("div[id=commentaires]");
}catch (ex){

}
var baseURL = window.location.origin;


function getCommentaires() {

    var devisId = document.querySelector("input[name=devisId]");


    fetch(baseURL+"/commentaire/list/" + devisId.value, {
        "method": "GET"
    })
        .then(response => {
            return response.text()
        })
        .then(data => {

            commentaires.innerHTML = data;
            commentaires.scrollTop = commentaires.scrollHeight - commentaires.clientHeight;
        })
        .catch((error) => {
            alert('Error:' + error);
        });

}




function saveCommentaire() {

    var devisId = document.querySelector("input[name=devisId]")
    var texte = document.querySelector("input[name=texte]")

    if(texte.value) {

        const formData = new FormData();
        formData.append('texte', texte.value);
        formData.append('devisId', devisId.value);
        formData.append('isCommentaireRelance', false);

        fetch(baseURL + "/commentaire/save", {
            "method": "POST",
            body: formData
        }).then(response => {
            return response.text();
        }).then(data => {

            commentaires.innerHTML = data;
            commentaires.scrollTop = commentaires.scrollHeight - commentaires.clientHeight;
            texte.value = "";
        }).catch((error) => {
            alert('Error:' + error);
        });
    }

}


function deleteCommentaire(id) {


    var confirmation = confirm("Etes-vous sûr de vouloir supprimer ?");

    if(confirmation) {

        const formData = new FormData();
        formData.append('commentaireId', id);

        fetch(baseURL+"/commentaire/delete", {
            "method": "DELETE",
            body: formData
        }).then(response => {
            return response.text();
        }).then(data => {


                commentaires.innerHTML = data;
                commentaires.scrollTop = commentaires.scrollHeight - commentaires.clientHeight;

        }).catch((error) => {
            alert('Error:' + error);
        });
    }




}
