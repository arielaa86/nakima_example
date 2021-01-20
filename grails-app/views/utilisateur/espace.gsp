<%@ page import="mccorletagencement.Etiquette" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="layout" content="main"/>
    <title>Mon agenda</title>

    <asset:javascript src="lib/bootstrap/dist/js/bootstrap.bundle.js"></asset:javascript>
    <asset:stylesheet src="css/espace.css"/>

</head>

<body>

<div class="card m-2">
    <div class="card-body">

        <div class="row">

            <div class="col-md-6 col-sm-12">
                <div class="widget widget-calendar">
                    <div class="cal-container">
                        <div class="cal-calendar">
                            <div class="ui-datepicker"></div>
                            <a href="#" class="add-note" data-toggle="modal" data-target="#md-fullWidth">
                                <span class="icon s7-plus"></span>Nouvelle tâche</a>

                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-6 col-sm-12 taches">
                <div class="widget widget-calendar">
                    <div class="cal-container">
                        <div class="cal-notes">
                            <span class="day"></span>
                            <span class="date"></span>
                            <span></span>
                            <span class="title">Evènements</span>
                            <ul id="listeEvenement">

                                <g:render template="/utilisateur/agenda"/>

                            </ul>
                        </div>
                    </div>
                </div>
            </div>

        </div>



        <div class="row m-3">





            <g:each in="${joursDelaSemaine}" var="jourSemaine" status="i">
                <div class="col-lg-2 jour">

                    <h2 class="font-weight-light">${jourSemaine}</h2>

                    <g:each in="${tachesSemaine.get(i).getTaches().sort({it.heureDebut})}" var="tache">
                        <div class="card mb-4" style="border-bottom: solid 1px lightgray; border-left: solid 1px lightgray; border-right: solid 1px lightgray">
                            <div class="card-header card-header-color"
                                 style="background-color: ${tache.etiquette.couleur}; color: white; font-size: 12px;
                                 text-shadow: 0 0 1px #7a7a7a, 0 0 5px #7e7e7e; max-height: 30px; line-height: 0px;
                                 ">
                                <div class="d-flex justify-content-between">
                                    <span class="title">

                                        <g:if test="${!tache.journee}">
                                            <g:formatDate format="HH:mm" date="${tache.heureDebut}"/>&nbsp;-
                                            <g:formatDate format="HH:mm" date="${tache.heureFin}"/>
                                        </g:if>
                                        <g:else>
                                            <span>Toute la journée</span>
                                        </g:else>

                                    </span>

                                    <span>${tache.etiquette.evenement}</span>
                                </div>
                            </div>
                            <div class="card-body">
                                <div class="mt-1 mb-1">${tache.description}</div>
                                <small>Créé par: ${tache.creator}</small>
                            </div>
                        </div>

                    </g:each>
                </div>
            </g:each>

        </div>


    </div>

</div>

<div class="modal fade" id="md-fullWidth" tabindex="-1" role="dialog">
    <div class="modal-dialog full-width">
        <div class="modal-content">
            <div class="modal-header mb-0 pb-0">
                <button class="close" type="button" data-dismiss="modal" aria-hidden="true"><span
                        class="s7-close"></span></button>
            </div>

            <div class="modal-body mt-0 pt-0">

                <div class="row" style="color: rgba(0,0,0,0.6); vertical-align: middle;">
                    <div class="col-lg-12" style="font-size: 22px;">
                        <i class="fa fa-calendar-o"></i> Créer tâche
                    </div>
                </div>

                <hr>

                <div class="">

                    <g:form controller="tache" action="save" resource="${this.tache}" method="POST" autocomplete="off"
                            onsubmit="submit.disabled = true; return true;">

                        <g:render template="/tache/form"></g:render>


                        <div class="row justify-content-end">
                            <button id="submit" class="btn btn-lg btn-success" type="submit" id="submit">
                                <i class="fa fa-save"></i>
                                Enregistrer
                            </button>
                        </div>

                    </g:form>
                </div>
            </div>
        </div>
    </div>


    <asset:stylesheet src="lib/datepicker/css/bootstrap-datepicker.standalone.css"/>
    <asset:javascript src="lib/jquery/jquery.min.js"/>
    <asset:javascript src="lib/datepicker/js/bootstrap-datepicker.js"/>
    <asset:javascript src="lib/datepicker/locales/bootstrap-datepicker.fr.min.js"/>
    <asset:javascript src="js/app-espace.js"/>

</div>


</body>

</html>