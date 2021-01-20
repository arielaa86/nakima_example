<g:each in="${listeSuiviCommercial}" var="suiviCommercial">

    <div class="row justify-content-center mt-4">
        <div class="col-lg-10">
            <h5>${suiviCommercial.getUtilisateur()}</h5>
        </div>

    </div>

    <g:render template="${actionName == 'rapport' ? '/utilisateur/commissionTemplate': 'commissionTemplate' }" model="['suiviCommercialDAO': suiviCommercial]"/>

</g:each>
