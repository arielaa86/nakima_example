<%@ page import="java.text.DecimalFormat; mccorletagencement.Role; mccorletagencement.ProjetAutre; mccorletagencement.ProjetPlacard; mccorletagencement.ProjetDressing; mccorletagencement.ProjetSalleBain; mccorletagencement.ProjetCuisine" %>
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
        <th>Livraison effectuée</th>
        <th class="noExport noSorting" style="text-align: center; max-width: 50px">Chantier</th>
        <th class="noExport noSorting" style="text-align: center; max-width: 30px">Pose</th>
    </tr>
    </thead>
    <tbody>
    <g:each in="${ordres}" var="ordre">

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
            <td style="text-align: center" id="sav${ordre.id}">
                <i class="fa fa-circle" style="font-size: 16px; color:${ordre.incomplete ? '#fa6163' : '#509834'}"
                   onclick="${!user.authorities.contains(Role.findByAuthority("ROLE_COMMERCIAL")) && ordre.incomplete ? 'livraisonComplete(' + ordre.id + ');' : ''}"></i>
            </td>
            <td style="text-align: center">
                <g:if test="${ordre.photoPose != null}">
                    <i class="fa fa-file-powerpoint-o" data-toggle="modal" data-target="#viewFormulaire${ordre.id}"></i>

                    <div class="modal fade" id="viewFormulaire${ordre.id}" tabindex="-1" role="dialog">
                        <div class="modal-dialog full-width">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button class="close" type="button"
                                            data-dismiss="modal"
                                            aria-hidden="true"><span
                                            class="s7-close"></span></button>
                                </div>

                                <div class="modal-body justify-content-center">
                                    <div class="row justify-content-center">
                                        <div class="col-lg-12" style="text-align: center">

                                            <object id="docPdf" width="850px" height="980px" style="text-align: center"
                                                    data="<g:createLink controller="ordreProduction"
                                                                        action="showFormulaire"
                                                                        params="[id: ordre.id]"/>"
                                                    trusted="yes" application="yes">
                                            </object>

                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                </g:if>

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