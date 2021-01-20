<%@ page import="mccorletagencement.Devis; java.text.DecimalFormat; mccorletagencement.ProjetComplementaire; mccorletagencement.ProjetCuisine; mccorletagencement.ProjetSalleBain; java.text.NumberFormat" %>

<g:set var="formeur" value="${(NumberFormat.getNumberInstance(Locale.FRENCH))}"></g:set>
<g:set var="formeurOK" value="${formeur.setMinimumFractionDigits(2)}"></g:set>




<input id="ancien" class="custom-control-input" type="checkbox" ${this.devis?.ancien ? 'checked=""' : ''}
       name="ancien" onclick="obtenirPrixProjet()">

<table class="table table-bordered">
    <tbody>
    <tr style="background-color: #ebf1de" class="noPrint">
        <td class="font-weight-bold" colspan="2">Agencement proposé HT</td>
        <td class="number font-weight-bold">
            ${formeur.format(this.devis?.agencementHT).replace(",", ".")} €
        </td>
    </tr>
    <tr style="background-color: #ebf1de; color: #ff0000; font-weight: bold" class="noPrint">
        <td class="font-weight-bold" style="width: 50%">Offre exceptionnelle</td>
        <td class="number" style="background-color: #ebf1de; color: #ff0000; font-weight: bold">
            ${this.devis?.remisePourcentage} %
        </td>
        <td id="remiseMontant" class="number" style="background-color: #ebf1de; color: #ff0000; font-weight: bold">
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
            ${this.devis.projet.instanceOf(ProjetSalleBain) || this.devis.projet.instanceOf(ProjetCuisine)
                    ? "(" + this.devis.projet.planTravail + ")" : ""}
        </td>
        <td class="number">
            ${formeur.format(this.devis?.prixPlanTravail).replace(",", ".")} €
        </td>
    </tr>
    <tr style="background-color: #ebf1de">
        <td colspan="2" class="font-weight-bold">Options diverses:
        ${this.devis.optionsDiverses}
        </td>
        <td class="number">
            ${formeur.format(this.devis?.prixOption).replace(",", ".")} €
        </td>
    </tr>
    <tr>
        <td colspan="2">Logistique et suivi de dossier</td>
        <td class="number" id="logistique">0.00 €</td>
    </tr>
    <tr id="soldeProjetRow">
        <td colspan="2">Solde du projet</td>
        <td class="number" id="verification">0.00 €</td>
    </tr>

    <g:if test="${this.devis.avoir < 0}">

        <g:set var="avoirUtilise" value="${Devis.findById(this.devis.avoirUtilise) }" />
        <tr>
            <td colspan="3" class="number font-weight-bold" id="avoir">
                <div class="justify-content-end">
                    Avoir utilisé ${"No." + avoirUtilise.projet.idInsitu + " : " + new DecimalFormat("###,###.00 €").format(this.devis.avoir).replaceAll(",", " ")}
                </div>
            </td>
        </tr>
    </g:if>


    <g:if test="${this.devis.avoirUtiliseDecline != null}">

        <g:set var="avoirAvantDecliner" value="${Devis.findById(this.devis.avoirUtiliseDecline) }" />
        <tr>
            <td colspan="3" class="number font-weight-bold" id="avoir">
                <div class="justify-content-end">
                    Avoir utilisé ${"No." + avoirAvantDecliner.projet.idInsitu + " : " + new DecimalFormat("###,###.00 €").format(avoirAvantDecliner.montant).replaceAll(",", " ")}
                </div>
            </td>
        </tr>
    </g:if>

    <tr style="background-color: orange; ${this.devis.montant >= 0 ? 'visibility: visible' : 'visibility: collapse;'}">
        <td colspan="2"
            class="font-weight-bold">Total projet HT + Plan de travail + Options diverses + Logistique et suivi de dossier</td>
        <td class="number font-weight-bold" id="totalComplexe">0.00 €</td>
    </tr>
    <tr style="${this.devis.montant >= 0 ? 'visibility: visible' : 'visibility: collapse;'}">
        <td>A la commande (40% du prix total)</td>
        <td class="number" id="acompte">0.00 €</td>
        <td class="number"></td>
    </tr>
    <tr style="${this.devis.montant >= 0 ? 'visibility: visible' : 'visibility: collapse;'}">
        <td id="verificationAtelier">A la vérification en atelier (55% du prix total)</td>
        <td class="number" id="solde">0.00 €</td>
        <td class="number"></td>
    </tr>
    <tr id="finInstallationRow">
        <td>A la fin de l'installation (5% du prix total)</td>
        <td class="number" id="finInstallation">0.00 €</td>
        <td class="number"></td>
    </tr>
    <tr id="verificationRow" style="${this.devis.montant >= 0 ? 'visibility: visible' : 'visibility: collapse;'}">
        <td colspan="2">Vérification du chantier</td>
        <td class="number" id="verificationValue">0.00 €</td>
    </tr>
    <tr style="background-color: #dbdbdb">
        <td colspan="2" class="font-weight-bold" style="font-size: 24px">
            <g:if test="${devis.montant >= 0}">
                Total à payer à MCCorlet Agencement
            </g:if>
            <g:else>
                Total de l'Avoir
            </g:else>

        </td>
        <td class="number font-weight-bold" style="font-size: 24px" id="totalMCCorlet">0.00 €</td>
    </tr>
    <g:if test="${devis.projet.instanceOf(ProjetSalleBain) && devis.projet.typeHabitation.equals("Maison")}">

        <g:hiddenField id="quantitePieceEau" name="quantitePieceEau"
                       value="${devis.projet.quantitePieceEau}"></g:hiddenField>

        <g:if test="${devis.projet.quantitePieceEau > 1}">
            <tr style="background-color: #a5e28e">
                <td colspan="2" class="font-weight-bold"
                    style="font-size: 24px">Total x ${devis.projet.quantitePieceEau} pièces d'eau</td>
                <td class="number font-weight-bold" style="font-size: 24px" id="totalPieceEauMccorlet"></td>
            </tr>
        </g:if>

    </g:if>

    <g:if test="${devis.projet.typeHabitation.equals("Immeuble")}">

        <g:hiddenField id="quantiteHabitation" name="quantiteHabitation"
                       value="${devis.projet.quantiteHabitation}"></g:hiddenField>

        <tr style="background-color: #a5e28e">
            <td colspan="2" class="font-weight-bold"
                style="font-size: 24px">Total x ${devis.projet.quantiteHabitation} logements</td>
            <td class="number font-weight-bold" style="font-size: 24px" id="totalQuantiteHabitationMccorlet"></td>
        </tr>

    </g:if>


    <g:render template="livraisonPrint"/>

    </tbody>
