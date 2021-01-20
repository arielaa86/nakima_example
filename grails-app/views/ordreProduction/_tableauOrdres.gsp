<%@ page import="mccorletagencement.Role; java.text.DecimalFormat; mccorletagencement.ProjetAutre; mccorletagencement.ProjetPlacard; mccorletagencement.ProjetDressing; mccorletagencement.ProjetSalleBain; mccorletagencement.ProjetCuisine" %>
<table width="100%" cellspacing="0"
       class="table dataTable table-hover table-bordered table-striped">
    <thead>
    <tr>
        <th class="noExport"></th>
        <th class="menu noSorting"></th>
        <th>No. Ordre de production</th>
        <th>Client</th>
        <th>Téléphone</th>
        <th>Type de projet</th>
        <g:if test="${!user.authorities.contains(Role.findByAuthority("ROLE_TECHNICIEN"))}">
            <th>Restant dû</th>
        </g:if>
        <th>Concepteur</th>
        <th>Semaine</th>
        <th>Livraison prévue</th>
    </tr>
    </thead>
    <tbody>
    <g:each var="ordre" in="${ordres}">

        <tr>
            <td></td>
            <td>
                <div class="dropdown">
                    <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink1"
                       data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <i class="fa fa-list"></i>
                    </a>

                    <div id="dropdown-menu1" class="dropdown-menu"
                         aria-labelledby="dropdownMenuLink1">

                        <g:link class="dropdown-item" controller="ordreProduction" action="show"
                                id="${ordre.id}">
                            Accéder aux détails
                        </g:link>

                    </div>
                </div>
            </td>
            <td>${ordre?.factureClient.devis.projet.idInsitu}</td>
            <td>${ordre?.factureClient.devis.projet.client}</td>
            <td>
                ${ordre?.factureClient.devis.projet.client.telephone != null ? ordre?.factureClient.devis.projet.client.telephone : ordre?.factureClient.devis.projet.client.telephoneFixe }
            </td>
            <td>
                ${ordre?.factureClient.devis.projet.getType()}
            </td>
            <g:if test="${!user.authorities.contains(Role.findByAuthority("ROLE_TECHNICIEN"))}">
                <td class="text-primary">
                    ${ordre?.factureClient.restantDuODP() > 0 ? new DecimalFormat("###,###.00 €").format(ordre?.factureClient.restantDuODP()).replaceAll(",", " ") : '0.00 €'}
                </td>
            </g:if>
            <td>
                ${ordre?.factureClient.devis.projet.concepteur}
            </td>
            <td>
                ${ordre?.factureClient.devis.projet.semaine}
            </td>
            <td>
                <g:formatDate date="${ordre?.factureClient.devis.projet.delaiRealisation}" format="MMMM yyyy" locale="fr"/>
            </td>
        </tr>

    </g:each>
    </tbody>
</table>