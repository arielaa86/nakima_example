<g:if test="${devis.montant >= 0}">

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

            ${formeur.format(this.devis?.supplementPoseur).replace(",", ".")} €

        </td>
    </tr>
    <tr style="background-color: #dbdbdb">
        <td colspan="2" class="font-weight-bold" style="font-size: 24px">Livraison et pose TTC</td>
        <td class="number font-weight-bold" style="font-size: 24px" id="livraison">0.00 €</td>
    </tr>

    <g:if test="${devis.projet.instanceOf(ProjetSalleBain) && devis.projet.typeHabitation.equals("Maison")}">

        <g:hiddenField id="quantitePieceEau" name="quantitePieceEau"
                       value="${devis.projet.quantitePieceEau}"></g:hiddenField>

        <tr style="background-color: #a5e28e">
            <td colspan="2" class="font-weight-bold"
                style="font-size: 24px">Total x ${devis.projet.quantitePieceEau} pièces d'eau</td>
            <td class="number font-weight-bold" style="font-size: 24px" id="totalPieceEauLivraison"></td>
        </tr>

    </g:if>

    <g:if test="${devis.projet.typeHabitation.equals("Immeuble")}">

        <g:hiddenField id="quantiteHabitation" name="quantiteHabitation"
                       value="${devis.projet.quantiteHabitation}"></g:hiddenField>

        <tr style="background-color: #a5e28e">
            <td colspan="2" class="font-weight-bold"
                style="font-size: 24px">Total x ${devis.projet.quantiteHabitation} logements</td>
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

    <g:if test="${devis.projet.instanceOf(ProjetSalleBain) && devis.projet.typeHabitation.equals("Maison")}">

        <g:hiddenField id="quantitePieceEau" name="quantitePieceEau"
                       value="${devis.projet.quantitePieceEau}"></g:hiddenField>

        <tr style="background-color: #a5e28e">
            <td colspan="2" class="font-weight-bold"
                style="font-size: 20px">Total x ${devis.projet.quantitePieceEau} pièces d'eau</td>
            <td class="number font-weight-bold" style="font-size: 20px" id="totalPieceEau"></td>
        </tr>

    </g:if>

    <g:if test="${devis.projet.typeHabitation.equals("Immeuble")}">

        <g:hiddenField id="quantiteHabitation" name="quantiteHabitation"
                       value="${devis.projet.quantiteHabitation}"></g:hiddenField>

        <tr style="background-color: #a5e28e">
            <td colspan="2" class="font-weight-bold"
                style="font-size: 20px">Total x ${devis.projet.quantiteHabitation} logements</td>
            <td class="number font-weight-bold" style="font-size: 20px" id="totalQuantiteHabitation"></td>
        </tr>

    </g:if>
</g:if>
