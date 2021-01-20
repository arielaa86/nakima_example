<%@ page import="mccorletagencement.Role" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'utilisateur.label', default: 'Utilisateur')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>


    <div class="card card-default m-2">


        <div class="card card-header">
            <div class="row" style="color: rgba(0,0,0,0.7); vertical-align: middle">
                <div class="col-lg-12" style="font-size: 22px;">
                    Nouvel utilisateur
                </div>
            </div>

            <hr>
        </div>

            <div class="card-body">


                <g:if test="${flash.error}">

                    <div class="row justify-content-center m-3">
                        <div class="alert alert-theme alert-danger alert-dismissible col-lg-6" role="alert">
                            <button class="close" type="button" data-dismiss="alert" aria-label="Close"><span class="s7-close" aria-hidden="true"></span></button>
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


                <g:hasErrors bean="${this.utilisateur}">
                    <div class="row justify-content-center m-3">
                        <div class="alert alert-theme alert-danger alert-dismissible col-lg-6" role="alert">
                            <button class="close" type="button" data-dismiss="alert" aria-label="Close"><span class="s7-close" aria-hidden="true"></span></button>
                            <div class="row ml-3 mt-3">
                                <div class="icon">
                                    <span class="s7-attention"></span>
                                </div>
                                <strong style="font-size:14px">Erreur !</strong>
                            </div>

                            <div class="message">


                                <ul class="errors" role="alert">
                                    <g:eachError bean="${this.utilisateur}" var="error">
                                        <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>>

                                            <g:message error="${error}"/>

                                        </li>
                                    </g:eachError>
                                </ul>

                            </div>
                        </div>
                    </div>
                </g:hasErrors>


                        <g:form resource="${this.utilisateur}" method="POST" autocomplete="off" onsubmit="submit.disabled = true; return true;">

                            <g:render template="form"></g:render>

                            <div class="row justify-content-center m-4">
                                <div class="col-lg-2 m-4">

                                    <button id="submit" class="btn btn-lg btn-success btn-block" type="submit" id="submit">
                                        <i class="fa fa-save"></i>
                                        Enregistrer
                                    </button>
                                </div>
                            </div>
                        </g:form>


            </div>
    </div>


    <script>

        function showSignaturePad(){

            if(document.getElementById("role.id").value === "3") {
                document.getElementById("signature-pad").style.display = "inline-block";
            }else{
                document.getElementById("signature-pad").style.display = "none";
            }

        }

    </script>

    </body>
</html>
