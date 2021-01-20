<div class="row">
    <div class="col-lg-12">
        <img style="object-fit: scale-down; width: 100%; /*max-height: 850px*/"
             src="<g:createLink controller="plan" action="showPlan"
                                params="[id: id]"/>">


        <g:if test="${this.factureClient.signatureClient}">

            <img style="
            mix-blend-mode: multiply;
            position: absolute;
            right: 50px;
            bottom: 60px;
            width: 200px!important" src="<g:createLink controller="factureClient"
                                                      action="showSignatureClient"
                                                      params="[id: factureClient.id]"/>"/>

        </g:if>

    </div>

</div>


<script>

    window.onload = function () {
        window.print();
    }
    window.onafterprint = function () {
        window.close();
    }

</script>