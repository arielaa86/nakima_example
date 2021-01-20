<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main" />
    <title>Signature</title>

    <style>

    .navbar{

        display: none;

    }
    </style>
</head>

<body>

<div class="row justify-content-center m-3">

    <div id="signature-pad" class="signature-pad col-lg-5 m-lg-2 col-md-12 mb-2">
        <div class="signature-pad--body">
            <canvas> </canvas>
        </div>
        <div class="signature-pad--footer">
            <div class="description">Signature du Commercial</div>

            <div class="signature-pad--actions" style="margin: 10px">
                <div>
                    <button type="button" class="btn btn-outline-secondary" data-action="clear">Effacer</button>

                </div>
                <div>
                    <button type="button" class="btn btn-outline-primary" data-action="save-png">Valider</button>

                </div>
            </div>
        </div>
    </div>

</div>


<g:form controller="factureClient" action="update3" resource="${this.factureClient}" method="PUT" onsubmit="submit.disabled = true; return true;">

    <g:hiddenField name="version" value="${this.factureClient?.version}" />

    <g:textArea style="visibility: hidden" id="sig-dataUrl" name="client" value="" />

    <div id="transfer" class="row m-2 mb-6 justify-content-center" style="visibility: hidden">
        <button class="btn btn-space" type="submit" style="background-color: #1a9fdd; color: white" id="submit">
            <i class="fa fa-chevron-right"></i>
            Transférer signature
        </button>
    </div>

</g:form>



</div>

<script>


</script>

</body>
</html>