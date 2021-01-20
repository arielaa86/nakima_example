<%@ page import="java.text.DecimalFormat" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Décharge de responsabilité</title>

    <style>


    #Selector {
        width: 200px;
        margin: 0 auto;
        border: 1px solid #1b68a7;
        border-radius: 20px;
    }

    .SubirFoto {
        width: 0.1px;
        height: 0.1px;
        opacity: 0;
        overflow: hidden;
        position: absolute;
        z-index: -1;
        line-height: normal;
        margin: 0;
    }

    .SubirFoto + label {
        font-size: 1.2rem;
        font-weight: bold;
        color: #1b68a7;
        display: inline-block;
        text-overflow: ellipsis;
        text-align: center;
        white-space: nowrap;
        overflow: hidden;
        padding: 1em 1em 1em 1em;
        cursor: pointer;
    }


    inputfile + label svg {
        vertical-align: middle;
        width: 100%;
        height: 100%;
        fill: #f1e5e6;
    }


    #blah {
        width: 100%;
        margin-top: 20px;
    }

    .item {
        font-size: 16px !important;
        text-align: right;
        margin-right: 5px;
        padding: 5px !important;
    }

    td:not(.item) {
        font-size: 16px !important;
        color: #fa6163;
    }

    .option-label {
        font-size: 16px;
        font-weight: bold;
    }

    .option {
        width: 260px;
        border-radius: 20px;
    }

    </style>
</head>

<body>

<div class="card card-default card-table">

    <div class="card-body m-5">

        <div class="row justify-content-end">
            <g:link class="btn btn-space btn-outline-secondary" controller="factureClient" action="show"
                    id="${this.facture.id}">
                <i class="fa fa-chevron-left"></i>
                Retour au BDC
            </g:link>
        </div>

        <div class="row m-4">
            <div id="pageTitle">
                <h3>${facture.photoDecharge == null ? 'Ajouter' : 'Modifier'} formulaire de décharge de responsabilité</h3>
            </div>
        </div>
        <hr>

        <div class="row justify-content-end m-4">
            <div id="buttonTrash">
            <g:if test="${facture.photoDecharge != null}">

                <i class="fa fa-trash text-danger" style="font-size: 16px" onclick="deleteDecharge()"></i>

            </g:if>
            </div>
        </div>

        <div class="row">

            <div class="col-lg-4" style="text-align: center">
                <form id="formDecharge" enctype="multipart/form-data">

                    <label class="col-12 col-sm-12 col-form-label">Télécharger pièce jointe:</label>

                    <div class="col-12 col-sm-12">
                        <input class="inputfile" type="file" name="document" id="document"
                               data-multiple-caption="{count} fichiers sélectionnés" required>
                        <label class="btn btn-secondary" for="document" style="min-width: 200px"><i
                                class="icon s7-upload"></i><span id="parcourir">Parcourir...</span></label>
                    </div>

                    <g:hiddenField name="idFacture" value="${facture.id}"/>

                    <button class="btn btn-space btn-success m-6"
                            type="submit" id="submit" onclick="enregistrerDecharge()" style="min-width: 200px">
                        <i class="fa fa-floppy-o"></i> Enregistrer
                    </button>

                </form>
            </div>

            <div class="col-lg-8">

                <div id="documentView">
                    <g:if test="${this.facture.documentType.equals("pdf") && this.facture.photoDecharge != null}">

                        <object width="100%" height="700px" type="application/pdf"
                                data="<g:createLink controller="factureClient" action="showDecharge"
                                                    params="[id: this.facture.id]"/>" trusted="yes"
                                application="yes">
                        </object>

                    </g:if>
                    <g:if test="${!this.facture.documentType.equals("pdf") && this.facture.photoDecharge != null}">

                        <div class="row justify-content-center">

                            <img width="100%"
                                 src="<g:createLink controller="factureClient" action="showDecharge"
                                                    params="[id: this.facture.id]"/>">

                        </div>

                    </g:if>

                </div>

            </div>

        </div>

    </div>
</div>


<asset:javascript src="jquery.min.js"/>
<asset:javascript src="factureClient/lancerProduction.js"/>

</body>
</html>