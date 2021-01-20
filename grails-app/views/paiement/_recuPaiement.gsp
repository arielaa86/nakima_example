<%@ page import="mccorletagencement.ProjetComplementaire; java.text.DecimalFormat; mccorletagencement.ProjetAutre; mccorletagencement.ProjetCuisine; mccorletagencement.ProjetSalleBain; mccorletagencement.ProjetDressing; mccorletagencement.ProjetPlacard; org.springframework.security.core.context.SecurityContextHolder; mccorletagencement.Utilisateur; mccorletagencement.FrenchNumberToWords" %>

<div class="row m-4 justify-content-center">
    <asset:image src="img/logomccorlet.jpg" style="width: 40%"/>

    <p class="mt-4 ml-5" style="font-size: 16px">
        Zac de Peters Maillet 97270 SAINT-ESPRIT <br>
                Téléphone 0596 70 41 31  - Télécopie 0596 56 69 97<br>
                SIRET : 818 034 829 00015 – APE 3102Z<br>
    </p>
</div>


<div class="row m-4 justify-content-end">
    <p class="mt-4 ml-5 mb-5" style="font-size: 16px">
        Ducos, le <g:formatDate date="${paiement.date}" format="dd MMMM yyyy" locale="fr"></g:formatDate>
    </p>

</div>



<div class="row justify-content-center" style="font-weight: bold ; font-size: 28px">

    Reçu de paiement


</div>

<hr style="margin-bottom: 80px; width: 800px">


    <p style="font-size: 22px">
        ${paiement.facture.devis.projet.client.intitule}
        ${paiement.facture.devis.projet.client.nom}
        ${paiement.facture.devis.projet.client.prenom}
        a réglé la somme de
    </p>
    <br>

    <p style="font-style: italic ; font-size: 22px">
       ${ new DecimalFormat("###,###.00 €").format(paiement.montant).replaceAll(",", " ") }
    </p>


        <p style="font-style: italic ; font-size: 22px">
            ${FrenchNumberToWords.convert(paiement.montant)} Euro

        </p>
    <br>

    <p style="font-size: 22px">
        en espèces sur le projet

        <g:if test="${paiement.facture.devis.projet.instanceOf( ProjetCuisine)}">
            Cuisine
        </g:if>
        <g:if test="${paiement.facture.devis.projet.instanceOf( ProjetSalleBain)}">
            Salle de bain
        </g:if>
        <g:if test="${paiement.facture.devis.projet.instanceOf( ProjetDressing)}">
            Dressing
        </g:if>
        <g:if test="${paiement.facture.devis.projet.instanceOf( ProjetPlacard)}">
            Placard
        </g:if>
        <g:if test="${paiement.facture.devis.projet.instanceOf( ProjetAutre)}">
            ${paiement.facture.devis.projet.typeProjet}
        </g:if>
        - réf. ${paiement.facture.devis.projet.idInsitu}.

    </p>


<div class="row justify-content-end" style="margin-top: 100px;">

    <div class="col-lg-3" id="textFirma" style="font-size: 16px">
        <g:if test="${paiement.utilisateur}">
            Pour Martinique Cuisine:
            <br>
            ${paiement.utilisateur.prenom+ " "+ paiement.utilisateur.nom}
        </g:if>
    </div>

</div>

<g:if test="${!actionName.equals("suiviEncaissement")}">
<div class="row justify-content-end" style="margin-top: 30px; margin-bottom: 100px">

    <div class="col-lg-2" id="firma">
        <asset:image class="print" width="300px" src="img/tampon.png" style="position: absolute; opacity: 70%;" />
        <g:if test="${Utilisateur.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName()).signature}">
            <img class="card-img-bottom" src="<g:createLink controller="utilisateur" action="showSignature" params="[id:Utilisateur.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName()).id]" />"/>
        </g:if>
    </div>

</div>
</g:if>
