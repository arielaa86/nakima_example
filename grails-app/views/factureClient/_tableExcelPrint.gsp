<%@ page import="mccorletagencement.Role; mccorletagencement.Devis; java.text.DecimalFormat; mccorletagencement.ProjetCuisine; mccorletagencement.ProjetSalleBain; java.text.NumberFormat" %>

<g:set var="formeur" value="${(NumberFormat.getNumberInstance(Locale.FRENCH))}"></g:set>
<g:set var="formeurOK" value="${formeur.setMinimumFractionDigits(2)}"></g:set>


<input id="ancien" class="custom-control-input" type="checkbox" ${this.factureClient?.devis.ancien ? 'checked=""' : ''}
       name="ancien" onclick="obtenirPrixProjet()">

<table class="table table-bordered col-lg-8">
    <tbody>
    <tr style="background-color: #ebf1de" class="noPrint">
        <td class="font-weight-bold" colspan="2">Agencement proposé HT</td>
        <td class="number">
            ${formeur.format(this.factureClient?.devis.agencementHT).replace(",", ".")} €
        </td>
    </tr>
    <tr style="background-color: #ebf1de" class="noPrint">
        <td class="font-weight-bold" style="width: 50%">Offre exceptionnelle</td>
        <td class="number">
            ${this.factureClient?.devis.remisePourcentage} %
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
        <td colspan="2" class="font-weight-bold">Plan de travail
        ${this.factureClient.montrerPlanTravail()}
        </td>
        <td class="number">
            ${formeur.format(this.factureClient?.devis.prixPlanTravail).replace(",", ".")} €
        </td>
    </tr>
    <tr style="background-color: #ebf1de">
        <td colspan="2" class="font-weight-bold">Options diverses:
            ${this.factureClient?.devis.optionsDiverses}
        </td>
        <td class="number">
            ${formeur.format(this.factureClient?.devis.prixOption).replace(",", ".")} €
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

    <g:if test="${this.factureClient.devis.avoir < 0}">

        <g:set var="avoirUtilise" value="${Devis.findById(this.factureClient.devis.avoirUtilise) }" />
        <tr>
            <td colspan="3" class="number font-weight-bold" id="avoir">
                <div class="justify-content-end">
                    Avoir utilisé ${"No." + avoirUtilise.projet.idInsitu + " : " + new DecimalFormat("###,###.00 €").format(this.factureClient.devis.avoir).replaceAll(",", " ")}
                </div>
            </td>
        </tr>
    </g:if>

        <tr style="background-color: orange" >
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
        <td colspan="2">Vérification du chantier</td>
        <td class="number" id="verificationValue">0.00 €</td>
    </tr>



    <tr style="background-color: #dbdbdb">
        <td colspan="2" class="font-weight-bold" style="font-size: 24px">
            <g:if test="${this.factureClient.devis.montant >= 0}">
                Total à payer à MCCorlet Agencement
            </g:if>
            <g:else>
                Total de l'Avoir
            </g:else>
        </td>
        <td class="number font-weight-bold" style="font-size: 24px" id="totalMCCorlet">0.00 €</td>
    </tr>

    <g:if test="${this.factureClient.devis.projet.instanceOf(ProjetSalleBain) && this.factureClient.devis.projet.typeHabitation.equals("Maison")}">

        <g:hiddenField id="quantitePieceEau" name="quantitePieceEau"
                       value="${this.factureClient.devis.projet.quantitePieceEau}"></g:hiddenField>


        <g:if test="${this.factureClient.devis.projet.quantitePieceEau > 1}">
            <tr style="background-color: #a5e28e">
                <td colspan="2" class="font-weight-bold"
                    style="font-size: 24px">Total x ${this.factureClient.devis.projet.quantitePieceEau} pièces d'eau</td>
                <td class="number font-weight-bold" style="font-size: 24px" id="totalPieceEauMccorlet"></td>
            </tr>
        </g:if>

    </g:if>

    <g:if test="${this.factureClient.devis.projet.typeHabitation.equals("Immeuble")}">

        <g:hiddenField id="quantiteHabitation" name="quantiteHabitation"
                       value="${this.factureClient.devis.projet.quantiteHabitation}"></g:hiddenField>

        <tr style="background-color: #a5e28e">
            <td colspan="2" class="font-weight-bold"
                style="font-size: 24px">Total x ${this.factureClient.devis.projet.quantiteHabitation} logements</td>
            <td class="number font-weight-bold" style="font-size: 24px" id="totalQuantiteHabitationMccorlet"></td>
        </tr>

    </g:if>

    <g:if test="${this.factureClient.devis.montant >= 0}">

        <tr class="row-divider">
            <td colspan="3"></td>
        </tr>
        <tr style="background-color: #ffe26b; text-align: center">
            <td colspan="3" class="font-weight-bold">
                La prestation Pose est réalisée par des poseurs indépendants
            </td>
        </tr>
        <tr class="noPrint">
            <td colspan="2">Frais supplémentaires poseur (non cumulable avec la ligne en-dessous)</td>
            <td class="number">
                ${formeur.format(this.factureClient.devis?.supplementPoseur).replace(",", ".")} €
            </td>
        </tr>
        <tr style="background-color: #dbdbdb">
            <td colspan="2" class="font-weight-bold" style="font-size: 24px">Livraison et pose TTC</td>
            <td class="number font-weight-bold" style="font-size: 24px" id="livraison">0.00 €</td>
        </tr>

        <g:if test="${this.factureClient.devis.projet.instanceOf(ProjetSalleBain) && this.factureClient.devis.projet.typeHabitation.equals("Maison")}">

            <g:hiddenField id="quantitePieceEau" name="quantitePieceEau"
                           value="${this.factureClient.devis.projet.quantitePieceEau}"></g:hiddenField>

            <g:if test="${this.factureClient.devis.projet.quantitePieceEau > 1}">
                <tr style="background-color: #a5e28e">
                    <td colspan="2" class="font-weight-bold"
                        style="font-size: 24px">Total x ${this.factureClient.devis.projet.quantitePieceEau} pièces d'eau</td>
                    <td class="number font-weight-bold" style="font-size: 24px" id="totalPieceEauLivraison"></td>
                </tr>
            </g:if>

        </g:if>

        <g:if test="${this.factureClient.devis.projet.typeHabitation.equals("Immeuble")}">

            <g:hiddenField id="quantiteHabitation" name="quantiteHabitation"
                           value="${this.factureClient.devis.projet.quantiteHabitation}"></g:hiddenField>

            <tr style="background-color: #a5e28e">
                <td colspan="2" class="font-weight-bold"
                    style="font-size: 24px">Total x ${this.factureClient.devis.projet.quantiteHabitation} logements</td>
                <td class="number font-weight-bold" style="font-size: 24px" id="totalQuantiteHabitationLivraison"></td>
            </tr>

        </g:if>

        <tr class="row-divider">
            <td colspan="3"></td>
        </tr>
        <tr style="background-color: #a7b1b3">
            <td colspan="2" class="font-weight-bold" style="font-size: 20px">Agencement livré et posé</td>
            <td class="number font-weight-bold" style="font-size: 20px" id="totalTTC">0.00 €</td>
        </tr>

        <g:if test="${this.factureClient?.devis.projet.instanceOf(ProjetSalleBain) && this.factureClient?.devis.projet.typeHabitation.equals("Maison")}">

            <g:hiddenField id="quantitePieceEau" name="quantitePieceEau"
                           value="${this.factureClient?.devis.projet.quantitePieceEau}"></g:hiddenField>

            <g:if test="${this.factureClient.devis.projet.quantitePieceEau > 1}">
                <tr style="background-color: #a5e28e">
                    <td colspan="2" class="font-weight-bold"
                        style="font-size: 20px">Total x ${this.factureClient.devis.projet.quantitePieceEau} pièces d'eau</td>
                    <td class="number font-weight-bold" style="font-size: 20px" id="totalPieceEau"></td>
                </tr>
            </g:if>

        </g:if>

        <g:if test="${this.factureClient?.devis.projet.typeHabitation.equals("Immeuble")}">

            <g:hiddenField id="quantiteHabitation" name="quantiteHabitation"
                           value="${this.factureClient?.devis.projet.quantiteHabitation}"></g:hiddenField>

            <tr style="background-color: #a5e28e">
                <td colspan="2" class="font-weight-bold"
                    style="font-size: 20px">Total x ${this.factureClient?.devis.projet.quantiteHabitation} logements</td>
                <td class="number font-weight-bold" style="font-size: 20px" id="totalQuantiteHabitation"></td>
            </tr>

        </g:if>
    </g:if>

    </tbody>
