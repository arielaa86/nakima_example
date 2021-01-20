
    <div class="row justify-content-center" style="font-size: 16px;">
        <div class="col-lg-8 font-weight-bold">
            <label>La présente commande est stipulée:</label>
        </div>
    </div>


    <div class="row justify-content-center" style="padding-left: 20px; padding-right: 20px; margin-bottom: 20px">
    <div class="col-lg-8" style="border: solid 1px  darkgray;">


    <div class="row justify-content-start mt-3 pl-3">

      <div class="form-group col-lg-4 col-md-4 col-sm-6 mb-0" style="font-size: 16px">

          <label class="custom-control custom-checkbox custom-control-inline">
              <input disabled class="custom-control-input" type="checkbox" ${this.factureClient?.livraisonIncluse ? 'checked=""' : ''}
                       name="livraisonIncluse">
                <span class="custom-control-label">Livraison incluse</span>
            </label>

        </div>


        <div class="form-group col-lg-4 col-md-4 col-sm-6 mb-0" style="font-size: 16px">

            <label class="custom-control custom-checkbox custom-control-inline">
                <input disabled class="custom-control-input" type="checkbox" ${this.factureClient?.horsLivraison ? 'checked=""' : ''}
                       name="horsLivraison">
                <span class="custom-control-label">Hors livraison</span>
            </label>

        </div>

    </div>

    <div class="row justify-content-start mb-1 pl-3">

        <div class="form-group col-lg-4 col-md-4 col-sm-6 mb-0" style="font-size: 16px">

            <label class="custom-control custom-checkbox custom-control-inline">
                <input disabled class="custom-control-input" type="checkbox" ${this.factureClient?.poseIncluse ? 'checked=""' : ''}
                       name="poseIncluse">
                <span class="custom-control-label">Pose incluse</span>
            </label>

        </div>


        <div class="form-group col-lg-4 col-md-4 col-sm-6 mb-0" style="font-size: 16px">

            <label class="custom-control custom-checkbox custom-control-inline">
                <input disabled class="custom-control-input" type="checkbox" ${this.factureClient?.horsPose ? 'checked=""' : ''}
                       name="horsPose">
                <span class="custom-control-label">Hors pose</span>
            </label>

        </div>

    </div>

    </div>
    </div>






    <div class="row justify-content-center" style="font-size: 16px;">
        <div class="col-lg-8 font-weight-bold">
            <label>Livraison / Installation:</label>
        </div>
    </div>


    <div class="row justify-content-center" style="padding-left: 20px; padding-right: 20px; margin-bottom: 20px">
        <div class="col-lg-8" style="border: solid 1px  darkgray;">

            <div class="form-group col-lg-12 mt-3 mb-1" style="font-size: 16px; ">

                <label class="custom-control custom-checkbox custom-control-inline">
                    <input disabled class="custom-control-input" type="checkbox"
                        <g:if test="${this.factureClient?.enlevement}">
                            checked=""
                        </g:if>
                           name="enlevement"><span class="custom-control-label">
                    Enlèvement des meubles, appareils ménagers et autres fournitures, par l'acheteur au dépôt du vendeur</span>
                </label>

            </div>


            <div class="form-group col-lg-12 mb-1" style="font-size: 16px">

                <label class="custom-control custom-checkbox custom-control-inline">
                    <input disabled class="custom-control-input" type="checkbox"
                        <g:if test="${this.factureClient?.livraisonMC}">
                            checked=""
                        </g:if>
                           name="livraisonMC"><span
                        class="custom-control-label">Livraison par Martinique Cuisine, à l'acheteur, à l'adresse indiquée</span>
                </label>

            </div>

        </div>

    </div>

    <div class="row justify-content-center" style="font-size: 16px;">
        <div class="col-lg-8 font-weight-bold">
            <label>Garantie:</label>
        </div>
    </div>

    <div class="row justify-content-center" style="padding-left: 20px; padding-right: 20px; margin-bottom: 20px">

        <div class="col-lg-8" style="border: solid 1px  darkgray;">
            <div class="text-left" style="font-size: 16px; height: 26px;">
                <div class="d-flex mb-3">
                    <div class="p-2">
                        <label class="col-form-label">Meubles:</label>
                    </div>

                    <div class="p-2 flex-lg-grow-1 flex-md-grow-1">
                        <label class="col-form-label text-left"
                               style="font-size: 16px!important">${this.factureClient?.garantieMeubles}</label>
                    </div>
                </div>
            </div>

            <div class="text-left" style="font-size: 16px; height: 26px;">
                <div class="d-flex mb-3">
                    <div class="p-2">
                        <label class="col-form-label">Appareils ménagers:</label>
                    </div>

                    <div class="p-2 flex-lg-grow-1 flex-md-grow-1">
                        <label class="col-form-label text-left"
                               style="font-size: 16px!important">${this.factureClient?.garantieAppareils}</label>
                    </div>
                </div>
            </div>

            <div class="text-left" style="font-size: 16px;">
                <div class="d-flex mb-0">
                    <div class="p-2">
                        <label class="col-form-label">Autres fournitures:</label>
                    </div>

                    <div class="p-2 flex-lg-grow-1 flex-md-grow-1">
                        <label class="col-form-label text-left"
                               style="font-size: 16px!important">${this.factureClient?.garantieFournitures}</label>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <div class="row justify-content-center">

        <div class="form-group col-lg-8" style="font-size: 16px">
            <label for="accords" class="font-weight-bold">Accords particuliers éventuels:</label>
            <g:textArea disabled id="accords" class="form-control" name="accords" rows="5"
                        value="${this.factureClient?.accords}"/>
        </div>

    </div>


<g:hiddenField name="devis.id" value="${this.factureClient?.devis.id}"/>

