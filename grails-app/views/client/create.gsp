<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'client.label', default: 'Client')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
        <style>

          .icon{
              width: 15px!important;
          }

        </style>

        <asset:javascript src="js/app-projetFonctionnes.js" />

    </head>
    <body>

      <div class="card card-default card-table m-2">

          <div class="card card-header">
              <div class="row" style="color: rgba(0,0,0,0.7); vertical-align: middle">
                  <div class="col-lg-12" style="font-size: 22px;">
                      <i class="fa fa-plus"></i> Nouveau client
                  </div>
              </div>

              <hr>
          </div>

        <div class="card-body">


            <g:hasErrors bean="${this.client}">
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
                            <g:eachError bean="${this.client}" var="error">
                            <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>>

                              <g:message error="${error}"/>

                            </li>
                            </g:eachError>
                        </ul>

                      </div>
                </div>
              </div>
            </g:hasErrors>



            <g:form resource="${this.client}" method="POST" autocomplete="off" onsubmit="submit.disabled = true; return true;">
                <fieldset class="form">

                  <g:render template="form" />

                </fieldset>

                <div class="row m-5 justify-content-end">
                  <button class="btn btn-space btn-success" type="submit" name="submit" id="submit">
                      <i class="fa fa-floppy-o"></i>
                      ${message(code: 'default.button.create.label', default: 'Create')}
                  </button>
                </div>

            </g:form>

        </div>
      </div>

    <script>

        function addRequiredPrenom() {

            let selectElement = document.querySelector('select[id=intitule]');
            let inputElement = document.querySelector('input[id=prenom]');
            let labelElement = document.querySelector('label[id=labelPrenom]');


            if ( selectElement.value === 'Société') {
                inputElement.required = false;
                inputElement.style.visibility ='hidden'
                labelElement.style.visibility ='hidden'
                inputElement.value = "----";

            }else{
                inputElement.required = true;
                inputElement.style.visibility ='visible'
                labelElement.style.visibility ='visible'
                inputElement.value = "";
            }
        }



    </script>

    </body>



</html>
