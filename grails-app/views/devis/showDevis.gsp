<%@ page import="mccorletagencement.ProjetComplementaire; mccorletagencement.Role; org.springframework.security.core.context.SecurityContextHolder; mccorletagencement.Utilisateur; mccorletagencement.ProjetAutre; mccorletagencement.ProjetPlacard; mccorletagencement.ProjetDressing; mccorletagencement.ProjetSalleBain; mccorletagencement.ProjetCuisine" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="noMenu"/>
    <g:set var="entityName" value="${message(code: 'devis.label', default: 'Devis')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>

    <style>

    th {
        font-weight: bold !important;
    }

    .item {
        font-weight: bold;
    }


    #commentaireModal {

        border: none;
        resize: none;
        background-color: white;
        font-size: 18px !important;
        text-align: center;


    }


    #notesTexte {
        background-color: white;
    }

    #commentaire {

        background-color: white;
        font-size: 18px;
        color: #3e3e3e !important;
        border: 1px solid;

    }

    .italic {
        font-style: italic;
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

    @media print {


        .navbar, .noPrint, .btn {
            display: none !important;
        }

        input {
            border: none !important;
        }

        .print {
            display: block;

        }


        #commentaire {

            border: 1px solid;
            resize: none;
            border: 1px solid;
            margin-left: -10px;
        }

        .pagebreak {
            break-before: page;
        }


    }

    .fa-eye, .fa-eye-slash {

        font-size: 18px;
        margin-top: 12px;

    }


    .splash-container .user-message {
        padding: 215px 30px 40px !important;
    }


    @media only screen and (min-width: 767px) {
        body {
            margin-top: 0px !important;
        }
    }

    @media only screen and (max-width: 767px) {
        body {
            margin-top: 0px !important;
        }
    }

    </style>

</head>

<body style="height: 0px">

<g:set var="user"
       value="${Utilisateur.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName())}"></g:set>

<div class="card card-default card-table m-2">
    <div class="card-body pt-4 pb-4">

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
                Ducos, le <g:formatDate date="${devis.date}" format="dd MMMM yyyy" locale="fr"></g:formatDate>
            </p>

        </div>

        <g:if test="${devis.decline}">
            <div class="water-mark">
                DECLINE
            </div>
        </g:if>




        <g:if test="${!devis.envoye}">
            <div class="water-mark2">
                BROUILLON
            </div>
        </g:if>


        <g:if test="${devis.envoye && !devis.valide && !devis.approuve && !devis.decline}">
            <div class="water-mark2">
                BROUILLON
            </div>
        </g:if>


        <div class="row ml-4 mr-4 mt-4 mb-0">
            <div class="card card-default">
                <div class="card-header card-header"
                     style="color: #832e00; font-weight: bold; font-size: 28px!important;">

                    <g:if test="${devis.getProjet().instanceOf(ProjetComplementaire)}">
                        Devis complémentaire No. ${devis.getProjet()?.idInsitu} <br> lié au bon de commande No. ${devis.getProjet().projetPrincipal.idInsitu}
                    </g:if>
                    <g:else>
                        Devis No. ${devis.getProjet()?.idInsitu}
                    </g:else>

                </div>

                <div class="card-body">
                    <table class="no-border no-strip skills">
                        <tbody class="no-border-x no-border-y">
                        <tr>
                            <td class="item">Désignation du produit:</td>
                            <td>

                                <g:if test="${devis.getProjet().instanceOf(ProjetCuisine)}">
                                    Cuisine
                                </g:if>
                                <g:if test="${devis.getProjet().instanceOf(ProjetSalleBain)}">
                                    Salle de bain
                                </g:if>
                                <g:if test="${devis.getProjet().instanceOf(ProjetDressing)}">
                                    Dressing
                                </g:if>
                                <g:if test="${devis.getProjet().instanceOf(ProjetPlacard)}">
                                    Placard
                                </g:if>
                                <g:if test="${devis.getProjet().instanceOf(ProjetAutre)}">
                                    ${devis.getProjet().typeProjet}
                                </g:if>
                                <g:if test="${devis.getProjet().instanceOf(ProjetComplementaire)}">
                                    ${devis.getProjet().description}
                                </g:if>

                            </td>
                        </tr>
                        <tr>
                            <td class="item">Au nom de:</td>
                            <td>
                                ${devis.projet.client.intitule + " " + devis.projet.client.prenom + " " + devis.projet.client.nom}
                            </td>
                        </tr>
                        <tr>
                            <td class="item">Adresse de livraison:</td>
                            <td>
                                ${devis.getProjet().client.adresse + "  " + devis.getProjet().client.codePostal + " " + devis.getProjet().client.ville}
                            </td>
                        </tr>
                        <tr>
                            <td class="item">Décorateur concepteur:</td>
                            <td>
                                ${devis.creePar}
                                <i class="fa fa-phone ml-3"></i>
                                ${devis.creePar.telephone}
                            </td>
                        </tr>

                        <g:if test="${devis.getLastUser() != devis.projet.concepteur}">
                            <tr style="color:#832e00">
                                <td class="item">Transféré à:</td>
                                <td>
                                    ${devis.getLastUser()}
                                    <i class="fa fa-phone ml-3"></i>
                                    ${devis.getLastUser().telephone}
                                </td>
                            </tr>
                        </g:if>

                        <tr>
                            <td class="item italic">Validité du devis:</td>
                            <td>
                                ${devis.validite}
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>

            </div>

        </div>


        <div class="row ml-5 font-weight-bold" style="font-size: 18px">
            Commentaires:

            <div class="col-lg-8 mb-5 mr-6 mt-2">
                <g:textArea disabled class="form-control" id="commentaire" name="commentaire"
                            value="${devis.commentaire}"></g:textArea>
            </div>
        </div>


        <div class="row m-2 justify-content-center">
            <table class="table table-bordered col-lg-8">
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


        <div class="pagebreak"></div>

        <div class="row mt-6 justify-content-center">

            <h1>DETAIL DU PRIX DU PROJET</h1>

        </div>

        <g:if test="${!devis.envoye}">
            <div class="water-mark2">
                BROUILLON
            </div>
        </g:if>


        <g:if test="${devis.envoye && !devis.valide && !devis.approuve && !devis.decline}">
            <div class="water-mark2">
                BROUILLON
            </div>
        </g:if>

        <div class="row mt-4 justify-content-center">
            <div class="col-lg-8">
                <g:render template="tableExcelPrint"/>
            </div>
        </div>

    </div>


    <div id="actionsButtons" class="row m-5 justify-content-end noPrint">

        <button class="btn btn-space btn-outline-secondary" type="button" onclick="window.print()">
            <i class="fa fa-print"></i> Imprimer
        </button>

    </div>

</div>



<asset:javascript src="lib/sweetalert2/sweetalert2.min.js"/>
<asset:javascript src="js/app-ui-sweetalert2.js"/>
<asset:javascript src="js/app-projetFonctionnes.js"/>
<asset:javascript src="js/app-devisCalculShow.js"/>

<script>


    fitContent("commentaire");


    obtenirPrixMin();

    obtenirPrixProjet();

    function updateContent(texte) {
        showAlert(texte);
    }




</script>
</body>
</html>
