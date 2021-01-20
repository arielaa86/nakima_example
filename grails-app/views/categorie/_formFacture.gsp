<%@ page import="java.text.SimpleDateFormat" %>

<div class="col-lg-6">

    <div class="form-group m-3">
        <label for="descriptionFacture">No. facture</label>
        <input type="text" autocomplete="off" name="numero" class="form-control" id="numero"/>
    </div>

</div>


<div class="col-lg-6">
    <div class="form-group m-3">

        <label for="date">Date</label>

        <input type="date" name="date"  class="form-control" id="date"
               value="${new SimpleDateFormat("yyyy-MM-dd").format(new Date())}"
               autocomplete="off">

    </div>
</div>

<div class="col-lg-6">
    <div class="form-group m-3">
        <label for="chercherFournisseur">Fournisseur</label>

        <input type="text" autocomplete="off" name="chercherFournisseur" class="form-control" id="chercherFournisseur"
               onkeyup="filtrerFournisseurs()"/>

        <div id="selectFournisseur" style="display: none; z-index: 3000; position: absolute">
            <g:render template="selectFournisseur" model="[listeFournisseurs: listeFournisseurs]"/>
        </div>

    </div>
</div>

<div class="col-lg-6">
    <div class="form-group m-3">
        <label for="montantFacture">Montant</label>
        <input type="text" autocomplete="off" name="montant" class="form-control" id="montantFacture"/>
    </div>
</div>


<div class="col-lg-12">
    <div class="form-group m-3">
        <label for="descriptionFacture">Description</label>
        <input type="text" autocomplete="off" name="description" class="form-control" id="descriptionFacture"/>
    </div>
</div>

<div class="col-lg-6">
    <div class="form-group m-3" id="categorie">
        <label>Poste de dépenses</label>

        <g:select class="form-control custom-select" id="categorie" name="categorie" required="true"
                  noSelection="['': '---']"
                  from="${postesDepenses}"
                  optionKey="id"
                  optionValue="${{ it.description }}"/>
    </div>
</div>


<div class="col-lg-6">
    <div class="form-group m-3" id="pieceJointe">
        <label>Télécharger pièce jointe</label>

        <div>
            <input class="inputfile" type="file" name="document" id="file-1"
                   data-multiple-caption="{count} fichiers sélectionnés" multiple>
            <label class="btn btn-secondary" style="min-width: 200px; height: 40px; border: 2px solid #ebebeb"
                   for="file-1"><i
                    class="icon s7-upload"></i><span id="parcourir">Parcourir...</span></label>
        </div>

    </div>
</div>



