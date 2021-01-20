<%@ page import="mccorletagencement.Tache; mccorletagencement.Role; grails.web.context.ServletContextHolder; mccorletagencement.Notification; mccorletagencement.Utilisateur; org.springframework.security.core.context.SecurityContextHolder" ,  %>
<!doctype html>
<html lang="fr" class="no-js">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>
        <g:layoutTitle default="Grails"/>

    </title>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>

    <asset:stylesheet src="lib/stroke-7/style.css"/>
    <asset:stylesheet src="lib/perfect-scrollbar/css/perfect-scrollbar.css"/>
    <asset:stylesheet src="css/themes/passion.css"/>

    <!-- DataTables -->
    <asset:stylesheet src="DataTablesB4/datatables.css"/>



    <!-- Icons -->
    <asset:stylesheet src="icon/themify-icons/themify-icons.css"/>
    <asset:stylesheet src="icon/font-awesome/css/font-awesome.min.css"/>
    <asset:stylesheet src="icon/typicons-icons/css/typicons.min.css"/>

    <asset:stylesheet src="lib/sweetalert2/sweetalert2.min.css"/>
    <asset:stylesheet src="lib/jquery.gritter/css/jquery.gritter.css"/>


    <asset:stylesheet src="signature_pad/css/ie9.css"/>
    <asset:stylesheet src="signature_pad/css/signature-pad.css"/>
    <asset:stylesheet src="css/main.css"/>
    <asset:stylesheet src="css/animate.css"/>



    <script src="https://js.pusher.com/5.1/pusher.min.js"></script>


    <g:layoutHead/>

</head>

<body>

<div id="sound"></div>

