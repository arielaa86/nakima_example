<div class="row p-3">


        <label class="col-12 col-sm-3 col-form-label text-sm-right">Télécharger pièce jointe:</label>
        <div class="col-12 col-sm-6">
            <input class="inputfile" type="file" name="document" id="document" data-multiple-caption="{count} fichiers sélectionnés" multiple>
            <label class="btn btn-secondary" for="document"><i class="icon s7-upload"></i><span>Parcourir...</span></label>
        </div>


        <g:hiddenField name="projet.id" value="${this.plan?.projet.id}" />


</div>
