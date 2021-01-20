<%@ page import="mccorletagencement.ProjetAutre; mccorletagencement.ProjetPlacard; mccorletagencement.ProjetDressing; mccorletagencement.ProjetSalleBain; mccorletagencement.ProjetCuisine" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'factureClient.label', default: 'FactureClient')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>

    </head>
    <body>


    <div class="card card-default m-2">


        <div class="card-header">

            <div class="row justify-content-end">
                <g:link class="btn btn-space btn-secondary" action="show" controller="client" id="${params.idClient}">
                    <i class="fa fa-chevron-left"></i>
                    Retour fiche client
                </g:link>
            </div>



            <div class="card card-header">
                <div class="row" style="color: rgba(0,0,0,0.7); vertical-align: middle">
                    <div class="col-lg-12" style="font-size: 22px;">
                       Liste des bons de commande
                    </div>
                </div>

                <hr>
            </div>




            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>

        </div>
        <div class="card-body">
            <table width="100%" class="table dataTable table-hover table-bordered table-striped">
                <thead>
                <tr>
                    <th class="noExport"></th>
                    <th class="menu noSorting"></th>
                    <th>No. Bon de commande</th>
                    <th>Date</th>
                    <th>Type de projet</th>
                    <th>Concepteur</th>
                </tr>
                </thead>
                <tbody>
                <g:each var="facture" in="${factures.sort{it.date}}">

                    <tr>
                        <td></td>
                        <td>
                            <div class="dropdown">
                                <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    <i class="fa fa-list"></i>
                                </a>

                                <div id="dropdown-menu" class="dropdown-menu" aria-labelledby="dropdownMenuLink">
                                    <g:if test="${!facture.isClosed()}">
                                        <g:link class="dropdown-item" controller="factureClient" action="show" id="${facture.id}">
                                            Accéder aux détails
                                        </g:link>
                                    </g:if>
                                    <g:else>
                                        <g:link class="dropdown-item" controller="factureClient" action="factureAcquittee" id="${facture.id}">
                                            Accéder aux détails
                                        </g:link>

                                    </g:else>

                                    <g:if test="${!facture.isClosed()}">
                                        <g:link class="dropdown-item" controller="paiement" action="create" params="['facture.id':facture.id]">
                                            Paiements
                                        </g:link>
                                    </g:if>

                                </div>
                            </div>
                        </td>
                        <td class="d-flex flex-row justify-content-between">

                         <g:if test="${!facture.isClosed()}">
                                ${facture?.devis.projet.idInsitu}
                             <i class="fa fa-credit-card" style="font-size: 20px; color: lightgray"></i>
                        </g:if>
                        <g:else>

                                ${facture?.devis.projet.idInsitu}

                        </g:else>
                        </td>
                        <td>
                            <g:formatDate date="${facture?.date}" format="dd MMMM yyyy" locale="fr"  /></td>
                        <td>

                            <g:if test="${facture?.devis.projet.instanceOf( ProjetCuisine )}">
                                Cuisine
                            </g:if>
                            <g:if test="${facture?.devis.projet.instanceOf( ProjetSalleBain )}">
                                Salle de bain
                            </g:if>
                            <g:if test="${facture?.devis.projet.instanceOf( ProjetDressing )}">
                                Dressing
                            </g:if>
                            <g:if test="${facture?.devis.projet.instanceOf(  ProjetPlacard )}">
                                Placard
                            </g:if>
                            <g:if test="${facture?.devis.projet.instanceOf(  ProjetAutre )}">
                                ${facture?.devis.projet.typeProjet}
                            </g:if>


                        </td>
                        <td> ${facture?.devis.projet.concepteur}</td>

                    </tr>

                </g:each>
                </tbody>
            </table>
        </div>
    </div>



    </body>
</html>