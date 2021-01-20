<%@ page import="mccorletagencement.ProjetAutre; mccorletagencement.ProjetPlacard; mccorletagencement.ProjetDressing; mccorletagencement.ProjetSalleBain; mccorletagencement.ProjetCuisine" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'factureClient.label', default: 'FactureClient')}"/>
    <title><g:message code="default.list.label" args="['des BDC']"/></title>

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


    a.disabled {
        pointer-events: none;
        cursor: default;
        color: #b2d6c5!important;

    }

    </style>
</head>

<body>

<div class="card card-default m-2 table-responsive">

    <div class="card card-header" style="min-width: 680px">
        <div class="row" style="color: rgba(0,0,0,0.7); vertical-align: middle">
            <div class="col-lg-12" style="font-size: 22px;">
                <i class="fa fa-file-text-o"></i> Suivi des bons de commande
            </div>
        </div>

        <hr>
    </div>


    <div class="card-body" style="min-width: 680px">

        <div class="col-lg-12">
            <div class="tab-container mb-5">
                <ul class="nav nav-tabs nav-tabs-primary" role="tablist">
                    <li class="nav-item"><a class="nav-link active" href="#p-home" data-toggle="tab" role="tab"
                                            aria-selected="true">Impayés</a></li>
                    <li class="nav-item"><a class="nav-link" href="#facturesEnCours" data-toggle="tab" role="tab"
                                            aria-selected="false">En cours</a></li>
                </ul>

                <div id="tab-content" class="tab-content">
                    <div class="tab-pane active" id="p-home" role="tabpanel">

                        <table width="100%" cellspacing="0"
                               class="table dataTable table-hover table-bordered table-striped">
                            <thead>
                            <tr>
                                <th class="noExport"></th>
                                <th class="menu noSorting"></th>
                                <th>No. Bon de commande</th>
                                <th>Montant à payer</th>
                                <th>Client</th>
                                <th>Type de projet</th>
                                <th>Concepteur</th>
                                <th>Livraison prévue </th>
                            </tr>
                            </thead>
                            <tbody>
                            <g:each var="facture" in="${facturesImpayees}">

                                <tr>
                                    <td></td>
                                    <td>
                                        <div class="dropdown">
                                            <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink"
                                               data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                <i class="fa fa-list"></i>
                                            </a>

                                            <div id="dropdown-menu" class="dropdown-menu"
                                                 aria-labelledby="dropdownMenuLink">

                                                <g:link class="dropdown-item" controller="client" action="show"
                                                        id="${facture.idClient}">
                                                    Accéder à la fiche client
                                                </g:link>
                                                <g:link class="dropdown-item" controller="factureClient" action="show"
                                                        id="${facture.id}">
                                                    Accéder aux détails
                                                </g:link>

                                                <g:if test="${!facture.isClosed() && facture.signatureClient}">
                                                    <g:link class="dropdown-item" controller="paiement" action="create"
                                                            params="['facture.id': facture.id]">
                                                        Paiements
                                                    </g:link>
                                                </g:if>

                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        ${facture.getIdInsitu()}
                                    </td>
                                    <td>
                                        ${facture.getTotalPayer() > 0 ? new java.text.DecimalFormat("###,###.00 €").format(facture.getTotalPayer()).replaceAll(",", " ") : "0.00 €"}
                                    </td>
                                    <td>
                                        ${facture.getClient().toUpperCase()}
                                    </td>
                                    <td>
                                        ${facture.getType()}
                                    </td>
                                    <td>
                                        ${facture.getConcepteur()}
                                    </td>
                                    <td>
                                        <g:if test="${!facture.isProjetComplementaire()}">
                                            <g:formatDate date="${facture.delaiRealisation}" format="MMMM yyyy" locale="fr"/>
                                        </g:if>
                                    </td>

                                </tr>

                            </g:each>
                            </tbody>
                        </table>

                    </div>

                    <div class="tab-pane" id="facturesEnCours" role="tabpanel">

                      <g:render template="tableauBdcEnCours" model="${factures}" />

                    </div>

                </div>
            </div>
        </div>

    </div>
</div>



<asset:javascript src="factureClient/lancerProduction.js" />


</body>
</html>