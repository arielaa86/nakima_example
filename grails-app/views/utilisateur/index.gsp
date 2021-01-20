<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'utilisateur.label', default: 'Utilisateur')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>

    <div class="card card-default m-2">
        <div class="card-header">Liste d'utilisateurs</div>
        <div class="card-body">
            <table width="100%" class="table table-hover table-bordered table-striped">
                <thead>
                <tr>
                    <th>Nom</th>
                    <th>Prénom</th>
                    <th>Téléphone</th>
                    <th>e-mail</th>
                </tr>
                </thead>
                <tbody>
                <g:each var="utilisateur" in="${utilisateurList}">

                    <tr>
                        <td>
                            <g:link controller="utilisateur" action="show" id="${utilisateur.id}">
                                ${utilisateur?.nom}
                            </g:link>
                        </td>
                        <td>${utilisateur?.prenom}</td>
                        <td>${utilisateur?.telephone}</td>
                        <td>${utilisateur?.email}</td>
                    </tr>

                </g:each>
                </tbody>
            </table>

            <div class="row pagination justify-content-end">
                <g:paginate total="${utilisateurCount ?: 0}" />
            </div>

        </div>
    </div>

<script>

    var steps = document.getElementsByClassName("step");
    var currentStep = document.getElementsByClassName("currentStep");

    var nextLink = document.getElementsByClassName("nextLink");
    var prevLink = document.getElementsByClassName("prevLink");

    var currentStep = document.getElementsByClassName("currentStep");

    for (i = 0; i < steps.length; i++) {
        steps[i].classList.add('btn')
        steps[i].classList.add('btn-secondary')
    }

    currentStep[0].classList.add('btn')
    currentStep[0].classList.add('btn-primary')

    try {
        nextLink[0].classList.add('btn')
        nextLink[0].classList.add('btn-secondary')
    }catch(e){

    }

    prevLink[0].classList.add('btn')
    prevLink[0].classList.add('btn-secondary')


</script>


    </body>
</html>