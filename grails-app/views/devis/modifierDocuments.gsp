<%@ page import="mccorletagencement.Projet" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'devis.label', default: 'Devis')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
    <asset:stylesheet src="css/gallery.css"/>

    <style>

    .alert {
        font-size: 12px;
        color: #575757;
    }
    </style>

</head>

<body>

<div class="card card-default m-2">

    <div class="card-header">

        <div class="row justify-content-center m-3">
            <div class="alert alert-theme alert-warning alert-dismissible col-lg-6" role="alert">

            </button>

                <div class="row ml-3 mt-3">
                    <div class="icon">
                        <span class="s7-attention"></span>
                    </div>
                    <strong style="font-size:14px">Attention !</strong>
                </div>

                <div class="message">

                    <ul class="errors" role="alert">

                        <li>
                            <g:if test="${projet.devisClient.montant > 0}">
                                Vous venez de créer un Bon de commande complémentaire.
                            </g:if>
                            <g:else>
                                Vous venez de créer un Avoir.
                            </g:else>


                            Pensez à vérifier et actualiser les documents associés au projet.

                        </li>

                    </ul>

                </div>
            </div>
        </div>


        <div class="row" style="font-size: 22px;">
            <div class="col-lg-12">
                Liste des documents
            </div>
        </div>

    </div>

    <div class="card-body">
        <g:render template="/projet/gallery" model="[projet: projet]"/>


        <div class="row m-4 justify-content-end">
            <g:link class="btn btn-space" style="background-color: #1a9fdd; color: white" controller="devis"
                    action="envoyer" id="${Projet.get(idProjet).devisClient.id}"
                    onclick="showAlertWait('Votre demande va être envoyée pour validation', 6000 )"><i
                    class="fa fa-send"></i> Poursuivre l'envoi</g:link>
        </div>
    </div>
</div>


<script>

    function submitForm(id) {

        var answer = confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');

        if (answer == true) {
            document.getElementById(id).click();
        }

    }

</script>