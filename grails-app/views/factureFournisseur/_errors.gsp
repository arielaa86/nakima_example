<g:hasErrors bean="${factureFournisseur}">
    <div class="alert alert-theme alert-danger alert-dismissible col-lg-12" role="alert">
        <button class="close" type="button" data-dismiss="alert" aria-label="Close"><span class="s7-close" aria-hidden="true"></span></button>
        <div class="row ml-3 mt-3">
            <div class="icon">
                <span class="s7-attention"></span>
            </div>
            <strong style="font-size:14px">Erreur !</strong>
        </div>

        <div class="message">

            <ul class="errors" role="alert">
                <g:eachError bean="${factureFournisseur}" var="error">
                    <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>>

                        <g:message error="${error}"/>

                    </li>
                </g:eachError>
            </ul>

        </div>
    </div>

</g:hasErrors>