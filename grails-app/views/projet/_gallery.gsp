

<div class="row gallery-container noPrint">
    <g:each var="planInstance" in="${projet?.getPlans().sort{ it.date }}">
        <div class="item col-lg-4">
            <div class="photo">
                <div class="img">

                    <g:if test="${planInstance.getDocumentType() == "pdf"}">

                        <img class="imagen" src="<g:createLink controller="plan" action="showPlanPDF"
                                                               params="[id: planInstance.getId()]"/>" alt="..." />

                    </g:if>
                    <g:else>

                        <img class="imagen" src="<g:createLink controller="plan" action="showPlan"
                                                               params="[id: planInstance.getId()]"/>" alt="..." />

                    </g:else>

                    <div class="over">
                        <div class="info-wrapper">
                            <div class="info">

                                <div class="description">Ajouté le:
                                    <g:formatDate format="EE dd-MM-yyyy HH:mm" locale="fr"
                                                  date="${planInstance.date}"/></div>

                                <g:form name="deleteForm" resource="${planInstance}" controller="plan"
                                        action="delete"
                                        method="DELETE"
                                        onsubmit="submit.disabled = true; return true;">

                                    <g:hiddenField name="id" value="${planInstance.id}"/>

                                    <g:hiddenField name="actionName" value="${actionName}"/>

                                    <div class="func">
                                        <a href="#" data-toggle="modal"
                                           data-target="#md-fullWidth${planInstance.id}"><i
                                                class="icon s7-search"></i></a>


                                        <a class="image-zoom" href="#"
                                           onclick="submitForm('${"buttonDelete" + planInstance.id}')">
                                            <i class="icon s7-trash"></i>
                                        </a>

                                    </div>

                                    <button style="display: none" type="submit"
                                            id="${"buttonDelete" + planInstance.id}"/>

                                </g:form>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="md-fullWidth${planInstance.id}" tabindex="-1" role="dialog">
            <div class="modal-dialog full-width">
                <div class="modal-content">
                    <div class="modal-header">
                        <button class="close" type="button" data-dismiss="modal" aria-hidden="true"><span
                                class="s7-close"></span></button>
                    </div>

                    <div class="modal-body">
                        <g:if test="${planInstance.getDocumentType().equals("pdf")}">

                            <object width="100%" height="960px"
                                    data="<g:createLink controller="plan" action="showPlan"
                                                        params="[id: planInstance.id]"/>?#zoom=150"
                                    trusted="yes" application="yes">
                            </object>

                        </g:if>
                        <g:else>
                            <img class="card-img-top" src="<g:createLink controller="plan" action="showPlan" params="[id: planInstance.id]"/>" />
                        </g:else>

                    </div>
                </div>
            </div>
        </div>

    </g:each>

    <div class="item col-lg-4">
        <div class="photo">
            <div class="img">
                <g:link class="btn btn-space btn-secondary imagen" controller="plan" action="create"
                        params="['projet.id': projet.getId(), actionName: actionName]"
                        style="width:100%; font-size: 20px; font-weight: lighter">

                    <div class="icon mt-6 pt-3 icon-class" style="vertical-align: center">
                        <i class="s7-plus" style="font-size: 24px"></i>
                    </div>
                    Ajouter un document

                </g:link>
            </div>
        </div>
    </div>

</div>