<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'projetPlacard.label', default: 'ProjetSalleBain')}"/>
    <title><g:message code="default.edit.label" args="[entityName]"/></title>
    <asset:stylesheet src="lib/datepicker/css/bootstrap-datepicker.standalone.css"/>

</head>

<body>

<div class="card card-default card-table m-2">

    <div class="card card-header">
        <div class="row" style="color: rgba(0,0,0,0.7); vertical-align: middle">
            <div class="col-lg-12" style="font-size: 22px;">
                Modifier projet placard
            </div>
        </div>

        <hr>
    </div>

    <div class="card-body">

        <div class="row mt-3 mr-3 justify-content-end">
            <g:if test="${flash.message}">
                <div class="alert alert-success alert-icon alert-icon-colored alert-dismissible col-lg-4" role="alert">
                    <div class="icon"><span class="s7-check"></span></div>

                    <div class="message">
                        <button class="close" type="button" data-dismiss="alert" aria-label="Close">
                            <span class="s7-close" aria-hidden="true"></span>
                        </button>
                        ${flash.message}
                    </div>
                </div>
            </g:if>
        </div>


        <g:hasErrors bean="${this.projetPlacard}">
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
                            <g:eachError bean="${this.projetPlacard}" var="error">
                                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>>

                                    <g:message error="${error}"/>

                                </li>
                            </g:eachError>
                        </ul>

                    </div>
                </div>
            </div>
        </g:hasErrors>



        <g:form resource="${this.projetPlacard}" method="PUT" autocomplete="off"
                onsubmit="document.querySelector('button[id=clickclick]').disabled = true; return true;">
            <g:hiddenField name="version" value="${this.projetPlacard?.version}"/>
            <fieldset class="form">
                <g:render template="form"/>
            </fieldset>
            <g:if test="${!this.projetPlacard.isFactureClosed()}">
                <div class="row m-5 justify-content-end">
                    <button class="btn btn-space btn-success" type="submit" id="clickclick">
                        <i class="fa fa-save"></i>
                        ${message(code: 'default.button.update.label', default: 'Update')}
                    </button>
                </div>
            </g:if>
        </g:form>
    </div>
</div>

<asset:javascript src="js/app-projetFonctionnes.js"/>

<script>

    setupRadioGroups();

</script>
</body>
</html>
