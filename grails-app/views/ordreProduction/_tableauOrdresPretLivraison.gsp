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
        <th>Livraison confirmée</th>
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
                ${ordre?.factureClient.devis.projet.client.telephone != null ? ordre?.factureClient.devis.projet.client.telephone : ordre?.factureClient.devis.projet.client.telephoneFixe}
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
                <g:if test="${ordre.livraison != null}">
                    <g:formatDate date="${ordre.livraison}" format="dd MMMM yyyy" locale="fr"/>
                </g:if>
                <g:else>
                    Non renseignée
                </g:else>
            </td>
        </tr>



        <g:if test="${ordre.factureClient.getAllComplements()!= null && !user.authorities.contains(Role.findByAuthority("ROLE_TECHNICIEN"))}">

            <g:each in="${ordre.factureClient.getAllComplements()}" var="projet" status="i">
                <tr>
                    <td></td>
                    <td>
                        <div class="dropdown">
                            <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLinkComplement"
                               data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <i class="fa fa-list"></i>
                            </a>

                            <div id="dropdown-menuComplement" class="dropdown-menu"
                                 aria-labelledby="dropdownMenuLinkComplement">

                                <g:link class="dropdown-item" controller="factureClient" action="show"
                                        id="${projet.getDevisClient().getFacture().id}">
                                    Accéder aux détails
                                </g:link>

                            </div>
                        </div></td>
                    <td>${projet.idInsitu}</td>
                    <td></td>
                    <td></td>
                    <td>${projet.getType()}</td>
                    <td class="text-primary">
                        ${projet.getDevisClient().getFacture().restantDuODP() > 0 ? new DecimalFormat("###,###.00 €").format(projet.getDevisClient().getFacture().restantDuODP()).replaceAll(",", " ") : '0.00 €'}
                    </td>
                    <td></td>
                    <td></td>
                    <td class="noExport noSorting" style="text-align: center; max-width: 50px"></td>
                    <td class="noExport noSorting" style="text-align: center; max-width: 30px"></td>
                </tr>

            </g:each>
        </g:if>


    </g:each>
    </tbody>
</table>