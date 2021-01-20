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

<body style="height: 0px">


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

<asset:javascript src="lib/jquery.maskedinput/jquery.maskedinput.js"/>
<asset:javascript src="js/app-form-masks.js"/>
<asset:javascript src="lib/sweetalert2/sweetalert2.min.js"/>
<asset:javascript src="js/app-ui-sweetalert2.js"/>
<asset:javascript src="js/app-ui-notifications.js"/>
<asset:javascript src="lib/jquery.gritter/js/jquery.gritter.js"/>

<asset:javascript src="lib/signature_pad/js/signature_pad.js"/>
<asset:javascript src="lib/signature_pad/js/app.js"/>

<asset:javascript src="js/app-notificationsPusher.js"/>
<asset:javascript src="js/app-activites.js"/>
<asset:javascript src="js/app-utils.js"/>




<script>


    $(document).ready(function () {


        App.init();
        App.masks();
        activeDataTables();
        updateDataTables();

        App.formElements();

    });





</script>

</body>
</html>
