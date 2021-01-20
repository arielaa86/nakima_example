
var picker = $('#date').datepicker({
    container: '#datePicker',
    format: "dd MM yyyy",
    startView: "days",
    /* minViewMode: "months",*/
    autoclose: true,
    language: 'fr-FR'
    /*endDate: ''*/

});


function displayTimerPickers() {

    var checked = document.getElementById("journee").checked;

    document.getElementById("heureDebut").value = "";
    document.getElementById("heureFin").value = "";

    document.getElementById("heureDebut").disabled = checked;
    document.getElementById("heureFin").disabled = checked;

    document.getElementById("heureDebut").required = !checked;
    document.getElementById("heureFin").required = !checked;


}


function changeStatus(id, idLabel, couleur) {

    var checked = document.getElementById(id).checked;

    var elements = document.getElementsByClassName("labelEvenement");

    var i;
    for (i = 0; i < elements.length; i++) {

        elements[i].style.borderColor = "lightgray";

    }


    if (checked === true) {
        document.getElementById(idLabel).style.borderColor = couleur;
    }


}

function montrerParticipants() {
    var element = document.getElementById("visibilite");

    if (element.value === "personnalisée") {
        document.getElementById("participants").style.display = "block";
        document.getElementById("participantsSelect").required = true;
    } else {
        document.getElementById("participants").style.display = "none";
        document.getElementById("participantsSelect").required = false;
    }
}


function checkElement(id, idLabel, couleur) {

    document.getElementById(id).checked = true

    changeStatus(id, idLabel, couleur);
}


montrerParticipants();
displayTimerPickers();


var id = "radioIcon1";
var label = "labelCheck1";
var couleur = '#005eff';

checkElement(id, label, couleur);


