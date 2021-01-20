<%@ page import="mccorletagencement.Role; mccorletagencement.ProjetAutre; mccorletagencement.ProjetPlacard; mccorletagencement.ProjetDressing; mccorletagencement.ProjetSalleBain; mccorletagencement.ProjetCuisine" %>

<div id="tableauPlanning">

    <div class="row accordion m-2" id="accordion">

        <div class="col-lg-6">
            <g:each in="${planning.take(6)}" var="plan" status="i">

                <div class="card monAccordion">
                    <div class="card-header d-flex justify-content-between" id="${plan.id}">
                        <button class="btn buttonAccordion" data-toggle="collapse" data-target="#collapse${plan.id}"
                                aria-expanded="true" aria-controls="collapse${plan.id}">
                            <span class="icon s7-angle-right"></span>${plan.mois}
                        </button>

                        <div>
                            <span class="badge badge-pill badge-secondary">${plan.listeBDC.size()}</span>
                        </div>
                    </div>

                    <div class="collapse" id="collapse${plan.id}" aria-labelledby="heading${plan.id}"
                         data-parent="#accordion">
                        <div class="card-block">

                            <div class="card card-default card-table">
                                <div class="card-header">
                                    Liste des projets
                                </div>

                                <div class="card-body table-responsive">
                                    <table class="table" style="min-width: 600px">
                                        <thead>
                                        <tr>
                                            <th>No.</th>
                                            <th>Type</th>
                                            <th>Client</th>
                                            <th>Semaine</th>
                                            <th>Livré</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <g:each in="${plan.listeBDC.sort({ it.devis.projet.semaine })}" var="bdc"
                                                status="k">
                                            <tr>
                                                <td>
                                                    <g:if test="${!user.authorities.contains(Role.findByAuthority("ROLE_TECHNICIEN"))}">
                                                        <g:link controller="projet" action="show"
                                                                id="${bdc.devis.projet.id}">
                                                            ${bdc.devis.projet.idInsitu}
                                                        </g:link>
                                                    </g:if>
                                                    <g:else>
                                                        ${bdc.devis.projet.idInsitu}
                                                    </g:else>
                                                </td>
                                                <td>
                                                    ${bdc.devis.projet.getType()}
                                                </td>
                                                <td>

                                                    <g:if test="${bdc.ordreProduction?.anonyme && user.authorities.contains(Role.findByAuthority("ROLE_TECHNICIEN"))}">
                                                        anonyme
                                                    </g:if>
                                                    <g:else>
                                                        ${bdc.devis.projet.client}
                                                    </g:else>

                                                </td>
                                                <td>${bdc.devis.projet.semaine}</td>
                                                <td>
                                                    <g:if test="${bdc.ordreProduction != null}">
                                                        <i class="${bdc.ordreProduction.livre ? 'fa fa-check' : ''}"
                                                           style="color: green"></i>
                                                    </g:if>
                                                </td>

                                            </tr>
                                            <tr>
                                                <td colspan="5"
                                                    style="border-color: white; padding-top: 0px;"><small>Concepteur: ${bdc.getLastUser()}</small>
                                                </td>
                                            </tr>
                                        </g:each>

                                        </tbody>
                                    </table>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>

            </g:each>
        </div>

        <div class="col-lg-6">

            <g:each in="${planning.grep({ it.id > 5 })}" var="plan" status="i">

                <div class="card monAccordion">
                    <div class="card-header d-flex justify-content-between" id="${plan.id}">
                        <button class="btn buttonAccordion" data-toggle="collapse" data-target="#collapse${plan.id}"
                                aria-expanded="true" aria-controls="collapse${plan.id}">
                            <span class="icon s7-angle-right"></span>${plan.mois}
                        </button>

                        <div>
                            <span class="badge badge-pill badge-secondary">${plan.listeBDC.size()}</span>
                        </div>
                    </div>

                    <div class="collapse" id="collapse${plan.id}" aria-labelledby="heading${plan.id}"
                         data-parent="#accordion">
                        <div class="card-block">

                            <div class="card card-default card-table">
                                <div class="card-header">
                                    Liste des projets
                                </div>

                                <div class="card-body table-responsive">
                                    <table class="table" style="min-width: 615px">
                                        <thead>
                                        <tr>
                                            <th>No.</th>
                                            <th>Type</th>
                                            <th>Client</th>
                                            <th>Semaine</th>
                                            <th>Livré</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <g:each in="${plan.listeBDC.sort({ it.devis.projet.semaine })}" var="bdc"
                                                status="k">
                                            <tr>
                                                <td>

                                                    <g:if test="${!user.authorities.contains(Role.findByAuthority("ROLE_TECHNICIEN"))}">
                                                        <g:link controller="projet" action="show"
                                                                id="${bdc.devis.projet.id}">
                                                            ${bdc.devis.projet.idInsitu}
                                                        </g:link>
                                                    </g:if>
                                                    <g:else>
                                                        ${bdc.devis.projet.idInsitu}
                                                    </g:else>
                                                <td>
                                                    ${bdc.devis.projet.getType()}
                                                </td>
                                                <td>
                                                    <g:if test="${bdc.ordreProduction?.anonyme && user.authorities.contains(Role.findByAuthority("ROLE_TECHNICIEN"))}">
                                                        anonyme
                                                    </g:if>
                                                    <g:else>
                                                        ${bdc.devis.projet.client}
                                                    </g:else>
                                                </td>
                                                <td>${bdc.devis.projet.semaine}</td>
                                                <td>
                                                    <g:if test="${bdc.ordreProduction != null}">
                                                        <i class="${bdc.ordreProduction.livre ? 'fa fa-check' : ''}"
                                                           style="color: green"></i>
                                                    </g:if>
                                                </td>

                                            </tr>
                                            <tr>
                                                <td colspan="5"
                                                    style="border-color: white; padding-top: 0px;"><small>Concepteur: ${bdc.getLastUser()}</small>
                                                </td>
                                            </tr>
                                        </g:each>

                                        </tbody>
                                    </table>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>

            </g:each>
        </div

    </div>

</div>
