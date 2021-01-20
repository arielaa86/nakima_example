<%@ page import="mccorletagencement.Role" %>



<div id="listeCorrections">

    <g:if test="${corrections.size() > 0}">

    <g:each var="correctionInstance" in="${corrections.sort { it.date }}">

        <div class="row mt-2 mb-2" style="margin-left: 0px">
            <label style="color: #9d9d9d; font-style: italic">Ajouté le <g:formatDate format="dd MMMM yyyy à HH:mm"
                                                                                      locale="fr"
                                                                                      date="${correctionInstance.date}"/></label>
        </div>

        <p>
            ${correctionInstance.description}
        </p>

        <div class="row gallery-container noPrint">

            <g:each var="photo" in="${correctionInstance.photos}">

                <div class="item col-lg-6">
                    <div class="photo">
                        <div class="img">
                            <g:if test="${photo.getDocumentType().equals("pdf")}">
                                <img class="imagen" src="<g:createLink controller="photoCorrection" action="showPDF"
                                                                       params="[id: photo.getId()]"/>" alt="..."/>
                            </g:if>
                            <g:else>
                                <img id="imagen" class="imagen"
                                     src="<g:createLink controller="photoCorrection" action="showPhoto"
                                                        params="[id: photo.getId()]"/>" alt="..."/>
                            </g:else>

                            <div class="over">
                                <div class="info-wrapper">
                                    <div class="info">
                                        <div class="description">Ajouté le:
                                            <g:formatDate format="EE dd-MM-yyyy HH:mm" locale="fr"
                                                          date="${photo.date}"/></div>

                                        <g:hiddenField name="photoId${photo.id}" id="photoId${photo.id}"
                                                       value="${photo.id}"/>

                                        <div class="func">

                                            <g:link target="_blank" controller="photoCorrection" action="showPhoto"
                                                    params="[id: photo.id]">
                                                <i class="icon s7-search"></i>
                                            </g:link>



                                            <g:if test="${!user.authorities.contains(Role.findByAuthority("ROLE_COMMERCIAL")) && !correctionInstance.corrige && !this.factureClient.ordreProduction.livre }">
                                                <a class="image-zoom" href="#"
                                                   onclick="deletePhoto('photoId${photo.id}')">
                                                    <i class="icon s7-trash"></i>
                                                </a>
                                            </g:if>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </g:each>

        </div>


        <div class="row m-2 justify-content-end">

        <g:if test="${!this.factureClient.ordreProduction.livre}">
            <label class="custom-control custom-checkbox custom-control-inline" style="margin-top: 8px">
                <input class="custom-control-input" type="checkbox" name="corrige" ${correctionInstance.corrige ? 'checked=""' : ''}
                    ${!user.authorities.contains(Role.findByAuthority("ROLE_COMMERCIAL")) ? 'disabled' : ''}
                       id="${correctionInstance.id}" onclick="setCorrige(this.id)">
                <span class="custom-control-label" style="width:108px;">Corrigé</span>
            </label>

            <g:if test="${!user.authorities.contains(Role.findByAuthority("ROLE_COMMERCIAL")) && !correctionInstance.corrige}">
                <button class="btn btn-primary" style="height: 38px" id="${correctionInstance.id}" onclick="supprimerCorrection(this.id)">
                    <i class="fa fa-trash"></i> Supprimer
                </button>
            </g:if>

        </g:if>
        </div>


        <hr>

    </g:each>

    <g:if test="${!this.factureClient.ordreProduction.livre}">
        <div class="row m-2 justify-content-end" id="infoTech">
            <g:if test="${user.authorities.contains(Role.findByAuthority("ROLE_COMMERCIAL")) && this.factureClient.allCorrectionsDone()}">
                <button class="btn" name="btnInfoTech" id="${this.factureClient.id}" style="background-color: #1a9fdd; color: white" onclick="sendNotification(this.id)">
                    <i class="fa fa-send"></i> Informer le Technicien
                </button>
            </g:if>

            <g:if test="${!user.authorities.contains(Role.findByAuthority("ROLE_COMMERCIAL"))}">
                <button class="btn" name="btnInfoCommercial" id="${this.factureClient.id}" style="background-color: #1a9fdd; color: white" onclick="sendNotificationCorrectionAfaire(this.id)">
                    <i class="fa fa-send"></i> Informer le Commercial
                </button>
            </g:if>
        </div>
    </g:if>

    </g:if>
    <g:else>

        <div class="row m-2 justify-content-center" id="infoTech">
        <p style="color: gray; margin-top: 50px; margin-bottom: 50px"> Aucune correction n'a été signalée </p>
        </div>

    </g:else>

</div>
