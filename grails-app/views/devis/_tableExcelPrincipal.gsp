<%@ page import="mccorletagencement.ProjetCuisine; mccorletagencement.ProjetSalleBain; java.text.NumberFormat" %>

<g:set var="formeur" value="${(NumberFormat.getNumberInstance(Locale.FRENCH))}"></g:set>
<g:set var="formeurOK" value="${formeur.setMinimumFractionDigits(2)}"></g:set>



<table class="table table-bordered">
    <tbody>
    <tr style="background-color: #ebf1de" class="noPrint">
        <td class="font-weight-bold" colspan="2">Agencement proposé HT</td>
        <td class="number">
            ${ formeur.format(devisPrincipal?.obtenirAgencementHTavecComplements()).replace(",", ".")} €
        </td>
    </tr>
    <tr style="background-color: #ebf1de; height: 55px!important;" class="noPrint">
        <td class="font-weight-bold" style="width: 50%">Offre exceptionnelle</td>
        <td style="width: 100px" class="number">
            ${this.devisPrincipal?.remisePourcentage} %
        </td>
        <td id="remiseMontantPrincipal" class="number">
            0.00 €
        </td>
    </tr>
    <tr>
        <td colspan="2" >Total HT</td>
        <td class="number" id="totalHTPrincipal">0.00 €</td>
    </tr>
    <tr>
        <td>TVA Non perçue non récupérable</td>
        <td class="number" id="tvaNonRecuperablePrincipal"> 0.00 €</td>
        <td></td>
    </tr>
    <tr>
        <td colspan="2" >Octroi de mer</td>
        <td class="number" id="octroiDeMerPrincipal">0.00 €</td>
    </tr>
    <tr>
        <td colspan="2" >Taxe eco-mobilier</td>
        <td class="number" id="taxeEcoMobPrincipal">0.00 €</td>
    </tr>
    <tr style="color: #ff6761">
        <td colspan="2" class="font-weight-bold">Total HT hors pose</td>
        <td class=" number font-weight-bold" id="totalHtHorsPosePrincipal">0.00 €</td>
    </tr>
    <tr style="background-color: #ebf1de">
        <td colspan="2" class="font-weight-bold"  >
            Plan de travail
            ${this.devisPrincipal.projet.instanceOf(ProjetSalleBain) || this.devisPrincipal.projet.instanceOf(ProjetCuisine)
                    ? "("+ this.devisPrincipal.projet.planTravail +")" : ""}
        </td>
        <td class="number">
           ${ formeur.format(this.devisPrincipal?.obtenirPlanTravailAvecComplements()).replace(",", ".")} €
        </td>
    </tr>
    <tr style="background-color: #ebf1de; height: 65px!important;">
        <td colspan="2" class="font-weight-bold"  >Options diverses: <br>
         ${this.devisPrincipal.optionsDiverses}
        </td>
        <td class="number">
            ${ formeur.format(this.devisPrincipal?.obtenirOptionsDiversesAvecComplements()).replace(",", ".")} €
        </td>
    </tr>
    <tr>
        <td colspan="2" >Logistique et suivi de dossier</td>
        <td class="number" id="logistiquePrincipal">0.00 €</td>
    </tr>
    <tr>
        <td colspan="2">Solde du projet</td>
        <td class="number" id="verificationPrincipal">0.00 €</td>
    </tr>
    <tr style="background-color: orange">
        <td colspan="2" class="font-weight-bold" >Total projet HT + Plan de travail + Options diverses + Logistique et suivi de dossier</td>
        <td class="number font-weight-bold" id="totalComplexePrincipal">0.00 €</td>
    </tr>
    <tr>
        <td>A la commande (40% du prix total)</td>
        <td class="number" id="acomptePrincipal">0.00 €</td>
        <td class="number"></td>
    </tr>
    <tr>
        <td>A la vérification en atelier (55% du prix total)</td>
        <td class="number" id="soldePrincipal">0.00 €</td>
        <td class="number"></td>
    </tr>
    <tr>
        <td>A la fin de l'installation (5% du prix total)</td>
        <td class="number" id="finInstallationPrincipal">0.00 €</td>
        <td class="number"></td>
    </tr>

    <tr style="background-color: #dbdbdb">
        <td colspan="2" class="font-weight-bold" style="font-size: 24px">Total à payer à MCCorlet Agencement</td>
        <td class="number font-weight-bold" style="font-size: 24px" id="totalMCCorletPrincipal">0.00 €</td>
    </tr>
    <g:if test="${devisPrincipal.projet.instanceOf(ProjetSalleBain) && devisPrincipal.projet.typeHabitation.equals("Maison")}">

        <g:hiddenField id="quantitePieceEauPrincipal" name="quantitePieceEau"
                       value="${devisPrincipal.projet.quantitePieceEau}"></g:hiddenField>

        <g:if test="${devisPrincipal.projet.quantitePieceEau > 1}">


        <tr style="background-color: #a5e28e">
            <td colspan="2" class="font-weight-bold" style="font-size: 24px" >Total x ${devisPrincipal.projet.quantitePieceEau} pièces d'eau</td>
            <td class="number font-weight-bold" style="font-size: 24px" id="totalPieceEauMccorletPrincipal"></td>
        </tr>
        </g:if>

    </g:if>

    <g:if test="${devisPrincipal.projet.typeHabitation.equals("Immeuble")}">

        <g:hiddenField id="quantiteHabitationPrincipal" name="quantiteHabitation"
                       value="${devisPrincipal.projet.quantiteHabitation}"></g:hiddenField>

        <tr style="background-color: #a5e28e">
            <td colspan="2" class="font-weight-bold" style="font-size: 24px">Total x ${devisPrincipal.projet.quantiteHabitation} logements</td>
            <td class="number font-weight-bold"style="font-size: 24px" id="totalQuantiteHabitationMccorletPrincipal"></td>
        </tr>


    </g:if>

    </tbody>
</table>

<table class="table table-bordered" style="visibility: collapse">

<tbody>

<g:render template="livraisonPrincipal" />

</tbody>

</table>



<g:hiddenField type="text" name="avoirPrincipal" id="avoirPrincipal" value="${this.devisPrincipal?.avoir}"/>

<g:hiddenField id="agencementHTPrincipal" class="form-control" type="text" onkeyup="obtenirPrixProjet()"
                   name="agencementHTPrincipal" value="${this.devisPrincipal.obtenirAgencementHTavecComplements()}" />


<g:hiddenField id="remisePourcentagePrincipal" class="form-control" onkeyup="obtenirPrixProjet()"
                   type="text" name="remisePourcentagePrincipal" value="${this.devisPrincipal?.remisePourcentage}" />


<g:hiddenField id="prixPlanTravailPrincipal" class="form-control" type="text" name="prixPlanTravailPrincipal"
                   value="${this.devisPrincipal?.obtenirPlanTravailAvecComplements()}" onkeyup="obtenirPrixProjet()" />


<g:hiddenField id="prixOptionPrincipal" class="form-control" type="text" name="prixOptionPrincipal"
                   value="${this.devisPrincipal?.obtenirOptionsDiversesAvecComplements()}" onkeyup="obtenirPrixProjet()" />


<g:hiddenField id="supplementPoseurPrincipal" class="form-control" type="text" name="supplementPoseurPrincipal"
       value="${this.devisPrincipal?.supplementPoseur}"
       onkeyup="obtenirPrixProjet()" />

