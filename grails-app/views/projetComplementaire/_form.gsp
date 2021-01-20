<%@ page import="mccorletagencement.Projet" %>


<div class="row m-4">
    <div class="col-md-12">
        <div class="card card-default">
            <div class="card-body pl-sm-5">


                <div class="form-group row">
                    <label class="col-6 col-sm-3 col-form-label text-sm-right">Projet principal: </label>

                    <div class="col-12 col-sm-8 col-lg-3" style="margin-top: 11px">
                        ${projetPrincipal.idInsitu}
                    </div>
                </div>

                <div class="form-group row">
                    <label class="col-6 col-sm-3 col-form-label text-sm-right">No. Dossier: </label>

                    <div class="col-12 col-sm-8 col-lg-3" style="margin-top: 11px">
                        ${projetPrincipal.idInsitu +"-C"+(projetPrincipal.devisClient.facture.getNumComplement()) }
                    </div>

                    <g:hiddenField value="${projetPrincipal.idInsitu +"-C"+(projetPrincipal.devisClient.facture.getNumComplement())}" name="idInsitu"/>

                </div>


                <div class="form-group row">
                    <label class="col-6 col-sm-3 col-form-label text-sm-right">Description du projet</label>

                    <div class="col-12 col-sm-12 col-lg-6" style="display:block">
                        <g:textField class="form-control" name="description"
                                     value="${this.projetComplementaire?.description}"/>
                    </div>

                </div>


                <div style="visibility: hidden; height: 50px">

                    <g:textField class="form-control" name="projetPrincipal"
                                 value="${this.projetComplementaire?.projetPrincipal != null ? this.projetComplementaire?.projetPrincipal.id : params.projet }"/>





                    <g:select class="form-control custom-select" name="typeHabitation"
                              from="${this.projetComplementaire?.constrainedProperties.typeHabitation.inList}"
                              required=""
                              value="${this.projetComplementaire?.typeHabitation}"/>


                    <g:select class="form-control custom-select" name="typeTravail"
                              from="${this.projetComplementaire?.constrainedProperties.typeTravail.inList}"
                              required=""
                              value="${this.projetComplementaire?.typeTravail}"/>


                    <g:datePicker name="delaiRealisation"
                                  value="${this.projetComplementaire?.delaiRealisation}"
                                  relativeYears="[0..1]"
                                  precision="day"/>

                    <g:select id="poignees" class="form-control custom-select" name="poigneesModele"
                              from="${this.projetComplementaire.constrainedProperties.poigneesModele.inList}"
                              required=""
                              value="${this.projetComplementaire?.poigneesModele}"/>

                    <g:select id="budget" class="form-control custom-select" name="budget"
                              from="${this.projetComplementaire.constrainedProperties.budget.inList}"
                              required=""
                              value="${this.projetComplementaire?.budget}"/>



                    <g:select id="financement" class="form-control custom-select" name="financement"
                              from="${this.projetComplementaire.constrainedProperties.financement.inList}"
                              required=""
                              value="${this.projetComplementaire?.financement}"/>


                    <g:select class="form-control custom-select" name="style"
                              from="${this.projetComplementaire.constrainedProperties.style.inList}"
                              required=""
                              value="${this.projetComplementaire?.style}"/>





                    <g:select id="facadeLaquee" class="form-control custom-select" name="facadeLaquee"
                              from="${this.projetComplementaire.constrainedProperties.facadeLaquee.inList}"
                              required=""
                              value="${this.projetComplementaire?.facadeLaquee}"/>



                    <g:select id="facadeBois" class="form-control custom-select" name="facadeBois"
                              from="${this.projetComplementaire.constrainedProperties.facadeBois.inList}"
                              required=""
                              value="${this.projetComplementaire?.facadeBois}"/>




                    <g:select class="form-control custom-select" name="optionMeuble"
                              from="${this.projetComplementaire?.constrainedProperties.optionMeuble.inList}"
                              required=""
                              value="${this.projetComplementaire?.optionMeuble}"/>

                    <g:hiddenField name="client.id" value="${this.projetComplementaire?.client.id}"/>

                </div>




            </div>
        </div>
    </div>
</div>
