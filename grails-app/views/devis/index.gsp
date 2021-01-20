<%@ page import="mccorletagencement.Client; mccorletagencement.ProjetAutre; mccorletagencement.ProjetPlacard; mccorletagencement.ProjetDressing; mccorletagencement.ProjetSalleBain; mccorletagencement.ProjetCuisine" %>

<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'devis.label', default: 'Devis')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>

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

        <g:set var="client" value="${Client.get(params.idClient)}"></g:set>


        <div class="row" style="font-size: 22px;">
            <div class="col-lg-12">
                Liste des devis de ${client.intitule + " " + client.nom + " " + client.prenom}
            </div>
        </div>

    </div>

    <div class="card-body">
        <table width="100%" class="table dataTable table-hover table-bordered table-striped">
            <thead>
            <tr>
                <th class="noExport"></th>
                <th class="menu noSorting"></th>
                <th>No. Devis</th>
                <th>Date</th>
                <th>Type de projet</th>
                <th>Concepteur</th>
            </tr>
            </thead>
            <tbody>
            <g:each var="devis" in="${devisList.sort { it.date }}">

                <tr>
                    <td></td>
                    <td>

                    <div class="dropdown">
                        <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <i class="fa fa-list"></i>
                        </a>

                        <div id="dropdown-menu" class="dropdown-menu" aria-labelledby="dropdownMenuLink">

                <g:if test="${devis.facture == null}">
                    <g:link class="dropdown-item" controller="devis" action="show" id="${devis.id}">
                        Accéder aux détails
                    </g:link>
                </g:if>
                <g:else>

                    <g:link class="dropdown-item" controller="factureClient" action="show" id="${devis.facture.id}">
                        Ajouter signature client
                    </g:link>

                </g:else>


                </div>
             </div>


             </td>
                <td>
                    ${devis.projet.idInsitu}
                </td>
                <td><g:formatDate date="${devis?.date}" format="dd MMMM yyyy" locale="fr"/></td>
                <td>
                    ${devis.projet.getType()}
                </td>
                <td>${devis.projet.concepteur}</td>

                </tr>

            </g:each>
            </tbody>
        </table>
    </div>
</div>

</body>
</html>