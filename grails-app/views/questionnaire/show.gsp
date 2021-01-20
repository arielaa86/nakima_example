<%@ page import="mccorletagencement.ProjetAutre; mccorletagencement.ProjetPlacard; mccorletagencement.ProjetDressing; mccorletagencement.ProjetSalleBain; mccorletagencement.ProjetCuisine; mccorletagencement.Devis" %>

<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'questionnaire.label', default: 'Questionnaire')}"/>
    <title><g:message code="default.edit.label" args="[entityName]"/></title>

    <style>
    tr {
        height: 40px;
        font-size: 16px;
    }

    .custom-control {
        font-size: 14px !important;
        margin-bottom: 2em !important;
        line-height: 20px;
    }


    .custom-control-input:disabled ~ .custom-control-label {
        color: #636363;
    }

    .custom-control-label::after {
        background-color: white;
        border: solid 1px #777777;
        color: #717171;
    }

    .custom-checkbox .custom-control-input:checked ~ .custom-control-label::after {

        background-color: white;
        border: solid 1px #777777;
        color: #717171;
    }




    </style>
</head>

<body>

<div class="card card-default m-2 p-6">

    <div class="card-body">
        <g:hasErrors bean="${this.questionnaire}">
            <ul class="errors" role="alert">
                <g:eachError bean="${this.questionnaire}" var="error">
                    <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message
                            error="${error}"/></li>
                </g:eachError>
            </ul>
        </g:hasErrors>


        <div class="row" style="color: rgba(0,0,0,0.7); vertical-align: middle">
            <div class="col-lg-12" style="font-size: 22px;">
                Modifier questionnaire devis décliné
            </div>
        </div>

        <hr>

        <g:set var="devis" value="${this.questionnaire.devis}"></g:set>

        <div class="row ml-4 mr-4 mt-4 mb-0" style="font-size: 14px">
            <div class="card card-default">
                <div class="card-body">
                    <table class="no-border no-strip skills">
                        <tbody class="no-border-x no-border-y">
                        <tr>
                            <td>
                                ${devis.projet.client.intitule + " " + devis.projet.client.nom + " " + devis.projet.client.prenom}
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Téléphone:
                                ${devis.projet.client.telephoneFixe == null ? devis.projet.client.telephone : devis.projet.client.telephoneFixe}
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Devis No.
                                ${devis.projet.idInsitu}
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Concepteur:
                                ${devis.projet.concepteur}
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Projet
                                <g:if test="${devis.getProjet().instanceOf(ProjetCuisine)}">
                                    Cuisine
                                </g:if>
                                <g:if test="${devis.getProjet().instanceOf(ProjetSalleBain)}">
                                    Salle de bain
                                </g:if>
                                <g:if test="${devis.getProjet().instanceOf(ProjetDressing)}">
                                    Dressing
                                </g:if>
                                <g:if test="${devis.getProjet().instanceOf(ProjetPlacard)}">
                                    Placard
                                </g:if>
                                <g:if test="${devis.getProjet().instanceOf(ProjetAutre)}">
                                    ${devis.getProjet().typeProjet}
                                </g:if>

                            </td>
                        </tr>
                        <tr>
                            <td>Montant:
                            ${devis.montant > 0 ? new java.text.DecimalFormat("###,###.00 €").format(devis.montant).replaceAll(",", " ") : "0.00 €"}
                            </td>

                        </tr>
                        </tbody>
                    </table>
                </div>

            </div>

        </div>

        <div class="row font-weight-bold ml-3">

            <p class="mb-5" style="font-size: 16px">
                Afin de nous permettre d’améliorer nos services et de proposer de meilleures offres, pourriez-vous nous préciser la raison de votre refus :
            </p>

        </div>




        <g:render template="formShow"/>

        <div class="row justify-content-end">
            <g:if test="${devis.decline}">

                <button class="btn btn-secondary" type="button" data-toggle="modal" data-target="#reouvrir"><i
                        class="fa fa-folder-open"></i> Réouvrir le dossier</button>

            </g:if>
        </div>

    </div>
</div>


<div class="modal fade" id="reouvrir" tabindex="-1" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button class="close" type="button" data-dismiss="modal" aria-hidden="true"><span
                        class="s7-close"></span></button>
            </div>

            <div class="modal-body">

                <div class="row text-primary justify-content-center"><span
                        class="modal-main-icon s7-attention"></span></div>


                <div class="row m-3">
                    <p>Vous êtes sur le point de réouvrir ce dossier. Veuillez ajouter un commentaire :</p>
                </div>


                <div style="border: solid #dedede 1px">
                    <g:render template="/devis/chatCommentaires" />
                </div>

                <g:form controller="questionnaire" action="reouvrirDevis" method="POST" onsubmit="submit.disabled = true; return true;">



                    <g:hiddenField name="id" value="${this.questionnaire.devis.id}"></g:hiddenField>


                    <div  class="row justify-content-end m-3 mt-6">

                        <button id="submit" class="btn btn-primary" id="submit" type="submit" data-toggle="modal" data-target="#reouvrir">
                            <i class="fa fa-folder-open"></i> Réouvrir
                        </button>

                    </div>

                </g:form>

            </div>
        </div>
    </div>
</div>

<g:hiddenField name="devisId" type="text" value="${this.questionnaire.devis.id}"/>


<asset:javascript src="commentaires/commentaire.js"/>

<script>


    getCommentaires();


    function showAutreMotif(id) {

        var element = document.getElementById(id);


        if (!element.checked) {
            document.getElementById("autreMotiftexte").style.display = "none";
        } else {
            document.getElementById("autreMotiftexte").style.display = "block";
        }


    }


    showAutreMotif("question7");


</script>

</body>
</html>
