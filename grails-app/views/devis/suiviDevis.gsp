<%@ page import="mccorletagencement.Devis; dtos.DevisDTO; mccorletagencement.Utilisateur; org.springframework.security.core.context.SecurityContextHolder; mccorletagencement.Role; mccorletagencement.ProjetAutre; mccorletagencement.ProjetPlacard; mccorletagencement.ProjetDressing; mccorletagencement.ProjetSalleBain; mccorletagencement.ProjetCuisine" %>

<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'devis.label', default: 'Devis')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>

    <style>

    .nav-tabs-primary + .tab-content {
        background-color: white;
        color: inherit;
        border: solid #eaeaea 1px;
        margin-top: -1px;
    }

    .nav-tabs-primary .nav-link.active {

        border-top-left-radius: 3px;
        border-top-right-radius: 3px;
        background-color: white;
        color: inherit;
        border: solid #eaeaea 1px;
        border-bottom: solid white 1px;
    }


    .modal tr {
        height: 40px;
        font-size: 16px;
    }



    </style>

</head>

<body>

<g:set var="directeur"
       value="${Utilisateur.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName()).authorities.contains(Role.findByAuthority("ROLE_DIRECTEUR"))}"></g:set>

<div class="card card-default m-2 table-responsive">

    <div class="card card-header" style="min-width: 680px">
        <div class="row" style="color: rgba(0,0,0,0.7); vertical-align: middle">
            <div class="col-lg-12" style="font-size: 22px;">
                <i class="fa fa-file-o"></i> Suivi des devis
            </div>
        </div>

        <hr>

        <div class="row justify-content-end">
            <nav class="navbar navbar-expand-lg navbar-light bg-light">
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavAltMarkup"
                        aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
                    <div class="navbar-nav">
                        <a class="nav-link active" href="#" style="font-size: 14px; color: #c6c6c6"><i
                                class="fa fa-hourglass-o"></i> Client à relancer</a>
                        <a class="nav-link active" href="#" style="font-size: 14px; color: #c6c6c6"><i
                                class="fa fa-check"></i> Client toujours intéressé</a>
                        <g:if test="${directeur}">
                            <a class="nav-link active" href="#" style="font-size: 14px; color: #c6c6c6"><i
                                    class="fa fa-warning"></i> Expiré sans aucune action</a>
                            <a class="nav-link active" href="#" style="font-size: 14px; color: #c6c6c6"><i
                                    class="fa fa-commenting-o"></i> Questionnaire à réaliser</a>
                        </g:if>
                    </div>
                </div>
            </nav>
        </div>
    </div>


    <div class="card-body" id="tabPane" style="min-width: 680px">

        <g:set var="commercial"
               value="${Utilisateur.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName()).authorities.contains(Role.findByAuthority("ROLE_COMMERCIAL"))}"></g:set>


        <div class="col-lg-12">
            <div class="tab-container mb-5">
                <ul class="nav nav-tabs nav-tabs-primary" role="tablist">
                    <g:if test="${directeur}">
                        <li class="nav-item"><a class="nav-link active" href="#p-home" data-toggle="tab" role="tab"
                                                aria-selected="true">Non validés</a></li>
                    </g:if>
                    <li class="nav-item"><a class="nav-link  ${!directeur ? 'active' : ''}" href="#p-profile1"
                                            data-toggle="tab" role="tab" aria-selected="true">En attente</a></li>

                    <li class="nav-item"><a class="nav-link" href="#p-profile2" data-toggle="tab" role="tab"
                                            aria-selected="false">Déclinés</a></li>

                    <li class="nav-item"><a class="nav-link" href="#p-profile3" data-toggle="tab" role="tab"
                                            aria-selected="false">Réouverts</a></li>


                    <li class="nav-item"><a class="nav-link" href="#p-profile4" data-toggle="tab" role="tab"
                                            aria-selected="false">Brouillons</a></li>

                </ul>

                <div id="tab-content" class="tab-content">

                    <g:if test="${directeur}">
                        <div class="tab-pane active" id="p-home" role="tabpanel">

                            <table width="100%" class="table dataTable table-hover table-bordered table-striped">
                                <thead>
                                <tr>
                                    <th class="noExport"></th>
                                    <th class="menu noSorting"></th>
                                    <th>No. Devis</th>
                                    <th>Client</th>
                                    <th>Date de création</th>
                                    <th>Type de projet</th>
                                    <th>Concepteur</th>
                                </tr>
                                </thead>
                                <tbody>
                                <g:each var="devis" in="${devisNonValides}">

                                    <tr>
                                        <td></td>
                                        <td>

                                            <div class="dropdown">
                                                <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink3"
                                                   data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                    <i class="fa fa-list"></i>
                                                </a>

                                                <div id="dropdown-menu3" class="dropdown-menu"
                                                     aria-labelledby="dropdownMenuLink3">
                                                    <g:link class="dropdown-item" controller="devis" action="show"
                                                            id="${devis.id}">
                                                        Accéder aux détails
                                                    </g:link>
                                                </div>
                                            </div>

                                        </td>
                                        <td>
                                            ${devis.idInsitu}
                                        </td>
                                        <td>
                                            ${devis.client}
                                        </td>
                                        <td>
                                            <g:formatDate date="${devis?.date}" format="dd MMMM yyyy" locale="fr"/>
                                        </td>

                                        <td>
                                            ${devis.typeProjet}
                                        </td>
                                        <td>${devis.concepteur}</td>

                                    </tr>

                                </g:each>
                                </tbody>
                            </table>

                        </div>
                    </g:if>

                    <div class="tab-pane ${!directeur ? 'active' : ''}" id="p-profile1" role="tabpanel">

                        <table width="100%" class="table dataTable table-hover table-bordered table-striped">
                            <thead>
                            <tr>
                                <th class="noExport"></th>
                                <th class="menu noSorting"></th>
                                <th>No. Devis</th>
                                <th>Client</th>
                                <th>Date de création</th>
                                <th>Type de projet</th>
                                <th>Concepteur</th>
                            </tr>
                            </thead>
                            <tbody>
                            <g:each var="devis" in="${devisAttente}">

                                <tr>
                                    <td></td>
                                    <td>

                                        <div class="dropdown" id="dropdown-menu${devis.id}">
                                            <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink"
                                               data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                <i class="fa fa-list"></i>
                                            </a>

                                            <div id="dropdown-menu" class="dropdown-menu"
                                                 aria-labelledby="dropdownMenuLink">
                                                <g:link class="dropdown-item" controller="devis" action="show"
                                                        id="${devis.id}">
                                                    Accéder aux détails
                                                </g:link>


                                                <g:if test="${devis.relance}">
                                                    <a href="#" class="dropdown-item" data-toggle="modal"
                                                       data-target="#infoContact${devis.id}"
                                                       onclick="getCommentairesRelance(${devis.id})">
                                                        Relancer le client
                                                    </a>
                                                </g:if>


                                                <g:if test="${devis.toujoursInteresse}">
                                                    <a href="#" class="dropdown-item" data-toggle="modal"
                                                       data-target="#infoContact${devis.id}"
                                                       onclick="getCommentairesRelance(${devis.id})">
                                                        Voir les  relances
                                                    </a>
                                                </g:if>

                                            </div>
                                        </div>

                                    </td>
                                    <td class="d-flex flex-row justify-content-between">
                                        ${devis.idInsitu}
                                        <div id="icon${devis.id}">
                                            <g:if test="${devis.expirationEnCours}">
                                                <i class="fa fa-hourglass-o"
                                                   style="font-size: 20px; color: lightgray"></i>
                                            </g:if>
                                            <g:if test="${devis.toujoursInteresse}">
                                                <i class="fa fa-check" style="font-size: 20px; color: lightgray"></i>
                                            </g:if>
                                        </div>

                                    </td>
                                    <td>
                                        ${devis.client}
                                    </td>
                                    <td>
                                        <g:formatDate date="${devis?.date}" format="dd MMMM yyyy" locale="fr"/>
                                    </td>
                                    <td>
                                        ${devis.typeProjet}
                                    </td>
                                    <td>${devis.concepteur}</td>

                                </tr>

                            </g:each>
                            </tbody>
                        </table>

                    </div>

                    <div class="tab-pane" id="p-profile2" role="tabpanel">

                        <table width="100%" class="table dataTable table-hover table-bordered table-striped">
                            <thead>
                            <tr>
                                <th class="noExport"></th>
                                <th class="menu noSorting"></th>
                                <th>No. Devis</th>
                                <th>Client</th>
                                <th>Date de création</th>
                                <th>Type de projet</th>
                                <th>Concepteur</th>
                            </tr>
                            </thead>
                            <tbody>
                            <g:each var="devis" in="${devisDecline}">

                                <tr>
                                    <td></td>
                                    <td>

                                        <div class="dropdown">
                                            <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink1"
                                               data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                <i class="fa fa-list"></i>
                                            </a>

                                            <div id="dropdown-menu1" class="dropdown-menu"
                                                 aria-labelledby="dropdownMenuLink1">

                                                <g:link class="dropdown-item" controller="devis" action="show"
                                                        id="${devis.id}">
                                                    Accéder aux détails
                                                </g:link>


                                                <g:if test="${!devis.questionnaire}">
                                                    <g:if test="${!Utilisateur.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName()).authorities.contains(Role.findByAuthority("ROLE_COMMERCIAL"))}">

                                                        <g:link class="dropdown-item" controller="questionnaire"
                                                                action="create" params="['devis.id': devis.id]">
                                                            Compléter le questionnaire
                                                        </g:link>
                                                    </g:if>

                                                </g:if>
                                                <g:else>

                                                    <g:if test="${!Utilisateur.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName()).authorities.contains(Role.findByAuthority("ROLE_COMMERCIAL"))}">

                                                        <g:if test="${devis.isQuestionnaireCompleted}">
                                                            <g:link class="dropdown-item" controller="questionnaire"
                                                                    action="show" id="${devis.questionnaireId}">
                                                                Accéder au questionnaire
                                                            </g:link>
                                                        </g:if>
                                                        <g:else>

                                                            <g:link class="dropdown-item" controller="questionnaire"
                                                                    action="edit" id="${devis.questionnaireId}">
                                                                Compléter le questionnaire
                                                            </g:link>

                                                        </g:else>

                                                    </g:if>

                                                </g:else>

                                            </div>
                                        </div>

                                    </td>
                                    <td>
                                        <div class="d-flex flex-row justify-content-between">

                                            ${devis.idInsitu}

                                            <g:if test="${!devis.questionnaireCompleted && Utilisateur.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName()).authorities.contains(Role.findByAuthority("ROLE_DIRECTEUR"))}">

                                                <div style="text-align: center">

                                                    <i class="fa fa-commenting ml-2"
                                                       style="font-size: 20px; color: lightgray"></i>


                                                    <g:if test="${devis.expireAuto}">
                                                        <i class="fa fa-exclamation-triangle"
                                                           style="font-size: 20px; color: lightgray"></i>
                                                    </g:if>
                                                </div>
                                            </g:if>

                                        </div>

                                    </td>
                                    <td>
                                        ${devis.client}
                                    </td>

                                    <td>
                                        <g:formatDate date="${devis?.date}" format="dd MMMM yyyy" locale="fr"/>
                                    </td>
                                    <td>
                                        ${devis.typeProjet}
                                    </td>
                                    <td>${devis.concepteur}</td>

                                </tr>

                            </g:each>
                            </tbody>
                        </table>

                    </div>

                    <div class="tab-pane" id="p-profile3" role="tabpanel">

                        <table width="100%" class="table dataTable table-hover table-bordered table-striped">
                            <thead>
                            <tr>
                                <th class="noExport"></th>
                                <th class="menu noSorting"></th>
                                <th>No. Devis</th>
                                <th>Client</th>
                                <th>Date de création</th>
                                <th>Type de projet</th>
                                <th>Concepteur</th>
                            </tr>
                            </thead>
                            <tbody>
                            <g:each var="devis" in="${devisReouvert}">

                                <tr>
                                    <td></td>
                                    <td>

                                        <div class="dropdown">
                                            <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink2"
                                               data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                <i class="fa fa-list"></i>
                                            </a>

                                            <div id="dropdown-menu2" class="dropdown-menu"
                                                 aria-labelledby="dropdownMenuLink2">

                                                <g:link class="dropdown-item" controller="devis" action="show"
                                                        id="${devis.id}">
                                                    Accéder aux détails
                                                </g:link>
                                            </div>
                                        </div>

                                    </td>
                                    <td>
                                        <div class="d-flex flex-row justify-content-between">
                                            <div>
                                                ${devis.idInsitu}
                                            </div>

                                            <g:if test="${!devis.questionnaire && !Utilisateur.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName()).authorities.contains(Role.findByAuthority("ROLE_COMMERCIAL"))}">
                                                <div>
                                                    <i class="fa fa-question-circle ml-2"
                                                       style="font-size: 20px; color: grey"></i>
                                                </div>
                                            </g:if>

                                        </div>

                                    </td>

                                    <td>
                                        ${devis.client}
                                    </td>
                                    <td>
                                        <g:formatDate date="${devis?.date}" format="dd MMMM yyyy" locale="fr"/>
                                    </td>
                                    <td>
                                        ${devis.typeProjet}
                                    </td>
                                    <td>${devis.concepteur}</td>

                                </tr>

                            </g:each>
                            </tbody>
                        </table>

                    </div>

                    <div class="tab-pane" id="p-profile4" role="tabpanel">

                        <table width="100%" class="table dataTable table-hover table-bordered table-striped">
                            <thead>
                            <tr>
                                <th class="noExport"></th>
                                <th class="menu noSorting"></th>
                                <th>No. Devis</th>
                                <th>Client</th>
                                <th>Date de création</th>
                                <th>Type de projet</th>
                                <th>Concepteur</th>
                            </tr>
                            </thead>
                            <tbody>
                            <g:each var="devis" in="${devisBrouillons}">

                                <tr>
                                    <td></td>
                                    <td>

                                        <div class="dropdown">
                                            <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink4"
                                               data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                <i class="fa fa-list"></i>
                                            </a>

                                            <div id="dropdown-menu4" class="dropdown-menu"
                                                 aria-labelledby="dropdownMenuLink4">

                                                <g:link class="dropdown-item" controller="devis" action="show"
                                                        id="${devis.id}">
                                                    Accéder aux détails
                                                </g:link>
                                            </div>
                                        </div>

                                    </td>
                                    <td>
                                        ${devis.idInsitu}
                                    </td>
                                    <td>
                                        ${devis.client}
                                    </td>
                                    <td>
                                        <g:formatDate date="${devis?.date}" format="dd MMMM yyyy" locale="fr"/>
                                    </td>
                                    <td>
                                        ${devis.typeProjet}
                                    </td>
                                    <td>${devis.concepteur}</td>

                                </tr>

                            </g:each>
                            </tbody>
                        </table>

                    </div>

                </div>
            </div>
        </div>

    </div>
