<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Rapport comptable</title>

    <asset:stylesheet src="lib/datepicker/css/bootstrap-datepicker.standalone.css"/>
    <asset:stylesheet src="css/statistiques.css"/>


</head>

<body>

<div class="card card-default card-table m-2 p-2">

    <div class="card card-header">
        <div class="row" style="color: rgba(0,0,0,0.7); vertical-align: middle">
            <div class="col-lg-12" style="font-size: 22px;">
                <i class="fa fa-paperclip"></i> Rapport comptable
            </div>
        </div>

        <hr>
    </div>


    <div class="card-body pt-4 pb-4">

        <div class="row justify-content-center m-4">

            <div id="month" class="col-12 col-sm-4 col-lg-3">

                <label for="datePicker">Sélectionner la date:</label>
                <div id="datePicker" class="input-group">

                    <input type="text" name="date" class="form-control" id="date" aria-describedby="btnGroupAddon"
                           value="${actualDate}"
                           autocomplete="off" onchange="getRapport()">

                    <div id="dateIcon" style="position: relative; top: 11px; right: 30px;">
                        <i class="fa fa-calendar-o"></i>
                    </div>
                </div>

            </div>

            <button style="display: none" id="submit" class="btn btn-primary" type="submit"><i
                    class="fa fa-search"></i></button>

        </div>


        <div id="rapport">
            <g:render template="commissionGeneralComptable" model="['listeSuiviCommercial': listeSuiviCommercial]"/>
        </div>



    </div>
</div>

<asset:javascript src="rapportComptable/actions.js"/>
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

    });


</script>

</body>
</html>
