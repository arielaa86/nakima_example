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

<div class="row m-1 justify-content-center">

    <div id="signature-pad" class="signature-pad col-lg-5 m-lg-2 col-md-12 mb-2">
        <div class="signature-pad--body">
            <canvas> </canvas>
        </div>
        <div class="signature-pad--footer">
            <div class="description">Signature du Client</div>

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


<g:form controller="factureClient" action="update2" resource="${this.factureClient}" method="PUT" onsubmit="submit.disabled = true; return true;">


    <div id="transfer" class="row m-2 mb-6 justify-content-center" style="visibility: hidden">
        <button class="btn btn-space" id="submit" type="submit" style="background-color: #1a9fdd; color: white" id="submit">
            <i class="fa fa-chevron-right"></i>
            Transférer signature
        </button>
    </div>


    <g:textArea style="visibility: hidden" id="sig-dataUrl" name="client" value="" />

    <g:hiddenField name="version" value="${this.factureClient?.version}" />


</g:form>



</div>

<script>


</script>

</body>
</html>