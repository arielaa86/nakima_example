

<div class="row p-3">
  <div class="col-lg-2 col-md-2">
            <label class="col-form-label text-sm-right">Intitulé:</label>

      <g:select class="form-control custom-select" name="intitule" id="intitule"
                from="${this.client.constrainedProperties.intitule.inList}"
                required=""
                value="${this.client?.intitule}"
                onchange="addRequiredPrenom()"
      />
  </div>

  <div class="col-lg-5 col-md-5">
            <label class="col-form-label text-sm-right">* Nom:</label>
            <input class="form-control" type="text" name="nom" value="${this.client?.nom}">

  </div>

  <div class="col-lg-5 col-md-5">
            <label class="col-form-label text-sm-right" id="labelPrenom">* Prénom:</label>
            <input required="" class="form-control" type="text" name="prenom" id="prenom" value="${this.client?.prenom}">

  </div>
</div>



<div class="row p-3">
  <div class="col-lg-6 col-md-6">
            <label class="col-form-label text-sm-right">* Adresse:</label>
            <input class="form-control" type="text" name="adresse" value="${this.client?.adresse}">
  </div>

  <div class="col-lg-2 col-md-2">
            <label class="col-form-label text-sm-right">* Code postal:</label>
            <input class="form-control" type="text" name="codePostal" value="${this.client?.codePostal}">

  </div>

  <div class="col-lg-4 col-md-4">
            <label class="col-form-label text-sm-right">* Ville:</label>
            <input class="form-control" type="text" name="ville" value="${this.client?.ville}">

  </div>
</div>


<div class="row p-3">
  <div class="col-lg-4 col-md-4">
            <label class="col-form-label text-sm-right">* Téléphone principal:</label>
            <input class="form-control" type="text" name="telephone" value="${this.client?.telephone}">
  </div>

  <div class="col-lg-4 col-md-4">
            <label class="col-form-label text-sm-right">Téléphone secondaire:</label>
            <input class="form-control" type="text" name="telephoneFixe" value="${this.client?.telephoneFixe}">

  </div>

  <div class="col-lg-4 col-md-4">
            <label class="col-form-label text-sm-right">E-mail:</label>
            <input class="form-control" type="text" name="email" value="${this.client?.email}">

  </div>

</div>


<div class="row p-3">

  <div class="col-lg-4 col-md-4">
            <label class="col-form-label text-sm-right">Secteur d'activité:</label>
            <input class="form-control" type="text" name="secteurActivite" value="${this.client?.secteurActivite}">

  </div>


  <div class="col-lg-4 col-md-4">
            <label class="col-form-label text-sm-right">Comment nous avez-vous connu ?</label>
             <g:select  id="reference" class="form-control custom-select" name="reference" onchange="showDetails()"
                from="${this.client.constrainedProperties.reference.inList}"
                required=""
                value="${this.client?.reference}" />
  </div>



  <div id="referenceAutre" class="col-lg-4 col-md-4" style="display:none">
            <label class="col-form-label text-sm-right">Précisez:</label>
            <input  class="form-control" type="text" name="referenceAutre" value="${this.client?.referenceAutre}">

  </div>
</div>
