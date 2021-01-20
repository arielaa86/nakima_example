<%@ page import="java.text.DecimalFormat; mccorletagencement.ProjetAutre; mccorletagencement.ProjetPlacard; mccorletagencement.ProjetDressing; mccorletagencement.ProjetSalleBain; mccorletagencement.ProjetCuisine" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'factureClient.label', default: 'FactureClient')}"/>
    <title><g:message code="default.list.label" args="['des factures']"/></title>

    <style>

    .nav-tabs-primary + .tab-content {
        background-color: white;
        color: inherit;
        border: solid #eaeaea 1px;
        margin-top: -1px;
    }

    .nav-tabs-primary .nav-link.active {

        border-top-left-radius: 3px;
        border-top-right-radius: 3px;
        background-color: white;
        color: inherit;
        border: solid #eaeaea 1px;
        border-bottom: solid white 1px;
    }

    </style>
</head>

<body>

<div class="card card-default m-2 table-responsive">

    <div class="card card-header" style="min-width: 680px">
        <div class="row" style="color: rgba(0,0,0,0.7); vertical-align: middle">
            <div class="col-lg-12" style="font-size: 22px;">
                <i class="fa fa-file"></i> Suivi des factures
            </div>
        </div>

        <hr>



        <div class="row justify-content-end">
            <nav class="navbar navbar-expand-lg navbar-light bg-light">
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
                    <div class="navbar-nav">
                        <a class="nav-link active" href="#" style="font-size: 14px; color: #c6c6c6"> <i class="fa fa-lock"></i> Avoir utilisé</a>
                    </div>
                </div>
            </nav>
        </div>



    </div>


    <div class="card-body" style="min-width: 830px">
        <div class="col-lg-12">

            <div class="tab-container mb-5">
                <ul class="nav nav-tabs nav-tabs-primary" role="tablist">
                    <li class="nav-item"><a class="nav-link active" href="#p-home" data-toggle="tab" role="tab"
                                            aria-selected="true">Acquittées</a></li>
                    <li class="nav-item"><a class="nav-link" href="#p-profile1" data-toggle="tab" role="tab"
                                            aria-selected="false">Avoirs</a></li>
                </ul>

                <div id="tab-content" class="tab-content">
                    <div class="tab-pane active" id="p-home" role="tabpanel">

                        <table width="100%" cellspacing="0"
                               class="table dataTable table-hover table-bordered table-striped">
                            <thead>
                            <tr>
                                <th class="noExport"></th>
                                <th class="menu noSorting"></th>
                                <th>No. Facture</th>
                                <th style="min-width: 80px">Total payé</th>
                                <th>Client</th>
                                <th>Type de projet</th>
                                <th>Concepteur</th>
                                <th>Livraison prévue</th>
                                <th class="noSorting">Envoi en production</th>

                            </tr>
                            </thead>
                            <tbody>
                            <g:each var="facture" in="${facturesAcquittees}">

                                <tr>
                                    <td></td>
                                    <td>
                                        <div class="dropdown">
                                            <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink2"
                                               data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                <i class="fa fa-list"></i>
                                            </a>

                                            <div id="dropdown-menu2" class="dropdown-menu"
                                                 aria-labelledby="dropdownMenuLink1">

                                                <g:link class="dropdown-item" controller="client" action="show"
                                                        id="${facture.idClient}">
                                                    Accéder à la fiche client
                                                </g:link>


                                                <g:link class="dropdown-item" controller="factureClient"
                                                        action="factureAcquittee" id="${facture.id}">
                                                    Accéder aux détails
                                                </g:link>

                                                <g:link class="dropdown-item" controller="paiement" action="create"
                                                        params="['facture.id': facture.id]">
                                                    Paiements
                                                </g:link>

                                            </div>
                                        </div>
                                    </td>
                                    <td>

                                        ${facture.idInsitu}

                                    </td>
                                    <td>
                                        ${facture.montant > 0 ? new java.text.DecimalFormat("###,###.00 €").format(facture.montant).replaceAll(",", " ") : "0.00 €"}
                                    </td>
                                    <td>
                                        ${facture.client.toUpperCase()}
                                    </td>
                                    <td>
                                        ${facture.getType()}
                                    </td>
                                    <td>${facture.concepteur}</td>
                                    <td>
                                        <g:if test="${!facture.projetComplementaire}">
                                            <g:formatDate date="${facture.delaiRealisation}" format="MMMM yyyy" locale="fr"/>
                                        </g:if>
                                    </td>
                                    <td>

                                        <div class="d-flex justify-content-between">

                                            <g:if test="${facture.pretPourLancerProduction}">
                                                <div class="switch-button switch-button-yesno" id="switch-button${facture.id}">
                                                    <g:render template="selecteur" model="[facture: facture]"/>
                                                </div>
                                            </g:if>

                                            <div style="line-height: 28px" id="envoiProd${facture.id}">
                                                <g:if test="${facture.ordreProduction}">

                                                    le <g:formatDate date="${facture?.ordreProductionDate}" format="dd MMM yyyy" locale="fr"/>

                                                </g:if>
                                            </div>

                                        </div>

                                    </td>

                                </tr>

                            </g:each>
                            </tbody>
                        </table>

                    </div>

                    <div class="tab-pane" id="p-profile1" role="tabpanel">

                        <table width="100%" cellspacing="0"
                               class="table dataTable table-hover table-bordered table-striped">
                            <thead>
                            <tr>
                                <th class="noExport"></th>
                                <th class="menu noSorting"></th>
                                <th>No. Facture</th>
                                <th>Montant</th>
                                <th>Client</th>
                                <th>Valable jusqu'au</th>
                                <th>Concepteur</th>
                            </tr>
                            </thead>
                            <tbody>
                            <g:each var="facture" in="${facturesAvoir}">

                                <tr>
                                    <td></td>
                                    <td>
                                        <div class="dropdown">
                                            <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink3"
                                               data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                <i class="fa fa-list"></i>
                                            </a>

                                            <div id="dropdown-menu3" class="dropdown-menu"
                                                 aria-labelledby="dropdownMenuLink3">

                                                <g:link class="dropdown-item" controller="client" action="show"
                                                        id="${facture.idClient}">
                                                    Accéder à la fiche client
                                                </g:link>


                                                <g:link class="dropdown-item" controller="factureClient" action="show"
                                                        id="${facture.id}">
                                                    Accéder aux détails
                                                </g:link>

                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="d-flex justify-content-between">

                                            ${facture.idInsitu}
                                            <g:if test="${facture.montant < 0 && facture.devisVisible == false}">
                                                <i class="fa fa-lock"  style="font-size: 20px; color: lightgray"></i>
                                            </g:if>

                                        </div>

                                    </td>
                                    <td>
                                        ${new DecimalFormat("###,###.00 €").format(Math.abs(facture.montant)).replaceAll(",", " ")}
                                    </td>


                                    <td>
                                        ${facture.client.toUpperCase()}
                                    </td>
                                    <td>
                                        <g:formatDate locale="fr" format="dd MMMM yyyy"
                                                      date="${facture?.dateValiditeAvoir}"/>
                                    </td>
                                    <td>${facture.concepteur}</td>

                                </tr>

                            </g:each>
                            </tbody>
                        </table>
                    </div>
                </div>

            </div>
        </div>

    </div>