</div>


<g:each var="devis" in="${devisAttente}">

    <div class="modal fade" id="infoContact${devis.id}" tabindex="-1" role="dialog">
        <div class="modal-dialog full-width">
            <div class="modal-content">
                <div class="modal-header">
                    <button class="close" type="button" data-dismiss="modal"
                            aria-hidden="true"><span
                            class="s7-close"></span></button>
                </div>

                <div class="modal-body">

                    <h2>Informations de contact</h2>
                    <hr>

                    <div class="row ml-4 mr-4 mt-4 mb-0">

                        <div class="col-lg-4 mb-4">
                            <table class="no-border no-strip skills">
                                <tbody class="no-border-x no-border-y">
                                <tr>
                                    <td>
                                        ${devis.client}
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        ${devis.telephoneClient}
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Devis No. ${devis.idInsitu}
                                    </td>
                                </tr>

                                <tr>
                                    <td>
                                        Projet: ${devis.typeProjet}
                                    </td>
                                </tr>


                                <tr>
                                    <td>
                                        Créé le:
                                        <g:formatDate date="${devis.date}" format="dd MMM yyyy"
                                                      locale="fr"></g:formatDate>
                                    </td>
                                </tr>


                                <tr>
                                    <td>Montant: ${devis.montant > 0 ? new java.text.DecimalFormat("###,###.00 €").format(devis.montant).replaceAll(",", " ") : "0.00 €"}
                                    </td>

                                </tr>

                                <tr>
                                    <td>
                                        Concepteur: ${devis.concepteur}
                                    </td>
                                </tr>

                                </tbody>
                            </table>
                        </div>


                        <div class="col-lg-8">

                            <g:render template="relanceCommentaires" model="[devis: devis]"/>

                        </div>

                    </div>


                    <g:if test="${!devis.toujoursInteresse}">
                        <div class="row m-4 justify-content-end" id="actions-buttons${devis.id}">

                            <button class="btn btn-secondary m-2" style="min-width: 230px"
                                    onclick="ajouterEssai('${devis.id}')">
                                <i class="fa fa-user-times"></i> Le client est injoignable
                            </button>

                            <button class="btn btn-secondary m-2" style="min-width: 230px"
                                    onclick="clientToujoursInteresse('${devis.id}')">
                                <i class="fa fa-thumbs-o-up"></i> Le client est toujours intéressé</button>

                            <button class="btn btn-secondary m-2" style="min-width: 230px"
                                    onclick="declinerDevis('${devis.id}')">
                                <i class="fa fa-times"></i> Le client décline la proposition
                            </button>

                        </div>
                    </g:if>

                </div>

            </div>
        </div>
    </div>
    </div>

</g:each>


<asset:javascript src="js/app-relance.js"/>

</body>
</html>