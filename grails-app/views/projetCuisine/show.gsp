<%@ page import="mccorletagencement.ProjetCuisine" %>


<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'projetCuisine.label', default: 'ProjetCuisine')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
    <asset:stylesheet src="css/gallery.css"/>

    <style>

    .item {
        font-weight: bold;
        height: 60px;
    }


    #divPlan {
        box-shadow: 0 0px 0 rgba(0, 0, 0, 0.0);
    }

    #divAddPlan {
        box-shadow: 0 0px 0 rgba(0, 0, 0, 0.0);
        margin-top: -20px;
    }

    th {
        font-weight: bold !important;
    }

    h4 {
        font-weight: bold !important;
    }

    .print {

        visibility: hidden;
        height: 0px;
    }


    @media print {

        body {
            height: 0px !important;
        }

        .noPrint {
            display: none;
        }

        .navbar, .noPrint, .btn {
            display: none !important;
            height: 0px !important;
        }


        .card-table {
            width: 300px !important;
            font-size: 16px !important;
            margin-bottom: 0px !important;
            margin-top: 0px !important;
            padding-bottom: 0px !important;
            padding-top: 0px !important;
        }

        .card-body .pb-4 {
            padding-bottom: 0px !important;

        }

        .card-body .pt-4 {
            padding-top: 0px !important;
        }


        .print {
            visibility: visible;
            height: 100px;
        }

        a {
            text-decoration: none !important;
        }


    }


    </style>

</head>

<body>

