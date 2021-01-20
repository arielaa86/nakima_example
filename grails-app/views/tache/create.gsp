<%@ page import="mccorletagencement.Etiquette" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'tache.label', default: 'Tache')}"/>
    <title>Créer tâche</title>

    <asset:stylesheet src="lib/datepicker/css/bootstrap-datepicker.standalone.css"/>

    <style>

    .datepicker table tr td.old, .datepicker table tr td.new {
        color: #dcdcdc;
    }


    .custom-radio-icon {

        margin: 0 !important;
        width: 25px !important;
        height: 25px !important;

    }

    .custom-radio-icon .custom-control-label {

        width: 25px !important;
        height: 25px !important;
        border: 13px solid #d5d8de;
    }

    .etiquette {

        margin-top: 5px;

    }

    textarea{
        background-color: white!important;
    }


    </style>

</head>

<body>

<div class="card card-default m-2">

    <div class="card card-header">
        <div class="row" style="color: rgba(0,0,0,0.7); vertical-align: middle">
            <div class="col-lg-12" style="font-size: 22px;">
                Créer tâche
            </div>
        </div>

        <hr>
    </div>

    <div class="card-body">

        <g:if test="${flash.error}">

            <div class="row justify-content-center m-3">
                <div class="alert alert-theme alert-danger alert-dismissible col-lg-6" role="alert">
                    <button class="close" type="button" data-dismiss="alert" aria-label="Close"><span class="s7-close"
                                                                                                      aria-hidden="true"></span>
                    </button>

                    <div class="row ml-3 mt-3">
                        <div class="icon">
                            <span class="s7-attention"></span>
                        </div>
                        <strong style="font-size:14px">Erreur !</strong>
                    </div>

                    <div class="message">

                        <ul class="errors" role="alert">
                            <li>

                                <g:message error="${flash.error}"/>

                            </li>
                        </ul>

                    </div>
                </div>
            </div>

        </g:if>


        <g:hasErrors bean="${this.tache}">
            <div class="row justify-content-center m-3">
                <div class="alert alert-theme alert-danger alert-dismissible col-lg-6" role="alert">
                    <button class="close" type="button" data-dismiss="alert" aria-label="Close"><span class="s7-close"
                                                                                                      aria-hidden="true"></span>
                    </button>

                    <div class="row ml-3 mt-3">
                        <div class="icon">
                            <span class="s7-attention"></span>
                        </div>
                        <strong style="font-size:14px">Erreur !</strong>
                    </div>

                    <div class="message">

                        <ul class="errors" role="alert">
                            <g:eachError bean="${this.tache}" var="error">
                                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>>

                                    <g:message error="${error}"/>

                                </li>
                            </g:eachError>
                        </ul>

                    </div>
                </div>
            </div>
        </g:hasErrors>


        <g:form resource="${this.tache}" method="POST" autocomplete="off" onsubmit="submit.disabled = true; return true;">

            <g:render template="form"></g:render>

            <div class="row justify-content-end m-4">


                    <button id="submit" class="btn btn-lg btn-success" type="submit" id="submit">
                        <i class="fa fa-save"></i>
                        Enregistrer
                    </button>

            </div>
        </g:form>

    </div>
</div>



<asset:javascript src="lib/jquery/jquery.min.js"/>
<asset:javascript src="lib/datepicker/js/bootstrap-datepicker.js"/>
<asset:javascript src="lib/datepicker/locales/bootstrap-datepicker.fr.min.js"/>


<script>

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
    var couleur = '${Etiquette.get(1).getCouleur()}';

    checkElement(id, label, couleur);




</script>

</body>
</html>

