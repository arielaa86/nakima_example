<div class="col-12 col-sm-12 col-lg-3 font-weight-bold" style="font-size: 16px; color: #2cc185">
    Recettes: ${ totalRecette > 0 ? new java.text.DecimalFormat("###,###.00 €").format(totalRecette).replaceAll(",", " ") : '0.00 €'}
</div>
<div class="col-12 col-sm-12 col-lg-3 font-weight-bold"  style="font-size: 16px; color: #fa6163">
    Dépenses: ${ totalDepense > 0 ? new java.text.DecimalFormat("###,###.00 €").format(totalDepense).replaceAll(",", " ") : '0.00 €'}
</div>
<div class="col-12 col-sm-12 col-lg-3 font-weight-bold" style="font-size: 16px; color: #8858f6" >
    Gain: ${ totalGain != 0 ? new java.text.DecimalFormat("###,###.00 €").format(totalDepense).replaceAll(",", " ") : '0.00 €'}
</div>