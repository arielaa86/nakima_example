<%@ page import="mccorletagencement.Role; mccorletagencement.ProjetCuisine; mccorletagencement.ProjetComplementaire; mccorletagencement.ProjetAutre; mccorletagencement.ProjetPlacard; mccorletagencement.ProjetDressing; mccorletagencement.ProjetSalleBain; org.springframework.security.core.context.SecurityContextHolder; mccorletagencement.Utilisateur; java.text.SimpleDateFormat; java.text.DecimalFormat; mccorletagencement.Paiement" %>



<div class="row m-4 justify-content-center print" style="margin-top: 0px!important">
    <asset:image src="img/logomccorlet.jpg" style="width: 40%"/>

    <p class="mt-4 ml-5" style="font-size: 16px">
        Zac de Peters Maillet 97270 SAINT-ESPRIT <br>
        Téléphone 0596 70 41 31  - Télécopie 0596 56 69 97<br>
        SIRET : 818 034 829 00015 – APE 3102Z<br>
    </p>
</div>


<div class="row m-4 mb-6 justify-content-end print">
    <p class="mt-4 ml-5" style="font-size: 16px">
        Ducos, le <g:formatDate date="${new Date()}" format="dd MMMM yyyy" locale="fr"></g:formatDate>
    </p>

</div>


<div class="row m-3 print">
    <div class="col-lg-12">
        <h3>Projet No. ${facture.devis.projet.idInsitu}</h3>
    </div>
</div>


<div class="row ml-4 mr-4 mt-4 mb-0 print">
    <div class="card card-default">

        <div class="card-body">
            <table class="no-border no-strip skills">
                <tbody class="no-border-x no-border-y">
                <tr>
                    <td class="font-weight-bold">Désignation du produit:</td>
                    <td>
                        ${facture.devis.projet.getType()}
                    </td>
                    <td class="font-weight-bold text-right" style="min-width: 150px">Au nom de:</td>
                    <td>
                        ${facture.devis.projet.client}
                    </td>
                </tr>

                </tbody>
            </table>
        </div>
    </div>
</div>


