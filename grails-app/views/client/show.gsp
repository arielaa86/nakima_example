<%@ page import="mccorletagencement.ProjetCuisine;mccorletagencement.ProjetAutre; mccorletagencement.ProjetSalleBain; mccorletagencement.ProjetPlacard; mccorletagencement.ProjetDressing" %>

<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'client.label', default: 'Client')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>

    <style>

    .item {
        font-weight: bold;
        height: 60px;
    }

    .btn-big {
        width: 105px;
        height: 65px;
        margin: 24px;
    }

    </style>

</head>

<body>

<div class="card card-default col-lg-12 m-2">

    <div class="card card-header">
        <div class="row" style="color: rgba(0,0,0,0.7); vertical-align: middle">
            <div class="col-lg-12" style="font-size: 22px;">
                Informations client
            </div>
        </div>

        <hr>
    </div>

    <div class="card-body">

        <div class="row m-2">
            <div class="card card-default card-table col-lg-4">

                <div class="card-body pt-4 pb-4">
                    <table class="no-border no-strip skills">
                        <tbody class="no-border-x no-border-y">
                        <tr>
                            <td class="item">Intitulé: <br>
                                <a href="#">${this.client?.intitule}</a>
                            </td>
                        </tr>
                        <tr>
                            <td class="item">Adresse: <br>
                                <a href="#">${this.client?.adresse}</a>
                            </td>
                        </tr>
                        <tr>
                            <td class="item">Téléphone: <br>
                                <a href="#">${this.client?.telephone}</a>
                            </td>
                        </tr>
                        <tr>
                            <td class="item">Secteur d'activité:<br>
                                <a href="#">${this.client?.secteurActivite}</a>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="card card-default card-table col-lg-4">

                <div class="card-body pt-4 pb-4">
                    <table class="no-border no-strip skills">
                        <tbody class="no-border-x no-border-y">
                        <tr>
                            <td class="item">Nom:  <br>
                                <a href="#">${this.client?.nom}</a>
                            </td>
                        </tr>
                        <tr>
                            <td class="item">Code postal: <br>
                                <a href="#">${this.client?.codePostal}</a>
                            </td>
                        </tr>
                        <tr>
                            <td class="item">Fixe:<br>
                                <a href="#">${this.client?.telephoneFixe}</a>
                            </td>
                        </tr>
                        <tr>
                            <td class="item">Référence:<br>
                                <g:if test="${this.client?.reference.equals("Autre")}">

                                    <a href="#">${this.client?.referenceAutre}</a>

                                </g:if>
                                <g:else>
                                    <a href="#">${this.client?.reference}</a>
                                </g:else>

                            </td>
                        </tr>

                        </tbody>
                    </table>
                </div>
            </div>


            <div class="card card-default card-table col-lg-4">

                <div class="card-body pt-4 pb-4">
                    <table class="no-border no-strip skills">
                        <tbody class="no-border-x no-border-y">
                        <tr>
                            <td class="item">
                                <g:if test="${this.client.intitule !='Société'}">
                                    Prénom:  <br>
                                    <a href="#">${this.client?.prenom}</a>
                                </g:if>
                            </td>
                        </tr>
                        <tr>
                            <td class="item">Ville: <br>
                                <a href="#">${this.client?.ville}</a>
                            </td>
                        </tr>
                        <tr>
                            <td class="item">E-mail: <br>
                                <a href="#">${this.client?.email}</a>
                            </td>
                        </tr>

                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <g:form resource="${this.client}" method="DELETE" onsubmit="submit.disabled = true; return true;">
            <fieldset class="buttons">

                <div class="row m-5 justify-content-end">
                    <g:link class="btn btn-space btn-secondary" action="edit" resource="${this.client}"
                            style="width:86px;">
                        <i class="fa fa-edit"></i>
                        <g:message code="default.button.edit.label" default="Modifier"/>
                    </g:link>

                <!--
                <button class="btn btn-space btn-primary" type="submit" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Etes-vous sûr ?')}');">Supprimer</button>
             -->
                </div>

            </fieldset>
        </g:form>


        <div class="card card-default card-table col-lg-12" style="text-align: center">

            <div class="card-header card-header-divider mb-4">

                Nouveau projet

            </div>

            <div class="card-body mb-4">

                <g:link class="btn btn-space btn-secondary btn-big" action="create" controller="projetCuisine"
                        params="['client.id': this.client.id]">
                    <i class="icon fa fa-coffee"></i> Cuisine
                </g:link>

                <g:link class="btn btn-space btn-secondary btn-big" action="create" controller="projetSalleBain"
                        params="['client.id': this.client.id]">
                    <i class="icon fa fa-shower"></i> Salle de bain
                </g:link>

                <g:link class="btn btn-space btn-secondary btn-big" action="create" controller="projetDressing"
                        params="['client.id': this.client.id]">
                    <i class="icon fa fa-shopping-bag"></i> Dressing
                </g:link>

                <g:link class="btn btn-space btn-secondary btn-big" action="create" controller="projetPlacard"
                        params="['client.id': this.client.id]">
                    <i class="icon fa fa-columns"></i> Placard
                </g:link>


                <g:link class="btn btn-space btn-secondary btn-big" action="create" controller="projetAutre"
                        params="['client.id': this.client.id]">
                    <i class="icon fa fa-delicious"></i> Autre
                </g:link>

            </div>
        </div>


        <h4 style="text-align: center">Historique des projets</h4>
        <hr>

        <table width="100%" class="table dataTable table-hover table-bordered table-striped">
            <thead>
            <tr>
                <th class="noExport"></th>
                <th>Date de création</th>
                <th>Référence</th>
                <th>Projet</th>
                <th>Chantier</th>
                <th>Bien concerné</th>
                <th>Budget</th>
                <th>Concepteur</th>

            </tr>
            </thead>
            <tbody>
            <g:each var="projet" in="${this.client.projets.sort { it.date }}">

                <tr>
                    <td></td>
                    <td>
                        <g:link controller="${projet.getClass().getSimpleName()}" action="show" id="${projet.id}">
                            <g:formatDate format="dd MMMM yyyy" date="${projet?.date}"/>
                        </g:link>
                    </td>
                    <td>
                        ${projet?.idInsitu}
                    </td>
                    <td>
                        <g:if test="${projet instanceof ProjetCuisine}">
                            Cuisine
                        </g:if>
                        <g:if test="${projet instanceof ProjetSalleBain}">
                            Salle de bain
                        </g:if>
                        <g:if test="${projet instanceof ProjetDressing}">
                            Dressing
                        </g:if>
                        <g:if test="${projet instanceof ProjetPlacard}">
                            Placard
                        </g:if>
                        <g:if test="${projet instanceof ProjetAutre}">
                            ${projet.typeProjet}
                        </g:if>

                    </td>
                    <td>${projet?.typeTravail}</td>
                    <td>${projet?.typeHabitation}


                    <g:if test="${projet.typeHabitation.equals("Immeuble")}">

                        ${"- " + projet.quantiteHabitation + " logements"}

                    </g:if>

                    <g:if test="${projet.typeHabitation.equals("Maison") && projet instanceof ProjetSalleBain}">

                        ${"- " + projet.quantitePieceEau + " pièce(s) d'eau"}

                    </g:if>

                    </td>
                    <td>

                        <g:if test="${projet?.budgetAutre}">
                            ${projet?.budgetAutre}
                        </g:if>
                        <g:else>
                            ${projet?.budget}
                        </g:else>

                    </td>
                    <td>
                        ${projet.concepteur}
                    </td>

                </tr>

            </g:each>
            </tbody>
        </table>
        <br>

    </div>
</div>

</body>
</html>
