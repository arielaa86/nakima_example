<%@ page import="mccorletagencement.Role; org.springframework.security.core.context.SecurityContextHolder; mccorletagencement.Utilisateur; java.text.DecimalFormat" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="noMenu"/>
    <title></title>

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

    .card-table {
        top: -154px;
    }


    .option {
        width: 260px;
        border-radius: 20px;
        align-items: center;
        font-size: 20px;
    }

    @media only screen and (max-width: 770px) {
        .card-table {
            top: -90px;
        }


        #docPdf {
            height: 200px;
            margin-top: 20px;
        }

    }


    @media only screen and (min-width: 770px) {

        #blah {
            width: 30%;
            margin-top: 20px;
        }


        #docPdf {
            width: 40%;
            margin-top: 20px;
        }


    }

    .option-label {
        font-size: 16px;
        font-weight: bold;
    }

    .option {
        width: 260px;
        border-radius: 20px;
        align-items: center;
    }


    </style>
</head>

<body>

<div class="card card-default card-table">

    <div class="card-body">

        <div class="col-sm-12">

            <g:set var="user"
                   value="${Utilisateur.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName())}"/>

            <g:if test="${user != null}">

                <g:if test="${user.authorities.contains(Role.findByAuthority("ROLE_ADMIN"))}">

                    <div class="row justify-content-end m-4">
                        <g:link action="suiviPoseClientAdmin" class="btn btn-outline-secondary"><i
                                class="fa fa-chevron-left"></i> Retourner à la liste</g:link>
                    </div>

                </g:if>

            </g:if>
            <g:else>

                <div class="row justify-content-end m-4">
                    <g:link action="suiviPoseClient" class="btn btn-outline-secondary"><i
                            class="fa fa-chevron-left"></i> Retourner à la liste</g:link>
                </div>

            </g:else>



            <div class="card-header card-header-divider m-4 font-weight-bold">Détails de la pose</div>

            <div class="user-info-list card card-default">
                <div class="card-body">
                    <table class="no-border no-strip skills">
                        <tbody class="no-border-x no-border-y">
                        <tr>
                            <td class="item font-weight-bold">Livraison:</td>
                            <td><g:formatDate date="${ordre.livraison}" format="dd MMMM yyyy" locale="fr"/></td>
                        </tr>
                        <tr>
                            <td class="item font-weight-bold">Client:</td>
                            <td>${ordre.factureClient.devis.projet.client}</td>
                        </tr>
                        <tr>
                            <td class="item font-weight-bold">Adresse:</td>
                            <td>
                                ${ordre.factureClient.devis.projet.client.adresse + " " +
                                        ordre.factureClient.devis.projet.client.codePostal + " " +
                                        ordre.factureClient.devis.projet.client.ville}
                            </td>
                        </tr>
                        <tr>
                            <td class="item font-weight-bold">Téléphone:</td>
                            <td>
                                ${ordre.factureClient.devis.projet.client.telephone != null ? ordre.factureClient.devis.projet.client.telephone : ordre.factureClient.devis.projet.client.telephoneFixe}
                            </td>
                        </tr>
                        <tr>

                            <td class="item font-weight-bold">Projet:</td>
                            <td>
                                ${ordre.factureClient.devis.projet.idInsitu + " - " + ordre.factureClient.devis.projet.getType()}
                            </td>
                        </tr>

                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <g:if test="${formVisisble}">
            <form id="formPose" enctype="multipart/form-data">

                <div class="row justify-content-center" id="Selector">
                    <input type="file" name="foto" id="foto" class="SubirFoto" accept="*" capture="camera"/>
                    <label for="foto">
                        <i class="fa fa-camera fa-3x"></i>
                        <br>
                        <span style="font-size: 16px; font-weight: bold">Télécharger / Photo<br>formulaire</span>
                    </label>
                </div>


                <div class="row justify-content-center" id="fullContainer" style="display: none">
                    <div id="imageContainer" class="col-lg-12" style="text-align: center" style="display: none">
                        <img id="blah" class="formulaire" src="#" alt="" />
                    </div>


                    <div id="pdfContainer" class="col-lg-12" style="text-align: center" style="display: none">
                        <object id="docPdf" height="600px"
                                data=""
                                trusted="yes" application="yes">
                        </object>


                    </div>
                </div>

                <g:hiddenField name="idPose" value="${ordre.id}"/>
                <g:hiddenField name="etat" value=""/>


                <div class="row justify-content-center m-4">
                    <button id="btnTrue" type="submit" class="btn btn-primary option"
                            onclick="informerPoseComplete(true)" disabled>
                        <i class="fa fa-times"></i> Signaler un problème
                    </button>
                </div>

                <div class="row justify-content-center m-4">
                    <button id="btnFalse" type="submit" class="btn btn-success option"
                            onclick="informerPoseComplete(false)" disabled>
                        <i class="fa fa-check"></i> Rien à signaler
                    </button>
                </div>

            </form>
        </g:if>

    </div>
</div>


<asset:javascript src="lib/jquery/jquery.min.js"/>
<asset:javascript src="ordreProduction/actions.js"/>

<script>
    function readURL(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();

            $('#btnTrue').prop('disabled', false);
            $('#btnFalse').prop('disabled', false);


            document.getElementById("fullContainer").style.display = "none";
            document.getElementById("pdfContainer").style.display = "none";
            document.getElementById("imageContainer").style.display = "none";


            if(input.files[0].name.includes(".pdf")){

                reader.onload = function (e) {
                    $('#docPdf').attr('data', e.target.result);
                    document.getElementById("pdfContainer").style.display = "block";

                }

            }else{

                reader.onload = function (e) {
                    $('#blah').attr('src', e.target.result);
                    document.getElementById("imageContainer").style.display = "block";
                }

            }


            document.getElementById("fullContainer").style.display = "block";

            reader.readAsDataURL(input.files[0]);
        }
    }

    $("#foto").change(function () {
        readURL(this);
    });
</script>
</body>
</html>