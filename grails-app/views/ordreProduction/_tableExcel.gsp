<table class="table table-bordered">
    <tbody>
    <tr style="background-color: #ebf1de">
        <td class="font-weight-bold" colspan="2">Agencement proposé HT</td>
        <td>
            <input id="agencementHT" class="form-control" type="text"
                   onkeyup="obtenirPrixProjet()"
                   onclick="viderChamp(this.id)"
                   onfocusout="formatChamp(this.id)"
                   name="agencementHT" value="${this.factureClient.devis?.agencementHT}">
        </td>
    </tr>
    <tr style="background-color: #ebf1de">
        <td class="font-weight-bold" style="width: 50%">Offre exceptionnelle (%)</td>
        <td>
            <input id="remisePourcentage" class="form-control"
                   onkeyup="obtenirPrixProjet()"
                   onclick="viderChamp(this.id)"
                   onfocusout="formatChamp(this.id)"
                   type="text" name="remisePourcentage" value="${this.factureClient.devis?.remisePourcentage}">
        </td>
        <td id="remiseMontant" class="number">
            0.00 €
        </td>
    </tr>
    <tr>
        <td colspan="2" >Total HT</td>
        <td class="number" id="totalHT">0.00 €</td>
    </tr>
    <tr>
        <td>TVA Non perçue non récupérable</td>
        <td class="number" id="tvaNonRecuperable"> 0.00 €</td>
        <td></td>
    </tr>
    <tr>
        <td colspan="2" >Octroi de mer</td>
        <td class="number" id="octroiDeMer">0.00 €</td>
    </tr>
    <tr>
        <td colspan="2" >Taxe eco-mobilier</td>
        <td class="number" id="taxeEcoMob">0.00 €</td>
    </tr>
    <tr style="color: #ff6761">
        <td colspan="2" class="font-weight-bold">Total HT hors pose</td>
        <td class=" number font-weight-bold" id="totalHtHorsPose">0.00 €</td>
    </tr>
    <tr style="background-color: #ebf1de">
        <td colspan="2" class="font-weight-bold"  >Plan de travail</td>
        <td class="number">
            <input id="prixPlanTravail" class="form-control" type="text" name="prixPlanTravail"
                   value="${this.factureClient.devis?.prixPlanTravail}"
                   onkeyup="obtenirPrixProjet()"
                   onclick="viderChamp(this.id)"
                   onfocusout="formatChamp(this.id)" />
        </td>
    </tr>
    <tr style="background-color: #ebf1de">
        <td colspan="2" class="font-weight-bold"  >Options diverses</td>
        <td class="number">
            <input id="prixOption" class="form-control" type="text" name="prixOption"
                   value="${this.factureClient.devis?.prixOption}"
                   onkeyup="obtenirPrixProjet()"
                   onclick="viderChamp(this.id)"
                   onfocusout="formatChamp(this.id)"/>
        </td>
    </tr>
    <tr>
        <td colspan="2" >Logistique et suivi de dossier</td>
        <td class="number" id="logistique">0.00 €</td>
    </tr>
    <tr style="background-color: orange">
        <td colspan="2" class="font-weight-bold" >Total projet HT + Plan de travail + Options diverses + Logistique et suivi de dossier</td>
        <td class="number font-weight-bold" id="totalComplexe">0.00 €</td>
    </tr>
    <tr>
        <td>A la commande (40% du prix total)</td>
        <td class="number" id="acompte">0.00 €</td>
        <td class="number"></td>
    </tr>
    <tr>
        <td>A la vérification en atelier (60% du prix total)</td>
        <td class="number" id="solde">0.00 €</td>
        <td class="number"></td>
    </tr>
    <tr style="background-color: #ffe26b; text-align: center">
        <td colspan="3" class="font-weight-bold">
            La prestation Pose est réalisée par des poseurs indépendants
        </td>
    </tr>
    <tr>
        <td colspan="2" >Livraison et pose TTC</td>
        <td class="number" id="livraison">0.00 €</td>
    </tr>
    <tr>
        <td colspan="2" >Vérification du chantier</td>
        <td class="number" id="verification">0.00 €</td>
    </tr>
    <tr>
        <td colspan="3" ></td>
    </tr>
    <tr style="background-color: #a7b1b3">
        <td colspan="2" class="font-weight-bold" style="font-size: 20px">Agencement livré et posé</td>
        <td class="number font-weight-bold" style="font-size: 20px" id="totalTTC">0.00 €</td>
    </tr>

    <g:if test="${this.factureClient?.devis.projet.instanceOf(ProjetSalleBain) && devis.projet.typeHabitation.equals("Maison")}">

        <g:hiddenField id="quantitePieceEau" name="quantitePieceEau" value="${devis.projet.quantitePieceEau}"></g:hiddenField>

        <tr style="background-color: #a5e28e">
            <td colspan="2" class="font-weight-bold" style="font-size: 20px">Total - ${devis.projet.quantitePieceEau} pièces d'eau</td>
            <td class="number font-weight-bold" style="font-size: 20px" id="totalPieceEau"></td>
        </tr>

    </g:if>

    <g:if test="${this.factureClient?.devis.projet.typeHabitation.equals("Immeuble")}">

        <g:hiddenField id="quantiteHabitation" name="quantiteHabitation" value="${devis.projet.quantiteHabitation}"></g:hiddenField>

        <tr style="background-color: #a5e28e">
            <td colspan="2" class="font-weight-bold" style="font-size: 20px">Total - ${devis.projet.quantiteHabitation} logements</td>
            <td class="number font-weight-bold" style="font-size: 20px" id="totalQuantiteHabitation"></td>
        </tr>

    </g:if>


    </tbody>
</table>

<g:hiddenField type="text" name="montant" id="montant" value="${this.factureClient?.devis.montant}" />