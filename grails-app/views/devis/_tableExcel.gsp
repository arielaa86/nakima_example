<%@ page import="mccorletagencement.Role; java.text.DecimalFormat; mccorletagencement.Projet; mccorletagencement.Client; mccorletagencement.ProjetCuisine; mccorletagencement.ProjetSalleBain" %>

<table class="table table-bordered">
    <tbody>
    <tr style="background-color: #ebf1de">
        <td class="font-weight-bold" colspan="2">Agencement proposé HT</td>
        <td class="petit width-100px">

            <div class="d-flex flex-row justify-content-between">

                <input id="agencementHT" class="form-control"
                       type="text" ${actionName.equals("changementPrix") ? 'disabled' : ''}
                       onkeyup="obtenirPrixProjet()"
                       onclick="viderChamp(this.id)"
                       onfocusout="formatChamp(this.id)"
                       name="agencementHT" value="${this.devis?.agencementHT}">

                <div style="margin-top: 11px; margin-left: 2px">
                    €
                </div>

            </div>
        </td>
    </tr>
    <tr style="background-color: #ebf1de">
        <td class="font-weight-bold" style="width: 50%">Offre exceptionnelle</td>
        <td class="width-100px">
            <input id="remisePourcentage" class="form-control" ${actionName.equals("changementPrix") ? 'disabled' : ''}
                   onkeyup="obtenirPrixProjet()"
                   onclick="viderChamp(this.id)"
                   onfocusout="formatChamp(this.id)"
                   type="text" name="remisePourcentage" value="${this.devis?.remisePourcentage}">
        </td>
        <td id="remiseMontant" class="number">
            0.00 €
        </td>
    </tr>
    <tr>
        <td colspan="2">Total HT</td>
        <td class="number" id="totalHT">0.00 €</td>
    </tr>
    <tr>
        <td>TVA Non perçue non récupérable</td>
        <td class="number" id="tvaNonRecuperable">0.00 €</td>
        <td></td>
    </tr>
    <tr>
        <td colspan="2">Octroi de mer</td>
        <td class="number" id="octroiDeMer">0.00 €</td>
    </tr>
    <tr>
        <td colspan="2">Taxe eco-mobilier</td>
        <td class="number" id="taxeEcoMob">0.00 €</td>
    </tr>
    <tr style="color: #ff6761">
        <td colspan="2" class="font-weight-bold">Total HT hors pose</td>
        <td class=" number font-weight-bold" id="totalHtHorsPose">0.00 €</td>
    </tr>
    <tr style="background-color: #ebf1de">
        <td colspan="2" class="font-weight-bold">
            Plan de travail
        </td>
        <td class="number petit">
            <div class="d-flex flex-row justify-content-between">
                <input id="prixPlanTravail" class="form-control" type="text" name="prixPlanTravail"
                       value="${this.devis?.prixPlanTravail}"
                       onkeyup="obtenirPrixProjet()"
                       onclick="viderChamp(this.id)"
                       onfocusout="formatChamp(this.id)"/>

                <div style="margin-top: 11px; margin-left: 2px">
                    €
                </div>
            </div>
        </td>
    </tr>


    <tr style="background-color: #ebf1de">
        <td colspan="2" class="font-weight-bold">
            <div class="d-flex justify-content-around">
                Options diverses
                <input id="optionsDiverses" style="text-align: left!important;" class="form-control" type="text"
                       name="optionsDiverses" value="${this.devis.optionsDiverses}"/>
            </div>
        </td>
        <td class="number petit">
            <div class="d-flex flex-row justify-content-between">
                <input id="prixOption" class="form-control" type="text" name="prixOption"
                       value="${this.devis?.prixOption}"
                       onkeyup="obtenirPrixProjet()"
                       onclick="viderChamp(this.id)"
                       onfocusout="formatChamp(this.id)"/>

                <div style="margin-top: 11px; margin-left: 2px">
                    €
                </div>
            </div>
        </td>
    </tr>

    <tr>
        <td>Logistique et suivi de dossier</td>
        <td>
                <input type="text" class="form-control" id="annulationSuivi" name="annulationSuivi"
                        style="${user.authorities.contains(Role.findByAuthority("ROLE_DIRECTEUR")) ? '': 'visibility: hidden'}"
                       onkeyup="obtenirPrixProjet()"
                       onclick="viderChamp(this.id)"
                       onfocusout="formatChamp(this.id)"
                       value="${this.devis?.annulationSuivi ? this.devis?.annulationSuivi : '0.0'}"/>
        </td>
        <td class="number" id="logistique">0.00 €</td>
    </tr>
    <tr id="soldeProjetRow">
        <td>Solde du projet</td>
        <td id="selecteurSolde">

            <input type="text" class="form-control" id="annulationSolde" name="annulationSolde"
                   onkeyup="obtenirPrixProjet()"
                   onclick="viderChamp(this.id)"
                   onfocusout="formatChamp(this.id)"
                   value="${this.devis?.annulation ? this.devis?.annulation : '0.0'}"/>
        </td>
        <td class="number" id="verification">0.00 €</td>
    </tr>


    <g:set var="avoirs"
           value="${actionName == 'create' ? client.obtenirAvoirs() : client.obtenirAvoirsEdit(devis.projet.id)}"/>

    <g:if test="${avoirs.size() > 0}">
        <tr>

            <td colspan="3" class="number font-weight-bold" id="avoir">

                <div class="d-flex justify-content-end">

                    <div class="col-lg-2">
                        <label for="selectAvoirs" style="margin-top: 10px">Utiliser un avoir</label>
                    </div>

                    <div class="col-lg-4">

                        <g:select class="form-control custom-select" id="selectAvoirs" name="avoirs"
                                  noSelection="['': '---']"
                                  onchange="obtenirPrixProjet()"
                                  from="${avoirs}"
                                  optionKey="id"
                                  optionValue="${{ "No. " + it.projet.idInsitu + " : " + new DecimalFormat("###,###.00 €").format(it.montant * -1).replaceAll(",", " ") }}"/>
                    </div>
                </div>

            </td>
        </tr>
    </g:if>
    <tr style="background-color: orange">
        <td colspan="2"
            class="font-weight-bold">Total projet HT + Plan de travail + Options diverses + Logistique et suivi de dossier</td>
        <td class="number font-weight-bold" id="totalComplexe">0.00 €</td>
    </tr>
    <tr>
        <td>A la commande (40% du prix total)</td>
        <td class="number" id="acompte">0.00 €</td>
        <td class="number"></td>
    </tr>
    <tr>
        <td id="verificationAtelier">A la vérification en atelier (55% du prix total)</td>
        <td class="number" id="solde">0.00 €</td>
        <td class="number"></td>
    </tr>
    <tr id="finInstallationRow">
        <td>A la fin de l'installation (5% du prix total)</td>
        <td class="number" id="finInstallation">0.00 €</td>
        <td class="number"></td>
    </tr>
    <tr id="verificationRow">
        <td>Vérification du chantier</td>
        <td id="selecteurVerif">

            <input type="text" class="form-control" id="annulationVerif" name="annulationVerif"
                   onkeyup="obtenirPrixProjet()"
                   onclick="viderChamp(this.id)"
                   onfocusout="formatChamp(this.id)"
                   value="0.0"/>
        </td>
        <td class="number" id="verificationValue">0.00 €</td>
    </tr>
    <tr style="background-color: #dbdbdb">
        <td colspan="2" class="font-weight-bold">Total à payer à MCCorlet Agencement</td>
        <td class="number font-weight-bold" id="totalMCCorlet">0.00 €</td>
    </tr>

    <g:if test="${this.devis.projet instanceof ProjetSalleBain && this.devis.projet.typeHabitation.equals("Maison")}">

        <g:hiddenField id="quantitePieceEau" name="quantitePieceEau"
                       value="${this.devis.projet.quantitePieceEau}"></g:hiddenField>

        <g:if test="${this.devis.projet.quantitePieceEau > 1}">
            <tr style="background-color: #a5e28e">
                <td colspan="2" class="font-weight-bold">Total x ${this.devis.projet.quantitePieceEau} pièces d'eau</td>
                <td class="number font-weight-bold" id="totalPieceEauMccorlet"></td>
            </tr>
        </g:if>

    </g:if>

    <g:if test="${this.devis.projet.typeHabitation.equals("Immeuble")}">

        <g:hiddenField id="quantiteHabitation" name="quantiteHabitation"
                       value="${this.devis.projet.quantiteHabitation}">
        </g:hiddenField>

        <tr style="background-color: #a5e28e">
            <td colspan="2" class="font-weight-bold">Total x ${this.devis.projet.quantiteHabitation} logements</td>
            <td class="number font-weight-bold" id="totalQuantiteHabitationMccorlet"></td>
        </tr>

    </g:if>


    <g:render template="livraison"/>

    </tbody>
</table>


<g:hiddenField type="text" name="montant" id="montant" value="${devis?.montant}"/>

<g:hiddenField type="text" name="avoir" id="avoir" value="${devis?.avoir}"/>

<g:hiddenField type="text" name="aRembourser" id="aRembourser" value="${devis?.aRembourser}"/>

<g:hiddenField type="text" name="avoirUtilise" id="avoirUtilise" value="${devis?.avoirUtilise}"/>

<g:hiddenField type="text" name="avoirExistant" id="avoirExistant" value=""/>

<g:hiddenField type="text" name="compoQuarante" id="compoQuarante" value="${devis?.compoQuarante}"/>

<g:hiddenField type="text" name="compoSoixante" id="compoSoixante" value="${devis?.compoSoixante}"/>

<g:hiddenField type="text" name="verificationChantier" id="verificationChantier"
               value="${devis?.verificationChantier}"/>

<g:hiddenField type="text" name="soldeProjet" id="soldeProjet" value="${devis?.soldeProjet}"/>

<g:hiddenField type="text" name="totalHThorsPose" id="totalHThorsPose" value="${devis?.totalHThorsPose}"/>