<div class="row m-3">
    <div class="col-lg-12">

        <h3>Paiements réalisés</h3>
        <hr>

        <table class="table">
            <thead>
            <tr>
                <th style="font-weight:bold" scope="col">Date</th>
                <th style="font-weight:bold" scope="col">Moyen de paiement</th>
                <th style="font-weight:bold" scope="col">Montant réglé</th>
                <th class="noPrint" style="font-weight:bold" scope="col">Commentaires</th>
                <th class="noPrint" style="font-weight:bold" scope="col"></th>
            </tr>
            </thead>
            <tbody>

            <g:each in="${facture?.paiements.sort { it.date }}" var="paiement">

                <g:if test="${!paiement.supprime}">
                    <tr class="${paiement.multiple && paiement.encaissements.size() == 0 ? 'noPrint' : ''}">

                        <td>
                            <g:formatDate date="${paiement.date}" format="dd MMMM yyyy" locale="fr"/>
                        </td>
                        <td>${paiement.moyen}</td>
                        <td class="${paiement.multiple ? 'paiementMultiple' : ''}">
                            ${new DecimalFormat("###,###.00 €").format(paiement.montant).replaceAll(",", " ")}
                        </td>
                        <td class="noPrint">${paiement.commentaire}</td>
                        <td class="noPrint" style="text-align: right">

                            <g:formRemote resource="${this.paiement}" method="DELETE" name="deleteForm"
                                          onComplete="showMessage('Paiement supprimé')"
                                          url="[controller: 'paiement', action: 'delete', params: ['id': paiement.id]]"
                                          update="paiements">

                                <g:if test="${paiement.multiple}">
                                    <button id="btnCard" class="btn btn-space btn-secondary" data-toggle="modal"
                                            style="border:none; outline:none; font-size: 16px; color: #828080;"
                                            onclick="activateUpdate(${paiement.id})"
                                            data-target="#paiementMultiple${paiement.getId()}" type="button"><i
                                            style="font-size: 14px" class="fa fa-credit-card"></i>
                                        x ${paiement.quantite}
                                    </button>
                                </g:if>

                                <button class="btn btn-space btn-secondary fa fa-search" data-toggle="modal"
                                        style="border:none; outline:none; font-size: 14px; color: #828080;"
                                        data-target="#paiement${paiement.getId()}" type="button">
                                </button>


                                <g:if test="${paiement.dateProchaineEcheance != null}">
                                    <button data-toggle="modal"
                                            data-target="#chequeCaution"
                                            class="btn btn-space btn-secondary fa fa-download"
                                            style="border:none; outline:none; font-size: 14px; color: #828080;"
                                            type="button" onclick="getDetailsPaiement(${paiement.id})">
                                    </button>
                                </g:if>


                                <g:if test="${!paiement.facture.isClosed()}">
                                    <button class="btn btn-space btn-secondary icon fa fa-trash-o"
                                            type="submit" ${paiement.permetreEfasser() ? '' : 'disabled'}
                                            style="border:none; outline:none; font-size: 16px; color: ${paiement.permetreEfasser() ? '#f63232;' : '#dbdbdb'} "
                                            onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');">
                                    </button>
                                </g:if>

                            </g:formRemote>

                        </td>
                    </tr>

                    <g:if test="${paiement.multiple && paiement.encaissements.size()}">

                        <tr style="font-size: 10px">
                            <th colspan="2" style="border: none"></th>
                            <th class="paiementMultiple">Montant</th>
                            <th class="paiementMultiple">Date d'échéance</th>
                        </tr>

                        <g:each in="${paiement.encaissements.sort { it.id }}" var="encaissement" status="i">

                            <tr style="font-size: 10px">
                                <td colspan="2" style="border: none"></td>
                                <td class="paiementMultiple">${new DecimalFormat("###,###.00 €").format(encaissement.montant).replaceAll(",", " ")}</td>
                                <td class="paiementMultiple">
                                    <g:formatDate date="${encaissement.date}" format="dd MMMM yyyy" locale="fr"/>
                                    <g:if test="${encaissement.cestPaye()}">

                                        <i class="fa fa-check" style="color: darkgreen"></i>

                                    </g:if>

                                </td>
                            </tr>
                        </g:each>

                    </g:if>


                    <div class="modal fade modalRecu" id="paiement${paiement.getId()}" tabindex="-1" role="dialog">
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

                                <div class="modal-body" style="min-height: 1200px">
                                    <div class="text-center">

                                        <g:if test="${!paiement.moyen.equals("Espèces")}">

                                            <g:if test="${paiement.documentType.equals("pdf")}">

                                                <object width="100%" height="800px" type="application/pdf"
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

                    <g:if test="${paiement.multiple}">

                        <div class="modal fade noPrint" id="paiementMultiple${paiement.getId()}" tabindex="-1"
                             role="dialog">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header noPrint" style="z-index: 8000; background-color: white">

                                        <button class="close" style="margin-left: 10px" type="button"
                                                data-dismiss="modal"
                                                aria-hidden="true"><span
                                                class="s7-close"></span>
                                        </button>

                                    </div>

                                    <div class="modal-body" style="min-height: 500px">
                                        <div class="text-center">

                                            <g:if test="${paiement.encaissements.size() == 0}">

                                                <g:form controller="encaissement" action="saveEncaissements"
                                                        method="POST"
                                                        onsubmit="submit.disabled = true; return true;">

                                                    <g:each in="${0..paiement.quantite - 1}" var="i">

                                                        <div class="d-flex justify-content-around">

                                                            <div class="form-group text-left">
                                                                <label>Montant</label>
                                                                <input id="montant${i}${paiement.id}"
                                                                       class="form-control" type="text"
                                                                       name="montant${i}${paiement.id}"
                                                                       onclick="viderChamp(this.id)"
                                                                       onkeyup="calculerTotal(${paiement.montant}, ${paiement.quantite}, ${paiement.id})"
                                                                       onfocusout="formatChamp(this.id)"
                                                                       value="0.00"
                                                                       required="" autocomplete="off">
                                                            </div>

                                                            <div class="form-group text-left">
                                                                <label>Date d'échéance</label>
                                                                <input id="date${i}${paiement.id}" class="form-control"
                                                                       type="date"
                                                                       name="date${i}${paiement.id}"
                                                                       value="${new SimpleDateFormat("yyyy-MM-dd").format(paiement.obtenirDateProchaineEcheance(paiement.date, i))}"
                                                                       required="">
                                                            </div>
                                                        </div>

                                                    </g:each>

                                                    <g:hiddenField name="idPaiement" value="${paiement.id}"/>

                                                    <button id="create${paiement.id}"
                                                            class="btn btn-space btn-success mt-3"
                                                            type="submit"
                                                            onclick="showRequired()"><i
                                                            class="fa fa-save"></i> <g:message
                                                            code="default.button.create.label"/>
                                                    </button>

                                                </g:form>

                                            </g:if>
                                            <g:else>

                                                <g:set var="encaissementsListe"
                                                       value="${paiement.encaissements.sort { it.id }}"></g:set>

                                                <g:form controller="encaissement" action="actualiserEncaissements"
                                                        method="POST" onsubmit="submit.disabled = true; return true;">
                                                    <div id="formBody${paiement.id}" disabled>
                                                        <g:each in="${encaissementsListe}"
                                                                var="encaissement" status="i">

                                                            <div class="d-flex justify-content-around">

                                                                <div class="form-group text-left">
                                                                    <label>Montant</label>
                                                                    <input id="montant${encaissement.getId()}"
                                                                           class="form-control" type="text"
                                                                           name="montant${encaissement.getId()}"
                                                                           onclick="viderChamp(this.id)"
                                                                           onkeyup="calculerTotalMultiple(${paiement.montant}, ${paiement.quantite}, ${encaissementsListe.getAt(0).id}, ${paiement.id})"
                                                                           onfocusout="formatChamp(this.id)"
                                                                           value="${encaissement.montant}"
                                                                           required="" autocomplete="off">
                                                                </div>

                                                                <div class="form-group text-left">
                                                                    <label>Date d'échéance</label>
                                                                    <input id="date${encaissement.getId()}"
                                                                           class="form-control" type="date"
                                                                           name="date${encaissement.getId()}"
                                                                           value="${new SimpleDateFormat("yyyy-MM-dd").format(encaissement.date)}"
                                                                           required="">
                                                                </div>
                                                            </div>

                                                        </g:each>
                                                    </div>

                                                    <g:hiddenField name="idPaiement" value="${paiement.id}"/>

                                                    <button id="update${paiement.id}"
                                                            class="btn btn-space btn-secondary mt-3"
                                                            type="button"
                                                            onclick="activateSave(${paiement.montant}, ${paiement.quantite}, ${encaissementsListe.getAt(0).id}, ${paiement.id})"><i
                                                            class="fa fa-edit"></i> <g:message
                                                            code="default.button.edit.label"/>
                                                    </button>


                                                    <button id="save${paiement.id}" disabled
                                                            class="btn btn-space btn-success mt-3"
                                                            type="submit"
                                                            onclick="showRequired()"><i
                                                            class="fa fa-save"></i> <g:message
                                                            code="default.button.update.label"/>
                                                    </button>

                                                </g:form>
                                            </g:else>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </g:if>

                </g:if>
            </g:each>

            </tbody>
        </table>
    </div>