</table>


<g:hiddenField  id="annulationSolde" name="annulationSolde" value="${this.factureClient?.devis.soldeProjet}"/>
<g:hiddenField id="annulationVerif" name="annulationVerif" value="${this.factureClient?.devis.soldeProjet}"/>


<g:hiddenField  id="annulation" name="annulation" value="${this.factureClient?.devis.annulation}"/>

<g:if test="${this.factureClient.devis.montant >= 0}">
    <g:hiddenField type="text" name="avoir" id="avoir" value="${factureClient.devis?.avoir}"/>
</g:if>


<g:if test="${factureClient.devis.avoirUtiliseDecline != null }">

    <g:set var="avoirUtiliseDecline" value="${Devis.findById(factureClient.devis.avoirUtiliseDecline)}" />

    <g:hiddenField type="text" name="avoirUtiliseDeclineIdInsitu" id="avoirUtiliseDeclineIdInsitu" value="${avoirUtiliseDecline.projet.idInsitu}"/>
    <g:hiddenField type="text" name="avoirUtiliseDeclineMontant" id="avoirUtiliseDeclineMontant" value="${avoirUtiliseDecline.montant}"/>
</g:if>

<g:hiddenField type="text" name="aRembourser" id="aRembourser" value="${factureClient.devis?.aRembourser}"/>




<g:hiddenField id="agencementHT" class="form-control" type="text" onkeyup="obtenirPrixProjet()"
               name="agencementHT" value="${this.factureClient?.devis.agencementHT}"/>


<g:hiddenField id="remisePourcentage" class="form-control" onkeyup="obtenirPrixProjet()"
               type="text" name="remisePourcentage" value="${this.factureClient?.devis.remisePourcentage}"/>


<g:hiddenField id="prixPlanTravail" class="form-control" type="text" name="prixPlanTravail"
               value="${this.factureClient?.devis.prixPlanTravail}" onkeyup="obtenirPrixProjet()"/>


<g:hiddenField id="prixOption" class="form-control" type="text" name="prixOption"
               value="${this.factureClient?.devis.prixOption}" onkeyup="obtenirPrixProjet()"/>


<g:hiddenField id="supplementPoseur" class="form-control" type="text" name="supplementPoseur"
               value="${this.factureClient?.devis.supplementPoseur}"
               onkeyup="obtenirPrixProjet()"/>


<g:hiddenField type="text" name="annulationSuivi" id="annulationSuivi" value="${this.factureClient?.devis?.annulationSuivi}"/>
