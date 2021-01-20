<%@ page import="java.text.SimpleDateFormat; mccorletagencement.Etape; mccorletagencement.ProjetComplementaire; mccorletagencement.Role; org.springframework.security.core.context.SecurityContextHolder; mccorletagencement.Utilisateur; mccorletagencement.ProjetAutre; mccorletagencement.ProjetPlacard; mccorletagencement.ProjetDressing; mccorletagencement.ProjetSalleBain; mccorletagencement.ProjetCuisine" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'ordreProduction.label', default: 'ordreProduction')}"/>
    <title><g:message code="default.show.label" args="['ordre de production']"/></title>



    <style>

    .month span {
        font-weight: bold !important;
    }

    .card-table tr th:last-child, .card-table tr td:last-child {
        padding-right: 8px !important;
    }

    .card-table tr th:first-child, .card-table tr td:first-child {
        padding-left: 8px;
    }

    .datepicker table th {

        font-weight: bold !important;
    }

    .datepicker table tr td {
        padding: 0 8px;
        line-height: 1.3;
        height: 28px;
        width: 28px;
    }

    .datepicker table * {
        font-size: 14px !important;
    }


    .btn-outline-secondary, .myButton {

        width: 200px !important;
    }

    .timeline-date, .timeline-time {
        font-size: 14px !important;
    }

    .timeline-item:before {
        border: 2px solid #ffffff !important;
        width: 22px !important;
        height: 22px !important;
        top: 31px !important;
        left: 99px !important;
    }

    .timeline-item.active:before {
        border: 11px solid #fa6163 !important;
        width: 22px !important;
        height: 22px !important;
        top: 31px !important;
        left: 99px !important;

    }

    .timeline-content {
        background-color: #eae9e9 !important;
    }

    .timeline-content:before {
        background-color: #eae9e9 !important;
    }

    .timeline-content:not(.active) {
        color: #b5b5b5 !important;
    }

    .timeline-content:not(.active) p {
        color: #b5b5b5 !important;
    }


    .timeline-content.active {
        background-color: #ffffff !important;
    }

    .timeline-content.active:before {
        background-color: #ffffff !important;
    }

    @media only screen and (min-width: 600px) {

        .timeline-date {
            margin-left: 5px !important;
            text-align: right;
            left: -60px !important;
            top: 32px !important;
            width: 150px !important;
        }

    }


    input[type="number"] {
        text-align: right;

    }

    input[type="text"] {
        text-align: right;

    }

    .item {
        font-weight: bold;
    }

    #buttonSigner .btn {
        width: 160px;
    }


    #buttonImprimer .btn {
        width: 180px;
    }


    #commentaire {

        background-color: white;
        font-size: 18px;
        color: #3e3e3e !important;
        border: 1px solid;

    }


    .custom-control .custom-control-label:after, .custom-control .custom-control-label:before {
        border: solid 1px;
    }


    .custom-control-label {
        color: #3e3e3e !important;
    }

    .custom-control-input:checked ~ .custom-control-label::after {
        color: #3e3e3e;
        background-color: white;
    }

    #accords {

        background-color: white;
        font-size: 18px;
        color: #3e3e3e !important;
        border: 1px solid;

    }

    .gallery-container .item {

        min-height: 230px !important;
        max-height: 230px !important;

    }

    .imagen {

        min-height: 230px !important;
        max-height: 230px !important;
        object-fit: cover;
    }

    .imagen2 {

        min-height: 230px !important;
        max-height: 230px !important;
        object-fit: cover;
    }

    @page {
        margin: 2cm
    }


    @media print {

        body {
            height: 0px !important;
        }


        #signatureFooter {
            margin-bottom: 0px !important;
        }

        .navbar, .noPrint, .btn {
            height: 0px !important;
            display: none !important;

        }


        #card1, #card2 {
            width: 50% !important;
        }

        noPrint {
            height: 0px !important;
        }


        #commentairesPourTechnicien {
            color: #ef4343;
            font-weight: bold;

        }


    }


    .signature {
        mix-blend-mode: multiply;
        position: absolute;
        right: 50px;
        bottom: 60px;
        width: 200px !important
    }


    table * {
        font-size: 18px;
    }


    .skills tr {
        line-height: 50px !important;
    }

    input {
        font-size: 18px !important;
        text-align: end;
    }


    .pagebreak {
        break-before: page;
    }


    #signature-pad {
        padding: 2px;
    }

    #signature-pad1 {
        padding: 2px;
    }

    .signature-pad {
        border: 0px solid #e8e8e8;
        box-shadow: 0 1px 4px rgba(0, 0, 0, 0.27), 0 0 40px rgba(0, 0, 0, 0.08) inset;

    }


    .card-img-bottom {
        width: 200px !important;
    }

    </style>