</table>


<div class="row m-3 noPrint">
    <g:if test="${devis.montant == 0 && devis.aRembourser < 0}">

        <p class="mt-3" style="font-size: 20px; color: #ff6761">
            <i class="fa fa-warning"></i>
            Remboursement client à prévoir : ${new DecimalFormat("###,###.00 €").format(devis.aRembourser * -1).replaceAll(",", " ")}
        </p>
    </g:if>
</div>

<div class="row m-3">
    <g:if test="${devis.montant >= 0}">
        <p class="mt-3"
           style="font-size: 18px">Nous restons à votre disposition pour vous donner tout renseignement complémentaire,</p>
    </g:if>
</div>


<div class="row justify-content-end">
    <p class="mt-3 mb-0 mr-6" style="font-size: 18px">Pour Martinique Cuisine:</p>

</div>

<div class="row justify-content-end">
    <p class="mr-6"
       style="font-size: 18px">
        ${devis.envoye ? devis.creePar : devis.getLastUser()}
    </p>
</div>

<div class="row justify-content-end" style="margin-right: 15px!important;">

    <asset:image width="300px" src="img/tampon.png" style="position: absolute; opacity: 70%"/>


    <g:if test="${devis.creePar.signature}">
        <img width="200px" src="<g:createLink controller="utilisateur" action="showSignaturePermiteAll"
                                              params="[id: devis.codeEmail]"/>"/>
    </g:if>
</div>






<g:hiddenField id="annulationSolde" name="annulationSolde" value="${this.devis.soldeProjet}"/>
<g:hiddenField id="annulationVerif" name="annulationVerif" value="${this.devis.soldeProjet}"/>

<g:hiddenField id="annulation" name="annulation" value="${this.devis.annulation}"/>
<g:hiddenField type="textField" name="avoir" id="avoir" value="${devis?.avoir}"/>

<g:if test="${this.devis.avoirUtiliseDecline != null }">

    <g:set var="avoirUtiliseDecline" value="${Devis.findById(devis.avoirUtiliseDecline)}" />

    <g:hiddenField type="text" name="avoirUtiliseDeclineIdInsitu" id="avoirUtiliseDeclineIdInsitu" value="${avoirUtiliseDecline.projet.idInsitu}"/>
    <g:hiddenField type="text" name="avoirUtiliseDeclineMontant" id="avoirUtiliseDeclineMontant" value="${avoirUtiliseDecline.montant}"/>
</g:if>

<g:hiddenField type="text" name="aRembourser" id="aRembourser" value="${devis?.aRembourser}"/>



<g:hiddenField id="agencementHT" class="form-control" type="text" onkeyup="obtenirPrixProjet()"
               name="agencementHT" value="${this.devis?.agencementHT}"/>



<g:hiddenField id="remisePourcentage" class="form-control" onkeyup="obtenirPrixProjet()"
               type="text" name="remisePourcentage" value="${this.devis?.remisePourcentage}"/>


<g:hiddenField id="prixPlanTravail" class="form-control" type="text" name="prixPlanTravail"
               value="${this.devis?.prixPlanTravail}" onkeyup="obtenirPrixProjet()"/>


<g:hiddenField id="prixOption" class="form-control" type="text" name="prixOption"
               value="${this.devis?.prixOption}" onkeyup="obtenirPrixProjet()"/>


<g:hiddenField id="supplementPoseur" class="form-control" type="text" name="supplementPoseur"
               value="${this.devis?.supplementPoseur}"
               onkeyup="obtenirPrixProjet()"/>


<g:hiddenField type="text" name="annulationSuivi" id="annulationSuivi" value="${this.devis?.annulationSuivi}"/>