<div id="cssmenu">
    <nav class="navbar navbar-expand navbar-dark mai-top-header">
        <div class="container">
            <a class="navbar-brand" href="#">

            </a>
            <ul class="nav navbar-nav mai-top-nav">

            </ul>
            <ul class="navbar-nav float-lg-right mai-icons-nav">
                <li class="dropdown nav-item mai-notifications">
                    <a id="search" class="nav-link" data-toggle="modal" data-target="#advancedSearch"
                       role="button"
                       aria-expanded="false" onclick="">
                        <span class="icon s7-search"></span>
                    </a>
                </li>
                <li class="dropdown nav-item mai-notifications">
                    <a id="notificationIcon" class="nav-link dropdown-toggle" href="#" data-toggle="dropdown"
                       role="button"
                       aria-expanded="false" onclick="hideIconAlert();
                    return false">
                        <span class="icon s7-bell"></span>
                        <span class="indicator blink_me" id="redAlert" style="display: none"></span>
                    </a>
                    <ul class="dropdown-menu">
                        <li>
                            <div class="title">Notifications</div>

                            <div class="mai-scroller-notifications" id="notifications">
                                <div class="content">
                                    <ul id="listNotifications">

                                    </ul>
                                </div>
                            </div>
                        </li>
                    </ul>
                </li>

            </ul>
            <ul class="nav navbar-nav float-lg-right mai-user-nav">
                <li class="dropdown nav-item"><a class="dropdown-toggle nav-link" href="#" data-toggle="dropdown"
                                                 role="button" aria-expanded="false">

                    <span class="user-name">

                        ${Utilisateur.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName())?.toString()}
                        <g:hiddenField name="userId" id="userId"
                                       value="${Utilisateur.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName())?.id}"/>

                    </span><span class="angle-down s7-angle-down"></span></a>
                    <g:form id="logout" controller="logout">
                        <div class="dropdown-menu" role="menu">
                            <g:link class="dropdown-item" controller="utilisateur" action="monCompte"
                                    id="${Utilisateur.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName())?.id}"
                                    style="color: white!important;">
                                <span class="icon s7-user"></span>Mon compte
                            </g:link>

                            <button id="logout" class="dropdown-item" type="submit" style="color: white!important;">
                                <span class="icon s7-power"></span>Déconnexion
                            </button>

                        </div>

                    </g:form>
                </li>
            </ul>
        </div>
    </nav>

    <nav class="navbar navbar-expand-lg mai-sub-header">
        <div class="container">
            <nav class="navbar navbar-expand-md">
                <button class="navbar-toggler hidden-md-up collapsed" type="button" data-toggle="collapse"
                        data-target="#mai-navbar-collapse" aria-controls="mai-navbar-collapse" aria-expanded="false"
                        aria-label="Toggle navigation"><span
                        class="icon-bar"><span></span><span></span><span></span>
                </span></button>

                <div class="navbar-collapse collapse mai-nav-tabs" id="mai-navbar-collapse">
                <ul class="nav navbar-nav">
                    <li class="nav-item parent" id="home"><a class="nav-link" href="#" role="button"
                                                             aria-expanded="false"><span
                                class="icon s7-home"></span><span>Accueil</span></a>
                        <ul class="mai-nav-tabs-sub mai-sub-nav nav">
                            <li class="nav-item"><a class="nav-link" href="${createLink(uri: '/')}">
                                <span class="fa fa-calendar-o"></span> <span class="name">Agenda</span></a>
                            </li>
                            <li class="nav-item">
                                <g:link controller="utilisateur" action="toDoList" class="nav-link">
                                    <i class="fa fa-list-ol"></i> Mémo
                                </g:link>
                            </li>
                        </ul>
                    </li>



                    <g:if test="${Utilisateur.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName())}">

                        <g:if test="${Utilisateur.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName()).authorities.contains(Role.findByAuthority("ROLE_DIRECTEUR")) ||
                                Utilisateur.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName()).authorities.contains(Role.findByAuthority("ROLE_COMMERCIAL"))}">

                            <li class="nav-item parent" id="gestion_commerciale"><a class="nav-link" href="#"
                                                                                    role="button"
                                                                                    aria-expanded="false"><span
                                        class="icon s7-id"></span><span>Gestion Commerciale</span></a>
                                <ul class="mai-nav-tabs-sub mai-sub-nav nav">

                                    <li class="nav-item">
                                        <g:link controller="client" action="create" class="nav-link">
                                            <i class="fa fa-plus"></i> Nouveau client
                                        </g:link>
                                    </li>

                                    <li class="nav-item">
                                        <g:link controller="client" action="index" class="nav-link">
                                            <i class="fa fa-address-book-o"
                                               style="font-size: 16px"></i> Liste des clients
                                        </g:link>
                                    </li>

                                    <li class="nav-item">

                                        <g:if test="${Utilisateur.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName()).authorities.contains(Role.findByAuthority("ROLE_COMMERCIAL"))}">
                                            <g:link controller="utilisateur" action="portefeuille" class="nav-link">
                                                <i class="fa fa-folder-open-o"></i> Mon portefeuille
                                            </g:link>
                                        </g:if>
                                        <g:else>
                                            <g:link controller="utilisateur" action="gestionTransfert" class="nav-link">
                                                <i class="fa fa-folder-open-o"></i> Portefeuilles
                                            </g:link>
                                        </g:else>
                                    </li>

                                    <li class="nav-item">
                                        <g:link controller="devis" action="suiviDevis" class="nav-link">
                                            <i class="fa fa-file-o"></i> Devis
                                        </g:link>
                                    </li>
                                    <li class="nav-item">
                                        <g:link controller="factureClient" action="suiviBDC" class="nav-link">
                                            <i class="fa fa-file-text-o"></i> Bons de commande
                                        </g:link>
                                    </li>
                                    <li class="nav-item">
                                        <g:link controller="factureClient" action="suiviFactures" class="nav-link">
                                            <i class="fa fa-file"></i> Factures
                                        </g:link>
                                    </li>

                                </ul>
                            </li>

                        </g:if>
                    </g:if>



                    <li class="nav-item parent" id="production">
                        <a class="nav-link" href="#" role="button" aria-expanded="false">
                            <span class="icon s7-tools"></span> <span>Production</span>
                        </a>
                        <ul class="mai-nav-tabs-sub mai-sub-nav nav">
                            <li class="nav-item">
                                <g:link class="nav-link" controller="ordreProduction" action="suiviGeneral"><span
                                        class="fa fa-th"></span> <span class="name">Planning</span>
                                </g:link>
                            </li>
                            <li class="nav-item">
                                <g:link class="nav-link" controller="ordreProduction" action="index">
                                    <span class="fa fa-tasks"></span>
                                    <span class="name">Suivi</span>
                                </g:link>
                            </li>

                        </ul>
                    </li>

                    <g:if test="${Utilisateur.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName())}">

                        <g:if test="${Utilisateur.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName()).authorities.contains(Role.findByAuthority("ROLE_DIRECTEUR"))}">

                            <li class="nav-item parent" id="gestion_financiere"><a class="nav-link" href="#"
                                                                                   role="button"
                                                                                   aria-expanded="false"><span
                                        class="icon s7-calculator"></span><span>Gestion Financière</span></a>
                                <ul class="mai-nav-tabs-sub mai-sub-nav nav">
                                    <li class="nav-item">
                                        <g:link class="nav-link" controller="utilisateur" action="statistiques">
                                            <i class="fa fa-bar-chart"></i> Statistiques
                                        </g:link>
                                    </li>
                                    <li class="nav-item">
                                        <g:link controller="paiement" action="suiviEncaissement" class="nav-link">
                                            <i class="fa fa-download"></i> Encaissements
                                        </g:link>
                                    </li>

                                    <li class="nav-item dropdown parent">
                                        <a class="nav-link" href="#" data-toggle="dropdown" aria-expanded="true">
                                            <i class="s7-piggy"
                                               style="font-weight: bold; font-size: 16px"></i> Commissions
                                        </a>

                                        <div class="dropdown-menu mai-sub-nav" role="menu">

                                            <g:link controller="utilisateur" action="suiviCommission"
                                                    class="dropdown-item">
                                                Commerciaux
                                            </g:link>

                                            <g:link controller="utilisateur" action="suiviDesPoses"
                                                    class="dropdown-item">Poseur
                                            </g:link>

                                        </div>
                                    </li>

                                    <li class="nav-item">
                                        <g:link controller="utilisateur" action="rapportComptable" class="nav-link">
                                            <i class="fa fa-paperclip"></i> Rapport comptable
                                        </g:link>
                                    </li>

                                    <li class="nav-item       <%-- dropdown parent --%> ">
                                    <g:link controller="categorie" action="index" class="nav-link" aria-expanded="true">
                                            <span class="icon fa fa-line-chart"
                                                  style="font-size: 14px"></span>
                                            <span class="name">Chiffre d'affaires</span>
                                    </g:link>
                                        <%--
                                        <div class="dropdown-menu mai-sub-nav" role="menu">


                                            <g:link controller="categorie" action="index" class="dropdown-item">
                                                Postes de dépenses
                                            </g:link>

                                            <g:link controller="factureFournisseur" action="index"
                                                    class="dropdown-item">
                                                Factures fournisseurs
                                            </g:link>

                                        </div>
                                        --%>
                                    </li>

                                </ul>
                            </li>

                        </g:if>
                    </g:if>


                    <g:if test="${Utilisateur.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName())}">

                        <g:if test="${Utilisateur.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName()).authorities.contains(Role.findByAuthority("ROLE_ADMIN"))}">

                            <li class="nav-item parent" id="parametres">
                                <a class="nav-link" href="#" role="button" aria-expanded="false"><span
                                        class="icon s7-config"></span><span>Paramètres</span></a>
                                <ul class="mai-nav-tabs-sub mai-sub-nav nav">
                                    <li class="nav-item">
                                        <g:link class="nav-link" controller="utilisateur" action="index">
                                            <i class="fa fa-list"></i> Liste d'utilisateurs
                                        </g:link>
                                    </li>
                                    <li class="nav-item">
                                        <g:link class="nav-link" controller="utilisateur" action="create">
                                            <i class="fa fa-plus"></i> Nouvel utilisateur
                                        </g:link>
                                    </li>
                                </ul>


                            </ul>
                          </li>

                        </g:if>
                    </g:if>
                </ul>
                </div>
            </nav>

        </div>
    </nav>
