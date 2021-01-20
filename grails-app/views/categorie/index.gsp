<%@ page import="mccorletagencement.dataServices.IconsDataService" %>
<!DOCTYPE html>
<html>
<head>

    <g:set var="iconsService" value="${IconsDataService.getConstructor().newInstance()}"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'categorie.label', default: 'Categorie')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>

    <asset:stylesheet src="lib/datepicker/css/bootstrap-datepicker.standalone.css"/>

    <asset:stylesheet src="lib/morrisjs/morris.css"/>
    <asset:javascript src="lib/jquery/jquery.min.js"/>
    <asset:javascript src="lib/raphael/raphael.min.js"/>
    <asset:javascript src="lib/morrisjs/morris.js"/>
    <asset:javascript src="js/app-charts-morris.js"/>

</head>

<body>

<div class="card card-default col-lg-12 m-2">

    <div class="card-body">

        <div id="errors">

        </div>

        <%--
                <div class="row mt-4" style="color: rgba(0,0,0,0.7); vertical-align: middle">
                    <div class="col-lg-12 d-flex" style="font-size: 22px;">
                        <i class="fa fa-th-large"></i>
                        <h3 class="ml-2"> Suivi des postes de dépenses</h3>

                    </div>

                </div>
                <hr>

                <div class="row justify-content-center m-5">

                    <div id="month" class="col-12 col-sm-4 col-lg-3">

                        <div id="datePicker" class="input-group">
                            <input type="text" name="date" class="form-control" id="date" aria-describedby="btnGroupAddon"
                                   value="${actualDateString}"
                                   autocomplete="off">

                            <div id="dateIcon" style="position: relative; top: 11px; right: 30px;">
                                <i class="fa fa-calendar-o"></i>
                            </div>
                        </div>

                    </div>

                </div>

                <div class="row" id="listeCategories">

                    <g:render template="listeCategories" model="[categories: categories]"/>

                </div>
        --%>

        <div class="row mt-4" style="color: rgba(0,0,0,0.7); vertical-align: middle">
            <div class="col-lg-12 d-flex" style="font-size: 22px;">
                <i class="fa fa-line-chart"></i>

                <h3 class="ml-2">Evolution du chiffre d'affaires</h3>
            </div>
        </div>
        <hr>

        <div class="row justify-content-center m-5">
            <div class="col-12 col-sm-4 col-lg-3">

                <label for="dateChart">Sélectionner l'année:</label>
                <g:select class="form-control custom-select" name="dateChart" id="dateChart"
                          from="${Calendar.getInstance().get(Calendar.YEAR)..Calendar.getInstance().get(Calendar.YEAR) - 5}"
                          required="" onchange="getCharData(); getTotalAnne();"/>

            </div>
        </div>


        <div class="row m-5">

            <g:each in="${["Janvier", "Février", "Mars", "Avril", "Mai", "Juin"]}" var="mois">
                <div class="col-lg-2">
                    <label for="${mois}">${mois}</label>
                    <input class="form-control" type="text" id="${mois}" name="${mois}" value="0.00 €" onfocusin="formatNumber(this.id)" onfocusout="formatEuro(this.id)">
                </div>
            </g:each>

        </div>

        <div class="row m-5">

            <g:each in="${["Juillet", "Août", "Septembre", "Octobre", "Novembre", "Décembre"]}" var="mois">
                <div class="col-lg-2">
                    <label for="${mois}">${mois}</label>
                    <input class="form-control" type="text" id="${mois}" name="${mois}">
                </div>
            </g:each>

        </div>

        <div class="row" id="chartData">

            <g:render template="chart" model="[chartData: chartData]"/>

        </div>

        <div class="row justify-content-center m-5" id="total">

            <g:render template="total"
                      model="[totalRecette: totalRecette, totalDepense: totalDepense, totalGain: totalGain]"/>

        </div>

    </div>
</div>


<div class="modal fade show noPrint" id="nouvelleCategorie" tabindex="-1" role="dialog" aria-modal="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button class="close" type="button" data-dismiss="modal" aria-hidden="true"><span
                        class="s7-close"></span></button>
            </div>

            <div class="modal-body">

                <h3 class="mb-4">Nouveau poste de dépense</h3>

                <form autocomplete="off">

                    <div class="form-group row mb-4 mt-4 noPrint">

                        <g:hiddenField name="categorieIconSave" value="fa-certificate"/>

                        <div class="col-lg-8">
                            <div class="col-lg-12">
                                <label for="description">Description:</label>
                                <input class="form-control" id="description" required type="text" name="description"
                                       value=""
                                       onkeyup="cestVide(this.id, 'save')">
                            </div>
                        </div>

                        <div class="col-lg-4 mb-4" id="iconPreviewSave">
                            <i class="fa fa-certificate fa-5x m-3"></i>
                        </div>

                    </div>


                    <div class="form-group row m-2">
                        Sélectionnez une icône
                    </div>

                    <div class="form-group row m-2 noPrint" style="border: solid 1px lightgray">

                        <div style="max-height: 250px; overflow: scroll">
                            <g:each in="${iconsService.getIcons()}" var="icon" status="k">
                                <i class="fa ${icon} fa-3x m-3" id="${icon}" onclick="selectIcon(this.id, 'Save')"></i>
                            </g:each>

                        </div>

                    </div>

                </form>

                <div class=" row mt-4 justify-content-end">
                    <button disabled id="save" class="btn btn-space btn-success" type="button" data-dismiss="modal"
                            onclick="saveCategory()">Sauvegarder</button>
                </div>

            </div>
        </div>
    </div>
</div>


<div class="modal fade show noPrint" id="actualiserCategorie" tabindex="-1" role="dialog" aria-modal="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button class="close" type="button" data-dismiss="modal" aria-hidden="true"><span
                        class="s7-close"></span></button>
            </div>

            <div class="modal-body">

                <h3 class="mb-4">Actualiser poste de dépense</h3>

                <form autocomplete="off">

                    <div class="form-group row mt-4 noPrint">

                        <g:hiddenField name="categorieIconUpdate" value=""/>

                        <g:hiddenField name="idCategory" value=""/>

                        <div class="col-lg-8">
                            <div class="col-lg-12">
                                <label for="description">Description:</label>
                                <input class="form-control" id="descriptionUpdate" required type="text"
                                       name="descriptionUpdate" value=""
                                       onkeyup="cestVide(this.id, 'update')">
                            </div>
                        </div>

                        <div class="col-lg-4 mb-4" id="iconPreviewUpdate">

                        </div>

                    </div>

                    <div class="form-group row m-2">
                        Sélectionnez une icône
                    </div>

                    <div class="form-group row m-2 noPrint" style="border: solid 1px lightgray">

                        <div style="max-height: 250px; overflow: scroll">
                            <g:each in="${iconsService.getIcons()}" var="icon" status="k">
                                <i class="fa ${icon} fa-3x m-3" id="${icon}"
                                   onclick="selectIcon(this.id, 'Update')"></i>
                            </g:each>

                        </div>

                    </div>

                </form>

                <div class=" row mt-4 justify-content-end">
                    <button id="update" class="btn btn-space btn-success" type="button" data-dismiss="modal"
                            onclick="updateCategory()">Enregistrer</button>
                </div>

            </div>
        </div>
    </div>
</div>



<asset:javascript src="categorie/actions.js"/>
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

    }).on('changeDate', function (ev) {
        getCategoryByMonth();
    });


</script>

</body>
</html>
