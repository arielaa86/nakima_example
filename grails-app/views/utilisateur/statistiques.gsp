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
    <title>Statistiques</title>



    <asset:stylesheet src="lib/datepicker/css/bootstrap-datepicker.standalone.css"/>
    <asset:stylesheet src="css/statistiques.css" />
    <asset:javascript src="lib/chartjs/Chart.min.js"/>
    <asset:javascript src="js/app-charts-chartjs.js"/>



</head>

<body>

<div class="card card-default card-table m-2 p-2">

    <div class="card card-header">
        <div class="row" style="color: rgba(0,0,0,0.7); vertical-align: middle">
            <div class="col-lg-12" style="font-size: 22px;">
                <i class="fa fa-bar-chart"></i> Statistiques
            </div>
        </div>

        <hr>
    </div>


    <div class="card-body pt-4 pb-4">
        <%--
        <g:formRemote id="dateForm" name="dateForm" url="[controller: 'utilisateur', action: 'statistiquesAjax']"
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


            <div class="row justify-content-center">
                <div class="col-lg-11" style="font-size: 18px;">
                   Suivi de l'activité commerciale
                    <hr>
                </div>
            </div>



        <div id="update">

            <g:render template="statistiquesTemplate"/>


        </div>

        --%>

        <div class="row justify-content-center mt-6">
            <div class="col-lg-11" style="font-size: 18px;">
                Motifs des devis déclinés
                <hr>
            </div>
        </div>


        <div class="row justify-content-center m-3">

            <div class="col-lg-6 p-0">

                        <canvas id="donut-chart" class="chartjs-render-monitor p-0" style="display: block; width: 425px; height: 255px;"></canvas>

            </div>

            <div class="col-lg-6 p-0">

                <div class="card card-default">
                    <div class="card-body">
                        <div class="mt-3">
                            <div class="list-group">
                                <g:each in="${dataInfo.getLabels()}" var="label" status="i">

                                    <a class="list-group-item d-flex list-group-item-action disabled" href="#" style="border: none; text-align: left;">

                                        <span class="badge badge-pill" style="max-height: 20px; background-color: ${dataInfo.getColors().get(i)} ; border: none; color: white; font-weight: bold">
                                            ${dataInfo.getValues().get(i)}
                                        </span>
                                        <span class="text ml-3" >${label}</span>

                                    </a>

                                </g:each>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

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
        format: "MM yyyy",
        startView: "months",
        minViewMode: "months",
        autoclose: true,
        language: 'fr-FR',
        endDate: '${maxDate}'

    }).on('changeDate', function (ev) {
        document.getElementById("submit").click();
    });


    donutChart(${dataInfo.getValues().toString()} );

</script>

</body>
</html>