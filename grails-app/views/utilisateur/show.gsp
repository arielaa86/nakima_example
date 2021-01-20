<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'utilisateur.label', default: 'Utilisateur')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>

        <style>

            .item{
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
                    Détails utilisateur
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
                                    <td> <a href="#">${this.utilisateur.nom}</a></td>
                                </tr>
                                <tr>

                                    <td class="item">Téléphone:</td>
                                    <td width="5px"></td>
                                    <td> <a href="#">${this.utilisateur.telephone}</a></td>
                                </tr>
                                <tr>
                                    <td class="item">e-mail:</td>
                                    <td width="5px"></td>
                                    <td> <a href="#">${this.utilisateur.email}</a></td>
                                </tr>
                                <tr>
                                    <td class="item">Identifiant:</td>
                                    <td width="5px"></td>
                                    <td> <a href="#">${this.utilisateur.username}</a></td>
                                </tr>
                                <tr>
                                    <td class="item">Role:</td>
                                    <td width="5px"></td>
                                    <td> <a href="#">${mccorletagencement.UtilisateurRole.findByUtilisateur(this.utilisateur).getRole().authority.split("_")[1]}</a></td>
                                </tr>
                                </tbody>
                            </table>
                    </div>
                    </div>
                    <div class="col-lg-2" style="text-align: center">

                        <div class="card card-default m-2">
                            <div class="card-header card-header-divider" style="font-size: 14px; font-weight: bold">Signature</div>
                            <div class="card-body">
                                <g:if test="${this.utilisateur.signature}">
                                    <img width="200px" src="<g:createLink action="showSignature" params="['id': this.utilisateur.id]" />" />
                                </g:if>

                            </div>
                        </div>
                    </div>
                        
                    </div>



                <div class="row m-4 justify-content-end">

                    <g:form resource="${this.utilisateur}" method="DELETE" onsubmit="submit.disabled = true; return true;">
                        <fieldset class="buttons">
                            <g:link class="btn btn-secondary" action="edit" resource="${this.utilisateur}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
                            <button class="btn btn-danger" type="submit"
                                    onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" >
                                ${message(code: 'default.button.delete.label', default: 'Delete')}</button>
                        </fieldset>
                    </g:form>

                </div>

                </div>
            </div>

    </div>




    </body>
</html>
