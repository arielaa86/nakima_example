<%@ page import="mccorletagencement.Projet" %>


<div class="row m-4">
          <div class="col-md-12">
            <div class="card card-default">
              <div class="card-body pl-sm-5">

                  <div class="form-group row">
                    <label class="col-12 col-sm-3 col-form-label text-sm-right">Avez-vous fait réaliser un devis ?</label>
                    <div class="col-12 col-sm-8 col-lg-6 form-check mt-2">
                      <label class="custom-control custom-radio custom-control-inline">
                        <input id="devisRadioOui" class="custom-control-input" type="radio" name="devisRadio"
                            <g:if test="${this.projetSalleBain?.devis}">
                                checked=""
                            </g:if>
                               value="oui" onchange="showDevisOui()">
                        <span class="custom-control-label">Oui</span>
                      </label>
                      <label class="custom-control custom-radio custom-control-inline">
                        <input class="custom-control-input" type="radio" name="devisRadio"
                            <g:if test="${!this.projetSalleBain?.devis}">
                                checked=""
                            </g:if>
                               value="non" onchange="hideDevisOui()">
                        <span class="custom-control-label">Non</span>
                      </label>
                    </div>
                  </div>

                  <div class="form-group row">
                    <label id="labelDevisOui" class="col-6 col-sm-3 col-form-label text-sm-right" style="display:block">Pourquoi n'avez-vous pas concrétisé ?</label>
                    <div id="devisOui" class="col-12 col-sm-8 col-lg-6" style="display:block">
                      <input class="form-control" type="text" name="devisOui" value="${this.projetSalleBain?.devisOui}">
                    </div>
                  </div>


                  <div class="form-group row">
                    <label class="col-12 col-sm-3 col-form-label text-sm-right">Le projet concerne un(e)</label>
                    <div class="col-12 col-sm-8 col-lg-2">
                        <g:select class="form-control custom-select" name="typeHabitation"
                                  from="${this.projetSalleBain?.constrainedProperties.typeHabitation.inList}"
                                  required=""
                                  value="${this.projetSalleBain?.typeHabitation}" onchange="showQuantiteHabitation()" />
                    </div>

                      <label id="labelQuantiteHabitation" class="col-6 col-sm-3 col-lg-2 col-form-label text-sm-right" style="display:none">Nombre de logements:</label>

                      <div id="quantiteHabitation" class="col-12 col-sm-8 col-lg-2" style="display:none">
                          <input class="form-control" type="number" min="2" name="quantiteHabitation" value="${this.projetSalleBain?.quantiteHabitation}">
                      </div>

                      <label id="labelQuantitePieceEau" class="col-6 col-sm-3 col-lg-2 col-form-label text-sm-right" style="display:none">Nombre de pièce(s) d'eau:</label>
                      <div id="quantitePieceEau" class="col-12 col-sm-8 col-lg-2" style="display:none">
                          <input class="form-control" type="number" min="1" name="quantitePieceEau" value="${this.projetSalleBain?.quantitePieceEau}">
                      </div>

                  </div>

                  <div class="form-group row">
                    <label class="col-12 col-sm-3 col-form-label text-sm-right">Type de chantier</label>
                    <div class="col-12 col-sm-8 col-lg-2">
                        <g:select class="form-control custom-select" name="typeTravail"
                                  from="${this.projetSalleBain?.constrainedProperties.typeTravail.inList}"
                                  required=""
                                  value="${this.projetSalleBain?.typeTravail}" />
                    </div>
                  </div>


                  <div class="form-group row">
                      <label class="col-12 col-sm-3 col-form-label text-sm-right">Quel est le délai de réalisation du projet ?</label>
                      <div class="col-12 col-sm-8 col-lg-2">
                          <input style="padding: 10px" class="form-control" type="week" name="dateDelai" required
                                 value="${actualDate.replace("-", "-W")}"
                                 min="${minDateSelect.replace("-", "-W")}">
                      </div>
                  </div>



                  <div class="form-group row">
                    <label class="col-12 col-sm-3 col-form-label text-sm-right">Quel est votre budget ?</label>
                    <div class="col-12 col-sm-8 col-lg-2">
                        <g:select id="budget" class="form-control custom-select" name="budget"  onchange="showBudgetAutre()" noSelection="${['':'------']}"
                                  from="${this.projetSalleBain.constrainedProperties.budget.inList}"
                                  required=""
                                  value="${this.projetSalleBain?.budget}" />

                    </div>

                    <label id="labelBudgetAutre" class="col-12 col-sm-3 col-lg-2 col-form-label text-sm-right" style="display:none">Fourchette:</label>
                    <div id="budgetAutre" class="col-12 col-sm-8 col-lg-2" style="display:none">
                      <input class="form-control" type="text" name="budgetAutre" value="${this.projetSalleBain?.budgetAutre}">
                    </div>
                  </div>

                  <div class="form-group row">
                    <label class="col-12 col-sm-3 col-form-label text-sm-right">Comment souhaitez-vous financer votre projet ?</label>
                    <div class="col-12 col-sm-8 col-lg-2">
                        <g:select id="financement" class="form-control custom-select" name="financement" onchange="showFinancementAutre()"
                                  from="${this.projetSalleBain.constrainedProperties.financement.inList}"
                                  required=""
                                  value="${this.projetSalleBain?.financement}" />
                    </div>

                    <label id="labelFinancementAutre" class="col-12 col-sm-3 col-lg-2 col-form-label text-sm-right" style="display:none">Précisez:</label>
                    <div id="financementAutre" class="col-12 col-sm-8 col-lg-2" style="display:none">
                      <input class="form-control" type="text" name="financementAutre" value="${this.projetSalleBain?.financementAutre}">
                    </div>
                  </div>

                  <div class="form-group row">
                    <label class="col-12 col-sm-3 col-form-label text-sm-right">Quel style souhaitez-vous ?</label>
                    <div class="col-12 col-sm-8 col-lg-2">
                        <g:select class="form-control custom-select" name="style"
                                  from="${this.projetSalleBain.constrainedProperties.style.inList}"
                                  required=""
                                  value="${this.projetSalleBain?.style}" />
                    </div>
                  </div>


                  <!-- Salle de bain -->



                  <!-- Equipements -->


                  <h4>Equipements</h4>
                  <hr>


                      <div class="form-group row">
                          <label class="col-12 col-sm-3 col-form-label text-sm-right">Lavabo</label>
                          <div class="col-12 col-sm-8 col-lg-2">
                              <g:select class="form-control custom-select" name="lavabo"
                                        from="${this.projetSalleBain?.constrainedProperties.lavabo.inList}"
                                        required=""
                                        value="${this.projetSalleBain?.lavabo}" />
                          </div>
                      </div>


                    <div class="form-group row">
                        <label class="col-12 col-sm-3 col-form-label text-sm-right"></label>
                        <div class="col-12 col-sm-8 col-lg-6 form-check mt-2">
                          <label class="custom-control custom-checkbox custom-control-inline">
                              <input class="custom-control-input" type="checkbox"
                                  <g:if test="${this.projetSalleBain?.laveLinge}">
                                      checked=""
                                  </g:if>
                                     name="laveLinge"><span class="custom-control-label" style="width:170px">Lave-linge</span>
                          </label>
                        </div>
                    </div>



                        <h4>Matériaux</h4>
                        <hr>

                                  <div class="form-group row">
                                      <label class="col-12 col-sm-3 col-form-label text-sm-right">Façade laquée</label>
                                      <div class="col-12 col-sm-3 col-lg-2">
                
                                          <g:select id="facadeLaquee" class="form-control custom-select" name="facadeLaquee"
                                                    from="${this.projetSalleBain.constrainedProperties.facadeLaquee.inList}"
                                                    required=""
                                                    value="${this.projetSalleBain?.facadeLaquee}"
                                                    onchange="showFacadeLaqueeCouleur()"/>
                                      </div>
                
                                      <label id="labelFacadeLaqueeCouleur" class="col-6 col-sm-3 col-lg-2 col-form-label text-sm-right">Couleur(s)</label>
                                      <div id="facadeLaqueeCouleur" class="col-12 col-sm-3 col-lg-5">
                                          <input class="form-control" type="text" name="facadeLaqueeCouleur" value="${this.projetSalleBain?.facadeLaqueeCouleur}">
                                      </div>
                                  </div>
                
                                  <div class="form-group row">
                                      <label class="col-12 col-sm-3 col-form-label text-sm-right">Façade bois</label>
                                      <div class="col-12 col-sm-3 col-lg-2">
                                          <g:select id="facadeBois" class="form-control custom-select" name="facadeBois"
                                                    from="${this.projetSalleBain.constrainedProperties.facadeBois.inList}"
                                                    required=""
                                                    value="${this.projetSalleBain?.facadeBois}"
                                                    onchange="showFacadeBoisCouleur()"/>
                                      </div>
                
                                      <label id="labelFacadeBoisCouleur" class="col-6 col-sm-3 col-lg-2 col-form-label text-sm-right">Couleur(s)</label>
                                      <div id="facadeBoisCouleur" class="col-12 col-sm-3 col-lg-5">
                                          <input class="form-control" type="text" name="facadeBoisCouleur" value="${this.projetSalleBain?.facadeBoisCouleur}">
                                      </div>
                                  </div>

                                <div class="form-group row">

                                    <label class="col-12 col-sm-3 col-form-label text-sm-right">Plan de travail</label>
                                    <div class="col-12 col-sm-3 col-lg-2">
                                        <g:select class="form-control custom-select" name="planTravail"
                                                  from="${this.projetSalleBain.constrainedProperties.planTravail.inList}"
                                                  required=""
                                                  value="${this.projetSalleBain?.planTravail}" />
                                    </div>

                                    <label class="col-6 col-sm-3 col-lg-2 col-form-label text-sm-right">Couleur(s)</label>
                                    <div class="col-12 col-sm-3 col-lg-5">
                                        <input class="form-control" type="text" name="planTravailCouleur" value="${this.projetSalleBain?.planTravailCouleur}">
                                    </div>
                                </div>


                              <div class="form-group row">
                                <label class="col-12 col-sm-3 col-form-label text-sm-right">Poignées</label>
                                <div class="col-12 col-sm-3 col-lg-2 form-check mt-2">
                                  <label class="custom-control custom-radio custom-control-inline">
                                    <input id="poigneesOui" class="custom-control-input" type="radio" name="poigneesTexteRadio"
                                        <g:if test="${this.projetSalleBain?.poignees}">
                                            checked=""
                                        </g:if>
                                           value="oui" checked="" onchange="showPoigneesModele()">
                                    <span class="custom-control-label">Oui</span>
                                  </label>
                                  <label class="custom-control custom-radio custom-control-inline">
                                    <input class="custom-control-input" type="radio" name="poigneesTexteRadio"
                                        <g:if test="${!this.projetSalleBain?.poignees}">
                                            checked=""
                                        </g:if>
                                           value="non" onchange="hidePoigneesModele()">
                                    <span class="custom-control-label">Non</span>
                                  </label>
                                </div>

                                <label id="labelPoigneesModele" class="col-6 col-sm-3 col-lg-2 col-form-label text-sm-right" style="display:block">Modèle</label>
                                <div id="poigneesModele" class="col-12 col-sm-3 col-lg-2" style="display:block">
                                    <g:select id="poignees" class="form-control custom-select" name="poigneesModele"  onchange="showPoigneesAutre()"
                                              from="${this.projetSalleBain.constrainedProperties.poigneesModele.inList}"
                                              required=""
                                              value="${this.projetSalleBain?.poigneesModele}" />


                                </div>

                                  <label id="labelPoigneesAutre" class="col-12 col-sm-3 col-lg-1 col-form-label text-sm-right"
                                      <g:if test="${this.projetSalleBain?.poigneesModele.equals("Autre")}">
                                          style="display:block"
                                      </g:if>
                                      <g:else>
                                          style="display:none"
                                      </g:else>
                                  >Précisez:</label>
                                  <div id="poigneesAutre" class="col-12 col-sm-3 col-lg-2"
                                      <g:if test="${this.projetSalleBain?.poigneesModele.equals("Autre")}">
                                          style="display:block"
                                      </g:if>
                                      <g:else>
                                          style="display:none"
                                      </g:else>
                                  >
                                      <input class="form-control" type="text" name="poigneesAutre" value="${this.projetSalleBain?.poigneesAutre}">
                                  </div>
                              </div>

                              <div class="form-group row">
                                  <label class="col-12 col-sm-3 col-form-label text-sm-right">Option du meuble</label>
                                  <div class="col-12 col-sm-8 col-lg-2">
                                      <g:select class="form-control custom-select" name="optionMeuble"
                                                from="${this.projetSalleBain?.constrainedProperties.optionMeuble.inList}"
                                                required=""
                                                value="${this.projetSalleBain?.optionMeuble}" />
                                  </div>
                              </div>

                              <g:hiddenField name="client.id" value="${this.projetSalleBain?.client.id}" />


                              <g:hiddenField id="optionMeubleAux"  name="optionMeubleAux" value="" />
                              <g:hiddenField id="planTravailAux" name="planTravailAux" value="" />
                              <g:hiddenField id="poigneesModeleAux" name="poigneesModeleAux" value="" />


              </div>
            </div>
          </div>
</div>
