<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="noMenu"/>
    <title>Mot de passe oublié</title>

    <style>
    @media only screen and (max-width: 767px) {
        body {
            margin-top: 0em;
            height: auto;
        }
    }

    @media only screen and (min-width: 767px) {
        body {
            margin-top: 0em;
            height: auto;
        }
    }

    </style>

</head>
<body>

<div class="card card-default m-2">


    <div class="card-body m-6">

        <div class="row justify-content-center" style="color: rgba(0,0,0,0.7); vertical-align: middle">

            <h2>Réinitialiser le mot de passe</h2>

        </div>

        <hr>

        <g:if test="${flash.error}">

            <div class="row justify-content-center m-3">
                <div class="alert alert-theme alert-danger alert-dismissible col-lg-6" role="alert">
                    <button class="close" type="button" data-dismiss="alert" aria-label="Close"><span class="s7-close"
                                                                                                      aria-hidden="true"></span>
                    </button>

                    <div class="row ml-3 mt-3">
                        <div class="icon">
                            <span class="s7-attention"></span>
                        </div>
                        <strong style="font-size:14px">Erreur !</strong>
                    </div>

                    <div class="message">

                        <ul class="errors" role="alert">
                            <li>

                                <g:message error="${flash.error}"/>

                            </li>
                        </ul>

                    </div>
                </div>
            </div>

        </g:if>

        <g:form resource="${this.utilisateur}" action="savePassword" method="PUT" autocomplete="off" onsubmit="submit.disabled = true; return true;">
            <g:hiddenField name="version" value="${this.utilisateur?.version}" />


            <g:render template="formAcces"></g:render>


            <div class="row justify-content-end m-4">

                <button id="submit" class="btn btn-success m-2" type="submit" id="submit">
                    <i class="fa fa-save"></i>
                    Enregistrer
                </button>

                <g:link class="btn btn-primary m-2" controller="utilisateur" action="monCompte" id="${utilisateur.id}">
                    <i class="fa fa-times"></i> Annuler
                </g:link>

            </div>


        </g:form>


    </div>
</div>





</body>
</html>