</div>

<div id="detailsPaiements">

    <div class="row m-3 mt-5 mb-5 p-4"
         style="text-align: center; font-size: 18px; background-color: rgba(92,96,96,0.21); font-weight:bold;text-decoration: ${facture.annulationDirection > 0 ? 'line-through' : ''}">

        <div class="col-lg-4">

            Total à payer: ${new java.text.DecimalFormat("###,###.00 €").format(facture.totalPayer()).replaceAll(",", " ")}

        </div>

        <div class="col-lg-4">
            Réglé à ce jour: ${facture.regleCeJour() > 0 ? new java.text.DecimalFormat("###,###.00 €").format(facture.regleCeJour()).replaceAll(",", " ") : "0.00 €"}
        </div>

        <div class="col-lg-4" style="color:#bd4233">
            Restant dû:  ${facture.restantDu() > 0 ? new java.text.DecimalFormat("###,###.00 €").format(facture.restantDu()).replaceAll(",", " ") : "0.00 €"}
        </div>

    </div>

    <g:if test="${facture.annulationDirection > 0}">
        <div class="row m-3 mt-5 mb-5 p-4"
             style="text-align: center; font-size: 18px; border: dashed 1px gray; font-weight:bold">

            <div class="col-lg-4">
                Geste commercial: ${facture.annulationDirection > 0 ? new java.text.DecimalFormat("###,###.00 €").format(facture.annulationDirection).replaceAll(",", " ") : "0.00 €"}
            </div>

        </div>


        <div class="row m-3 mt-5 mb-5 p-4"
             style="text-align: center; font-size: 18px; background-color: rgba(92,96,96,0.21); font-weight:bold">

            <div class="col-lg-4">

                Nouveau total à payer: ${new java.text.DecimalFormat("###,###.00 €").format(facture.totalPayer() - facture.annulationDirection).replaceAll(",", " ")}

            </div>

            <div class="col-lg-4">
                Réglé à ce jour: ${facture.regleCeJour() > 0 ? new java.text.DecimalFormat("###,###.00 €").format(facture.regleCeJour()).replaceAll(",", " ") : "0.00 €"}
            </div>

            <div class="col-lg-4" style="color:#bd4233">
                Restant dû:  ${facture.restantDuAvecGesteCommercial() > 0 ? new java.text.DecimalFormat("###,###.00 €").format(facture.restantDuAvecGesteCommercial()).replaceAll(",", " ") : "0.00 €"}
            </div>

        </div>

    </g:if>