<div class="card card-default col-lg-12 m-2">
    <div class="card-body">

        <g:if test="${flash.error}">

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
                            <li>

                                <g:message error="${flash.error}"/>

                            </li>
                        </ul>

                    </div>
                </div>
            </div>

        </g:if>

        <div class="row justify-content-end">
            <g:link class="btn btn-space btn-secondary" action="show" controller="client"
                    id="${this.projetCuisine?.client.id}">
                <i class="fa fa-chevron-left"></i>
                Retour fiche client
            </g:link>
        </div>


        <div class="row m-4 justify-content-center print">
            <asset:image src="img/logomccorlet.jpg" style="width: 40%"/>

            <p class="mt-4 ml-5" style="font-size: 16px">
                Zac de Peters Maillet 97270 SAINT-ESPRIT <br>
                Téléphone 0596 70 41 31  - Télécopie 0596 56 69 97<br>
                SIRET : 818 034 829 00015 – APE 3102Z<br>
            </p>
        </div>


        <div class="row m-4 justify-content-end print">
            <p class="mt-4 ml-5" style="font-size: 16px">
                Remis le <g:formatDate date="${new Date()}" format="dd MMMM yyyy"
                                       locale="fr"></g:formatDate>
            </p>

        </div>


        <h4>Détails du projet

            <g:if test="${this.projetCuisine?.idInsitu}">
                <a href="#">
                    No. ${this.projetCuisine?.idInsitu}
                </a>
            </g:if>
            - Cuisine

        </h4>
        <hr>

        <div class="row m-2 ">
            <div class="card card-default card-table col-lg-4">
                <div class="card-body pt-4 pb-4">
                    <table class="no-border no-strip skills">
                        <tbody class="no-border-x no-border-y">
                        <tr>
                            <td class="item">Date de création: <br> <a href="#"><g:formatDate format="dd MMMM yyyy"
                                                                                              locale="fr"
                                                                                              date="${this.projetCuisine?.date}"/></a>
                            </td>

                        </tr>

                        <tr>
                            <td class="item">Délai de réalisation du projet: <br>
                                <a href="#">
                                    ${this.projetCuisine?.delaiFormated()}
                                </a>
                            </td>
                        </tr>

                        <tr>
                            <td class="item">Style souhaité: <br>
                                <a href="#">${this.projetCuisine?.style}</a>
                            </td>

                        </tr>


                        <g:if test="${this.projetCuisine.devis}">
                            <tr>

                                <td class="item">Financement du projet: <br>
                                    <a href="#">
                                        <g:if test="${this.projetCuisine?.financement.equals("Autre")}">
                                            ${this.projetCuisine?.financementAutre}
                                        </g:if>
                                        <g:else>
                                            ${this.projetCuisine?.financement}
                                        </g:else>

                                    </a>
                                </td>

                            </tr>

                        </g:if>

                        </tbody>
                    </table>
                </div>
            </div>

            <div class="card card-default card-table col-lg-4">
                <div class="card-body pt-4 pb-4">
                    <table class="no-border no-strip skills">
                        <tbody class="no-border-x no-border-y">
                        <tr>
                            <td class="item">Avez-vous fait réaliser un devis ? <br>
                                <a href="#">${this.projetCuisine?.devis ? "Oui" : "Non"}</a>
                            </td>

                        </tr>
                        <tr>
                            <td class="item">Le projet concerne un(e): <br>
                                <a href="#">${this.projetCuisine?.typeHabitation}

                                <g:if test="${this.projetCuisine?.typeHabitation.equals("Immeuble")}">

                                    ${"- " + this.projetCuisine?.quantiteHabitation + " logements"}

                                </g:if>

                                </a>
                            </td>
                        </tr>


                        <tr>
                            <td class="item">Coin repas: <br>
                                <a href="#">${this.projetCuisine?.coinRepas ? this.projetCuisine?.nombrePersonne + " personne(s)" : "Non"}</a>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="card card-default card-table col-lg-4">
                <div class="card-body pt-4 pb-4">
                    <table class="no-border no-strip skills">
                        <tbody class="no-border-x no-border-y">
                        <tr>
                            <g:if test="${this.projetCuisine?.devis}">
                                <td class="item">

                                    Pourquoi n'avez-vous pas concrétisé ? <br>

                                    <a href="#">${this.projetCuisine?.devisOui}</a>

                                </td>
                            </g:if>
                            <g:else>
                                <td class="item">Financement du projet: <br>
                                    <a href="#">
                                        <g:if test="${this.projetCuisine?.financement.equals("Autre")}">
                                            ${this.projetCuisine?.financementAutre}
                                        </g:if>
                                        <g:else>
                                            ${this.projetCuisine?.financement}
                                        </g:else>

                                    </a>
                                </td>
                            </g:else>
                        </tr>
                        <tr>
                            <td class="item">Type de chantier: <br>
                                <a href="#">${this.projetCuisine?.typeTravail}</a>
                            </td>
                        </tr>

                        <tr>
                            <td class="item">Votre budget:  <br>

                                <a href="#">
                                    <g:if test="${this.projetCuisine?.budget.equals("Autre")}">
                                        ${this.projetCuisine?.budgetAutre}
                                    </g:if>
                                    <g:else>
                                        ${this.projetCuisine?.budget}
                                    </g:else>

                                </a>

                            </td>
                        </tr>

                        </tbody>
                    </table>
                </div>
            </div>

        </div>




        <h4>Equipements</h4>
        <hr>

        <div class="row m-2">
            <div class="card card-default card-table col-lg-2">

                <div class="card-body pt-4 pb-4">
                    <table class="no-border no-strip skills">
                        <tbody class="no-border-x no-border-y">
                        <tr>
                            <td class="item">Plaque de cuisson: <br>
                                <a href="#">${this.projetCuisine?.plaqueCuisson}</a>
                            </td>
                        </tr>
                        <tr>
                            <td class="item">Four:  <br>
                                <a href="#">${this.projetCuisine?.four ? "Oui" : "Non"}</a>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="card card-default card-table col-lg-3">

                <div class="card-body pt-4 pb-4">
                    <table class="no-border no-strip skills">
                        <tbody class="no-border-x no-border-y">
                        <tr>
                            <td class="item">Bouteille de gaz: <br>
                                <a href="#">${this.projetCuisine?.bouteilleGaz}</a>
                            </td>
                        </tr>
                        <tr>
                            <td class="item">Micro-ondes: <br>
                                <a href="#">${this.projetCuisine?.microondes ? "Oui" : "Non"}</a>
                            </td>
                        </tr>

                        </tbody>
                    </table>
                </div>
            </div>


            <div class="card card-default card-table col-lg-2">

                <div class="card-body pt-4 pb-4">
                    <table class="no-border no-strip skills">
                        <tbody class="no-border-x no-border-y">
                        <tr>
                            <td class="item">Evier:  <br>
                                <a href="#">${this.projetCuisine?.evier}</a>
                            </td>
                        </tr>
                        <tr>
                            <td class="item">Hotte:  <br>
                                <a href="#">${this.projetCuisine?.hotte ? "Oui" : "Non"}</a>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>


            <div class="card card-default card-table col-lg-3">

                <div class="card-body pt-4 pb-4">
                    <table class="no-border no-strip skills">
                        <tbody class="no-border-x no-border-y">
                        <tr>
                            <td class="item">Réfrigérateur: <br>
                                <a href="#">${this.projetCuisine?.frigo}</a>
                            </td>
                        </tr>
                        <tr>
                            <td class="item">Lave-vaisselle: <br>
                                <a href="#">${this.projetCuisine?.laveVaisselle ? "Oui" : "Non"}</a>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="card card-default card-table col-lg-2">

                <div class="card-body pt-4 pb-4">
                    <table class="no-border no-strip skills">
                        <tbody class="no-border-x no-border-y">
                        <tr>
                            <td class="item">Congélateur: <br>
                                <a href="#">${this.projetCuisine?.congelateur ? "Oui" : "Non"}</a>
                            </td>
                        </tr>
                        <tr>
                            <td class="item">Lave-linge: <br>
                                <a href="#">${this.projetCuisine?.laveLinge ? "Oui" : "Non"}</a>
                            </td>
                        </tr>

                        </tbody>
                    </table>
                </div>
            </div>

        </div>

        <h4>Matériaux</h4>
        <hr>

        <div class="row m-2">

            <div class="card card-default card-table col-lg-3">
                <div class="card-body pt-4 pb-4">
                    <table class="no-border no-strip skills">
                        <tbody class="no-border-x no-border-y">

                        <tr>
                            <td class="item">Façade laquée: <br>
                                <a href="#">
                                    <g:if test="${!this.projetCuisine?.facadeLaquee.equals("Néant")}">

                                        ${this.projetCuisine?.facadeLaqueeCouleur == null ?
                                                this.projetCuisine?.facadeLaquee + " (Couleur non renseignée)" :
                                                this.projetCuisine?.facadeLaquee + " (" + this.projetCuisine?.facadeLaqueeCouleur + ")"}

                                    </g:if>
                                    <g:else>
                                        Néant
                                    </g:else>
                                </a>
                            </td>
                        </tr>

                        </tbody>
                    </table>
                </div>
            </div>

            <div class="card card-default card-table col-lg-3">
                <div class="card-body pt-4 pb-4">
                    <table class="no-border no-strip skills">
                        <tbody class="no-border-x no-border-y">
                        <tr>
                            <td class="item">Façade bois: <br>
                            <a href="#">

                                <g:if test="${!this.projetCuisine?.facadeBois.equals("Néant")}">
                                    ${this.projetCuisine?.facadeBoisCouleur == null ?
                                            this.projetCuisine?.facadeBois + " (Couleur non renseignée)" :
                                            this.projetCuisine?.facadeBois + " (" + this.projetCuisine?.facadeBoisCouleur + ")"}</a>
                                </g:if>
                                <g:else>
                                    Néant
                                </g:else>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>


            <div class="card card-default card-table col-lg-3">

                <div class="card-body pt-4 pb-4">
                    <table class="no-border no-strip skills">
                        <tbody class="no-border-x no-border-y">
                        <tr>
                            <td class="item">Plan de travail: <br>
                                <a href="#">
                                    ${this.projetCuisine?.planTravail}
                                    <g:if test="${this.projetCuisine?.planTravail != 'Néant'}">
                                        ${this.projetCuisine?.planTravailCouleur == null ? "(Couleur non renseignée)" : "(" + this.projetCuisine?.planTravailCouleur + ")"}
                                    </g:if>
                                </a>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="card card-default card-table col-lg-3">

                <div class="card-body pt-4 pb-4">
                    <table class="no-border no-strip skills">
                        <tbody class="no-border-x no-border-y">

                        <tr>
                            <td class="item">Poignées: <br>

                                <g:if test="${this.projetCuisine.poignees}">

                                    <a href="#">${this.projetCuisine?.poigneesModele.equals("Autre") ? this.projetCuisine?.poigneesAutre : this.projetCuisine?.poigneesModele}</a>

                                </g:if>
                                <g:else>

                                    <a href="#">Non</a>

                                </g:else>

                            </td>
                        </tr>

                        </tbody>
                    </table>
                </div>
            </div>


            <div class="card card-default card-table col-lg-3">
                <div class="card-body pt-4 pb-4">
                    <table class="no-border no-strip skills">
                        <tbody class="no-border-x no-border-y">
                        <tr>
                            <td class="item">Option du meuble: <br>
                                <a href="#">${this.projetCuisine.optionMeuble}</a>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>

        </div>

        <div class="row justify-content-end print mb-0">
            <p class="mt-3 mb-0 mr-6" style="font-size: 18px; line-height: 20px">Pour Martinique Cuisine:</p>
        </div>

        <div class="row justify-content-end print mt-0">
            <p class="mr-6"
               style="font-size: 18px">${this.projetCuisine.concepteur.prenom + " " + this.projetCuisine.concepteur.nom.toUpperCase()}</p>
        </div>

        <div class="row justify-content-end print">
            <g:if test="${this.projetCuisine.concepteur.signature}">
                <img width="200px" src="<g:createLink controller="utilisateur" action="showSignature"
                                                      params="['id': this.projetCuisine.concepteur.id]"/>"/>
            </g:if>
        </div>


        <g:form resource="${this.projetCuisine}" method="DELETE" onsubmit="submit.disabled = true; return true;">

            <div class="row m-5 justify-content-end">

                <g:if test="${!this.projetCuisine.existDevis()}">
                    <a href="#" data-toggle="modal"
                       data-target="#numeroDossier"
                       class="btn btn-space" style="background-color: #1a9fdd; color: white"><i class="fa fa-plus"></i>
                        ${this.projetCuisine.idInsitu?.isBlank() || this.projetCuisine.idInsitu == null ? 'Ajouter No. dossier' : 'Modifier No. dossier'}
                    </a>
                </g:if>


                <button class="btn btn-space btn-secondary" type="button" onclick="window.print()">
                    <i class="fa fa-print"></i> Imprimer
                </button>

                <g:link class="btn btn-space btn-secondary" action="edit" resource="${this.projetCuisine}">
                    <i class="fa fa-edit"></i> Modifier détails
                </g:link>

            </div>

        </g:form>



        <div class="modal fade" id="numeroDossier" tabindex="-1" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button class="close" type="button" data-dismiss="modal" aria-hidden="true"><span
                                class="s7-close"></span></button>
                    </div>

                    <div class="modal-body">

                        <g:form controller="projet" action="saveNumeroDossier" autocomplete="off"
                                onsubmit="submit.disabled = true; return true;">
                            <div class="row justify-content-start ml-4">
                                <label class="col-lg-12">No. Dossier</label>
                            </div>

                            <div class="row justify-content-start ml-4 mb-6">
                                <div class="col-lg-8">
                                    <input class="form-control" type="text" value="${this.projetCuisine?.idInsitu}"
                                           name="idInsitu"/>
                                    <small class="form-text text-muted">Reporter ici la référence générée par INSITU</small>
                                </div>

                                <div class="col-lg-4">

                                    <button class="btn btn-success" type="submit" style="margin-top: 2px" id="submit"><i
                                            class=" fa fa-edit"></i> Enregistrer</button>

                                </div>
                            </div>

                            <g:hiddenField name="id" value="${this.projetCuisine?.id}"/>

                        </g:form>

                    </div>
                </div>
            </div>
        </div>




        <!-- Documents session --->


        <h4 class="mb-0 noPrint">Document(s)</h4>
        <hr class="noPrint">


        <g:render template="/projet/gallery" model="[projet: this.projetCuisine]"/>


        <div class="row m-5 justify-content-end noPrint">

            <g:if test="${this.projetCuisine.idInsitu}">
                <g:if test="${this.projetCuisine?.devisClient}">

                    <g:link class="btn btn-outline-secondary btn-space btn-big" controller="devis" action="show"
                            params="[id: this.projetCuisine.devisClient.id]">
                        <i class="fa fa-file-o"></i>
                        <g:message code="default.button.voirPropositionPrix.label" default="Voir proposition de prix"/>
                    </g:link>

                </g:if>
                <g:else>

                    <g:link class="btn btn-outline-secondary btn-space btn-big" controller="devis" action="create"
                            params="[projet: this.projetCuisine.getId()]">
                        <i class="fa fa-file-o"></i>
                        <g:message code="default.button.propositionPrix.label" default="Proposer un prix"/>
                    </g:link>

                </g:else>

            </g:if>

        </div>

    </div>
</div>




<script>

    function submitForm(id) {

        var answer = confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');

        if (answer == true) {
            document.getElementById(id).click();
        }

    }

</script>

</body>
</html>
