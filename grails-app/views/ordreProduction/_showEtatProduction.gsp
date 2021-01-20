<%@ page import="java.text.SimpleDateFormat; mccorletagencement.Role" %>
<g:each in="${etatsProduction?.sort { it.etape.indice }}" var="etapeProd" status="i">
    <li class="timeline-item ${etapeProd.active ? 'active' : ''}" id="${etapeProd.id}"
        onclick="${!user.authorities.contains(Role.findByAuthority("ROLE_COMMERCIAL"))  ? 'changerStatut(this.id,'+etapeProd.active+')' : ''}"
        style="z-index: 100">

    </li>
    <li class="timeline-item ${etapeProd.active ? 'active' : ''}">
        <div class="timeline-date">
            <span>
                <g:if test="${etapeProd.date != null}">
                    <g:formatDate date="${etapeProd.date}" locale="fr" format="dd MMMM yyyy"/>
                </g:if>
            </span>
        </div>

        <div class="timeline-content ${etapeProd.active ? 'active' : ''}">
            <div class="timeline-header">
                <span class="timeline-time">
                    <g:if test="${etapeProd.date != null}">
                        <g:formatDate date="${etapeProd.date}" locale="fr" format="HH:mm"/>
                    </g:if>
                </span>
                <span class="timeline-autor">

                    <g:if test="${ etapeProd.etape.description == 'Prêt pour vérification' && etapeProd.ordre.verification == null}">
                        ${etapeProd.etape.description + ' (Date inconnue)'}
                    </g:if>

                    <g:if test="${ etapeProd.etape.description == 'Prêt pour vérification' && etapeProd.ordre.verification != null}">
                        ${etapeProd.etape.description +' (' + new SimpleDateFormat("dd MMMM yyyy", Locale.FRANCE).format(etapeProd.ordre.verification) +')'}
                    </g:if>



                    <g:if test="${ etapeProd.etape.description == 'Prêt pour livraison' && etapeProd.ordre.livraison == null}">
                        ${etapeProd.etape.description + ' (Date inconnue)'}
                    </g:if>

                    <g:if test="${ etapeProd.etape.description == 'Prêt pour livraison' && etapeProd.ordre.livraison != null}">
                        ${etapeProd.etape.description +' (' + new SimpleDateFormat("dd MMMM yyyy", Locale.FRANCE).format(etapeProd.ordre.livraison) +')'}
                    </g:if>

                    <g:if test="${etapeProd.etape.description != 'Prêt pour vérification' && etapeProd.etape.description != 'Prêt pour livraison'}">
                        ${etapeProd.etape.description }
                    </g:if>


                </span>


                <g:if test="${etapeProd.etape.description == 'Prêt pour vérification' && !etapeProd.ordre.pretLivraison }">
                    <a data-toggle="modal" href="#myModal3"><i class="fa fa-calendar-o"></i></a>
                </g:if>

                <g:if test="${etapeProd.etape.description == 'Prêt pour livraison' && !etapeProd.ordre.livre }">
                    <a data-toggle="modal" href="#myModal2"><i class="fa fa-calendar-o"></i></a>
                </g:if>

                <div class="timeline-summary" id="note${etapeProd.id}">
                    <p>${etapeProd.note != null ? etapeProd.note : 'Rien à signaler'}</p>
                </div>

                <div class="mt-3 mb-3 d-flex justify-content-between">
                    <g:if test="${etapeProd.dateModification != null}">
                        <p style="font-size: 12px!important; color: #bcbcbc">
                            Modifié le <g:formatDate date="${etapeProd.dateModification}" locale="fr"
                                                     format="dd MMMM yyyy à HH:mm"/>
                        </p>
                    </g:if>
                    <g:else>
                        <p style="font-size: 12px!important; color: grey">

                        </p>
                    </g:else>
                    <g:if test="${user.authorities.contains(Role.findByAuthority("ROLE_TECHNICIEN")) ||
                            etapeProd.etape.description == 'Prêt pour vérification' || etapeProd.etape.description == 'Prêt pour livraison'}">

                        <g:hiddenField name="noteTexte${etapeProd.id}" value="${etapeProd.note}" />

                        <g:if test="${etapeProd.active && !etapeProd.ordre.livre}">
                            <i class="fa fa-edit " id="edit-${etapeProd.id}"
                               onclick="editNote(this.id)"></i>
                        </g:if>


                        <i class="fa fa-check" id="save-${etapeProd.id}" onclick="saveNote(this.id)"
                           style="display: none"></i>
                    </g:if>
                </div>

            </div>
        </div>
    </li>
</g:each>
