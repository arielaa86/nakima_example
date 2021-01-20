<%@ page import="mccorletagencement.FactureClient; mccorletagencement.Paiement" %>

<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'paiement.label', default: 'Paiement')}"/>
    <title><g:message code="default.create.label" args="[entityName]"/></title>

    <style>

    .print {
        visibility: hidden;
        height: 0px !important;
    }

    .paiementMultiple {
        background-color: #f5f5f5;
    }


    #btnCard {
        font-family: "Open Sans", sans-serif;
    }


    .printer {
        margin-left: 10px !important;
    }

    .rotateRight {
        margin-left: 10px !important;
    }

    .rotateLeft {
        margin-left: 10px !important;
    }

    .zoomin {
        margin-left: 10px !important;
    }

    .up {
        margin-left: 10px !important;
    }

    .down {
        margin-left: 10px !important;
    }


    @media print {

        body {
            height: 0px !important;
        }

        .fade {
            background-color: white !important;
        }

        .noPrint input, textarea {
            display: none !important;
            height: 0px !important;
        }

        .navbar, .noPrint, .btn {
            display: none !important;
            height: 0px !important;
        }

        #firma {
            width: 300px;
        }

        .print {
            height: auto !important;
            visibility: visible;
        }


        #textFirma {
            width: 400px;
        }


    }


    </style>

</head>

<body>

<g:set var="factureAux" value="${FactureClient.get(params.'facture.id')}"/>

<div class="card card-default m-2">

    <div class="card card-header noPrint">
        <div class="row" style="color: rgba(0,0,0,0.7); vertical-align: middle">
            <div class="col-lg-12" style="font-size: 22px;">

                <g:if test="${!facture.isClosed()}">
                    Ajouter nouveau paiement - BDC No. ${factureAux.devis.projet.idInsitu} - ${factureAux.devis.projet.client}
                </g:if>
                <g:else>
                    Historique des paiements - BDC No. ${factureAux.devis.projet.idInsitu} - ${factureAux.devis.projet.client}
                </g:else>
            </div>
        </div>

        <hr>
    </div>


    <div class="card-body">



        <g:hasErrors bean="${this.paiement}">
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
                            <g:eachError bean="${this.paiement}" var="error">
                                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>>

                                    <g:message error="${error}"/>

                                </li>
                            </g:eachError>
                        </ul>

                    </div>
                </div>
            </div>

        </g:hasErrors>


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
                                ${flash.error}
                            </li>

                        </ul>

                    </div>
                </div>
            </div>

        </g:if>

        <g:form class="noPrint" controller="paiement" action="save" resource="${this.paiement}" method="POST"
                enctype="multipart/form-data" onsubmit="submit.disabled = true; return true;">

            <g:render template="form"></g:render>


            <div class="row justify-content-end m-3 mt-4 mb-5" id="savePaiement">
                <g:if test="${facture.restantDu() > 0}">
                    <button id="submit" class="btn btn-space btn-success" style="width: 160px" type="submit"
                            onclick="showRequired()"><i
                            class="fa fa-save"></i> Enregistrer</button>
                </g:if>
            </div>

        </g:form>




        <div id="paiements">
            <g:render template="tableauPaiement"
                      model="[facture: FactureClient.findById(facture.id)]"></g:render>
        </div>


        <div class="modal fade" id="chequeCaution" data-backdrop="static" data-keyboard="false" tabindex="-1"
             aria-labelledby="staticBackdropLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="staticBackdropLabel">Chèque caution</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>

                    <div class="modal-body">

                        <input type="hidden" id="paiementId" value="">

                        <div class="form-group">
                            <label>Montant:</label>
                            <label id="montantPaiement"></label>
                        </div>

                        <div class="form-group text-left">
                            <label>Date d'échéance</label>
                            <input id="datePaiement" class="form-control" type="date"
                                   name=""
                                   value=""
                                   required="">
                        </div>

                        <div class="row justify-content-center">

                            <button id="annuler" type="button" class="m-2 btn btn-outline-secondary"><i class="fa fa-times"></i> Annuler la caution</button>

                            <button id="encaisser" type="button" class="m-2 btn btn-outline-secondary"><i class="fa fa-download"></i> Encaisser le chèque</button>

                            <button id="sauvegarder" type="button" class="m-2 btn btn-outline-secondary"><i class="fa fa-save"></i> Sauvegarder</button>

                        </div>

                    </div>

                </div>
            </div>
        </div>





    </div>

</div>


<asset:javascript src="js/app-devisCalcul.js"/>
<asset:javascript src="paiements/actions.js"/>
<script>


    addRequired();

    formatChamp("montant");



</script>

</body>
</html>
