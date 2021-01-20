var baseURL = window.location.origin;
var listeCategories = document.querySelector("div[id=listeCategories]");
var errors = document.querySelector("div[id=errors]");

var morrisChart = document.querySelector("div[id=chartData]");



function saveCategory() {

    var icon = document.querySelector("input[name=categorieIconSave]").value;

    var description = document.querySelector("input[name=description]").value;

    const formData = new FormData();

    formData.append('icon', icon);
    formData.append('description', description);

    fetch(baseURL + "/categorie/save", {
        method: "POST",
        body: formData
    }).then(response => {
        return response.text();
    }).then(data => {

        if(data.includes("error")){
            errors.innerHTML = data;
        }else{
            listeCategories.innerHTML = data;
        }

    }).catch((error) => {
        alert('Error:' + error);
    });

}



function updateCategory() {


    var id = document.querySelector("input[name=idCategory]").value;

    var divCategorie = document.querySelector("div[id=categorie"+id+"]");

    var icon = document.querySelector("input[name=categorieIconUpdate]").value;

    var descriptionUpdate = document.querySelector("input[name=descriptionUpdate]").value;

    alert(id+" : "+icon+" : "+descriptionUpdate );


    const formData = new FormData();

    formData.append('id', id);
    formData.append('icon', icon);
    formData.append('description', descriptionUpdate);

    fetch(baseURL + "/categorie/update", {
        method: "PUT",
        body: formData
    }).then(response => {
        return response.text();
    }).then(data => {
        if(data.includes("error")){
            errors.innerHTML = data;
        }else{
            divCategorie.innerHTML = data;
        }

    }).catch((error) => {
        alert('Error:' + error);
    });

}

function getDetailscategorie(id) {


   document.querySelector("button[id=update]").disabled = false;

    var description = document.querySelector("input[name=descriptionUpdate]");
    var montant = document.querySelector("input[name=montantUpdate]");


    const formData = new FormData();

    formData.append('id', id);

    fetch(baseURL + "/categorie/obtenir", {
        "method": "POST",
        body: formData
    }).then(response => {
        return response.json();
    }).then(data => {

        document.querySelector("input[name=idCategory]").value = id;
        description.value = data.description;

        var icon = document.querySelector("div[id=iconPreviewUpdate]");
        icon.innerHTML = "<i class='fa "+data.icon+" fa-5x m-3'></i>";

        document.querySelector("input[name=categorieIconUpdate]").value = data.icon;


    }).catch((error) => {
        alert('Error:' + error);
    });

}


function cestVide(id, buttonId){

    var value = document.querySelector("input[id="+id+"]").value;
    var button = document.querySelector("button[id="+buttonId+"]");

   if (value.length === 0 || value.trim().length === 0){
       button.disabled = true;
   }else{
       button.disabled = false;
   }

}


function selectIcon(id, action){

    var icon = document.querySelector("div[id=iconPreview"+action+"]");
    icon.innerHTML = "<i class='fa "+id+" fa-5x m-3'></i>";
   document.querySelector("input[name=categorieIcon"+action+"]").value = id;

}

function getCategorieSelectionne(id){
    document.querySelector("input[name=categorieSelectionne]").value = id;

    loadFacturesCategorie(id);
}


function getCategoryByMonth() {

    var date = document.querySelector("input[name=date]").value;

    const formData = new FormData();

    formData.append('date', date);

    fetch(baseURL + "/categorie/indexAjax", {
        "method": "POST",
        body: formData
    }).then(response => {
        return response.text();
    }).then(data => {

        if(data.includes("error")){
            errors.innerHTML = data;
        }else{
            listeCategories.innerHTML = data;
        }

    }).catch((error) => {
        alert('Error:' + error);
    });

}




function getTotalAnne() {

    var date = document.querySelector("select[name=dateChart]").value;
    var totalElement = document.querySelector("div[id=total]");

    const formData = new FormData();

    formData.append('date', date);

    fetch(baseURL + "/categorie/getTotal", {
        "method": "POST",
        body: formData
    }).then(response => {
        return response.text();
    }).then(data => {

        if(data.includes("error")){
            errors.innerHTML = data;
        }else{
            totalElement.innerHTML = data;
        }

    }).catch((error) => {
        alert('Error:' + error);
    });

}


function getCharData() {

    var date = document.querySelector("select[name=dateChart]").value;

    const formData = new FormData();

    formData.append('date', date);

    fetch(baseURL + "/categorie/getCharData", {
        "method": "POST",
        body: formData
    }).then(response => {
        return response.text();
    }).then(data => {

        if(data.includes("error")){
            errors.innerHTML = data;
        }else{

            document.getElementById('line-chart').innerHTML = "";

            line_chart(data);
        }

    }).catch((error) => {
        alert('Error:' + error);
    });

}


const formatNumber = (id) =>{
    const input = document.getElementById(id);

    if(input.value.includes("€")){
        let number = input.value.split("€")[0]
        input.value = number.replaceAll(" ","").trim();
    }
}

const formatEuro = (id) =>{
    const input = document.getElementById(id);
    let number = input.value *1;
     input.value = number.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$& ') + " €"
}













