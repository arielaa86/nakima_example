<%--
  Created by IntelliJ IDEA.
  User: ariel
  Date: 14/04/2020
  Time: 14:14
--%>

<%@ page import="java.text.SimpleDateFormat" contentType="text/html;charset=UTF-8" %>

<html>
<head>
    <meta name="layout" content="main"/>
    <title>Suivi Encaissements</title>

    <asset:stylesheet src="lib/datepicker/css/bootstrap-datepicker.standalone.css"/>
    <asset:stylesheet src="css/statistiques.css"/>

    <style>

        .dataTables_empty{

            font-size: 12px!important;
            color: grey;

        }


        @media print {

            body {
                height: 0px !important;
            }

            .fade {
                background-color: white !important;
            }

            .noPrint input, textarea {
                display: none !important;
                height: 0px !important;
            }

            .navbar, .noPrint, .btn {
                display: none !important;
                height: 0px !important;
            }

            #firma {
                width: 300px;
            }

            .print {
                height: auto !important;
                visibility: visible;
            }





        }

    </style>
</head>

<body>

<div class="card card-default card-table m-2 p-2">

    <div class="card card-header">
        <div class="row" style="color: rgba(0,0,0,0.7); vertical-align: middle">
            <div class="col-lg-12" style="font-size: 22px;">
                <i class="fa fa-download"></i> Suivi des encaissements
            </div>
        </div>

        <hr>
    </div>


    <div class="card-body pt-4 pb-4">
        <g:formRemote id="dateForm" name="dateForm" url="[controller: 'paiement', action: 'suiviEncaissementAjax']"
                      update="update" method="POST">

            <div class="row justify-content-center m-4">

                <div id="month" class="col-12 col-sm-4 col-lg-3">

                    <div id="datePicker" class="input-group">
                        <input type="text" name="date" class="form-control" id="date" aria-describedby="btnGroupAddon"
                               value="${actualDate}"
                               autocomplete="off">

                        <div id="dateIcon" style="position: relative; top: 11px; right: 30px;">
                            <i class="fa fa-calendar-o"></i>
                        </div>
                    </div>

                </div>

                <button style="display: none" id="submit" class="btn btn-primary" type="submit"><i
                        class="fa fa-search"></i></button>

            </div>
        </g:formRemote>





        <div id="update">

            <g:render template="encaissementTemplate" />

        </div>

    </div>

</div>


</div>

<asset:javascript src="lib/jquery/jquery.min.js"/>
<asset:javascript src="lib/datepicker/js/bootstrap-datepicker.js"/>
<asset:javascript src="lib/datepicker/locales/bootstrap-datepicker.fr.min.js"/>


<script>
    var picker = $('#date').datepicker({
        container: '#datePicker',
        format: "dd MM yyyy",
        startView: "days",
        minViewMode: "days",
        autoclose: true,
        language: 'fr-FR',
        endDate: '${maxDate}'

    }).on('changeDate', function (ev) {
        document.getElementById("submit").click();
    });



    function rotate(id) {
        var img = document.getElementById(id);
        var rotate = img.style.transform;
        var degrees = 0;

        if (rotate !== null) {

            degrees = 90 + parseInt(rotate.split('(')[1].split('d')[0]);

        }

        img.style.transform = 'rotate(' + degrees + 'deg)';

    }


    function rotateLeft(id) {
        var img = document.getElementById(id);
        var rotate = img.style.transform;
        var degrees = 0;

        if (rotate !== null) {

            degrees = parseInt(rotate.split('(')[1].split('d')[0]) - 90;

        }

        img.style.transform = 'rotate(' + degrees + 'deg)';


    }


    function zoomin(id) {
        var GFG = document.getElementById(id);
        var currWidth = GFG.clientWidth;
        GFG.style.width = (currWidth + 80) + "px";
    }

    function zoomout(id) {

        var GFG = document.getElementById(id);
        var currWidth = GFG.clientWidth;
        GFG.style.width = (currWidth - 80) + "px";

    }


    function up(id) {

        var img = document.getElementById(id);
        var up = img.style.marginTop;
        var qty = 0;

        if (up !== null) {
            qty = parseInt(up.split('px')[0]) - 30;
        }

        img.style.marginTop = qty + "px";

    }


    function down(id) {

        var img = document.getElementById(id);
        var up = img.style.marginTop;
        var qty = 0;

        if (up !== null) {
            qty = parseInt(up.split('px')[0]) + 30;
        }

        img.style.marginTop = qty + "px";

    }

</script>

</body>
</html>