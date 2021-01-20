<%--
  Created by IntelliJ IDEA.
  User: ariel
  Date: 14/04/2020
  Time: 14:14
--%>

<%@ page import="mccorletagencement.Utilisateur; java.text.SimpleDateFormat" contentType="text/html;charset=UTF-8" %>

<html>
<head>
    <meta name="layout" content="main"/>
    <title>Suivi des poses</title>



    <asset:stylesheet src="lib/datepicker/css/bootstrap-datepicker.standalone.css"/>
    <asset:stylesheet src="css/statistiques.css"/>


    <style>

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
    }

    </style>

</head>

<body>

<div class="card card-default card-table m-2 p-2">

    <div class="card card-header">
        <div class="row" style="color: rgba(0,0,0,0.7); vertical-align: middle">
            <div class="col-lg-12" style="font-size: 22px;">
                <i class="s7-piggy" style="font-weight: bold; font-size: 22px"></i> Suivi des poses
            </div>
        </div>

        <hr>
    </div>


    <div class="card-body pt-4 pb-4">
        <g:formRemote id="dateForm" name="dateForm" url="[controller: 'utilisateur', action: 'suiviDesPosesAjax']"
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

            <g:render template="posesTemplate" model="['previsionnelles': previsionnelles, 'realisees': realisees,  'totalSupplement': totalSupplement, 'totalPaiements':totalPaiements]"/>

        </div>

        <g:hiddenField name="devisId" id="devisId" value="" />


        <div class="modal fade" id="poseSupplementModal" data-backdrop="static" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">

                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <h5 class="modal-title text-center mb-2" id="exampleModalLabel">Ajouter supplément</h5>

                        <div class="row form-group justify-content-center">
                            <div class="col-sm-6">
                                <input autocomplete="off" type="text" class="form-control" id="supplement" value="0" />
                            </div>
                        </div>


                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Annuler</button>
                        <button type="button" class="btn btn-success" id="sauvegarderSupplement">Sauvegarder</button>
                    </div>
                </div>
            </div>
        </div>


        <div class="row m-6 justify-content-end noPrint">
            <button class="btn btn-secondary" style="min-width: 150px" onclick="window.print()"><i
                    class="fa fa-print"></i> Imprimer</button>
        </div>

    </div>

</div>



<asset:javascript src="lib/jquery/jquery.min.js"/>
<asset:javascript src="lib/datepicker/js/bootstrap-datepicker.js"/>
<asset:javascript src="lib/datepicker/locales/bootstrap-datepicker.fr.min.js"/>
<asset:javascript src="poseur/actions.js" />


<script>
    var picker = $('#date').datepicker({
        container: '#datePicker',
        format: "MM yyyy",
        startView: "months",
        minViewMode: "months",
        autoclose: true,
        language: 'fr-FR',
        endDate: '${maxDate}'

    }).on('changeDate', function (ev) {
        document.getElementById("submit").click();
    });


</script>

</body>
</html>