<%@ page import="java.text.SimpleDateFormat; org.springframework.security.core.context.SecurityContextHolder; mccorletagencement.Utilisateur" %>
<ul class="timeline">
    <g:each in="${commentaires.sort { it.id }}" var="commentaire">
        <li class="timeline-item">
            <g:if test="${!commentaire.supprime}">
                <div class="timeline-date"><span>${new java.text.SimpleDateFormat("dd MMM yyyy", Locale.FRANCE).format(commentaire.date)}</span></div>

                <div class="timeline-content">
                    <div class="timeline-header">
                        <span class="timeline-time" >${new java.text.SimpleDateFormat("HH:mm").format(commentaire.date)}</span>

                        <span class="timeline-autor">${commentaire.createur}</span>
                        <br>

                        <p class="timeline-activity">${commentaire.texte}</p>

                    </div>
                </div>

            </g:if>
            <g:else>
                <div class="timeline-date"><span>${commentaire.date}</span></div>

                <div class="timeline-content" style="height: 30px!important;">
                    <div class="timeline-header">
                        <span class="timeline-time">${new java.text.SimpleDateFormat("HH:mm").format(commentaire.date)}</span>

                        <span class="timeline-autor">${commentaire.createur}</span>
                        <br>

                        <p class="timeline-activity font-italic" style="color: darkgray">Ce message a été supprimé</p>
                    </div>
                </div>

            </g:else>

        </li>
    </g:each>
</ul>