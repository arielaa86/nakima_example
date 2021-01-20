<table width="100%" cellspacing="0" class="table dataTableNoImport table-hover">
    <thead class="bg-primary text-white">
    <tr>
        <th class="noExport noSorting"></th>
        <th class="noSorting" style="width: 400px!important" >Client</th>
        <th class="noSorting" style="width: 150px!important" >Montant</th>
        <th class="noSorting" style="width: 400px!important" >Encaissé par</th>
    </tr>
    </thead>
    <tbody>

    <g:each in="${paiements}" var="paiement">
        <tr style="font-size: 14px; ${paiement.supprime ? 'text-decoration: line-through;': ''}">
            <td></td>
            <td>
                <a href="#" data-toggle="modal" data-target="#paiement${paiement.id}">
                    ${paiement.getFacture().getDevis().getProjet().getClient()}
                </a>
            </td>
            <td>${new java.text.DecimalFormat("###,###.00 €").format(paiement.getMontant()).replaceAll(",", " ")}</td>
            <td style="font-size: 14px!important;">${paiement.getUtilisateur()}</td>
        </tr>



        <div class="modal fade" id="paiement${paiement.id}" tabindex="-1" role="dialog">
            <div class="modal-dialog full-width">
                <div class="modal-content">
                    <div class="modal-header noPrint" style="z-index: 8000; background-color: white">

                        <g:if test="${!paiement.moyen.equals("Espèces")}">

                            <g:if test="${!paiement.documentType.equals("pdf")}">

                                <button class="close zoomout" type="button"
                                        onclick="zoomout('image${paiement.getId()}')"><span
                                        class="s7-less"></span>
                                </button>
                                <button class="close zoomin" type="button"
                                        onclick="zoomin('image${paiement.getId()}')"><span
                                        class="s7-plus"></span>
                                </button>

                                <button style="-webkit-transform: scaleX(-1); transform: scaleX(-1)"
                                        class="close rotateLeft" type="button"
                                        onclick="rotateLeft('image${paiement.getId()}')"><span
                                        class="s7-refresh"></span></button>
                                <button class="close rotateRight" type="button"
                                        onclick="rotate('image${paiement.getId()}')"><span
                                        class="s7-refresh"></span>
                                </button>

                                <button class="close up" type="button"
                                        onclick="up('image${paiement.getId()}')"><span
                                        class="s7-up-arrow"></span></button>
                                <button class="close down" type="button"
                                        onclick="down('image${paiement.getId()}')"><span
                                        class="s7-bottom-arrow"></span>
                                </button>

                                <button class="close printer" type="button" onclick="window.print()"
                                        aria-hidden="true"><span class="s7-print"></span></button>

                                <button class="close" type="button" data-dismiss="modal"
                                        aria-hidden="true"><span
                                        class="s7-close"></span></button>

                            </g:if>
                            <g:else>

                                <button class="close" type="button" data-dismiss="modal"
                                        aria-hidden="true"><span
                                        class="s7-close"></span></button>

                            </g:else>

                        </g:if>
                        <g:else>

                            <button class="close" type="button" onclick="window.print()"
                                    aria-hidden="true"><span
                                    class="s7-print"></span></button>

                            <button class="close" style="margin-left: 10px" type="button"
                                    data-dismiss="modal"
                                    aria-hidden="true"><span class="s7-close"></span></button>

                        </g:else>

                    </div>

                    <div class="modal-body" style="min-height: 750px">

                        <div class="row justify-content-center">
                            <p>
                                ${paiement.commentaire != null ? "Commentaires: "+ paiement.commentaire : ""}
                            </p>
                        </div>



                        <div class="text-center">

                            <g:if test="${!paiement.moyen.equals("Espèces")}">

                                <g:if test="${paiement.documentType.equals("pdf")}">

                                    <object width="100%" height="700px" type="application/pdf"
                                            data="<g:createLink controller="paiement"
                                                                action="montrerPieceJointe"
                                                                params="[id: paiement.id]"/>" trusted="yes"
                                            application="yes">
                                    </object>

                                </g:if>
                                <g:else>

                                    <div class="row justify-content-center">

                                        <img id="image${paiement.getId()}"
                                             style="transform: rotate(0); margin-top: 0px"
                                             src="<g:createLink controller="paiement"
                                                                action="montrerPieceJointe"
                                                                params="[id: paiement.id]"/>"/>

                                    </div>

                                </g:else>

                            </g:if>
                            <g:else>

                                <g:render template="recuPaiement" model="['paiement': paiement]"></g:render>

                            </g:else>

                        </div>
                    </div>
                </div>
            </div>
        </div>



    </g:each>
    </tbody>
</table>
