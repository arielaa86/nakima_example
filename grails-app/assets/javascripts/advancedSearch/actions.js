var baseURL = window.location.origin;
var listeResultats = document.querySelector("div[id=resultat]");

function searchAll() {

    var description = document.querySelector("input[id=description]").value;

    const formData = new FormData();
    formData.append('description', description);


    fetch(baseURL + "/search/searchAll", {
        "method": "POST",
        body: formData
    }).then(response => {
        return response.text();
    }).then(data => {

        listeResultats.innerHTML = data;

    }).catch((error) => {
        alert('Error:' + error);
    });

}

