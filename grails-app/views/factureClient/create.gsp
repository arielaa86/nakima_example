<%@ page import="mccorletagencement.ProjetComplementaire; mccorletagencement.ProjetAutre; mccorletagencement.ProjetPlacard; mccorletagencement.ProjetDressing; mccorletagencement.ProjetSalleBain; mccorletagencement.ProjetCuisine" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'factureClient.label', default: 'factureClient')}" />
        <title><g:message code="default.create.label" args="['bon de commande']" /></title>

        <style>



        input[type="number"]{
            text-align:right;

        }

        input[type="text"]{
            text-align:right;

        }


        #commentaire{

            background-color: white;
            font-size: 18px;
            color: #3e3e3e!important;
            border: 1px solid;

        }

        #buttons .btn{
            width: 160px;
        }


        @media print
        {

            body{
                height: 0px;
            }


            .navbar, .noPrint, .btn{
                display: none!important;
            }



        }



        table *{
            font-size: 18px;
        }


        .skills tr{
            line-height: 50px!important;
        }

        input{
            font-size: 18px!important;
            text-align: end;
        }


        .pagebreak { break-before: page; }


        #signature-pad{
            padding: 2px;
        }

        #signature-pad1{
            padding: 2px;
        }

            .signature-pad{
                border: 0px solid #e8e8e8;
                box-shadow: 0 1px 4px rgba(0, 0, 0, 0.27), 0 0 40px rgba(0, 0, 0, 0.08) inset;

            }

        </style>

    </head>
    <body class="print">



    <div class="card card-default card-table m-2">

        <div class="card card-header noPrint">
            <div class="row" style="color: rgba(0,0,0,0.7); vertical-align: middle">
                <div class="col-lg-12" style="font-size: 22px;">

                    <g:if test="${this.factureClient.devis.projet.instanceOf(ProjetComplementaire)}">
                        Créer bon de commande complémentaire
                    </g:if>
                    <g:else>
                        Créer bon de commande
                    </g:else>


                </div>
            </div>

            <hr>
        </div>
        <div class="card-body">


            <g:hasErrors bean="${this.factureClient}">
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
                                <g:eachError bean="${this.factureClient}" var="error">
                                    <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>>

                                        <g:message error="${error}"/>

                                    </li>
                                </g:eachError>
                            </ul>

                        </div>
                    </div>
                </div>

            </g:hasErrors>




            <div class="row m-4 justify-content-center">
                <asset:image src="img/logomccorlet.jpg" style="width: 40%"/>

                <p class="mt-4 ml-5" style="font-size: 16px">
                    Zac de Peters Maillet 97270 SAINT-ESPRIT <br>
                Téléphone 0596 70 41 31  - Télécopie 0596 56 69 97<br>
                SIRET : 818 034 829 00015 – APE 3102Z<br>
                </p>
            </div>


            <div class="row m-4 justify-content-end">
                <p class="mt-4 ml-5" style="font-size: 16px">
                    Ducos, le <g:formatDate date="${new Date()}" format="dd MMMM yyyy" locale="fr"></g:formatDate>
                </p>

            </div>


            <div class="row ml-4 mr-4 mt-4 mb-0">

                <div class="card card-default">
                    <div class="card-header card-header" style="color: #832e00; font-weight: bold; font-size: 28px!important;">


                        <g:if test="${this.factureClient?.devis.projet.instanceOf(ProjetComplementaire)}">
                            Bon de commande complémentaire No. ${this.factureClient?.devis.projet.idInsitu} <br> lié au Bon de commande No. ${this.factureClient?.devis.projet.projetPrincipal.idInsitu}
                        </g:if>
                        <g:else>
                            Bon de commande No. ${this.factureClient?.devis.projet.idInsitu}
                        </g:else>

                    </div>
                    <div class="card-body">
                        <table class="no-border no-strip skills">
                            <tbody class="no-border-x no-border-y">
                            <tr>
                                <td class="item" style="font-weight: bold;">Désignation du produit: </td>
                                <td>

                                    <g:if test="${this.factureClient?.devis.getProjet().instanceOf(ProjetCuisine)}">
                                        Cuisine
                                    </g:if>
                                    <g:if test="${this.factureClient?.devis.getProjet().instanceOf(ProjetSalleBain)}">
                                        Salle de bain
                                    </g:if>
                                    <g:if test="${this.factureClient?.devis.getProjet().instanceOf(ProjetDressing)}">
                                        Dressing
                                    </g:if>
                                    <g:if test="${this.factureClient?.devis.getProjet().instanceOf(ProjetPlacard)}">
                                        Placard
                                    </g:if>
                                    <g:if test="${this.factureClient?.devis.getProjet().instanceOf(ProjetAutre)}">
                                        ${this.factureClient?.devis.getProjet().typeProjet}
                                    </g:if>
                                    <g:if test="${this.factureClient?.devis.getProjet().instanceOf(ProjetComplementaire)}">
                                        ${this.factureClient?.devis.getProjet().description}
                                    </g:if>

                                </td>
                            </tr>
                            <tr>
                                <td class="item"> Au nom de: </td>
                                <td>
                                    ${this.factureClient?.devis.projet.client.intitule + " "+ this.factureClient?.devis.projet.client.prenom + " "+ this.factureClient?.devis.projet.client.nom}
                                </td>
                            </tr>
                            <tr>
                                <td class="item">Adresse de livraison: </td>
                                <td>
                                    ${this.factureClient?.devis.getProjet().client.adresse +"  "+this.factureClient?.devis.getProjet().client.codePostal+" "+this.factureClient?.devis.getProjet().client.ville}
                                </td>
                            </tr>
                            <tr>
                                <td class="item">Décorateur concepteur:</td>
                                <td>
                                    ${this.factureClient.devis.creePar}
                                    <i class="fa fa-phone ml-3"></i>
                                    ${this.factureClient.devis.creePar.telephone}
                                </td>
                            </tr>

                            <g:if test="${this.factureClient.devis.getLastUser() != this.factureClient.devis.projet.concepteur}">
                                <tr style="color:#832e00">
                                    <td class="item">Transféré à:</td>
                                    <td>
                                        ${this.factureClient.devis.getLastUser()}
                                        <i class="fa fa-phone ml-3"></i>
                                        ${this.factureClient.devis.getLastUser().telephone}
                                    </td>
                                </tr>
                            </g:if>
                            </tbody>
                        </table>
                    </div>

                </div>


            </div>


            <div class="row ml-5 font-weight-bold" style="font-size: 18px">
                Commentaires:

                <div class="col-lg-8 mb-5 mr-6 mt-2">
                    <g:textArea style="line-height: 1.5" disabled class="form-control"  id="commentaire" name="commentaire" value="${this.factureClient?.devis.commentaire}"></g:textArea>
                </div>
            </div>



            <div class="row m-2 justify-content-center">
                <table class="table table-responsive-sm table-bordered col-lg-8">
                    <thead>
                    <th>No.</th>
                    <th>Référence</th>
                    <th>F.</th>
                    <th>Descriptif</th>
                    <th>L</th>
                    <th>P</th>
                    <th>H</th>
                    <th>Qté</th>
                    </thead>
                    <tbody>

                    <g:each in="${references}" var="reference">
                        <tr>
                            <td>
                                ${reference.nombre}
                            </td>
                            <td>
                                ${reference.reference}
                            </td>
                            <td>
                                ${reference.colonneF}
                            </td>
                            <td>
                                ${reference.descriptif}
                            </td>
                            <td>
                                ${reference.longueur}
                            </td>
                            <td>
                                ${reference.profondeur}
                            </td>
                            <td>
                                ${reference.hauteur}
                            </td>
                            <td>
                                ${reference.quantite}
                            </td>



                        </tr>
                    </g:each>
                    </tbody>
                </table>

            </div>


            <div class="pagebreak"> </div>


            <div class="row mt-6 justify-content-center">

                <h1>DETAIL DU PRIX DU PROJET</h1>

            </div>





                <div class="row justify-content-center m-2 mb-6">


                          <g:render template="tableExcelPrint"/>

                </div>



            <g:form resource="${this.factureClient}" method="POST" enctype="multipart/form-data" autocomplete="off" onsubmit="submit.disabled = true; return true;">

                <div class="row justify-content-center m-2">
                   <div class="col-lg-12 print">
                    <g:render template="form"/>
                   </div>
                </div>



                <div class="row m-5 justify-content-end" id="buttons">
                    <button class="btn btn-space" type="submit" style="background-color: #1a9fdd; color: white" id="submit">
                        <i class="fa fa-chevron-right"></i>
                        Continuer
                    </button>
                </div>

            </g:form>

        </div>
    </div>


    <asset:javascript src="js/app-projetFonctionnes.js" />
    <asset:javascript src="js/app-devisCalculShow.js"/>

    <script>

       fitContent("commentaire");
       obtenirPrixMin();
       obtenirPrixProjet();



    </script>

    </body>
</html>
