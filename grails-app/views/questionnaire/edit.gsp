<%@ page import="mccorletagencement.ProjetAutre; mccorletagencement.ProjetPlacard; mccorletagencement.ProjetDressing; mccorletagencement.ProjetSalleBain; mccorletagencement.ProjetCuisine; mccorletagencement.Devis" %>

<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'questionnaire.label', default: 'Questionnaire')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>

        <style>
        tr{
            height: 40px;
            font-size: 16px;
        }

        .custom-control{
            font-size: 14px!important;
            margin-bottom: 2em!important;
            line-height: 20px;
        }
        </style>
    </head>
    <body>

    <div class="card card-default m-2 p-6">

        <div class="card-body">




            <g:if test="${flash.error}">
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
                                <li>
                                    ${flash.error}
                                </li>

                            </ul>

                        </div>
                    </div>
                </div>

            </g:if>


        <div class="row" style="color: rgba(0,0,0,0.7); vertical-align: middle">
            <div class="col-lg-12" style="font-size: 22px;">
                Questionnaire devis décliné
            </div>
        </div>

        <hr>

        <g:set var="devis" value="${this.questionnaire.devis}"></g:set>

        <div class="row ml-4 mr-4 mt-4 mb-6" style="font-size: 14px">
            <div class="card card-default col-lg-5">
                <div class="card-body">


                        <table class="no-border no-strip skills">
                        <tbody class="no-border-x no-border-y">
                        <tr>
                            <td>
                                ${devis.projet.client.intitule+" "+devis.projet.client.nom + " "+devis.projet.client.prenom}
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Téléphone:
                                ${devis.projet.client.telephoneFixe == null ? devis.projet.client.telephone : devis.projet.client.telephoneFixe}
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Devis No.
                                ${devis.projet.idInsitu}
                            </td>
                        </tr>

                        <tr>
                            <td>
                                Concepteur:
                                ${devis.projet.concepteur}
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Type de projet:
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

                            </td>
                        </tr>
                        <tr>
                            <td>
                                Type de chantier:
                                ${devis.projet.typeHabitation}
                            </td>
                        </tr>
                        <tr>
                            <td>Montant:

                                <g:if test="${devis.projet.instanceOf(ProjetSalleBain) && devis.projet.typeHabitation.equals("Maison") && devis.projet.quantitePieceEau > 1}">
                                    ${ devis.montant > 0 ? new java.text.DecimalFormat("###,###.00 €").format(devis.montant * devis.projet.quantitePieceEau).replaceAll(",", " ") : "0.00 €" } (${devis.projet.quantitePieceEau} pièces d'eau)
                                </g:if>
                                <g:else>

                                    <g:if test="${devis.projet.typeHabitation.equals("Immeuble")}">
                                        ${ devis.montant > 0 ? new java.text.DecimalFormat("###,###.00 €").format(devis.montant * devis.projet.quantiteHabitation ).replaceAll(",", " ") : "0.00 €" } (${devis.projet.quantiteHabitation} logements)
                                    </g:if>
                                    <g:else>

                                        ${ devis.montant > 0 ? new java.text.DecimalFormat("###,###.00 €").format(devis.montant ).replaceAll(",", " ") : "0.00 €" }

                                    </g:else>

                                </g:else>


                            </td>

                        </tr>
                        </tbody>
                    </table>

                </div>

            </div>


            <div class="col-lg-7">

                <h3>Historique des relances</h3>
                <g:render template="/devis/relanceCommentaires" model="[devis: this.questionnaire.devis]"/>

            </div>


        </div>

            <div class="row font-weight-bold ml-3">

                <p class="mb-5" style="font-size: 16px">
                    Afin de nous permettre d’améliorer nos services et de proposer de meilleures offres, pourriez-vous nous préciser la raison de votre refus :
                </p>

            </div>


            <g:form resource="${this.questionnaire}" method="PUT" onsubmit="submit.disabled = true; return true;">
                <g:hiddenField name="version" value="${this.questionnaire?.version}" />

                    <g:render template="form" />

                <div class="row justify-content-end">
                    <button class="btn btn-success" type="submit" id="submit"> <i class="fa fa-save"></i> ${message(code: 'default.button.update.label', default: 'Update')}</button>
                </div>

            </g:form>


        </div>
    </div>


    <asset:javascript src="js/app-relance.js"/>

    <script>


        getCommentairesRelance(${this.questionnaire.devis.id});


        function showAutreMotif(id) {

            var element = document.getElementById(id);


            if(!element.checked){
                document.getElementById("autreMotiftexte").style.display = "none";
            }else{
                document.getElementById("autreMotiftexte").style.display = "block";
            }


        }


        showAutreMotif("question7");


    </script>

    </body>
</html>
