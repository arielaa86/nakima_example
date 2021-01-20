
<div class="row justify-content-center" style="font-size: 16px;">
    <div class="col-lg-8 font-weight-bold">
        <label>La présente commande est stipulée:</label>
    </div>
</div>



<div class="row justify-content-center">

    <div class="form-group col-lg-4 mb-0" style="font-size: 16px">

        <label class="custom-control custom-checkbox custom-control-inline">
            <input id="livraisonIncluse" class="custom-control-input" type="checkbox" ${this.factureClient?.livraisonIncluse ? 'checked=""' : ''}
                   name="livraisonIncluse">
            <span class="custom-control-label">Livraison incluse</span>
        </label>

    </div>


    <div class="form-group col-lg-4 mb-0" style="font-size: 16px">

        <label class="custom-control custom-checkbox custom-control-inline">
            <input id="horsLivraison" class="custom-control-input" type="checkbox" ${this.factureClient?.horsLivraison ? 'checked=""' : ''}
                   name="horsLivraison">
            <span class="custom-control-label">Hors livraison</span>
        </label>

    </div>

</div>

<div class="row justify-content-center mb-4">

    <div class="form-group col-lg-4 mb-0" style="font-size: 16px">

        <label class="custom-control custom-checkbox custom-control-inline">
            <input id="poseIncluse" class="custom-control-input" type="checkbox" ${this.factureClient?.poseIncluse ? 'checked=""' : ''}
                   name="poseIncluse" >
            <span class="custom-control-label">Pose incluse</span>
        </label>

    </div>


    <div class="form-group col-lg-4 mb-0" style="font-size: 16px">

        <label class="custom-control custom-checkbox custom-control-inline">
            <input id="horsPose" class="custom-control-input" type="checkbox" ${this.factureClient?.horsPose ? 'checked=""' : ''}
                   name="horsPose">
            <span class="custom-control-label">Hors pose</span>
        </label>

    </div>



</div>







<div class="row justify-content-center" style="font-size: 16px;">
    <div class="col-lg-8 font-weight-bold">
        <label>Livraison / Installation:</label>
    </div>
</div>



<div class="row justify-content-center">

    <div class="form-group col-lg-8 mb-1" style="font-size: 16px">

        <label class="custom-control custom-checkbox custom-control-inline">
            <input id="enlevement" class="custom-control-input" type="checkbox" ${this.factureClient?.enlevement ? 'checked=""' : ''}
                   name="enlevement">
            <span class="custom-control-label">Enlèvement des meubles, appareils ménagers et autres fournitures, par l'acheteur au dépôt du vendeur</span>
        </label>

    </div>


    <div class="form-group col-lg-8" style="font-size: 16px">

        <label class="custom-control custom-checkbox custom-control-inline">
            <input id="livraisonMC" class="custom-control-input" type="checkbox" ${this.factureClient?.livraisonMC ? 'checked=""' : ''}
                   name="livraisonMC">
            <span class="custom-control-label">Livraison par Martinique Cuisine, à l'acheteur, à l'adresse indiquée</span>
        </label>

    </div>



</div>



<div class="row justify-content-center" style="font-size: 16px;">
    <div class="col-lg-8 font-weight-bold">
        <label>Garantie:</label>
    </div>
</div>

<div class="row justify-content-center" style="padding-left: 20px; padding-right: 20px; margin-bottom: 20px">

    <div class="col-lg-8 text-left" style="font-size: 16px; height: 55px">
        <div class="d-flex mb-3">
            <div class="p-2 col-lg-3 text-right">
                <label class="col-form-label">Meubles:</label>
            </div>
            <div class="p-2 flex-lg-grow-1 flex-md-grow-1">
                <input class="form-control text-left" type="text" style="font-size: 16px!important" name="garantieMeubles" value="${ actionName.equals("create") ? '5 Ans pour les corps de meubles' : this.factureClient?.garantieMeubles}" >
            </div>
        </div>
    </div>



    <div class="col-lg-8 text-left" style="font-size: 16px; height: 55px">
        <div class="d-flex mb-3">
            <div class="p-2 col-lg-3 text-right">
                <label class="col-form-label">Appareils ménagers:</label>
            </div>
            <div class="p-2 flex-lg-grow-1 flex-md-grow-1">
                <input class="form-control text-left" type="text" style="font-size: 16px!important" name="garantieAppareils" value="${this.factureClient?.garantieAppareils}" >
            </div>
        </div>
    </div>

    <div class="col-lg-8 text-left" style="font-size: 16px; height: 55px">
        <div class="d-flex mb-3">
            <div class="p-2 col-lg-3 text-right">
                <label class="col-form-label">Autres fournitures:</label>
            </div>
            <div class="p-2 flex-lg-grow-1 flex-md-grow-1">
                <input class="form-control text-left" type="text" style="font-size: 16px!important" name="garantieFournitures" value="${this.factureClient?.garantieFournitures}" >
            </div>
        </div>
    </div>


</div>


<div class="row justify-content-center">

    <div class="form-group col-lg-8" style="font-size: 16px">
        <label class="font-weight-bold" for="accords ">Accords particuliers éventuels:</label>
        <g:textArea id="accords" class="form-control" name="accords" rows="5" value="${this.factureClient?.accords}"/>
    </div>

</div>



<g:hiddenField name="devis.id" value="${this.factureClient?.devis.id}"/>

