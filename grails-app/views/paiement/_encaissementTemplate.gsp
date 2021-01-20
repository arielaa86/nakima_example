<div class="row justify-content-center mb-6">
    <div class="col-lg-8">
        <div class="row" style="color: rgba(0,0,0,0.7); vertical-align: middle">
            <div class="col-lg-12" style="font-size: 18px;">
                <i class="fa fa-credit-card"></i> Carte bancaire
            </div>
        </div>

        <g:render template="tableauEncaissement"
                  model="[paiements: paiementsDAO.getCarteBancairePaiements()?.sort{it.date} ]"/>

    </div>
</div>

<div class="row justify-content-center mb-6">
    <div class="col-lg-8">
        <div class="row" style="color: rgba(0,0,0,0.7); vertical-align: middle">
            <div class="col-lg-12" style="font-size: 18px;">
                <i class="fa fa-euro"></i> Chèque
            </div>
        </div>

        <g:render template="tableauEncaissement"
                  model="[paiements: paiementsDAO.getChequePaiements()?.sort{it.date} ]"/>

    </div>
</div>


<div class="row justify-content-center mb-6">
    <div class="col-lg-8">
        <div class="row" style="color: rgba(0,0,0,0.7); vertical-align: middle">
            <div class="col-lg-12" style="font-size: 18px;">
                <i class="fa fa-money"></i> Espèces
            </div>
        </div>

        <g:render template="tableauEncaissement"
                  model="[paiements: paiementsDAO.getEspecesPaiements()?.sort{it.date}]"/>


    </div>
</div>




<div class="row justify-content-center mb-6">
    <div class="col-lg-8">
        <div class="row" style="color: rgba(0,0,0,0.7); vertical-align: middle">
            <div class="col-lg-12" style="font-size: 18px;">
                <i class="fa fa-exchange"></i> Virement
            </div>
        </div>


        <g:render template="tableauEncaissement"
                  model="[paiements: paiementsDAO.getVirementPaiements()?.sort{it.date}]"/>
    </div>
</div>


<div class="row m-3 justify-content-center">


<g:each in="${resumeCommerciaux}" var="resumen" >

<div class="col-sm-6 col-lg-3">
    <div class="widget widget-fullwidth earnings">
        <div class="widget-head">
           <span class="title">${resumen.utilisateur}</span>
        </div>
        <div class="earnings-resume">
            <div class="earnings-value earnings-value-big">
                <span class="earnings-counter" data-toggle="counter">
                    ${resumen.total > 0 ? new java.text.DecimalFormat("###,###.00 €").format(resumen.total).replaceAll(",", " ") : '0.00 €'}
                </span>
                <span class="earnings-title">TOTAL</span>
            </div>
            <div class="earnings-value">
                <span class="earnings-counter" data-toggle="counter">
                    ${resumen.carteBleu > 0 ? new java.text.DecimalFormat("###,###.00 €").format(resumen.carteBleu).replaceAll(",", " ") : '0.00 €'}
                </span>
                <span class="earnings-title">Carte bancaire</span>
            </div>
            <div class="earnings-value">
                <span class="earnings-counter" data-toggle="counter">
                    ${resumen.cheque > 0 ? new java.text.DecimalFormat("###,###.00 €").format(resumen.cheque).replaceAll(",", " ") : '0.00 €'}
                </span>
                <span class="earnings-title">Chèque</span>
            </div>

            <div class="earnings-value">
                <span class="earnings-counter" data-toggle="counter">
                    ${resumen.especes > 0 ? new java.text.DecimalFormat("###,###.00 €").format(resumen.especes).replaceAll(",", " ") : '0.00 €'}
                </span>
                <span class="earnings-title">Espèces</span>
            </div>

            <div class="earnings-value">
                <span class="earnings-counter" data-toggle="counter">
                    ${resumen.virement > 0 ? new java.text.DecimalFormat("###,###.00 €").format(resumen.virement).replaceAll(",", " ") : '0.00 €'}
                </span>
                <span class="earnings-title">Virement</span>
            </div>


        </div>
    </div>
</div>

</g:each>
</div>



<script>


    activeDataTables();




</script>







