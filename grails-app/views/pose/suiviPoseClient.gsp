<%@ page import="java.text.DecimalFormat" %>
<!DOCTYPE html>
<html>
<head>

    <meta name="layout" content="main"/>
    <title></title>

    <style>

    .dataTables_filter{
        margin-bottom: 20px!important;
    }

    </style>

</head>

<body style="background-color: white">

<div class="card card-default card-table">

    <div class="card-header card-header-divider m-4 font-weight-bold">Prochaines livraisons</div>

    <div class="card-body">

        <div class="col-lg-12">

            <table cellspacing="0"
                   class="table dataTableNoImport table-hover table-bordered table-striped">
                <thead>
                <tr>
                    <th class="noSorting font-weight-bold">Date</th>
                    <th class="noSorting font-weight-bold">Client</th>
                </tr>
                </thead>
                <tbody>
                <g:each var="ordre" in="${ordres}">
                    <tr>
                        <td style="width: 140px!important;">
                            <g:link controller="pose" action="details" id="${ordre.id}">
                                <g:formatDate date="${ordre.livraison}" format="dd MMMM yyyy" locale="fr"/>
                            </g:link>
                        </td>
                        <td>${ordre.factureClient.devis.projet.client}</td>

                    </tr>
                </g:each>
                </tbody>
            </table>
        </div>

    </div>
</div>

</body>
</html>