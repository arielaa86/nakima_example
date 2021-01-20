<%@ page import="mccorletagencement.Role; org.springframework.security.core.context.SecurityContextHolder; mccorletagencement.Utilisateur; mccorletagencement.ProjetSalleBain; mccorletagencement.ProjetCuisine" %>

<!DOCTYPE html>
    <html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'devis.label', default: 'Devis')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>

        <style>

        #commentaireModal{

            border: none;
            resize: none;
            background-color: white;
            font-size: 18px!important;
            text-align: center;


        }


        #commentaire{

            max-height: 80px!important;
            background-color: white;
        }

        input[type="number"]{
            text-align:right;

        }

        input[type="text"]{
            text-align:right;

        }

        #actionsButtons .btn{
            width: 160px;
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




        </style>

    </head>
    <body class="print">

    <g:set var="user"
           value="${Utilisateur.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName())}"></g:set>



    <div class="card card-default card-table m-2">
        <div class="card-header card-header-divider noPrint">

            <div class="d-flex justify-content-between">

                <div class="row" style="vertical-align: middle">
                    <div class="col-lg-12" style="font-size: 22px;">
                        Modifier devis
                    </div>
                </div>



                <%--

                <g:if test="${ this.devis.notes !=null && Utilisateur.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName()).authorities.contains(Role.findByAuthority("ROLE_COMMERCIAL"))}">

                    <button id="showNotes" class="btn btn-space btn-secondary" data-toggle="modal" data-target="#md-default" type="button"> Revoir la note</button>

                </g:if>

                --%>

            </div>


        </div>
        <div class="card-body">


            <g:if test="${flash.error}">

                <div class="row justify-content-center m-3">
                    <div class="alert alert-theme alert-warning alert-dismissible col-lg-6" role="alert">
                        <button class="close" type="button" data-dismiss="alert" aria-label="Close"><span class="s7-close"
                                                                                                          aria-hidden="true"></span>
                        </button>

                        <div class="row ml-3 mt-3">
                            <div class="icon" style="color: #575757">
                                <span class="s7-attention"></span>
                            </div>
                            <strong style="font-size:14px; color: #575757">Attention !</strong>
                        </div>

                        <div class="message">
                            <ul class="errors" role="alert" style="color: #575757">
                                <li>
                                    <g:message error="${flash.error}"/>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>

            </g:if>


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

            <div class="row justify-content-center m-3 noPrint" style="display: none" id="erreurCategoriePrix">
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
                                Veuillez sélectionner une catégorie de prix
                            </li>

                        </ul>

                    </div>
                </div>
            </div>


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

             <g:form resource="${this.devis}" method="PUT" enctype="multipart/form-data" autocomplete="off" onsubmit="submit.disabled = true; return true;">

                <g:hiddenField name="version" value="${this.devis?.version}" />
                <div class="noPrint m-3">
                    <g:render template="form" />
                </div>


                <div class="row justify-content-center m-6">

                    <div class="col-lg-8 print">

                        <g:render template="tableExcel"/>
                    </div>


                </div>


                <div class="row m-5 justify-content-end">
                    <button class="btn btn-space" type="submit" style="background-color: #1a9fdd; color: white" onclick="return validerDocumentWord()">
                        <i class="fa fa-chevron-right"></i>
                        Générer document
                    </button>
                </div>

            </g:form>

        </div>

        <input id="debloquerRemise" type="checkbox" ${this.devis.debloquerRemise ? 'checked=""' : ''} name="debloquerRemise" style="visibility: hidden">


    </div>



    <div class="modal fade show noPrint" id="md-default" tabindex="-1" role="dialog" aria-modal="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button class="close" type="button" data-dismiss="modal" aria-hidden="true"><span class="s7-close"></span></button>
                </div>
                <div class="modal-body">
                    <div class="text-center">
                        <div class="text-primary"><span class="modal-main-icon s7-attention"></span></div>
                        <h3 class="mb-4">Commentaires</h3>

                        <div class="form-group row mt-4 noPrint">
                            <div class="col-lg-12 mb-3">
                                <g:textArea disabled class="form-control" id="commentaireModal" name="notesTexte" rows="10" value="${this.devis?.notes}" />
                            </div>
                        </div>


                        <div class="mt-6">

                            <button class="btn btn-sm btn-space btn-primary" type="button" data-dismiss="modal">OK</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>






    <asset:javascript src="js/app-projetFonctionnes.js" />
    <asset:javascript src="js/app-devisCalcul.js" />

    <script>


        function validerDocumentWord() {
            try {


                var file = document.querySelector("input[id=document]").value;

                if (file == "") {

                    document.querySelector("div[id=erreurDocument]").style.display = "flex";
                    window.scrollTo({top: 0, behavior: 'smooth'});

                    return false;
                }


                if (document.querySelector("select[name=categoriePrix]").value == ""){

                    document.querySelector("div[id=erreurCategoriePrix]").style.display = "flex";
                    window.scrollTo({top: 0, behavior: 'smooth'});
                    return false;
                }


                return true;
            } catch (ex) {

            }

        }


        fitContent("commentaire");

        try {

            let valueAvoir = document.querySelector("input[id=avoirUtilise]").value;

            var select = document.querySelector("select[id=selectAvoirs]");

            if (valueAvoir !== null) {
                select.value = valueAvoir;

                document.querySelector("input[id=avoirExistant]").value = document.querySelector("input[id=avoirUtilise]").value

            }

        }catch (ex){

        }


        formatChamp("metreLineaire");
        formatChamp("agencementHT");
        formatChamp("remisePourcentage");
        formatChamp("prixPlanTravail");
        formatChamp("prixOption");

        obtenirPrixMin();
        obtenirPrixProjet();



    </script>

    </body>
</html>


