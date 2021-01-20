<g:if test="${taches}">
    <g:each in="${taches}" var="tache">

        <li>
            <g:if test="${!tache.journee}">
                <span class='hour'>&nbsp; <g:formatDate format="HH:mm" date="${tache.heureFin}"/></span>
                <span class='hour'><g:formatDate format="HH:mm" date="${tache.heureDebut}"/>&nbsp;-</span>
            </g:if>
            <g:else>
                <span class='hour'>Toute la journée</span>
            </g:else>


            <span class='fa fa-circle' style='color:${tache.etiquette.couleur}'></span>
            <span class='event-name'>${tache.etiquette.evenement}</span>

            <a href="/tache/show/${tache.id}" class="tacheDescription">
                <p style='margin-top: 5px; margin-bottom: 5px'>
                    ${tache.description}
                </p>
            </a>
            <small class='form-text text-muted'>Créé par: ${tache.creator}</small>

        </li>
        <hr class='dividerEvenement'>


    </g:each>
</g:if>
<g:else>

    <div class='pasEvenement'>Pas d'évènement à cette date</div>

</g:else>