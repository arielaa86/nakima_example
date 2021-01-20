<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'etiquette.label', default: 'Etiquette')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>


    <style>


    .custom-radio-icon {

        margin: 0!important;
        width: 25px!important;
        height: 25px!important;

    }

    .custom-radio-icon .custom-control-label {

        width: 25px!important;
        height: 25px!important;
        border: 13px solid #d5d8de;
    }

    .etiquette{

        margin-top: 5px;

    }


    </style>

</head>

<body>

<div class="card card-default m-2">

    <div class="card card-header">
        <div class="row" style="color: rgba(0,0,0,0.7); vertical-align: middle">
            <div class="col-lg-12" style="font-size: 22px;">
                Détails étiquette
            </div>
        </div>

        <hr>
    </div>

    <div class="card-body">

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


        <g:hasErrors bean="${this.etiquette}">
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
                            <g:eachError bean="${this.etiquette}" var="error">
                                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>>

                                    <g:message error="${error}"/>

                                </li>
                            </g:eachError>
                        </ul>

                    </div>
                </div>
            </div>
        </g:hasErrors>


        <g:form resource="${this.etiquette}" method="DELETE" onsubmit="submit.disabled = true; return true;">


            <div class="p-2 bd-highlight">
                <div class="d-flex flex-row justify-content-md-center">
                    <div class="mai-radio-icon form-check form-check-inline">
                        <label class="custom-control custom-radio custom-radio-icon custom-control-inline">
                            <input class="custom-control-input" id="radioIcon1" type="radio" name="radio-icon" checked="true">

                            <span class="custom-control-label pepe" style="border-color:  ${this.etiquette.getCouleur()}"></span>

                        </label>
                    </div>

                    <div class="etiquette">
                        ${this.etiquette.getEvenement()}
                    </div>
                </div>

            </div>




            <div class="row m-4 justify-content-end">

                <fieldset class="buttons">
                    <g:link class="btn btn-secondary" action="edit" resource="${this.etiquette}"><i
                            class="fa fa-pencil-square-o"></i> <g:message code="default.button.edit.label"
                                                                          default="Edit"/></g:link>
                    <button class="btn btn-danger" type="submit"
                            onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"><i
                            class="fa fa-trash-o"></i>
                        ${message(code: 'default.button.delete.label', default: 'Delete')}</button>
                </fieldset>

            </div>
        </g:form>

    </div>
</div>

</body>
</html>
