



class Activite {

    constructor(description) {
        this.description = description;
    }

}


function enregistrerActivite() {

    var baseURL = window.location.origin;

    let description = document.getElementById("description").value;

    let activite = new Activite(description);


    $.ajax({
        type: 'post',
        url: baseURL+'/activite/enregistrer',
        data: {
            'description': activite.description
        },
        beforeSend: function() {

        },
        success: function (data) {
            $("#description").val("");
            showAlertTime('Enregistré', 1000);
            $("#todo-tasks").load(window.location.href + " #todo-tasks");
        },
        error: function () {
            showAlertDanger('Veuillez ajouter une description');
        }
    });

}


function barreActivite(id) {

    var baseURL = window.location.origin;

        $.ajax({
            type: 'post',
            url: baseURL + '/activite/barre',
            data: {
                'id': id
            },
            success: function (data) {

            },
            error: function () {
                showAlertDanger('Erreur');
            }
        });

}


function effacerActivite(id, message) {

    var baseURL = window.location.origin;

    var effacer = confirm(message);

    if (effacer === true) {
        $.ajax({
            type: 'post',
            url: baseURL + '/activite/effacer',
            data: {
                'id': id
            },
            success: function (data) {

                $("#todo-tasks").load(window.location.href + " #todo-tasks");
                showAlertTime('Supprimé', 1000);
            },
            error: function () {
                showAlertDanger('Erreur');
            }
        });
    }
}


$("#enregistrer").click(function () {
    enregistrerActivite();
});