</div>




<div class="modal fade" id="advancedSearch" tabindex="-1" role="dialog">
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
                    <div class="col-lg-2 todo-new-task todo-new-task2">
                        <div class="input-group">

                            <input required="" id="description" class="form-control" type="text" onkeyup="searchAll()"
                                   placeholder="Rechercher ..." autocomplete="off">
                            <i class="icon s7-search" style="font-size: 28px!important; margin-top: 6px;"></i>

                        </div>

                    </div>
                </div>

                <div class="row m-6 justify-content-center">

                    <div class="col-lg-8" id="resultat">

                    </div>

                </div>

            </div>
        </div>
    </div>
</div>


<g:layoutBody/>



<asset:javascript src="lib/jquery/jquery.min.js"/>
<asset:javascript src="lib/perfect-scrollbar/js/perfect-scrollbar.min.js"/>
<asset:javascript src="lib/bootstrap/dist/js/bootstrap.bundle.min.js"/>
<asset:javascript src="js/app.js"/>
<asset:javascript src="js/app-form-elements.js"/>


<asset:javascript src="DataTablesB4/datatables.min.js"/>
<asset:javascript src="DataTablesB4/Buttons-1.5.4/dataTables.buttons.min.js"/>
<asset:javascript src="DataTablesB4/JSZip-2.5.0/jszip.min.js"/>
<asset:javascript src="js/datatablesFunctions.js"/>

