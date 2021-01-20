<%@ page import="java.text.DecimalFormat; mccorletagencement.ProjetComplementaire; org.springframework.security.core.context.SecurityContextHolder; mccorletagencement.Utilisateur; mccorletagencement.ProjetAutre; mccorletagencement.ProjetPlacard; mccorletagencement.ProjetDressing; mccorletagencement.ProjetSalleBain; mccorletagencement.ProjetCuisine" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />
    <g:set var="entityName" value="${message(code: 'factureClient.label', default: 'factureClient')}" />
    <title><g:message code="default.show.label" args="[entityName]" /></title>

    <style>



    #commentaire{

        background-color: white;
        font-size: 18px;
        color: #3e3e3e!important;
        border: 1px solid;

    }


    .custom-control .custom-control-label:after, .custom-control .custom-control-label:before {
        border: solid 1px;
    }


    .custom-control-label{
        color: #3e3e3e!important;
    }

    .custom-control-input:checked ~ .custom-control-label::after {
        color: #3e3e3e;
        background-color: white;
    }

    #accords{

        background-color: white;
        font-size: 18px;
        color: #3e3e3e!important;
        border: 1px solid;

    }


    @media print
    {

        body{
            height: 0px!important;
        }


        .navbar, .noPrint, .btn{
            display: none!important;
        }


        #card1, #card2{
            width: 50%!important;
            margin-right: -120px!important;
        }

    }


    .navbar{

        display: none;

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



    .card-img-bottom{
        width: 200px!important;
    }


    @media only screen and (min-width: 767px) {
        body {
            margin-top: 0px!important;
        }
    }

    @media only screen and (max-width: 767px) {
        body {
            margin-top: 0px!important;
        }
    }

    </style>

</head>
<body class="print">

<div class="card card-default card-table m-2">
    <div class="card card-header noPrint">
        <div class="row" style="color: rgba(0,0,0,0.7); vertical-align: middle">
            <div class="col-lg-12" style="font-size: 22px;">
                Facture Acquittée
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
                Ducos, le <g:formatDate date="${this.factureClient?.date}" format="dd MMMM yyyy" locale="fr"></g:formatDate>
            </p>

        </div>


        <div class="water-mark">
            ACQUITTEE
        </div>


        <div class="row ml-4 mr-4 mt-4 mb-0">

            <div class="card card-default">
                <div class="card-header card-header" style="color: #832e00; font-weight: bold; font-size: 28px!important;">
                    Facture Acquittée No.${this.factureClient?.devis.getProjet().idInsitu}
                </div>
                <div class="card-body">
                    <table class="no-border no-strip skills">
                        <tbody class="no-border-x no-border-y">
                        <tr style="color: #832e00; font-weight: bold;">
                            <td class="item">Désignation du produit: </td>
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
                            <td class="item">Décorateur concepteur: </td>
                            <td>
                                ${this.factureClient?.devis.getProjet().concepteur.prenom +" "+ this.factureClient?.devis.getProjet().concepteur.nom+" "}
                                <i class="fa fa-phone ml-3"></i>
                                ${this.factureClient?.devis.getProjet().concepteur.telephone}</td>
                        </tr>
                        </tbody>
                    </table>
                </div>

            </div>


        </div>


        <div class="row ml-5 font-weight-bold" style="font-size: 18px">
            Commentaires:

            <div class="col-lg-8 mb-5 mr-6 mt-2">
                <g:textArea disabled class="form-control"  id="commentaire" name="commentaire" value="${this.factureClient?.devis.commentaire}"></g:textArea>
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


        <div class="water-mark3">
            ACQUITTEE
        </div>


        <div class="row justify-content-center m-2 mb-4">

            <g:render template="tableExcelPrint"/>

        </div>

        <div class="pagebreak"></div>

        <div class="row justify-content-center m-2">
            <div class="col-lg-12 print">
                <g:render template="formPrint"/>
            </div>
        </div>



        <div class="pagebreak"> </div>


        <div class="row mt-6 mb-4 justify-content-center">

            <h1>PAIEMENTS REALISES</h1>

        </div>

        <div class="water-mark4">
            ACQUITTEE
        </div>

        <div class="row justify-content-center m-2 mb-6">

            <div class="col-lg-8 print">

                <table class="table">
                    <thead>
                    <tr>
                        <th style="font-weight:bold" scope="col">Date</th>
                        <th style="font-weight:bold" scope="col">Moyen de paiement</th>
                        <th style="font-weight:bold" scope="col">Montant réglé</th>
                    </tr>
                    </thead>
                    <tbody>


                    <g:each var="paiement" in="${factureClient?.paiements.sort{it.date}}">

                        <tr>
                            <td><g:formatDate  date="${paiement.date}" format="dd MMMM yyyy" locale="fr"/> </td>
                            <td>${paiement.moyen}</td>
                            <td>${new java.text.DecimalFormat("###,###.00 €").format(paiement.montant).replaceAll(",", " ")}</td>
                        </tr>


                        <g:if test="${paiement.multiple && paiement.encaissements.size() }">

                            <tr style="font-size: 10px">
                                <th colspan="2" style="border: none"></th>
                                <th class="paiementMultiple">Montant</th>
                                <th class="paiementMultiple">Date d'échéance</th>
                            </tr>

                            <g:each in="${paiement.encaissements.sort{it.id}}" var="encaissement" status="i" >

                                <tr style="font-size: 10px">
                                    <td colspan="2" style="border: none"></td>
                                    <td class="paiementMultiple">${new DecimalFormat("###,###.00 €").format(encaissement.montant).replaceAll(",", " ")}</td>
                                    <td class="paiementMultiple">
                                        <g:formatDate date="${encaissement.date}" format="dd MMMM yyyy" locale="fr"/>
                                        <g:if test="${encaissement.cestPaye()}">

                                            <i class="fa fa-check" style="color: darkgreen"></i>

                                        </g:if>

                                    </td>
                                </tr>
                            </g:each>


                        </g:if>


                    </g:each>

                    </tbody>
                </table>
            </div>

        </div>


        <div class="row justify-content-center m-2 mb-6">


            <table class="table-bordered col-lg-8">
                <thead>

                </thead>
                <tbody>
                <tr style="background-color: rgba(92,96,96,0.21); color: #bd4233">
                    <td colspan="2" class="font-weight-bold" style="font-size: 24px">Restant dû</td>
                    <td class="number font-weight-bold" style="font-size: 24px; text-align: center" >0.00 €</td>
                </tr>
                </tbody>
            </table>


        </div>



        <div class="row m-2 justify-content-end">


            <div class="card col-lg-6" id="card1" style="text-align: center">
                <div class="card-body">
                    <p class="card-text">Pour Martinique Cuisine:</p>
                    <p class="card-text">
                        ${factureClient.devis.projet.concepteur}
                    </p>
                </div>

                <div style="text-align: center; margin-right: 121px">
                    <g:if test="${factureClient.devis.projet.concepteur.signature}">
                        <asset:image width="300px" src="img/tampon.png" style="position: absolute; opacity: 70%;" />
                        <img id="sig-image" class="card-img-bottom" src="<g:createLink controller="utilisateur" action="showSignaturePermiteAll" params="[id:factureClient.devis.codeEmail]" />"/>
                    </g:if>
                </div>

            </div>


        </div>

        <div class="row m-5 justify-content-end noPrint">
            <div id="buttonImprimer">
                    <button class="btn btn-space btn-outline-secondary" type="button" onclick="window.print()">
                        <i class="fa fa-print"></i>
                        Imprimer
                    </button>
            </div>
        </div>





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
