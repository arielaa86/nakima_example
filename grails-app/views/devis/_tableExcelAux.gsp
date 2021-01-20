<%@ page import="mccorletagencement.ProjetCuisine; mccorletagencement.ProjetSalleBain; java.text.NumberFormat" %>

<g:set var="formeur" value="${(NumberFormat.getNumberInstance(Locale.FRENCH))}"></g:set>
<g:set var="formeurOK" value="${formeur.setMinimumFractionDigits(2)}"></g:set>


<table class="table table-bordered">
    <tbody>
    <tr style="background-color: #ebf1de" class="noPrint">
        <td class="font-weight-bold" colspan="2">Agencement proposé HT</td>
        <td class="number" id="agencementHTFinalDisplay">
            ${ formeur.format(devisPrincipal?.agencementHT).replace(",", ".")} €
        </td>
    </tr>
    <tr style="background-color: #ebf1de; height: 55px!important;" class="noPrint">
        <td class="font-weight-bold" style="width: 50%">Offre exceptionnelle</td>
        <td style="width: 100px" class="number" id="remisePorcentageAux">

        </td>
        <td id="remiseMontantAux" class="number">
            0.00 €
        </td>
    </tr>
    <tr>
        <td colspan="2" >Total HT</td>
        <td class="number" id="totalHTAux">0.00 €</td>
    </tr>
    <tr>
        <td>TVA Non perçue non récupérable</td>
        <td class="number" id="tvaNonRecuperableAux"> 0.00 €</td>
        <td></td>
    </tr>
    <tr>
        <td colspan="2" >Octroi de mer</td>
        <td class="number" id="octroiDeMerAux">0.00 €</td>
    </tr>
    <tr>
        <td colspan="2" >Taxe eco-mobilier</td>
        <td class="number" id="taxeEcoMobAux">0.00 €</td>
    </tr>
    <tr style="color: #ff6761">
        <td colspan="2" class="font-weight-bold">Total HT hors pose</td>
        <td class=" number font-weight-bold" id="totalHtHorsPoseAux">0.00 €</td>
    </tr>
    <tr style="background-color: #ebf1de">
        <td colspan="2" class="font-weight-bold"  >
            Plan de travail
            ${this.devisPrincipal.projet.instanceOf(ProjetSalleBain) || this.devisPrincipal.projet.instanceOf(ProjetCuisine)
                    ? "("+ this.devisPrincipal.projet.planTravail +")" : ""}
        </td>
        <td class="number" id="prixPlanTravailAux">

        </td>
    </tr>
    <tr style="background-color: #ebf1de; height: 65px!important;">
        <td colspan="2" class="font-weight-bold"  >Options diverses: <br>

            <div class="displayOptions">

            </div>
        </td>
        <td class="number" id="prixOptionAux">

        </td>
    </tr>
    <tr>
        <td colspan="2" >Logistique et suivi de dossier</td>
        <td class="number" id="logistiqueAux">0.00 €</td>
    </tr>
    <tr>
        <td>Solde du projet</td>
        <td id="selecteurSolde">

            <input type="text" class="form-control" id="annulationSolde" name="annulationSolde"
                   onkeyup="obtenirPrixProjet()"
                   onclick="viderChamp(this.id)"
                   onfocusout="formatChamp(this.id)"
                   value="0.0"/>
        </td>
        <td class="number" id="verificationAux">0.00 €</td>
    </tr>
    <tr style="background-color: orange">
        <td colspan="2" class="font-weight-bold" >Total projet HT + Plan de travail + Options diverses + Logistique et suivi de dossier</td>
        <td class="number font-weight-bold" id="totalComplexeAux">0.00 €</td>
    </tr>
    <tr>
        <td>A la commande (40% du prix total)</td>
        <td class="number" id="acompteAux">0.00 €</td>
        <td class="number"></td>
    </tr>
    <tr>
        <td>A la vérification en atelier (55% du prix total)</td>
        <td class="number" id="soldeAux">0.00 €</td>
        <td class="number"></td>
    </tr>
    <tr>
        <td>A la fin de l'installation (5% du prix total)</td>
        <td class="number" id="finInstallationAux">0.00 €</td>
        <td class="number"></td>
    </tr>

    <tr style="background-color: #dbdbdb">
        <td colspan="2" class="font-weight-bold" style="font-size: 24px">Total à payer à MCCorlet Agencement</td>
        <td class="number font-weight-bold" style="font-size: 24px" id="totalMCCorletAux">0.00 €</td>
    </tr>
    <g:if test="${devisPrincipal.projet.instanceOf(ProjetSalleBain) && devisPrincipal.projet.typeHabitation.equals("Maison")}">

        <g:hiddenField id="quantitePieceEauAux" name="quantitePieceEau"
                       value="${devisPrincipal.projet.quantitePieceEau}"></g:hiddenField>
        <g:if test="${devisPrincipal.projet.quantitePieceEau > 1}">
        <tr style="background-color: #a5e28e">
            <td colspan="2" class="font-weight-bold" style="font-size: 24px" >Total x ${devisPrincipal.projet.quantitePieceEau} pièces d'eau</td>
            <td class="number font-weight-bold" style="font-size: 24px" id="totalPieceEauMccorletAux"></td>
        </tr>
        </g:if>

    </g:if>

    <g:if test="${devisPrincipal.projet.typeHabitation.equals("Immeuble")}">

        <g:hiddenField id="quantiteHabitationAux" name="quantiteHabitation"
                       value="${devisPrincipal.projet.quantiteHabitation}"></g:hiddenField>

        <tr style="background-color: #a5e28e">
            <td colspan="2" class="font-weight-bold" style="font-size: 24px">Total x ${devisPrincipal.projet.quantiteHabitation} logements</td>
            <td class="number font-weight-bold"style="font-size: 24px" id="totalQuantiteHabitationMccorletAux"></td>
        </tr>

    </g:if>

    <g:render template="livraison" />


    </tbody>
</table>

<g:hiddenField name="agencementHT" id="agencementHT" value=""/>
<g:hiddenField name="montant" id="montant" value=""/>
<g:hiddenField name="compoQuarante" id="compoQuarante" value=""/>
<g:hiddenField name="compoSoixante" id="compoSoixante" value=""/>
<g:hiddenField name="verificationChantier" id="verificationChantier" value=""/>
<g:hiddenField name="soldeProjet" id="soldeProjet" value=""/>
<g:hiddenField name="totalHThorsPose" id="totalHThorsPose" value=""/>

<g:hiddenField name="prixPlanTravail" id="prixPlanTravail" value=""/>
<g:hiddenField name="prixOption" id="prixOption" value=""/>
<g:hiddenField name="annulation" id="annulation" value=""/>