</head>

<body>

<div class="card card-default card-table m-2">

    <div class="card card-header noPrint">
        <div class="row" style="color: rgba(0,0,0,0.7); vertical-align: middle">
            <div class="col-lg-12" style="font-size: 22px;">
                Détails de l'ordre de production No. ${this.factureClient.devis.getProjet()?.idInsitu}
            </div>
        </div>
        <hr>
    </div>


    <div class="card-body" id="cardBody">

        <g:hasErrors bean="${this.factureClient}">
            <div class="row justify-content-center m-3">
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
                Ducos, le <g:formatDate date="${this.factureClient?.ordreProduction.date}" format="dd MMMM yyyy"
                                        locale="fr"></g:formatDate>
            </p>

        </div>


        <div class="row ml-4 mr-4 mt-4 mb-0">

            <div class="card card-default">
                <div class="card-header card-header"
                     style="color: #832e00; font-weight: bold; font-size: 28px!important;">

                    Ordre de Production No. ${this.factureClient.devis.getProjet()?.idInsitu}

                </div>

                <div class="card-body">
                    <table class="no-border no-strip skills">
                        <tbody class="no-border-x no-border-y">
                        <tr>
                            <g:if test="${this.factureClient.devis.montant > 0}">
                                <td class="item">Désignation du produit:</td>
                            </g:if>
                            <g:else>
                                <td class="item">Description:</td>
                            </g:else>
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


                        <g:if test="${this.factureClient.ordreProduction.anonyme && user.authorities.contains(Role.findByAuthority("ROLE_TECHNICIEN"))}">
                            <tr>
                                <td class="item">Au nom de:</td>
                                <td>

                                    anonyme
                                    <i class="fa fa-phone ml-3"></i>
                                    anonyme

                                </td>
                            </tr>
                            <g:if test="${this.factureClient.devis.montant > 0}">
                                <tr>

                                    <td class="item">Adresse de livraison:</td>
                                    <td>
                                        anonyme
                                    </td>
                                </tr>
                            </g:if>

                        </g:if>
                        <g:else>

                            <tr>
                                <td class="item">Au nom de:</td>
                                <td>

                                    ${this.factureClient?.devis.projet.client}
                                    <i class="fa fa-phone ml-3"></i>
                                    ${this.factureClient?.devis.projet.client.telephone + (this.factureClient?.devis.projet.client.telephoneFixe != null ? " / " + this.factureClient?.devis.projet.client.telephoneFixe : "")}

                                </td>
                            </tr>
                            <g:if test="${this.factureClient.devis.montant > 0}">
                                <tr>

                                    <td class="item">Adresse de livraison:</td>
                                    <td>
                                        ${this.factureClient?.devis.getProjet().client.adresse + "  " + this.factureClient?.devis.getProjet().client.codePostal + " " + this.factureClient?.devis.getProjet().client.ville}
                                    </td>
                                </tr>
                            </g:if>

                        </g:else>

                        <tr>
                            <td class="item">Décorateur concepteur:</td>
                            <td>
                                ${this.factureClient?.devis.getProjet().concepteur.prenom + " " + this.factureClient?.devis.getProjet().concepteur.nom + " "}
                                <i class="fa fa-phone ml-3"></i>
                                ${this.factureClient?.devis.getProjet().concepteur.telephone}</td>
                        </tr>
                        </tbody>
                    </table>
                </div>

            </div>

        </div>

        <div class="row ml-5 font-weight-bold justify-content-start" style="font-size: 18px">
            Commentaires:
        </div>


        <div class="row ml-5 font-weight-bold justify-content-center" style="font-size: 18px">

            <div class="col-lg-8 mb-5 mr-6 mt-2">

                <g:textArea disabled class="form-control" id="commentaire" name="commentaire"
                            value="${this.factureClient?.devis.commentaire}">
                </g:textArea>
            </div>
        </div>

        <div class="row m-2 font-weight-bold justify-content-center mb-6">

            <div class="col-lg-8">
                <g:textArea disabled class="form-control btn-primary" id="commentairesPourTechnicien"
                            name="commentairesPourTechnicien" rows="20"
                            style="font-size: 18px!important;"
                            value="${this.factureClient?.ordreProduction.commentairesPourTechnicien}"></g:textArea>
            </div>
        </div>


        <div class="row m-2 justify-content-center mb-6">

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


        <g:set var="user"
               value="${Utilisateur.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName())}"></g:set>



        <div class="pagebreak"></div>


        <div class="row justify-content-center m-2">
            <div class="col-lg-12 print">
                <g:render template="formPrint"/>
            </div>
        </div>


        <div class="row m-2 justify-content-center" id="signatureFooter">

            <div class="card col-lg-6" id="card1" style="text-align: center">
                <div class="card-body">
                    <p class="card-text">Signature du Commercial</p>
                </div>

                <g:if test="${user.authorities.contains(Role.findByAuthority("ROLE_DIRECTEUR"))}">

                    <div style="text-align: center" id="signaturesViewDirecteur">
                        <g:if test="${this.factureClient.signatureDirecteur}">
                            <asset:image width="300px" src="img/tampon.png" style="position: absolute; opacity: 70%;"/>
                            <img id="sig-image" class="card-img-bottom"
                                 src="<g:createLink controller="factureClient" action="showSignatureDirecteur"
                                                    params="[id: factureClient.id]"/>"/>
                        </g:if>
                        <g:else>
                            <g:if test="${this.factureClient.devis.projet.concepteur.signature && this.factureClient.signatureClient}">
                                <asset:image width="300px" src="img/tampon.png"
                                             style="position: absolute; opacity: 70%;"/>
                                <img id="sig-image" class="card-img-bottom"
                                     src="<g:createLink controller="factureClient" action="showSignatureCommercial"
                                                        params="[id: factureClient.id]"/>"/>
                            </g:if>
                        </g:else>
                    </div>

                </g:if>
                <g:else>

                    <div style="text-align: center">
                        <g:if test="${this.factureClient.signePar.signature}">

                            <asset:image width="300px" src="img/tampon.png" style="position: absolute; opacity: 70%;"/>
                            <img id="sig-image" class="card-img-bottom"
                                 src="<g:createLink controller="utilisateur" action="showSignature"
                                                    params="[id: this.factureClient.signePar.id]"/>"/>
                        </g:if>
                    </div>

                </g:else>

            </div>

            <div class="card col-lg-6" id="card2" style="text-align: center">
                <div class="card-body">
                    <p class="card-text">Signature du Client
                        <br>
                        "Bon pour accord, lu et approuvé"
                    </p>

                    <div style="text-align: center" id="signaturesView">
                        <g:if test="${this.factureClient.signatureClient}">
                            <img id="sig-image1" class="card-img-bottom"
                                 src="<g:createLink controller="factureClient" action="showSignatureClient"
                                                    params="[id: factureClient.id]"/>"/>
                        </g:if>
                    </div>
                </div>

            </div>

        </div>


        <div class="row gallery-container m-4 noPrint">
            <g:each var="planInstance" in="${this.factureClient?.devis.projet.getPlans().sort { it.date }}">
                <div class="item col-lg-4 noPrint">
                    <div class="photo">
                        <div class="img">

                            <g:if test="${planInstance.getDocumentType().equals("pdf")}">

                                <img class="imagen" src="<g:createLink controller="plan" action="showPlanPDF"
                                                                       params="[id: planInstance.getId()]"/>" alt="...">

                            </g:if>
                            <g:else>

                                <img class="imagen" src="<g:createLink controller="plan" action="showPlan"
                                                                       params="[id: planInstance.getId()]"/>" alt="...">

                            </g:else>

                            <div class="over">
                                <div class="info-wrapper">
                                    <div class="info">

                                        <div class="description">Ajouté le:
                                            <g:formatDate format="EE dd-MM-yyyy HH:mm" locale="fr"
                                                          date="${planInstance.date}"/></div>

                                        <g:form name="deleteForm" resource="${planInstance}" controller="plan"
                                                action="delete"
                                                method="DELETE"
                                                onsubmit="submit.disabled = true; return true;">
                                            <g:hiddenField name="id" value="${planInstance.id}"/>

                                            <div class="func">
                                                <a href="#" data-toggle="modal"
                                                   data-target="${"#md-fullWidth" + planInstance.id}"><i
                                                        class="icon s7-search"></i></a>
                                            </div>

                                            <button style="display: none" type="submit"
                                                    id="${"buttonDelete" + planInstance.id}"/>

                                        </g:form>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="modal fade" id="${"md-fullWidth" + planInstance.getId()}" tabindex="-1" role="dialog">
                    <div class="modal-dialog full-width" id="printThis">
                        <div class="modal-content">
                            <div class="fmodal-header d-flex flex-row justify-content-end">

                                <g:if test="${!planInstance.getDocumentType().equals("pdf")}">
                                    <a class="close m-4" type="button" target="_blank"
                                       href="<g:createLink controller="factureClient" action="printImage"
                                                           params="[id: planInstance.getId()]"/>"
                                       onclick="$('#close${planInstance.getId()}').click();">
                                        <span class="s7-print"></span>
                                    </a>
                                </g:if>

                                <button id="close${planInstance.getId()}" class="close m-4" type="button"
                                        data-dismiss="modal"
                                        aria-hidden="true"><span
                                        class="s7-close"></span></button>
                            </div>

                            <div class="modal-body">

                                <g:if test="${planInstance.getDocumentType().equals("pdf")}">

                                    <object width="100%" height="960px"
                                            data="<g:createLink controller="plan" action="showPlan"
                                                                params="[id: planInstance.getId()]"/>?#zoom=150"
                                            trusted="yes" application="yes">
                                    </object>

                                </g:if>
                                <g:else>

                                    <div>

                                        <img class="card-img-top print"
                                             src="<g:createLink controller="plan" action="showPlan"
                                                                params="[id: planInstance.getId()]"/>">

                                        <g:if test="${this.factureClient.signatureClient}">

                                            <img class="signature" src="<g:createLink controller="factureClient"
                                                                                      action="showSignatureClient"
                                                                                      params="[id: factureClient.id]"/>"/>

                                        </g:if>
                                    </div>

                                </g:else>

                            </div>
                        </div>
                    </div>
                </div>

            </g:each>
        </div>


        <div class="row m-5 justify-content-end noPrint">

            <button class="btn btn-space btn-outline-secondary" type="button" onclick="window.print()">
                <i class="fa fa-print"></i>
                Imprimer
            </button>

            <g:if test="${!user.authorities.contains(Role.findByAuthority("ROLE_TECHNICIEN"))}">
                <g:link class="btn btn-space btn-success myButton" controller="paiement" action="create"
                        params="['facture.id': factureClient.id]">
                    <i class="fa fa-credit-card"></i>
                    Paiements
                </g:link>

            </g:if>


            <g:if test="${this.factureClient.signatureClient}">

                <button id="listeEtapes" class="btn btn-space btn-outline-secondary" type="button" data-toggle="modal"
                        data-target="#ordreProductionEtapes">
                    <i class="fa fa-wrench"></i>
                    Etapes de production
                </button>

            </g:if>



            <div id="buttonImprimer">

                <g:if test="${this.factureClient.signatureClient}">

                    <button class="btn btn-space btn-outline-secondary" type="button" data-toggle="modal"
                            data-target="#corrections${this.factureClient.ordreProduction.id}">
                        <i class="fa fa-object-ungroup"></i>
                        ${!user.authorities.contains(Role.findByAuthority("ROLE_COMMERCIAL")) ? 'Signaler une correction' : 'Voir les corrections'}
                    </button>

                </g:if>
            </div>


            <g:if test="${this.factureClient.ordreProduction.photoPose == null}">
                <g:link target="_blank" class="btn btn-space btn-outline-secondary"
                        controller="pose" action="formPrint" params="[id: this.factureClient.ordreProduction.id]">
                    <i class="fa fa-file-powerpoint-o"></i>
                    Générer formulaire de pose
                </g:link>


                <g:if test="${!user.authorities.contains(Role.findByAuthority("ROLE_TECHNICIEN")) && this.factureClient.ordreProduction.livraison}">
                    <g:link controller="pose" action="details" id="${this.factureClient.ordreProduction.id}"
                            class="btn btn-space btn-outline-secondary">
                        <i class="fa fa-download"></i>
                        Ajouter formulaire de pose
                    </g:link>
                </g:if>

            </g:if>

            <g:if test="${this.factureClient.photoDecharge != null}">

                <button class="btn btn-space btn-outline-secondary" data-toggle="modal" data-target="#viewDecharge">
                    <i class="fa fa-ban"></i>
                    Décharge de responsabilité
                </button>


                <div class="modal fade" id="viewDecharge" tabindex="-1" role="dialog">
                    <div class="modal-dialog full-width">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button class="close" type="button"
                                        data-dismiss="modal"
                                        aria-hidden="true"><span
                                        class="s7-close"></span></button>
                            </div>

                            <div class="modal-body justify-content-center">
                                <div class="row justify-content-center">
                                    <div class="col-lg-8">

                                        <g:if test="${this.factureClient.documentType.equals("pdf")}">

                                            <object width="100%" height="700px" type="application/pdf"
                                                    data="<g:createLink controller="factureClient" action="showDecharge"
                                                                        params="[id: this.factureClient.id]"/>"
                                                    trusted="yes"
                                                    application="yes">
                                            </object>

                                        </g:if>
                                        <g:else>

                                            <div class="row justify-content-center">

                                                <img width="100%"
                                                     src="<g:createLink controller="factureClient" action="showDecharge"
                                                                        params="[id: this.factureClient.id]"/>">

                                            </div>

                                        </g:else>

                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>

            </g:if>

        </div>

    </div>


    <div class="modal fade noPrint" id="ordreProductionEtapes" tabindex="-1" role="dialog">
        <div class="modal-dialog full-width">
            <div class="modal-content">
                <div class="modal-header d-flex justify-content-between">
                    <div style="font-size: 20px; margin-top: 30px">
                        <g:set var="projet" value="${this.factureClient.devis.projet}"/>

                        Ordre de Production No. ${projet?.idInsitu} -

                        ${projet.getType()}
                        -
                        <g:if test="${this.factureClient.ordreProduction.anonyme && user.authorities.contains(Role.findByAuthority("ROLE_TECHNICIEN"))}">
                            anonyme
                        </g:if>
                        <g:else>
                            ${this.factureClient.devis.getProjet().client}
                        </g:else>
                    </div>
                    <button class="close m-4" type="button"
                            data-dismiss="modal"
                            aria-hidden="true"><span
                            class="s7-close"></span></button>
                </div>


                <div class="modal-body" style="background-color: lightgray; font-size: 18px;">

                    <div class="row">
                        <div class="col-12">

                            <ul class="timeline" id="etatsProduction">

                                <g:render template="showEtatProduction"
                                          model="[etatsProduction: this.factureClient.ordreProduction.getEtats()]"/>

                            </ul>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>


    <div class="modal fade noPrint" id="corrections${this.factureClient.ordreProduction.id}" tabindex="-1"
         role="dialog">
        <div class="modal-dialog full-width" id="lolo">
            <div class="modal-content">
                <div class="modal-header d-flex justify-content-between">
                    <div style="font-size: 20px; margin-top: 30px">
                        <g:set var="projet" value="${this.factureClient.devis.projet}"/>

                        Corrections de l'ordre de production No. ${projet?.idInsitu} -
                        ${projet.getType()}
                        -
                        <g:if test="${this.factureClient.ordreProduction.anonyme && user.authorities.contains(Role.findByAuthority("ROLE_TECHNICIEN"))}">
                            anonyme
                        </g:if>
                        <g:else>
                            ${this.factureClient.devis.getProjet().client}
                        </g:else>

                    </div>
                    <button class="close m-4" type="button"
                            data-dismiss="modal"
                            aria-hidden="true"><span
                            class="s7-close"></span></button>
                </div>


                <div class="modal-body">

                    <div class="row">

                        <g:if test="${!user.authorities.contains(Role.findByAuthority("ROLE_COMMERCIAL")) && !this.factureClient.ordreProduction.livre}">

                            <div class="col-lg-3">

                                <form id="correction-form" enctype="multipart/form-data">

                                    <g:hiddenField name="factureId" value="${this.factureClient.id}"/>

                                    <div class="form-group" id="pieceJointe" style="display: inline">
                                        <label>Télécharger pièce jointe</label>

                                        <div>
                                            <input class="inputfile" type="file" name="document" id="file-1"
                                                   data-multiple-caption="{count} fichiers sélectionnés" multiple>
                                            <label class="btn btn-secondary" style="min-width: 100%" for="file-1"><i
                                                    class="icon s7-upload"></i><span id="parcourir">Parcourir...</span>
                                            </label>
                                        </div>
                                        <small id="fileMissing" class="form-text text-muted mb-3"
                                               style="color: #f94735!important; display: none">Veuillez ajouter la pièce jointe</small>
                                    </div>


                                    <div class="form-group">
                                        <label>Commentaires:</label>
                                        <textarea required class="form-control" rows="15" name="description"></textarea>
                                    </div>


                                    <div class="form-group mt-6 mb-lg-0 mb-md-6 mb-sm-6"
                                         style="text-align: right!important;">
                                        <button type="submit" class="btn btn-success"
                                                onclick="saveCorrection()" id="buttonSubmit">
                                            <i class="fa fa-check"></i> Sauvegarder
                                        </button>
                                    </div>

                                </form>

                            </div>

                        </g:if>

                        <div class="${!user.authorities.contains(Role.findByAuthority("ROLE_COMMERCIAL")) && !this.factureClient.ordreProduction.livre ? 'col-lg-8' : 'col-lg-12'}"
                             style="${!user.authorities.contains(Role.findByAuthority("ROLE_COMMERCIAL")) && !this.factureClient.ordreProduction.livre ? 'border-left: 1px solid #e9e7e7' : ''}">

                            <g:render template="listeCorrections" model="[corrections: corrections, user: user]"/>

                        </div>

                    </div>

                </div>
            </div>
        </div>
    </div>


    <div class="modal fade noPrint" id="myModal2" tabindex="-1" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header d-flex justify-content-end">
                    <button class="close buttonClose" type="button"
                            onclick="document.querySelector('input[name=date]').value = '${new SimpleDateFormat("dd MMMM yyyy", Locale.FRANCE).format(new Date())}'"
                            data-dismiss="modal"
                            aria-hidden="true"><span
                            class="s7-close"></span></button>
                </div>

                <div class="modal-body" style="height: 420px">

                    <div class="row justify-content-center">
                        <h4>Renseigner la date de livraison</h4>
                    </div>


                    <div class="row m-4 justify-content-center">
                        <div id="month" class="col-lg-8">
                            <div id="datePicker" class="input-group">
                                <input type="text" name="date" class="form-control" id="date"
                                       aria-describedby="btnGroupAddon"
                                       value="${new SimpleDateFormat("dd MMMM yyyy", Locale.FRANCE).format(new Date())}"
                                       autocomplete="off"
                                       style="font-size: 14px!important; text-align: left">

                                <div id="dateIcon"
                                     style="position: relative; top: 8px!important; right: 25px; font-size: 15px;">
                                    <i class="fa fa-calendar-o"></i>
                                </div>
                            </div>

                        </div>

                        <div class="col-lg-4">
                            <button class="btn btn-success" onclick="saveDateDelivery()"><i
                                    class="fa fa-save"></i> Enregistrer</button>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>


    <div class="modal fade noPrint" id="myModal3" tabindex="-1" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header d-flex justify-content-end">
                    <button class="close buttonClose" type="button"
                            onclick="document.querySelector('input[name=date]').value = '${new SimpleDateFormat("dd MMMM yyyy", Locale.FRANCE).format(new Date())}'"
                            data-dismiss="modal"
                            aria-hidden="true"><span
                            class="s7-close"></span></button>
                </div>

                <div class="modal-body" style="height: 420px">

                    <div class="row justify-content-center">
                        <h4>Renseigner la date de la vérification</h4>
                    </div>


                    <div class="row m-4 justify-content-center">
                        <div id="month2" class="col-lg-8">
                            <div id="datePicker2" class="input-group">
                                <input type="text" name="date2" class="form-control" id="date2"
                                       aria-describedby="btnGroupAddon"
                                       value="${new SimpleDateFormat("dd MMMM yyyy", Locale.FRANCE).format(new Date())}"
                                       autocomplete="off"
                                       style="font-size: 14px!important; text-align: left">

                                <div id="dateIcon2"
                                     style="position: relative; top: 8px!important; right: 25px; font-size: 15px;">
                                    <i class="fa fa-calendar-o"></i>
                                </div>
                            </div>

                        </div>

                        <div class="col-lg-4">
                            <button class="btn btn-success" onclick="saveDateVerification()"><i
                                    class="fa fa-save"></i> Enregistrer</button>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>



    <g:hiddenField name="ordreId" value="${this.factureClient.ordreProduction.id}"/>


    <asset:javascript src="lib/jquery/jquery.min.js"/>
    <asset:javascript src="lib/sweetalert2/sweetalert2.min.js"/>
    <asset:javascript src="js/app-ui-sweetalert2.js"/>
    <asset:javascript src="js/app-projetFonctionnes.js"/>
    <asset:javascript src="js/app-devisCalcul.js"/>



    <asset:javascript src="lib/datepicker/js/bootstrap-datepicker.js"/>
    <asset:javascript src="lib/datepicker/locales/bootstrap-datepicker.fr.min.js"/>

    <asset:javascript src="ordreProduction/actions.js"/>

    <script>

        var picker = $('#date').datepicker({
            container: '#datePicker',
            format: "dd MM yyyy",
            startView: "days",
            minViewMode: "days",
            language: 'fr-FR'

        }).on('changeDate', function (ev) {

        });


        var picker2 = $('#date2').datepicker({
            container: '#datePicker2',
            format: "dd MM yyyy",
            startView: "days",
            minViewMode: "days",
            language: 'fr-FR'

        }).on('changeDateVerification', function (ev) {

        });


        fitContent("commentaire");
        obtenirPrixMin();
        obtenirPrixProjet();


        function printDiv(divId) {
            var printContents = document.getElementById(divId).innerHTML;
            var originalContents = document.body.innerHTML;

            document.body.innerHTML = printContents;

            window.print();

            document.body.innerHTML = originalContents;

        }

    </script>

</body>
</html>
