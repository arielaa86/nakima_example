<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'factureFournisseur.label', default: 'Factures Fournisseur')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>

    <style>
    .addFournisseurButton {
        top: -30px;
        left: 164px;
        position: relative;
    }
    </style>
</head>

<body>

<div class="card card-default col-lg-12 m-2" id="cardFactures">

    <div class="card-body">


        <div class="row m-2 justify-content-center">
            <button class="btn btn-primary" data-toggle="modal" data-target="#md-fullWidth">
                Ajouter une facture <i class="fa fa-plus-circle"></i>
            </button>
        </div>

        <div class="row m-2">
            <div class="row" style="color: rgba(0,0,0,0.6); vertical-align: middle;">
                <div class="col-lg-12" style="font-size: 22px;">
                    <i class="fa fa-archive"></i> Suivi des factures
                </div>
            </div>

        </div>
        <hr>

        <div id="tableauFactures">

            <g:render template="/factureFournisseur/tableauFactures" model="[factures: factures]"/>

        </div>

    </div>
</div>

<div class="modal fade" id="md-fullWidth" tabindex="-1" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header mb-0 pb-0">
                <button class="close" type="button" data-dismiss="modal" aria-hidden="true"><span
                        class="s7-close"></span></button>
            </div>

            <div class="modal-body mt-0 pt-0">

                <div class="row" style="color: rgba(0,0,0,0.6); vertical-align: middle;">
                    <div class="col-lg-12" style="font-size: 22px;">
                        <i class="fa fa-file"></i> Ajouter une facture
                    </div>
                </div>

                <hr>

                <g:form resource="${this.factureFournisseur}" method="POST" enctype="multipart/form-data" onsubmit="submit.disabled = true; return true;">

                    <div class="row justify-content-center m-3" id="errorsFacture">

                    </div>


                    <div class="row">

                        <g:render template="/categorie/formFacture" model="[listeFournisseurs: listeFournisseurs]"/>

                    </div>

                    <div class="row justify-content-end">
                        <button id="submit" class="btn btn-lg btn-success" type="submit" id="submit"
                                onclick="showAlertWait('Enregistrement en cours. Veuillez patienter', 2000)">
                            <i class="fa fa-save"></i>
                            Enregistrer
                        </button>
                    </div>

                </g:form>

            </div>
        </div>
    </div>

</div>

<asset:javascript src="fournisseur/actions.js"/>
<asset:javascript src="factureFournisseur/actions.js"/>

</body>
</html>