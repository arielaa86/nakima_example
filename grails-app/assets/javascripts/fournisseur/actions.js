var baseURL = window.location.origin;
var divFournisseur = document.querySelector("div[id=selectFournisseur]");
var nomFournisseur = document.querySelector("input[id=chercherFournisseur]");


function filtrerFournisseurs() {

    var texte = document.querySelector("input[id=chercherFournisseur]").value;

    const formData = new FormData();

    formData.append('texte', texte);

    fetch(baseURL + "/fournisseur/search", {
        "method": "POST",
        body: formData
    }).then(response => {
        return response.text();
    }).then(data => {
        divFournisseur.innerHTML = data;
        showSelect();


    }).catch((error) => {
        alert('Error:' + error);
    });

}

function getSelectItem() {

    var selectFournisseur = document.querySelector("select[id=fournisseur]");

    if (typeof (selectFournisseur) != 'undefined' && selectFournisseur != null) {
        var nom = selectFournisseur.options[selectFournisseur.selectedIndex].text;
        nomFournisseur.value = nom;
        hideSelect();
    }

}


function showSelect() {
    divFournisseur.style.display = "flex";
}

function hideSelect() {
    divFournisseur.style.display = "none";
}


function addFournisseur() {

    var nom = nomFournisseur.value;

    const formData = new FormData();

    formData.append('nom', nom);

    fetch(baseURL + "/fournisseur/save", {
        "method": "POST",
        body: formData
    }).then(response => {
        return response.text();
    }).then(data => {

        $('#addFournisseur').hide();

    }).catch((error) => {
        alert('Error:' + error);
    });





}



