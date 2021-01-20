<%@ page import="mccorletagencement.ProjetSalleBain" %>


    <tr class="row-divider">
     <td colspan="3"></td>
    </tr>
    <tr style="background-color: #ffe26b; text-align: center">
     <td colspan="3" class="font-weight-bold">
         La prestation Pose est réalisée par des poseurs indépendants
     </td>
    </tr>
    <tr class="noPrint">
     <td colspan="2">Frais supplémentaires poseur (non cumulable avec la ligne en-dessous) </td>
     <td class="number">

            ${ formeur.format( this.devisPrincipal?.supplementPoseur).replace(",", ".") } €

        </td>
    </tr>
    <tr style="background-color: #dbdbdb">
        <td colspan="2" class="font-weight-bold" style="font-size: 24px" >Livraison et pose TTC</td>
        <td  class="number font-weight-bold" style="font-size: 24px"  id="livraisonPrincipal">0.00 €</td>
    </tr>

    <g:if test="${devisPrincipal.projet.instanceOf(ProjetSalleBain) && devisPrincipal.projet.typeHabitation.equals("Maison")}">

        <g:hiddenField id="quantitePieceEauPrincipal" name="quantitePieceEauPrincipal"
                       value="${devisPrincipal.projet.quantitePieceEau}"></g:hiddenField>

        <tr style="background-color: #a5e28e">
            <td colspan="2" class="font-weight-bold" style="font-size: 24px">Total x ${devisPrincipal.projet.quantitePieceEau} pièces d'eau</td>
            <td class="number font-weight-bold" style="font-size: 24px" id="totalPieceEauLivraisonPrincipal"></td>
        </tr>

    </g:if>

    <g:if test="${devisPrincipal.projet.typeHabitation.equals("Immeuble")}">

        <g:hiddenField id="quantiteHabitationPrincipal" name="quantiteHabitationPrincipal"
                       value="${devisPrincipal.projet.quantiteHabitation}"></g:hiddenField>

        <tr style="background-color: #a5e28e">
            <td colspan="2" class="font-weight-bold" style="font-size: 24px">Total x ${devisPrincipal.projet.quantiteHabitation} logements</td>
            <td class="number font-weight-bold" style="font-size: 24px" id="totalQuantiteHabitationLivraisonPrincipal"></td>
        </tr>

    </g:if>

    <tr class="row-divider">
        <td colspan="3"></td>
    </tr>


    <tr style="background-color: #a7b1b3">
        <td colspan="2" class="font-weight-bold" style="font-size: 20px">Agencement livré et posé</td>
        <td class="number font-weight-bold" style="font-size: 20px" id="totalTTCPrincipal">0.00 €</td>
    </tr>

    <g:if test="${devisPrincipal.projet.instanceOf(ProjetSalleBain) && devisPrincipal.projet.typeHabitation.equals("Maison")}">

        <g:hiddenField id="quantitePieceEauPrincipal" name="quantitePieceEauPrincipal" value="${devisPrincipal.projet.quantitePieceEau}"></g:hiddenField>

        <tr style="background-color: #a5e28e">
            <td colspan="2" class="font-weight-bold" style="font-size: 20px">Total x ${devisPrincipal.projet.quantitePieceEau} pièces d'eau</td>
            <td class="number font-weight-bold" style="font-size: 20px" id="totalPieceEauPrincipal"></td>
        </tr>

    </g:if>

    <g:if test="${devisPrincipal.projet.typeHabitation.equals("Immeuble")}">

        <g:hiddenField id="quantiteHabitationPrincipal" name="quantiteHabitationPrincipal" value="${devisPrincipal.projet.quantiteHabitation}"></g:hiddenField>

        <tr style="background-color: #a5e28e" >
            <td colspan="2" class="font-weight-bold" style="font-size: 20px">Total x ${devisPrincipal.projet.quantiteHabitation} logements</td>
            <td class="number font-weight-bold" style="font-size: 20px" id="totalQuantiteHabitationPrincipal"></td>
        </tr>

    </g:if>

