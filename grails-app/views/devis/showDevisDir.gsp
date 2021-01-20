<%@ page import="mccorletagencement.ProjetComplementaire; mccorletagencement.Role; org.springframework.security.core.context.SecurityContextHolder; mccorletagencement.Utilisateur; mccorletagencement.ProjetAutre; mccorletagencement.ProjetPlacard; mccorletagencement.ProjetDressing; mccorletagencement.ProjetSalleBain; mccorletagencement.ProjetCuisine" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'devis.label', default: 'Devis')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>

    <style>

    .red-header {
        color: #832e00;
        font-weight: bold;
        font-size: 28px !important;
    "
    }

    th {
        font-weight: bold !important;
    }

    .item {
        font-weight: bold;
    }

    .gallery-container .item {

        min-height: 300px !important;
        max-height: 300px !important;

    }

    .imagen {

        min-height: 300px !important;
        max-height: 300px !important;
        object-fit: cover;
    }

    #actionsButtons .btn {
        width: 160px;
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


    .print {
        display: none;

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

    </style>

</head>

<body>

<g:set var="user"
       value="${Utilisateur.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName())}"></g:set>

<div class="card card-default card-table m-2">
    <div class="card-body pt-4 pb-4">


        <g:if test="${flash.error}">
            <div class="row justify-content-center m-3 noPrint">
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
                                ${flash.error}
                            </li>

                        </ul>

                    </div>
                </div>
            </div>

        </g:if>

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

        <g:if test="${!devis.envoye && !user.authorities.contains(Role.findByAuthority("ROLE_DIRECTEUR"))}">
            <div class="water-mark2">
                BROUILLON
            </div>
        </g:if>


        <g:if test="${devis.envoye && !devis.valide && !devis.approuve && !devis.decline && !user.authorities.contains(Role.findByAuthority("ROLE_DIRECTEUR"))}">
            <div class="water-mark2">
                BROUILLON
            </div>
        </g:if>


        <div class="row ml-4 mr-4 mt-4 mb-0">
            <div class="card card-default">
                <div class="card-header card-header red-header">

                    <g:if test="${devis.montant > 0 && devis.getProjet().instanceOf(ProjetComplementaire)}">
                        Devis complémentaire No. ${devis.getProjet()?.idInsitu} <br> lié au bon de commande No. ${devis.getProjet().projetPrincipal.idInsitu}
                    </g:if>
                    <g:else>

                        <g:if test="${devis.montant < 0 && devis.getProjet().instanceOf(ProjetComplementaire)}">
                            Avoir No. ${devis.getProjet()?.idInsitu} <br> lié au bon de commande No. ${devis.getProjet().projetPrincipal.idInsitu}
                        </g:if>
                        <g:else>
                            Devis No. ${devis.getProjet()?.idInsitu}
                        </g:else>
                    </g:else>

                </div>

                <div class="card-body">
                    <table class="no-border no-strip skills">
                        <tbody class="no-border-x no-border-y">
                        <tr>
                            <g:if test="${devis.montant > 0}">
                                <td class="item">Désignation du produit:</td>
                            </g:if>
                            <g:else>
                                <td class="item">Description:</td>
                            </g:else>
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
                                ${devis.projet.client}
                                <i class="fa fa-phone ml-3"></i>
                                ${devis.projet.client.telephone + (devis.projet.client.telephoneFixe != null ? " / " + devis.projet.client.telephoneFixe : "")}
                            </td>

                        </tr>
                        <g:if test="${devis.montant > 0}">
                            <tr>
                                <td class="item">Adresse de livraison:</td>
                                <td>
                                    ${devis.getProjet().client.adresse + "  " + devis.getProjet().client.codePostal + " " + devis.getProjet().client.ville}
                                </td>
                            </tr>
                        </g:if>
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
                        <g:if test="${devis.montant >= 0}">
                            <tr>
                                <td class="item italic">Validité du devis:</td>
                                <td>
                                    ${devis.validite}
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
                <g:textArea style="line-height: 1.5" disabled class="form-control" id="commentaire" name="commentaire"
                            value="${devis.commentaire}"></g:textArea>
            </div>
        </div>


        <div class="row m-2 justify-content-center">
            <table class="table table-bordered table-responsive col-lg-8">
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

            <g:if test="${devis.montant >= 0}">
                <h1>DETAIL DU PRIX DU PROJET</h1>
            </g:if>
            <g:else>
                <h1>DETAIL DE L'AVOIR</h1>
            </g:else>

        </div>

        <g:if test="${user.authorities.contains(Role.findByAuthority("ROLE_DIRECTEUR")) && devis.montant > 0}">

            <g:hiddenField id="metreLineaire" value="${devis.metreLineaire}" name="metreLineaire"></g:hiddenField>
            <g:if test="${!this.devis.projet.instanceOf(ProjetComplementaire)}">

                <div class="row noPrint justify-content-center">
                    <div class="col-12 col-sm-8 col-lg-8 m-3">
                        <table class="table table-bordered">
                            <tbody>
                            <tr style="background-color: #e8e0da">
                                <td colspan="2" class="font-weight-bold" style="font-size: 20px">Budget client</td>
                                <td class="number font-weight-bold" style="font-size: 20px">
                                    ${devis.projet.budget.equals("Autre") ? devis.projet.budgetAutre : devis.projet.budget}
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>


                <div class="row noPrint justify-content-center">
                    <div class="col-12 col-sm-8 col-lg-8 m-3">
                        <table class="table table-bordered">
                            <tbody>
                            <tr style="background-color: #e8e0da">
                                <td class="font-weight-bold" style="font-size: 20px">Prix d'après le mètre linéaire</td>
                                <td class="number font-weight-bold"
                                    style="font-size: 20px">${devis.metreLineaire} m</td>
                                <td id="resultat" class="number font-weight-bold" style="font-size: 20px">

                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </g:if>

        </g:if>


        <g:if test="${!devis.envoye && !user.authorities.contains(Role.findByAuthority("ROLE_DIRECTEUR"))}">
            <div class="water-mark2">
                BROUILLON
            </div>
        </g:if>


        <g:if test="${devis.envoye && !devis.valide && !devis.approuve && !devis.decline && !user.authorities.contains(Role.findByAuthority("ROLE_DIRECTEUR"))}">
            <div class="water-mark2">
                BROUILLON
            </div>
        </g:if>

        <div class="row mt-4 justify-content-center">
            <div class="col-lg-8">
                <g:render template="tableExcelPrint"/>
            </div>
        </div>

        <g:if test="${user.authorities.contains(Role.findByAuthority("ROLE_DIRECTEUR")) && devis.projet.plans.size() > 0}">

            <div class="pagebreak"></div>

        </g:if>



    <g:if test="${user.authorities.contains(Role.findByAuthority("ROLE_DIRECTEUR"))}">

        <g:hiddenField id="metreLineaire" value="${devis.metreLineaire}" name="metreLineaire"></g:hiddenField>

        <div class="row gallery-container noPrint">
            <g:each var="planInstance" in="${devis.projet?.getPlans().sort { it.date }}">
                <div class="item col-lg-4">
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
                    <div class="modal-dialog full-width">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button class="close" type="button" data-dismiss="modal" aria-hidden="true"><span
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
                                    <img src="<g:createLink controller="plan" action="showPlan"
                                                            params="[id: planInstance.getId()]"/>"
                                         class="card-img-top">
                                </g:else>

                            </div>
                        </div>
                    </div>
                </div>

            </g:each>

        </div>

    </g:if>


    <g:hiddenField name="devisId" type="text" value="${this.devis.id}"/>

    <div class="row m-4 noPrint">
        <h4>Observations:</h4>

    </div>

    <div class="noPrint col-lg-6 col-md-7 col-sm-12 p-0 m-lg-4 m-sm-0" style="border: solid #dedede 1px">

        <g:render template="chatCommentaires"/>

    </div>

    <div id="actionsButtons" class="row mb-0 mr-5 mt-5 ml-5 justify-content-end noPrint">

        <g:link class="btn btn-space btn-outline-secondary" controller="projet" action="show"
                id="${this.devis.projet.id}">
            <i class="fa fa-chevron-left"></i> Détails du projet
        </g:link>

        <g:if test="${devis.envoye}">

            <g:if test="${devis.valide}">

                <g:if test="${!devis.approuve}">

                    <button class="btn btn-space btn-outline-secondary" type="button" onclick="window.print()">
                        <i class="fa fa-print"></i> Imprimer
                    </button>
                </g:if>
            </g:if>
        </g:if>


        <g:if test="${user.authorities.contains(Role.findByAuthority("ROLE_COMMERCIAL"))}">

            <g:if test="${!devis.decline}">

                            <g:if test="${!devis.envoye}">

                                <div class="dropdown">
                                     <button class="btn btn-outline-secondary dropdown-toggle" type="button" id="dropdownMenu1"
                                             data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                         Autres actions
                                         <i class="fa fa-chevron-up"></i>
                                     </button>

                                        <div class="dropdown-menu" aria-labelledby="dropdownMenu1">



                                                <g:link class="dropdown-item" action="declinerSansEnvoyer" controller="devis"
                                                        id="${devis.id}"  onclick="return confirm('Confirmez-vous que le client ne souhaite pas donner suite à ce devis ?');">
                                                    <i class="fa fa-times"></i> Décliner sans envoyer
                                                </g:link>

                                                <g:link class="dropdown-item" action="${devis.projet.instanceOf(ProjetComplementaire)? 'recommencerComplement' : 'edit'}" controller="devis"
                                                        id="${devis.id}" params="[projet: devis.projet.id]">
                                                    <i class="fa fa-pencil"></i> ${devis.projet.instanceOf(ProjetComplementaire) ? 'Recommencer' : 'Modifier' }
                                                </g:link>

                                                <g:if test="${!devis.projet.instanceOf(ProjetComplementaire)}">

                                                    <g:link class="dropdown-item" action="envoyer" controller="devis"
                                                            params="['id': devis.id]"
                                                            onclick="showAlertWait('Votre demande va être envoyée pour validation', 6000 )">
                                                        <i class="fa fa-send"></i> Envoyer
                                                    </g:link>

                                                </g:if>
                                                <g:else>

                                                    <g:link class="dropdown-item" action="modifierDocuments" controller="devis"
                                                            params="['id': devis.projet.projetPrincipal.id, 'idProjet': devis.projet.id]">
                                                        <i class="fa fa-send"></i> Envoyer
                                                    </g:link>

                                                </g:else>

                                        </div>
                                     </div>

                            </g:if>


                            <g:if test="${devis.envoye && devis.valide}">

                                  <div class="dropdown">
                                     <button class="btn btn-outline-secondary dropdown-toggle" type="button" id="dropdownMenu2"
                                             data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                         Autres actions
                                         <i class="fa fa-chevron-up"></i>
                                     </button>

                                        <div class="dropdown-menu" aria-labelledby="dropdownMenu2">


                                            <g:link class="dropdown-item" action="${devis.projet.instanceOf(ProjetComplementaire) ? 'recommencerComplement' : 'edit' }" controller="devis"
                                                    id="${devis.id}">
                                                <i class="fa fa-pencil"></i> ${devis.projet.instanceOf(ProjetComplementaire) ? 'Recommencer' : 'Modifier' }
                                            </g:link>

                                            <g:if test="${!devis.approuve}">

                                            <g:if test="${devis.projet.client.email != null}">
                                                <g:form controller="devis" action="envoyerEmail" params="['id': devis.id]"
                                                        onsubmit="submit.disabled = true; return true;">
                                                    <button type="submit" class="dropdown-item"
                                                            onclick="return sendMail()">
                                                        <i class="fa fa-send"></i> Envoyer par email
                                                    </button>
                                                </g:form>
                                            </g:if>

                                            <g:form resource="${this.devis}" action="updatePourLaBanque" method="PUT"
                                                    onsubmit="submit.disabled = true; return true;">
                                                <button type="submit" class="dropdown-item">
                                                    <i class="fa fa-university"></i> Devis banque
                                                </button>
                                            </g:form>

                                            <g:link class="dropdown-item" controller="factureClient" action="create"
                                                    params="['devis.id': devis.id]" style="color: #239768 !important;"
                                                    onclick="return confirm('Confirmez-vous que le client approuve ce devis ?');">
                                                <i class="fa fa-check"></i> Approuver
                                            </g:link>

                                            <g:link class="dropdown-item" controller="devis" action="decliner"
                                                    params="['id': devis.id]" style="color: #f12d16 !important;"
                                                    onclick="return confirm('Confirmez-vous que le client ne souhaite pas donner suite à ce devis ?');">
                                                <i class="fa fa-times"></i> Décliner
                                            </g:link>

                                        </g:if>

                                        </div>
                                    </div>

                             </g:if>

            </g:if>

        </g:if>



        <g:if test="${user.authorities.contains(Role.findByAuthority("ROLE_DIRECTEUR"))}">

            <g:if test="${devis.envoye}">

                    <g:if test="${!devis.valide}">

                        <div class="dropdown">
                              <button class="btn btn-outline-secondary dropdown-toggle" type="button" id="dropdownMenu3"
                                      data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                  Autres actions
                                  <i class="fa fa-chevron-up"></i>
                              </button>

                            <div class="dropdown-menu" aria-labelledby="dropdownMenu3">


                                 <button class="dropdown-item" type="submit" style="color: #239768 !important;"
                                         onclick="valider()">
                                     <i class="fa fa-check"></i> Oui, je valide
                                 </button>



                                 <button class="dropdown-item" type="submit" style="color: #f12d16 !important; "
                                         onclick="refuser()">
                                     <i class="fa fa-times"></i> Renégocier le prix
                                 </button>

                            </div>
                        </div>

                    </g:if>


                    <g:if test="${devis.decline}">

                        <div class="dropdown">
                                  <button class="btn btn-outline-secondary dropdown-toggle" type="button" id="dropdownMenu4"
                                          data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                      Autres actions
                                      <i class="fa fa-chevron-up"></i>
                                  </button>

                                <div class="dropdown-menu" aria-labelledby="dropdownMenu4">

                                    <g:if test="${devis.questionnaire == null}">

                                            <g:link class="dropdown-item" controller="questionnaire"
                                                    action="create" params="['devis.id': devis.id]">
                                                <i class="fa fa-commenting-o"></i> Compléter le questionnaire
                                            </g:link>


                                    </g:if>
                                    <g:else>

                                            <g:if test="${devis.isQuestionnaireCompleted()}">
                                                <g:link class="dropdown-item" controller="questionnaire"
                                                        action="show" id="${devis.questionnaire.id}">
                                                    <i class="fa fa-commenting-o"></i> Accéder au questionnaire
                                                </g:link>
                                            </g:if>
                                            <g:else>

                                                <g:link class="dropdown-item" controller="questionnaire"
                                                        action="edit" id="${devis.questionnaire.id}">
                                                    <i class="fa fa-commenting-o"></i> Compléter le questionnaire
                                                </g:link>

                                            </g:else>
                                    </g:else>


                                </div>
                        </div>

                    </g:if>

            </g:if>

        </g:if>

    </div>

    <div class="pagebreak"></div>

    <div class="print">
        <g:render template="conditions" model="[factureClient: null]"/>
    </div>

    </div>
</div>
    <asset:javascript src="lib/sweetalert2/sweetalert2.min.js"/>
    <asset:javascript src="js/app-ui-sweetalert2.js"/>
    <asset:javascript src="js/app-projetFonctionnes.js"/>
    <asset:javascript src="js/app-devisCalculShow.js"/>
    <asset:javascript src="commentaires/commentaire.js"/>
    <asset:javascript src="devis/actions.js"/>



    <script>

        getCommentaires();

        fitContent("commentaire");


        obtenirPrixMin();

        obtenirPrixProjet();


        function sendMail() {

            var resp = confirm('Vous êtes sur le point d' + '\'envoyer le devis par email au client. Confirmez-vous l' + '\'envoi ?');

            if (resp) {

                showAlertWait('Le devis est en cours d' + '\'envoi. Veuillez patienter', 15000);
                return true;
            }

            return false;

        }







    </script>
</body>
</html>