<asset:javascript src="js/app-notificationsPusher.js"/>


<asset:javascript src="lib/jquery.maskedinput/jquery.maskedinput.js"/>
<asset:javascript src="js/app-form-masks.js"/>
<asset:javascript src="lib/sweetalert2/sweetalert2.min.js"/>
<asset:javascript src="js/app-ui-sweetalert2.js"/>
<asset:javascript src="js/app-ui-notifications.js"/>

<%--
<asset:javascript src="application" />
<asset:javascript src="spring-websocket" />
--%>

<asset:javascript src="lib/jquery.gritter/js/jquery.gritter.js"/>

<asset:javascript src="lib/signature_pad/js/signature_pad.js"/>
<asset:javascript src="lib/signature_pad/js/app.js"/>


<asset:javascript src="js/app-activites.js"/>
<asset:javascript src="js/app-utils.js"/>

<!-- calendar widget -->
<asset:javascript src="lib/jquery-ui/jquery-ui.min.js"/>
<asset:javascript src="js/app-pages-profile.js"/>
<asset:javascript src="lib/jquery-ui/datepicker-fr.js"/>

<asset:javascript src="js/app-pages-gallery.js"/>

<asset:javascript src="advancedSearch/actions.js"/>



<script>


    $(document).ready(function () {

        App.init();
        App.profile();
        App.uiSweetalert2();
        App.uiNotifications();
        App.masks();
        activeDataTables();
        updateDataTables();
        App.formElements();

    });


    $(window).on('load', function () {
        showActiveTab('${session.controller}');
        ${session.controller = null}
        App.pageGallery();

    });

    <g:if test="${flash.message && !actionName.equals("auth")}">
    setTimeout(function () {
        showAlert('${flash.message}');
    }, 150);
    </g:if>


    $('[id^=paiementMultiple]').on('hidden.bs.modal', function () {
        location.reload();
    });


    $('#horsLivraison').click(function () {

        $('#poseIncluse').prop("checked", false);
        $('#livraisonIncluse').prop("checked", false);

        $('#enlevement').prop("checked", false);
        $('#livraisonMC').prop("checked", false);

        if ($('#horsLivraison').prop("checked") && $('#horsPose').prop("checked")) {

            $('#enlevement').prop("checked", true);
        } else {
            $('#enlevement').prop("checked", false);
        }


    });


    $('#livraisonIncluse').click(function () {

        $('#horsLivraison').prop("checked", false);

        $('#enlevement').prop("checked", false);
        $('#livraisonMC').prop("checked", false);


        if ($('#livraisonIncluse').prop("checked") && $('#poseIncluse').prop("checked")) {

            $('#livraisonMC').prop("checked", true);
        } else {
            $('#livraisonMC').prop("checked", false);
        }

    });


    $('#poseIncluse').click(function () {

        $('#horsLivraison').prop("checked", false);
        $('#horsPose').prop("checked", false)
        $('#livraisonIncluse').prop("checked", true);


        $('#enlevement').prop("checked", false);
        $('#livraisonMC').prop("checked", false);


        if ($('#livraisonIncluse').prop("checked") && $('#poseIncluse').prop("checked")) {

            $('#livraisonMC').prop("checked", true);
        } else {
            $('#livraisonMC').prop("checked", false);
        }

    });


    $('#horsPose').click(function () {

        $('#poseIncluse').prop("checked", false);

        $('#enlevement').prop("checked", false);
        $('#livraisonMC').prop("checked", false);

        if ($('#horsLivraison').prop("checked") && $('#horsPose').prop("checked")) {

            $('#enlevement').prop("checked", true);
        } else {
            $('#enlevement').prop("checked", false);
        }

    });


    $('body').on('keypress', 'input', function (args) {

        if (args.keyCode == 13) {

            if (args.target.name === "texte" || args.target.id === "password") {
                saveCommentaire();
                return true;
            } else {
                return false;
            }

        }
    });


    if (localStorage.getItem('showAlert') === "yes") {
        showIconAlert();
    }


    $('#commentaireTechnicien').on('hide.bs.modal', function () {
        changerEtat(false);

        document.querySelector("textarea[id=commentaireModal]").value = "";

    })

    $('#myModal2').on('hidden.bs.modal', function (e) {
        $('body').addClass('modal-open');
    });

    $('#myModal3').on('hidden.bs.modal', function (e) {
        $('body').addClass('modal-open');
    });


    $('.modalRecu').on('hidden.bs.modal', function (e) {
        $("#paiements").load(window.location.href + " #paiements");
    });


</script>



</body>
</html>
