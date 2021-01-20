<%@ page import="mccorletagencement.ProjetSalleBain" %>


<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'projetComplementaire.label', default: 'projetComplementaire')}"/>
    <title><g:message code="default.show.label" args="['BDC complémentaire']"/></title>



    <style>

    .item {
        font-weight: bold;
        height: 60px;
    }

    #divPlan {
        box-shadow: 0 0px 0 rgba(0, 0, 0, 0.0);
    }

    #divAddPlan {
        box-shadow: 0 0px 0 rgba(0, 0, 0, 0.0);
        margin-top: -20px;
    }

    th {
        font-weight: bold !important;
    }

    h4 {
        font-weight: bold !important;
    }


    .print{

        visibility: hidden;
        height: 0px;
    }


    @media print {

        body{
            height: 0px!important;
        }

        .noPrint{
            display: none;
        }

        .navbar, .noPrint, .btn{
            display: none!important;
            height: 0px!important;
        }


        .card-table{
            width: 300px!important;
            font-size: 16px!important;
            margin-bottom: 0px!important;
            margin-top: 0px!important;
            padding-bottom: 0px!important;
            padding-top: 0px!important;
        }

        .card-body .pb-4{
            padding-bottom: 0px!important;

        }

        .card-body .pt-4{
            padding-top: 0px!important;
        }


        .print{
            visibility: visible;
            height: 100px;
        }

        a {
            text-decoration: none!important;
        }




    }



    </style>

</head>

<body>

<div class="card card-default col-lg-12 m-2">

    <div class="card-body">

        <h4>Détails du projet complémentaire

            <g:if test="${this.projetComplementaire?.idInsitu}">
                <a href="#">
                    No. ${this.projetComplementaire?.idInsitu}
                </a>
            </g:if>

        </h4>
        <hr>





        <div class="row m-2 ">
            <div class="card card-default card-table col-lg-4">
                <div class="card-body pt-4 pb-4">
                    <table class="no-border no-strip skills">
                        <tbody class="no-border-x no-border-y">

                        <tr>
                            <td class="item">Projet principal: <br>
                                <a href="#">
                                    <a href="#">${this.projetComplementaire.projetPrincipal.idInsitu}</a>
                                </a>
                            </td>

                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>


            <div class="card card-default card-table col-lg-4">
                <div class="card-body pt-4 pb-4">
                    <table class="no-border no-strip skills">
                        <tbody class="no-border-x no-border-y">
                        <tr>
                            <td class="item">Description: <br>
                                <a href="#">
                                    <a href="#">${this.projetComplementaire?.description}</a>
                                </a>
                            </td>

                        </tr>

                        </tbody>
                    </table>
                </div>
            </div>


            <div class="card card-default card-table col-lg-4">
                <div class="card-body pt-4 pb-4">
                    <table class="no-border no-strip skills">
                        <tbody class="no-border-x no-border-y">
                        <tr>
                            <td class="item">Date creation: <br>
                                <a href="#">
                                    <a href="#">
                                        <g:formatDate format="dd-MMMM-yyyy" locale="fr" date="${this.projetComplementaire?.date}" />
                                    </a>
                                </a>
                            </td>

                        </tr>

                        </tbody>
                    </table>
                </div>
            </div>



        </div>



        <div class="row justify-content-end print mb-0">
            <p class="mt-3 mb-0 mr-6" style="font-size: 18px; line-height: 20px">Pour Martinique Cuisine:</p>
        </div>

        <div class="row justify-content-end print mt-0">
            <p class="mr-6" style="font-size: 18px">${this.projetComplementaire.concepteur.prenom + " "+this.projetComplementaire.concepteur.nom.toUpperCase()}</p>
        </div>
        <div class="row justify-content-end print">
            <g:if test="${this.projetComplementaire.concepteur.signature}">
                <img width="200px" src="<g:createLink controller="utilisateur" action="showSignature" params="['id': this.projetComplementaire.concepteur.id]" />" />
            </g:if>
        </div>




        <div class="row m-5 justify-content-end">


        <g:link class="btn btn-space btn-outline-secondary" controller="projet" action="show"
                id="${this.projetComplementaire?.projetPrincipal.id}">
            <i class="fa fa-chevron-left"></i>
            Voir projet principal
        </g:link>


        <g:if test="${this.projetComplementaire.idInsitu}">
                <g:if test="${this.projetComplementaire?.devisClient}">

                    <g:link class="btn btn-outline-secondary btn-space btn-big" controller="devis" action="show"
                            params="[id: this.projetComplementaire.devisClient.id]">
                        <i class="fa fa-file-o"></i>
                        <g:message code="default.button.voirPropositionPrix.label" default="Voir proposition de prix"/>
                    </g:link>

                </g:if>
                <g:else>

                    <g:link class="btn btn-outline-secondary btn-space btn-big" controller="devis" action="createComplement"
                            params="[projet: this.projetComplementaire.getId()]">
                        <i class="fa fa-file-o"></i>
                        <g:message code="default.button.propositionPrix.label" default="Proposer un prix"/>
                    </g:link>

                </g:else>

            </g:if>

        <g:link class="btn btn-space btn-outline-secondary btn-space btn-big" action="edit" resource="${this.projetComplementaire}">
            <i class="fa fa-edit"></i>
            <g:message code="default.button.edit.label" default="Modifier"/>
        </g:link>

        </div>


        <script>

            function submitForm(id) {

                var answer = confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');

                if (answer == true) {
                    document.getElementById(id).click();
                }

            }

        </script>

</body>
</html>
