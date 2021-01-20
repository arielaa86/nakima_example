<%@ page import="java.time.LocalDateTime; java.text.SimpleDateFormat" %>

<g:set var="calendar" value="${Calendar.getInstance()}"/>
<g:set var="date" value="${calendar.setTime(new Date())}"/>
<g:set var="dateOk" value="${calendar.getTime()}"/>

<g:set var="calendarPlus" value="${calendar.add(Calendar.DATE, 45)}"/>
<g:set var="datePlus" value="${calendar.getTime()}"/>

<div class="row m-1 mt-0 mb-5" style="color: gray; font-weight: bold; background-color:rgba(92,96,96,0.21);">

    <h5 class="col-lg-3 mt-2">Rappel</h5>


    <div class="col-lg-3" style="top: 6px">40% du prix: ${new java.text.DecimalFormat("###,###.00 €").format(facture.devis.compoQuarante).replaceAll(",", " ")}</div>


    <g:if test="${!facture.devis.ancien}">
        <div class="col-lg-3" style="top: 6px">55% du prix: ${new java.text.DecimalFormat("###,###.00 €").format(facture.devis.compoSoixante).replaceAll(",", " ")}</div>

        <div class="col-lg-3" style="top: 6px; margin-bottom: 10px">5% du prix: ${new java.text.DecimalFormat("###,###.00 €").format(facture.devis.verificationChantier).replaceAll(",", " ")}</div>

    </g:if>
    <g:else>

        <div class="col-lg-3" style="top: 6px">60% du prix: ${new java.text.DecimalFormat("###,###.00 €").format(facture.devis.compoSoixante).replaceAll(",", " ")}</div>

        <div class="col-lg-3" style="top: 6px; margin-bottom: 10px">Vérification du chantier : ${facture.devis.soldeProjet > 0 ? new java.text.DecimalFormat("###,###.00 €").format(facture.devis.soldeProjet).replaceAll(",", " ") : '0.00 €' }</div>

    </g:else>






</div>
<g:if test="${!facture.isClosed()}">

<div class="row">
    <div class="col-lg-3">

        <div class="form-group">
            <label>Moyen de paiement</label>
            <g:select id="moyen" class="form-control custom-select" name="moyen" onchange="addRequired()"
                      required="true"
                      noSelection="['': '---']"
                      from="${this.paiement?.constrainedProperties.moyen.inList}"
                      value="${this.paiement?.moyen}"/>
        </div>

    </div>

    <div class="col-lg-2">

        <div class="form-group">
            <label>Montant</label>
            <input id="montant" class="form-control" type="text" name="montant" onclick="viderChamp(this.id)"
                   onfocusout="formatChamp(this.id)" value="${this.paiement?.montant}" required="" autocomplete="off">
        </div>

    </div>


    <div class="col-lg-2 form-group d-flex justify-content-center p-0">

        <div class="form-group" style="margin-top: 2.8em;">
            <label id="checkboxMultiple" class="custom-control custom-checkbox" style="display: none">
                <input class="custom-control-input" id="multiple" name="multiple" type="checkbox"
                       onclick="showQuantite(this.id)">
                <span class="custom-control-label">Multiple</span>
            </label>
        </div>


        <div class="form-group" style="margin-top: 2.8em;">
            <label id="checkboxCaution" class="custom-control custom-checkbox" style="display: none">
                <input class="custom-control-input" id="caution" name="caution" type="checkbox"
                       onclick="">
                <span class="custom-control-label">Caution</span>
            </label>
        </div>

    </div>

    <div class="col-lg-2">
        <label id="quantiteLabel" class="mr-2" style="display: none">Nombre de paiements</label>
        <input id="quantiteInput" class="form-control" type="number" min="2" name="quantite" value="2" required=""
               autocomplete="off" style="display: none">

        <label id="dateLabel" class="mr-2" style="display: none">Date d'échéance</label>
        <input id="dateInput" class="form-control" type="date" name="dateProchaineEcheance" value="" min="${new SimpleDateFormat('yyyy-MM-dd', Locale.FRANCE).format(new Date())}"
               autocomplete="off" style="display: none">

    </div>

</div>


<div class="row">

    <div class="form-group col-lg-3" id="pieceJointe" style="display: inline">
        <label>Télécharger pièce jointe</label>

        <div>
            <input class="inputfile" type="file" name="pieceJointe" id="file-1"
                   data-multiple-caption="{count} fichiers sélectionnés">
            <label class="btn btn-secondary" style="min-width: 100%" for="file-1"><i
                    class="icon s7-upload"></i><span>Parcourir...</span></label>
        </div>
        <small id="fileMissing" class="form-text text-muted mb-3"
               style="color: #f94735!important; display: none">* Veuillez ajouter la pièce jointe</small>
    </div>


    <div class="form-group col-lg-6">
        <label>Commentaires</label>
        <textarea class="form-control" name="commentaire" rows="3"></textarea>
    </div>

</div>


</g:if>




<g:hiddenField name="facture.id" value="${this.paiement.facture.id}"/>