</div>



<g:hiddenField name="factureId" value=""/>

<div class="modal fade show noPrint" id="commentaireTechnicien" tabindex="-1" role="dialog" aria-modal="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button class="close" type="button" data-dismiss="modal" aria-hidden="true"
                        onclick="changerEtat(false)"><span class="s7-close"></span></button>
            </div>

            <div class="modal-body">
                <div class="text-center">
                    <div class="text-primary">
                        <span class="modal-main-icon s7-attention" style="margin-top: -40px!important;"></span>
                    </div>
                    <h4 class="mb-4">Veuillez ajouter ici les informations complémentaires que vous souhaitez communiquer au Chef Technicien</h4>

                    <div class="form-group row mt-4 noPrint">
                        <div class="col-lg-12 mb-3">
                            <g:textArea class="form-control" id="commentaireModal" name="commentairesPourTechnicien"
                                        rows="15" value=""/>
                        </div>
                    </div>


                    <label class="custom-control custom-checkbox custom-control-inline" >
                        <input id="anonyme" class="custom-control-input" type="checkbox">
                        <span class="custom-control-label"> Envoi anonyme à la production</span>
                    </label>


                    <div class="mt-4">
                        <button class="btn btn-sm btn-space btn-success" type="button" data-dismiss="modal"
                                onclick="changerEtat(true)">Confirmer</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>




<asset:javascript src="factureClient/lancerProduction.js" />

</body>
</html>
