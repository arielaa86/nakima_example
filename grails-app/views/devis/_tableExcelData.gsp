<%@ page import="mccorletagencement.ProjetCuisine; mccorletagencement.ProjetSalleBain" %>

<table class="table table-bordered">
    <tbody>
    <tr style="background-color: #ebf1de">
        <td class="font-weight-bold" colspan="2">Agencement proposé HT</td>
        <td class="petit width-100px">

            <div class="d-flex flex-row justify-content-between">


                <input id="agencementHTData" class="form-control" type="text" ${actionName.equals("changementPrix") ? 'disabled' : ''}
                       onkeyup="obtenirPrixProjet()"
                       onclick="viderChamp(this.id)"
                       onfocusout="formatChamp(this.id)"
                       name="agencementHTData" value="${this.devis?.agencementHT}">

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
                <input id="prixPlanTravailData" class="form-control" type="text" name="prixPlanTravail"
                       value="0.00"
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
             Options diverses: <br>
             <input id="optionsDiverses" style="text-align: left!important;" class="form-control optionsDiverses"
                    type="text" name="optionsDiverses" value="${this.devisPrincipal.optionsDiverses}" onkeyup="getOptions()" />
        </td>
        <td class="number petit">
            <div class="d-flex flex-row justify-content-between">
                <input id="prixOptionData" class="form-control" type="text" name="prixOption"
                       value="0.00"
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
        <td colspan="2">Logistique et suivi de dossier</td>
        <td class="number" id="logistique">0.00 €</td>
    </tr>
    <tr>
        <td colspan="2">Solde du projet</td>
        <td class="number" id="verification">0.00 €</td>
    </tr>
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
        <td>A la vérification en atelier (55% du prix total)</td>
        <td class="number" id="solde">0.00 €</td>
        <td class="number"></td>
    </tr>
    <tr>
        <td>A la fin de l'installation (5% du prix total)</td>
        <td class="number" id="finInstallation">0.00 €</td>
        <td class="number"></td>
    </tr>
    <tr style="background-color: #dbdbdb">
        <td colspan="2" class="font-weight-bold">Total à payer à MCCorlet Agencement</td>
        <td class="number font-weight-bold" id="totalMCCorlet">0.00 €</td>
    </tr>


    <g:if test="${this.devis.projet.instanceOf(ProjetSalleBain) && this.devis.projet.typeHabitation.equals("Maison")}">

        <g:hiddenField id="quantitePieceEau" name="quantitePieceEau"
                       value="${this.devis.projet.quantitePieceEau}"></g:hiddenField>

        <tr style="background-color: #a5e28e">
            <td colspan="2" class="font-weight-bold">Total x ${this.devis.projet.quantitePieceEau} pièces d'eau</td>
            <td class="number font-weight-bold" id="totalPieceEauMccorlet"></td>
        </tr>

    </g:if>

    <g:if test="${this.devis.projet.typeHabitation.equals("Immeuble")}">

        <g:hiddenField id="quantiteHabitation" name="quantiteHabitation" value="${this.devis.projet.quantiteHabitation}">
        </g:hiddenField>

        <tr style="background-color: #a5e28e">
            <td colspan="2" class="font-weight-bold">Total x ${this.devis.projet.quantiteHabitation} logements</td>
            <td class="number font-weight-bold" id="totalQuantiteHabitationMccorlet"></td>
        </tr>

    </g:if>



    </tbody>
</table>
