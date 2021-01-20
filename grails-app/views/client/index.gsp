<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'client.label', default: 'Client')}" />
        <title><g:message code="default.list.label" args="['des '+entityName+'s']" /></title>

    </head>
    <body>

            <div class="card card-default m-2">

                  <div class="card card-header">
                      <div class="row" style="color: rgba(0,0,0,0.7); vertical-align: middle">
                          <div class="col-lg-12" style="font-size: 22px;">
                              <i class="fa fa-list"></i> Liste des clients


                          </div>
                      </div>

                      <hr>
                  </div>

              <div class="card-body">



                <table width="100%" class="table dataTable table-hover table-bordered table-striped">
                  <thead>
                    <tr>
                      <th class="noExport"></th>
                      <th class="menu noSorting"></th>
                      <th>Nom</th>
                      <th>Prénom</th>
                      <th>Téléphone</th>
                      <th>Adresse</th>
                      <th>Code postal</th>
                      <th>Ville</th>
                    </tr>
                  </thead>
                  <tbody>
                    <g:each var="client" in="${clientList}">

                      <tr>
                        <td>

                        </td>
                        <td>
                            <div class="dropdown">
                            <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <i class="fa fa-list"></i>
                            </a>

                            <div id="dropdown-menu" class="dropdown-menu" aria-labelledby="dropdownMenuLink">

                                <g:link class="dropdown-item" controller="client" action="show" id="${client.get("id")}">
                                    Accéder à la fiche client
                                </g:link>

                                <%--
                                <g:if test="${client.hasDevis()}">
                                    <g:link class="dropdown-item" controller="devis" action="index" params="[idClient: client.id]">
                                        Accéder aux devis
                                    </g:link>

                                </g:if>


                                <g:if test="${client.hasFactures()}">
                                    <g:link class="dropdown-item" controller="factureClient" action="index" params="[idClient: client.id]">
                                        Accéder aux bons de commande
                                    </g:link>

                                </g:if>

                                --%>

                            </div>
                        </div>

                        </td>
                        <td>
                            ${client?.get("nom")}
                        </td>
                        <td>${client?.get("prenom")}</td>
                        <td>${client?.get("telephone")}</td>
                        <td>${client?.get("adresse")}</td>
                        <td>${client?.get("codePostal")}</td>
                        <td>${client?.get("ville")}</td>
                          <%--
                          <td>${client?.get("concepteur") }</td>
                          --%>
                      </tr>

                    </g:each>
                  </tbody>
                </table>

              </div>
            </div>


    </body>
</html>
