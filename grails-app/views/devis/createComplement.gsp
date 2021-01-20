<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'devis.label', default: 'Devis')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>

        <style>

        table *{
            font-size: 12px!important;
        }

        table input{
            font-size: 12px;
            padding: 5px!important;
            height: 24px!important;
            width: 60px!important;
        }

        .optionsDiverses{
            font-size: 12px;
            padding: 5px!important;
            height: 24px!important;
            width: 100%!important;
        }

        .d-flex div{
            margin-top: 3px!important;
        }

        input[type="number"]{
            text-align:right;

        }

        input[type="text"]{
            text-align:right;

        }


        @media print
        {

            body, body *{
                height: 0px;
            }


            .navbar, .noPrint, .btn{
                display: none!important;
            }

            input{
                border: none!important;
            }

            .print {
                display: block;

            }

        }

        @media only screen and (max-width: 510px) {
            .petit {
               padding: 0px!important;

            }

            .form-control {
                padding: 0px;
                padding-right: 2px;
            }

            .width-100px{
                min-width: 100px;
            }
        }

        </style>

    </head>
    <body class="print">

    <div class="card card-default card-table m-2">

        <div class="card card-header noPrint">
            <div class="row" style="color: rgba(0,0,0,0.7); vertical-align: middle">
                <div class="col-lg-12" style="font-size: 22px;">
                    Créer devis
                </div>
            </div>

            <hr>
        </div>


        <div class="card-body">

            <div class="row mt-3 mr-3 justify-content-end">
                <g:if test="${flash.message}">
                    <div class="alert alert-success alert-icon alert-icon-colored alert-dismissible col-lg-4" role="alert">
                        <div class="icon"><span class="s7-check"></span></div>
                        <div class="message">
                            <button class="close" type="button" data-dismiss="alert" aria-label="Close">
                                <span class="s7-close" aria-hidden="true"></span>
                            </button>
                            ${flash.message}
                        </div>
                    </div>
                </g:if>
            </div>


            <div class="row justify-content-center m-3 noPrint" style="display: none" id="erreurDocument">
                <div class="alert alert-theme alert-danger alert-dismissible col-lg-6" role="alert">
                    <button class="close" type="button" data-dismiss="alert" aria-label="Close"><span class="s7-close"
                                                                                                      aria-hidden="true"></span>
                    </button>

                    <div class="row ml-3 mt-3">
                        <div class="icon">
                            <span class="s7-attention"></span>
                        </div>
                        <strong style="font-size:14px">Erreur !</strong>
                    </div>

                    <div class="message">

                        <ul class="errors" role="alert">
                            <li>
                                Veuillez télécharger la pièce jointe
                            </li>

                        </ul>

                    </div>
                </div>
            </div>




            <g:hasErrors bean="${this.devis}">
                <div class="row justify-content-center m-3">
                    <div class="alert alert-theme alert-danger alert-dismissible col-lg-6" role="alert">
                        <button class="close" type="button" data-dismiss="alert" aria-label="Close"><span class="s7-close" aria-hidden="true"></span></button>
                        <div class="row ml-3 mt-3">
                            <div class="icon">
                                <span class="s7-attention"></span>
                            </div>
                            <strong style="font-size:14px">Erreur !</strong>
                        </div>

                        <div class="message">


                            <ul class="errors" role="alert">
                                <g:eachError bean="${this.devis}" var="error">
                                    <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>>

                                        <g:message error="${error}"/>

                                    </li>
                                </g:eachError>
                            </ul>

                        </div>
                    </div>
                </div>

            </g:hasErrors>

            <g:form resource="${this.devis}" action="saveComplement" method="POST" enctype="multipart/form-data" autocomplete="off"
                    onsubmit="submit.disabled = true; return true;"
            >


                <div class="noPrint m-3">
                    <g:render template="form"/>
                </div>


                <div class="row justify-content-center m-lg-6  ml-sm-0">

                    <div class="col-lg-4 print">
                        <h3>Projet principal</h3>
                        <g:render template="tableExcelPrincipal"/>
                    </div>


                    <div class="col-lg-4 print">
                        <h3>Projet modifié</h3>
                        <g:render template="tableExcelData"/>
                    </div>

                    <div class="col-lg-4 print">

                        <h3>Complément / Avoir</h3>
                        <g:render template="tableExcelAux"/>
                    </div>

                </div>


                <div class="row m-5 justify-content-end">
                    <button class="btn btn-space" type="submit" style="background-color: #1a9fdd; color: white" id="submit" onclick="return validerDocumentWord()">
                        <i class="fa fa-chevron-right"></i>
                        Générer document
                    </button>
                </div>

            </g:form>

        </div>


    </div>


    <asset:javascript src="js/app-projetFonctionnes.js" />
    <asset:javascript src="js/app-devisCalculPrincipal.js" />
    <asset:javascript src="js/app-devisCalculAux.js" />


    <script>
        function getOptions() {
            var options = document.querySelector("input[name=optionsDiverses]").value;

            document.querySelector("div[class=displayOptions]").innerHTML = options;

        }



        function validerDocumentWord(){
           var file = document.querySelector("input[id=document]").value;

           if(file==""){

               document.querySelector("div[id=erreurDocument]").style.display = "flex";
               window.scrollTo({ top: 0, behavior: 'smooth' });

               return false;
           }
           return true;
        }


       getOptions();
       obtenirPrixMin();
       obtenirPrixProjet();

       obtenirPrixMinPrincipal();
       obtenirPrixProjetPrincipal();

       formatChamp("metreLineaire");
       formatChamp("agencementHT");
       formatChamp("remisePourcentage");
       formatChamp("prixPlanTravail");
       formatChamp("prixOption");


    </script>

    </body>
</html>
