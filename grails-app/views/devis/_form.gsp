<%@ page import="mccorletagencement.Role; java.text.SimpleDateFormat; mccorletagencement.ProjetComplementaire" %>


<g:if test="${actionName != 'createComplement'}">
<div class="form-group col-lg-4 mb-0" style="${actionName == 'createComplement' ? 'visibility: hidden; height: 0px' : 'font-size: 16px' }">

    <label class="custom-control custom-checkbox custom-control-inline" style="${user.authorities.contains(Role.findByAuthority("ROLE_DIRECTEUR")) && user.prenom == 'Lynda' ? '': 'visibility: hidden; height: 0px'}">
        <input id="ancien" class="custom-control-input" type="checkbox" ${this.devis?.ancien ? 'checked=""' : ''}
               name="ancien" onclick="obtenirPrixProjet()">
        <span class="custom-control-label">Ancien devis</span>
    </label>

</div>

<div class="form-group col-lg-4 mb-0" style="${user.authorities.contains(Role.findByAuthority("ROLE_DIRECTEUR")) && user.prenom == 'Lynda' ? '': 'visibility: hidden; height: 0px'}">
    <label>Date de creation</label>
    <g:datePicker name="date" precision="day" value="${this.devis?.date}" />

</div>

</g:if>


<div class="form-group row" style="${actionName == 'createComplement' ? 'visibility: hidden; height: 0px' : '' }">
    <label  class="col-6 col-sm-3 col-lg-5 col-form-label text-sm-right">Validité du devis:</label>
    <div class="col-12 col-sm-8 col-lg-4 mb-3">
        <g:select class="form-control custom-select"  name="validite"
                  from="${this.devis?.constrainedProperties.validite.inList}"
                  required=""
                  value="${this.devis?.validite}" />

    </div>
</div>




<div class="form-group row">

    <label class="col-6 col-sm-3 col-lg-5 col-form-label text-sm-right">Télécharger pièce jointe:</label>
    <div class="col-12 col-sm-6">
        <input class="inputfile" type="file" name="documentWord" id="document" data-multiple-caption="{count} fichiers sélectionnés" multiple>
        <label style="min-width: 230px" class="btn btn-secondary" for="document"><i class="icon s7-upload"></i><span>Parcourir...</span></label>
        <small class="form-text text-muted">Ajouter ici le document Word généré par INSITU</small>
    </div>


</div>


<div class="form-group row">
    <label  class="col-6 col-sm-3 col-lg-5 col-form-label text-sm-right">Commentaires:</label>
    <div class="col-12 col-sm-8 col-lg-4 mb-3">
        <g:if test="${actionName.equals("create")}">

            <g:textArea style="line-height: 1.5" id="commentaire" class="form-control" name="commentaire" rows="5"  value="Meubles du modèle: Laqué plein - (L1)
Caisson mélaminé hydrofuge 19mm
Portes médium hydrofuge Ep 19mm" />


        </g:if>
        <g:else>
            <g:textArea id="commentaire" class="form-control" name="commentaire" rows="5"  value="${this.devis?.commentaire}" />
        </g:else>

    </div>
</div>


<div class="form-group row">
    <label class="col-6 col-sm-3 col-lg-5 col-form-label text-sm-right">Renseigner le mètre linéaire:</label>
    <div class="col-12 col-sm-8 col-lg-2" >
        <input required="required" id="metreLineaire" class="form-control" onkeyup="obtenirPrixMin()"
               type="text" onclick="viderChamp(this.id)" onfocusout="formatChamp(this.id)" name="metreLineaire" value="${this.devis?.metreLineaire}">
    </div>
    <div class="col-12 col-sm-8 col-lg-5" style="font-weight: bold" >
        <label class="col-form-label"> Prix minimum: </label>
        <label id="resultat" class="col-form-label"></label>

    </div>
</div>

<div class="form-group row" style="${actionName == 'createComplement' ? 'visibility: hidden; height: 0px' : '' }">
    <label  class="col-6 col-sm-3 col-lg-5 col-form-label text-sm-right">Catégorie de prix:</label>
    <div class="col-12 col-sm-8 col-lg-2 mb-3">

        <g:if test="${actionName != 'createComplement'}">

            <g:select class="form-control custom-select" name="categoriePrix" id="categoriePrix"
                      noSelection="['': '---']"
                      from="${this.devis?.constrainedProperties.categoriePrix.inList}"
                      value="${this.devis?.categoriePrix}"
            />

        </g:if>


    </div>
</div>



<g:hiddenField name="projet.id" value="${this.devis?.projet.id}" />



