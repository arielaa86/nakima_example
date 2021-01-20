<%@ page import="mccorletagencement.Role" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'utilisateur.label', default: 'Utilisateur')}"/>
    <title>Mon compte</title>


    <asset:stylesheet src="lib/datepicker/css/bootstrap-datepicker.standalone.css"/>
    <asset:stylesheet src="css/statistiques.css"/>

    <style>

    .item {
        text-align: right;
        font-weight: bold;
    }
    </style>
</head>

<body>

<div class="card card-default m-2">
    <div class="card card-header">
        <div class="row" style="color: rgba(0,0,0,0.7); vertical-align: middle">
            <div class="col-lg-12" style="font-size: 22px;">
                Mon compte
            </div>
        </div>

        <hr>
    </div>

    <div class="card-body">

        <div class="row m-4 justify-content-center">
            <div class="user-info-list card card-default col-lg-4">
                <div class="card-body">
                    <table class="no-border no-strip skills">
                        <tbody class="no-border-x no-border-y">
                        <tr>
                            <td class="item">Prénom:</td>
                            <td width="5px"></td>
                            <td><a href="#">${this.utilisateur.prenom}</a></td>
                        </tr>
                        <tr>

                            <td class="item">Nom:</td>
                            <td width="5px"></td>
                            <td><a href="#">${this.utilisateur.nom}</a></td>
                        </tr>
                        <tr>

                            <td class="item">Téléphone:</td>
                            <td width="5px"></td>
                            <td><a href="#">${this.utilisateur.telephone}</a></td>
                        </tr>
                        <tr>
                            <td class="item">e-mail:</td>
                            <td width="5px"></td>
                            <td><a href="#">${this.utilisateur.email}</a></td>
                        </tr>
                        <tr>
                            <td class="item">Identifiant:</td>
                            <td width="5px"></td>
                            <td><a href="#">${this.utilisateur.username}</a></td>
                        </tr>
                        <tr>
                            <td class="item">Role:</td>
                            <td width="5px"></td>
                            <td><a href="#">${mccorletagencement.UtilisateurRole.findByUtilisateur(this.utilisateur).getRole().authority.split("_")[1]}</a>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="col-lg-2" style="text-align: center">

                <div class="card card-default m-2">
                    <div class="card-header card-header-divider"
                         style="font-size: 14px; font-weight: bold">Signature</div>

                    <div class="card-body">
                        <g:if test="${this.utilisateur.signature}">
                            <img width="200px"
                                 src="<g:createLink action="showSignature" params="['id': this.utilisateur.id]"/>"/>
                        </g:if>

                    </div>
                </div>
            </div>

        </div>


        <div class="row m-4 justify-content-end">

            <g:link class="btn btn-secondary" action="editAcces" resource="${this.utilisateur}"><i
                    class="fa fa-edit"></i> Modifier mes accès</g:link>

        </div>

        <g:if test="${utilisateur.authorities.contains(Role.findByAuthority("ROLE_COMMERCIAL"))}" >

        <div class="card card-default card-table m-2 p-2">

            <div class="card card-header">
                <div class="row" style="color: rgba(0,0,0,0.7); vertical-align: middle">
                    <div class="col-lg-12" style="font-size: 22px;">
                         Commissions
                    </div>
                </div>

                <hr>
            </div>


            <div class="card-body pt-4 pb-4">

                <g:formRemote id="dateForm" name="dateForm"
                              url="[controller: 'utilisateur', action: 'obtenirCommissionAjax']"
                              update="update" method="POST">

                    <div class="row justify-content-center m-4">

                        <div id="month" class="col-12 col-sm-4 col-lg-3">

                            <div id="datePicker" class="input-group">
                                <input type="text" name="date" class="form-control" id="date"
                                       aria-describedby="btnGroupAddon"
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

                    <g:render template="commissionTemplate"/>

                </div>

            </div>
        </div>
        </g:if>



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

</script>

</body>
</html>
