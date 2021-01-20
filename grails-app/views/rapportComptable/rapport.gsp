<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="noMenu"/>
    <title>Rapport comptable</title>

    <asset:stylesheet src="lib/datepicker/css/bootstrap-datepicker.standalone.css"/>
    <asset:stylesheet src="css/statistiques.css"/>



    <style>



    .table tr th .custom-control, .table tr td .custom-control {
        padding: 4px;
        vertical-align: middle;
        margin-right: -12px;
    }


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

<div class="card card-default card-table m-2 p-2" style="top: -148px">

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
            <g:if test="${actionName != 'rapport'}">
                <div id="month" class="col-12 col-sm-4 col-lg-3">

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

            </g:if>
            <g:else>
                <label style="font-weight: bold; font-size: 14px">
                   <g:formatDate date="${rapportComptable.date}" locale="fr" format="MMMM yyyy" />
                </label>
            </g:else>

        </div>


        <div id="rapport">
            <g:render
                    template="${actionName == 'rapport' ? '/utilisateur/commissionGeneralComptable' : 'commissionGeneralComptable'}"
                    model="['listeSuiviCommercial': listeSuiviCommercial]"/>
        </div>

    </div>
</div>

<asset:javascript src="rapportComptable/actions.js"/>
<asset:javascript src="lib/jquery/jquery.min.js"/>

</body>
</html>