</div>

<div class="row justify-content-end print">
    <p class="mt-3 mb-0 mr-6" style="font-size: 18px">Pour Martinique Cuisine:</p>

</div>

<div class="row justify-content-end print">
    <p class="mr-6"
       style="font-size: 18px">${Utilisateur.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName()).toString()}</p>
</div>


<div class="row justify-content-end print">
    <asset:image width="300px" src="img/tampon.png" style="position: absolute; opacity: 70%;"/>
    <g:if test="${Utilisateur.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName()).signature}">
        <img width="200px" src="<g:createLink controller="utilisateur" action="showSignature"
                                              params="['id': Utilisateur.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName()).id]"/>"/>
    </g:if>
</div>

<div class="row m-1 mt-5 mb-5 noPrint" style="text-align: right;">
    <div class="col-lg-12 m-2 mt-5 mb-5">

        <g:link class="btn btn-space btn-secondary" controller="factureClient"
                action="show" id="${facture.id}"><i
                class="fa fa-chevron-left"></i> Retour au bon de commande</g:link>


        <g:if test="${facture.regleCeJour() >= facture?.devis.compoQuarante && !facture.isClosed() &&
                Utilisateur.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName()).authorities.contains(Role.findByAuthority("ROLE_DIRECTEUR"))}">
            <button class="btn btn-space btn-secondary" data-toggle="modal" data-target="#gesteCommercial"><i
                    class="fa fa-star"></i>
                Faire un geste commercial</button>

            <div class="modal fade" id="gesteCommercial" tabindex="-1" aria-labelledby="exampleModalLabel"
                 aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">Montant du geste commercial</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>

                        <div class="modal-body">
                            <g:hiddenField name="idFacture" value="${facture.id}"></g:hiddenField>
                            <input id="geste" class="form-control" type="text"
                                   name="geste" value="${this.facture.annulationDirection}">
                        </div>

                        <div class="modal-footer">
                            <button type="button" class="btn btn-success" style="width: 120px"
                                    onclick="annulationDirection()">Enregistrer</button>
                            <button type="button" class="btn btn-primary" data-dismiss="modal"
                                    style="width: 120px">Annuler</button>

                        </div>
                    </div>
                </div>
            </div>
        </g:if>

        <g:if test="${facture?.paiements.size() >= 1}">

            <button class="btn btn-space btn-secondary" type="button" onclick="window.print()"><i
                    class="fa fa-print"></i>
                Imprimer reçu</button>

        </g:if>


        <g:if test="${facture.restantDu() == 0 || facture.restantDuAvecGesteCommercial() <= 0}">

            <g:link class="btn btn-space" style="background-color: #1a9fdd; color: white" controller="factureClient"
                    action="factureAcquittee" id="${facture.id}"><i
                    class="fa fa-edit"></i> Générer facture acquittée</g:link>

        </g:if>

    </div>
</div>


