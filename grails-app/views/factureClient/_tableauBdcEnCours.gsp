<%@ page import="mccorletagencement.ProjetComplementaire; mccorletagencement.ProjetAutre; mccorletagencement.ProjetPlacard; mccorletagencement.ProjetDressing; mccorletagencement.ProjetSalleBain; mccorletagencement.ProjetCuisine" %>
<table width="100%" cellspacing="0"
       class="table dataTable table-hover table-bordered table-striped">
    <thead>
    <tr>
        <th class="noExport"></th>
        <th class="menu noSorting"></th>
        <th>No. Bon de commande</th>
        <th>Total</th>
        <th>Restant dû</th>
        <th>Client</th>
        <th>Type de projet</th>
        <th>Concepteur</th>
        <th>Livraison prévue</th>
        <th class="noSorting">Envoi en production</th>
    </tr>
    </thead>
    <tbody>
    <g:each var="facture" in="${factures}">

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

                ${facture.idInsitu}

            </td>
            <td>
                ${facture.montant > 0 ? new java.text.DecimalFormat("###,###.00 €").format(facture.montant).replaceAll(",", " ") : "0.00 €"}
            </td>
            <td>

                ${facture.restantDuAvecGesteCommercial > 0 ? new java.text.DecimalFormat("###,###.00 €").format(facture.restantDuAvecGesteCommercial).replaceAll(",", " ") : "0.00 €"}

            <td>
                ${facture.client.toUpperCase()}
            </td>

            <td>

                ${facture.getType()}

            </td>
            <td>
                ${facture.concepteur}
            </td>
            <td>
                <g:if test="${!facture.isProjetComplementaire()}">
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

                            le <g:formatDate date="${facture.ordreProductionDate}" format="dd MMM yyyy" locale="fr"/>

                        </g:if>
                    </div>

                </div>

            </td>

        </tr>

    </g:each>
    </tbody>
</table>

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



