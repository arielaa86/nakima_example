<%@ page import="java.text.DecimalFormat" %>
<!DOCTYPE html>
<html>
<head>

    <meta name="layout" content="noMenu"/>
    <title></title>

    <style>

    .dataTables_filter{
        margin-bottom: 20px!important;
    }

    .card-table {
        top: -154px;
    }

    @media only screen and (max-width: 770px) {
        .card-table {
            top: -90px;
        }

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
                    <th>Livré</th>
                    <th>Formulaire Pose</th>
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

                        <td><i class="${ordre.livre ? 'fa fa-check': ''}"></i></td>

                        <td>
                        <g:if test="${ordre.photoPose != null}">
                           <i class="fa fa-file-powerpoint-o" data-toggle="modal" data-target="#viewFormulaire"></i>

                            <div class="modal fade" id="viewFormulaire" tabindex="-1" role="dialog">
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
                                                <div class="col-lg-8">
                                                    <img width="100%"
                                                         src="<g:createLink controller="ordreProduction" action="showFormulaire"
                                                                            params="[id: ordre.id]"/>">
                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </g:if>
                        </td>
                    </tr>
                </g:each>
                </tbody>
            </table>
        </div>

    </div>
</div>

</body>
</html>