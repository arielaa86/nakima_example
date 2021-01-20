<%@ page import="org.springframework.security.core.context.SecurityContextHolder; mccorletagencement.Utilisateur" %>
<ul class="timeline" id="timeline">
    <g:if test="${commentaires != null}">
        <g:each in="${commentaires.sort { it.id }}" var="commentaire">
            <li class="timeline-item" >
                <g:if test="${!commentaire.supprime}">
                    <div class="timeline-date"><span>${commentaire.date}</span></div>

                    <div class="timeline-content">
                        <div class="timeline-header">
                            <span class="timeline-time">${commentaire.heure}</span>

                            <span class="timeline-autor">${commentaire.createur}</span>
                            <br>

                            <p class="timeline-activity" style="${commentaire.auto == true ? 'font-style: italic':''}">${commentaire.texte}</p>

                            <g:if test="${controllerName!='questionnaire' &&  commentaire.auto == false  && commentaire.createur.equals(Utilisateur.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName()).toString())}">
                                <div class="mb-0" style="text-align: right">
                                    <a href="#"
                                <g:if test="${commentaire.commentaireRelance}">
                                    onclick="deleteCommentaireRelance(${commentaire.id}, ${commentaire.devis}); return false;"
                                </g:if><g:else>
                                    onclick="deleteCommentaire(${commentaire.id}); return false;"
                                </g:else>
                                <i class="fa fa-trash"></i>
                                </a>
                            </div>
                            </g:if>

                        </div>
                    </div>

                </g:if>
                <g:else>
                    <div class="timeline-date"><span>${commentaire.date}</span></div>

                    <div class="timeline-content" style="height: 30px!important;">
                        <div class="timeline-header">
                            <span class="timeline-time">${commentaire.heure}</span>

                            <span class="timeline-autor">${commentaire.createur}</span>
                            <br>

                            <p class="timeline-activity font-italic"
                               style="color: darkgray">Ce message a été supprimé</p>
                        </div>
                    </div>

                </g:else>

            </li>
        </g:each>
    </g:if>
</ul>