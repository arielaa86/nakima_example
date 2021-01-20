<%@ page import="mccorletagencement.Devis; mccorletagencement.ProjetComplementaire; mccorletagencement.Role; org.springframework.security.core.context.SecurityContextHolder; mccorletagencement.Utilisateur; mccorletagencement.ProjetAutre; mccorletagencement.ProjetPlacard; mccorletagencement.ProjetDressing; mccorletagencement.ProjetSalleBain; mccorletagencement.ProjetCuisine" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'factureClient.label', default: 'factureClient')}"/>
    <title><g:message code="default.show.label" args="['bon de commande']"/></title>



    <style>


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

                <g:if test="${this.factureClient.devis.montant > 0 && this.factureClient.devis.getProjet().instanceOf(ProjetComplementaire)}">
                    Détails du bon de commande complémentaire No. ${this.factureClient.devis.getProjet()?.idInsitu}
                </g:if>
                <g:else>

                    <g:if test="${this.factureClient.devis.montant < 0 && this.factureClient.devis.getProjet().instanceOf(ProjetComplementaire)}">
                        Détails de l'Avoir No. ${this.factureClient.devis.getProjet()?.idInsitu}
                    </g:if>
                    <g:else>
                        Détails du bon de commande No. ${this.factureClient.devis.getProjet()?.idInsitu}
                    </g:else>

                </g:else>

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
                Ducos, le <g:formatDate date="${this.factureClient?.date}" format="dd MMMM yyyy"
                                        locale="fr"></g:formatDate>
            </p>
        </div>

        <g:if test="${this.factureClient.devis.montant < 0 && this.factureClient.devis.visible == false}">
            <div class="water-mark-avoir">
                UTILISE
            </div>
        </g:if>


        <div class="row ml-4 mr-4 mt-4 mb-0">

            <div class="card card-default">
                <div class="card-header card-header"
                     style="color: #832e00; font-weight: bold; font-size: 28px!important;">

                    <g:if test="${this.factureClient.devis.montant > 0 && this.factureClient.devis.getProjet().instanceOf(ProjetComplementaire)}">
                        Bon de commande complémentaire No. ${this.factureClient.devis.getProjet()?.idInsitu} <br> lié au bon de commande No. ${this.factureClient.devis.getProjet().projetPrincipal.idInsitu}
                    </g:if>
                    <g:else>

                        <g:if test="${this.factureClient.devis.montant < 0 && this.factureClient.devis.getProjet().instanceOf(ProjetComplementaire)}">
                            Avoir No.
                            ${this.factureClient.devis.getProjet()?.idInsitu}
                            <br>
                            ${ Devis.findByAvoirUtilise(this.factureClient.devis.id)?.avoirUtilise == null ?
                            'lié au bon de commande No. '+ this.factureClient.devis.getProjet().projetPrincipal.idInsitu :
                                    'utilisé dans le bon de commande No. ' + Devis.findByAvoirUtilise(this.factureClient.devis.id).projet.idInsitu}

                        </g:if>
                        <g:else>
                            Bon de commande No. ${this.factureClient.devis.getProjet()?.idInsitu}
                        </g:else>

                    </g:else>

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
                        <tr>
                            <td class="item">Décorateur concepteur:</td>
                            <td>
                                ${this.factureClient.signePar}
                                <i class="fa fa-phone ml-3"></i>
                                ${this.factureClient.signePar.telephone}
                            </td>
                        </tr>

                        <g:if test="${this.factureClient.devis.getLastUser() != this.factureClient.signePar}">
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
                <g:textArea disabled class="form-control" id="commentaire" name="commentaire"
                            value="${this.factureClient?.devis.commentaire}"></g:textArea>
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


        <g:set var="user"
               value="${Utilisateur.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName())}"></g:set>



        <g:if test="${user.authorities.contains(Role.findByAuthority("ROLE_DIRECTEUR")) || user.authorities.contains(Role.findByAuthority("ROLE_COMMERCIAL"))}">

            <div class="pagebreak"></div>


            <div class="row mt-6 justify-content-center">

                <g:if test="${this.factureClient.devis.montant >= 0}">
                    <h2>DETAIL DU PRIX DU PROJET</h2>
                </g:if>
                <g:else>
                    <h2>DETAIL DE L'AVOIR</h2>

                    <g:if test="${this.factureClient.devis.montant < 0 && this.factureClient.devis.visible == false}">
                        <div class="water-mark-avoir2">
                            UTILISE
                        </div>
                    </g:if>

                </g:else>

            </div>


            <div class="row justify-content-center m-2 mb-4">

                <g:render template="tableExcelPrint"/>

            </div>

        </g:if>


        <g:if test="${this.factureClient.devis.montant >= 0}">
            <div class="pagebreak"></div>


            <div class="row justify-content-center m-2">
                <div class="col-lg-12 print">
                    <g:render template="formPrint"/>
                </div>
            </div>
        </g:if>
        <g:else>

            <div class="row justify-content-center m-4">
                <div class="col-lg-8 font-weight-bold">
                    <p>Cet avoir est valable jusqu'au <g:formatDate date="${this.factureClient.dateValiditeAvoir}"
                                                                    format="dd MMMM yyyy" locale="fr"/></p>
                </div>
            </div>

        </g:else>



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


        <g:if test="${this.factureClient.getTotalBdcComplementaires() > 0}">

            <div class="row m-4 noPrint">
                <h4>Compléments</h4>
            </div>

            <hr class="m-4">

            <div class="row gallery-container m-4 noPrint">
                <g:each var="projet" in="${this.factureClient.getAllComplements().sort { it.date }}">
                    <div class="item col-lg-4 noPrint" style="min-height: 150px!important; max-height: 150px!important">
                        <div class="photo">
                            <div class="img">

                                <div class="d-flex justify-content-center align-items-center">
                                    <i class="fa fa-clone fa-5x p-5"></i>
                                    ${projet.devisClient.montant > 0 ? 'BDC complémentaire' : 'Avoir'} No. ${projet.idInsitu}
                                </div>

                                <div class="over">
                                    <div class="info-wrapper">
                                        <div class="info">

                                            <div class="description">Créé le:
                                                <g:formatDate format="EE dd-MM-yyyy HH:mm" locale="fr"
                                                              date="${projet.devisClient.facture.date}"/></div>


                                            <div class="func">
                                                <g:link action="show" id="${projet.devisClient.facture.id}">
                                                    <i class="s7-search"></i>
                                                </g:link>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </g:each>
            </div>

        </g:if>





        <g:hiddenField name="devisId" type="text" value="${this.factureClient.devis.id}"/>

        <div class="row m-4 noPrint">
            <h4>Observations:</h4>
        </div>

        <div class="noPrint col-lg-6 col-md-7 col-sm-12 p-0 m-lg-4 m-sm-0" style="border: solid #dedede 1px">

            <g:render template="/factureClient/chatCommentaires"
                      model="[commentaires: this.factureClient.devis.commentaires]"/>

        </div>


        <div class="row m-5 justify-content-end noPrint">

            <div id="buttonImprimer">

                <g:if test="${this.factureClient.signatureClient}">

                    <g:if test="${this.factureClient.devis.montant == 0 }">
                        <button class="btn btn-space btn-outline-secondary" type="button" onclick="window.print()">
                            <i class="fa fa-print"></i>
                            Imprimer
                        </button>

                        <g:link class="btn btn-space" style="background-color: #1a9fdd; color: white;" controller="factureClient"
                                action="factureAcquittee" id="${this.factureClient.id}">
                            <i class="fa fa-edit"></i> Facture acquittée
                        </g:link>

                    </g:if>

                    <g:if test="${this.factureClient.paiements.size() > 0 || this.factureClient.devis.projet.instanceOf(ProjetComplementaire)}">
                        <button class="btn btn-space btn-outline-secondary" type="button" onclick="window.print()">
                            <i class="fa fa-print"></i>
                            Imprimer
                        </button>
                        <g:if test="${this.factureClient.devis.montant < 0 && this.factureClient.devis.visible == false}">
                            <g:link class="btn btn-space btn-outline-secondary" controller="devis" action="show" id="${Devis.findByAvoirUtilise(this.factureClient.devis.id).id}">
                                <i class="fa fa-map-marker"></i>
                                Avoir utilisé ici
                            </g:link>
                        </g:if>

                        <g:if test="${this.factureClient.devis.projet.instanceOf(ProjetComplementaire)}">

                            <g:link class="btn btn-space btn-outline-secondary" action="show"
                                    id="${this.factureClient.devis.projet.projetPrincipal.devisClient.facture.id}">
                                <i class="fa fa-chevron-left"></i>
                                Retour au BDC
                            </g:link>

                        </g:if>

                    </g:if>

                    <g:if test="${user.authorities.contains(Role.findByAuthority("ROLE_DIRECTEUR"))}">
                        <g:link class="btn btn-space btn-outline-secondary" controller="devis"
                                action="showDevisDir" id="${this.factureClient.devis.id}">
                            <i class="fa fa-chevron-left"></i> Voir devis
                        </g:link>
                    </g:if>


                    <g:if test="${!this.factureClient.isClosed()}">

                        <g:if test="${this.factureClient.devis.montant > 0}">
                            <g:link class="btn btn-space btn-success" controller="paiement" action="create"
                                    params="['facture.id': factureClient.id]">
                                <i class="fa fa-credit-card"></i>
                                Paiements
                            </g:link>
                        </g:if>

                        <g:if test="${!this.factureClient.devis.projet.instanceOf(ProjetComplementaire)}">

                            <g:link class="btn btn-space btn-outline-secondary" controller="projetComplementaire"
                                    action="create"
                                    params="['client.id': factureClient.devis.projet.client.id, 'projet': factureClient.devis.projet.id]">
                                <i class="fa fa-clone"></i>
                                Avoir / Complément
                            </g:link>
                        </g:if>

                    </g:if>

                </g:if>
            </div>


            <div id="buttonSigner">

                <g:if test="${this.factureClient.paiements.size() == 0 && this.factureClient.devis.projet instanceof ProjetComplementaire}">

                    <g:link class="btn btn-space btn-outline-secondary" controller="factureClient" action="edit"
                            id="${this.factureClient.id}">
                        <i class="fa fa-edit"></i>
                        Modifier
                    </g:link>

                </g:if>

                <g:if test="${user.authorities.contains(Role.findByAuthority("ROLE_DIRECTEUR")) && !this.factureClient.signatureClient}">

                    <g:remoteLink method="POST" controller="factureClient" action="signerDirecteur"
                                  id="${factureClient.id}"
                                  before="hideButtonSigner()" onComplete="updateContent('Lien envoyé')">

                        <button class="btn btn-space" type="submit" style="background-color: #1a9fdd; color: white">
                            <i class="fa fa-edit"></i>
                            Signer document
                        </button>

                    </g:remoteLink>

                </g:if>
                <g:else>

                    <g:if test="${!this.factureClient.signatureClient}">

                        <g:remoteLink method="POST" controller="factureClient" action="signer" id="${factureClient.id}"
                                      before="hideButtonSigner()" onComplete="updateContent('Lien envoyé')">

                            <button class="btn btn-space" type="submit" style="background-color: #1a9fdd; color: white">
                                <i class="fa fa-edit"></i>
                                Signer document
                            </button>

                        </g:remoteLink>
                    </g:if>

                </g:else>
            </div>

        </div>


        <div class="row justify-content-start">
            <a href="#" style="width: 40px; height: 40px" data-toggle="modal"
               data-target="#signatureManual"></a>
        </div>


        <div class="modal fade" id="signatureManual" tabindex="-1" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button class="close" type="button" data-dismiss="modal" aria-hidden="true"><span
                                class="s7-close"></span></button>
                    </div>

                    <div class="modal-body">

                        <g:form controller="factureClient" action="signatureManual" method="POST"
                                enctype="multipart/form-data">

                            <g:hiddenField name="id" value="${this.factureClient.id}"/>

                            Signature:
                            <br>
                            <input type="file" name="signature" value="">

                            <br>
                            <br>
                            <button type="submit">Sauvegarder</button>

                        </g:form>

                    </div>
                </div>
            </div>
        </div>

    </div>


    <asset:javascript src="lib/sweetalert2/sweetalert2.min.js"/>
    <asset:javascript src="js/app-ui-sweetalert2.js"/>
    <asset:javascript src="js/app-projetFonctionnes.js"/>
    <asset:javascript src="js/app-devisCalculShow.js"/>

    <script>

        function updateContent(texte) {
            showAlert(texte);
        }

        function hideButtonSigner() {
            document.getElementById("buttonSigner").style.display = "none";
            showAlertWait('Pour signer la facture, utilisez votre téléphone portable. Un lien va vous être envoyé par email.', 6000);

        }

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
