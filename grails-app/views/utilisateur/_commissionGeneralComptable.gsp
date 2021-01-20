
<div class="row justify-content-center" style="color: rgba(0,0,0,0.7); vertical-align: middle">
    <div class="col-lg-10 font-weight-bold" style="font-size: 18px;">
        Commissions mensuelles
        <hr>
    </div>
</div>



<g:each in="${listeSuiviCommercial}" var="suiviCommercial">

    <div class="row justify-content-center mt-4">
        <div class="col-lg-10">
            <h5>${suiviCommercial.getUtilisateur()}</h5>
        </div>

    </div>

    <g:render template="commissionComptable" model="['suiviCommercialDAO': suiviCommercial]"/>

</g:each>



<div class="row justify-content-center" style="color: rgba(0,0,0,0.7); vertical-align: middle">
    <div class="col-lg-10 font-weight-bold" style="font-size: 18px;">
            Détail mensuel des paiements clients
        <hr>
    </div>
</div>


<div class="row justify-content-center">
    <div class="col-lg-10 table-responsive-md" style="margin-bottom: 50px">

        <g:render template="listeEncaissements" model="['listeEncaissements': listeEncaissements ]"/>

    </div>
</div>

<div class="row">
     <div class="col-lg-11" style="text-align: right">
        <button class="btn btn-space btn-outline-secondary" type="button" onclick="window.print()">
            <i class="fa fa-print"></i>
            Imprimer
        </button>
     </div>
</div>


