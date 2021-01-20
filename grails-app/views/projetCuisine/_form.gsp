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
                            <g:if test="${this.projetCuisine?.devis}">
                                checked=""
                            </g:if>
                               value="oui" onchange="showDevisOui()">
                        <span class="custom-control-label">Oui</span>
                      </label>
                      <label class="custom-control custom-radio custom-control-inline">
                        <input class="custom-control-input" type="radio" name="devisRadio"
                            <g:if test="${!this.projetCuisine?.devis}">
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
                      <input class="form-control" type="text" name="devisOui" value="${this.projetCuisine?.devisOui}">
                    </div>
                  </div>


                  <div class="form-group row">
                    <label class="col-12 col-sm-3 col-form-label text-sm-right">Le projet concerne un(e)</label>
                    <div class="col-12 col-sm-8 col-lg-2">
                        <g:select id="typeHabitation" class="form-control custom-select" name="typeHabitation"
                                  from="${this.projetCuisine?.constrainedProperties.typeHabitation.inList}"
                                  required=""
                                  value="${this.projetCuisine?.typeHabitation}" onchange="showQuantiteHabitation()"/>
                    </div>

                      <label id="labelQuantiteHabitation" class="col-6 col-sm-3 col-lg-2 col-form-label text-sm-right" style="display:none">Nombre de logements:</label>
                      <div id="quantiteHabitation" class="col-12 col-sm-8 col-lg-2" style="display:none">
                          <input class="form-control" type="number" min="2" name="quantiteHabitation" value="${this.projetCuisine?.quantiteHabitation}">
                      </div>

                  </div>

                  <div class="form-group row">
                    <label class="col-12 col-sm-3 col-form-label text-sm-right">Type de chantier</label>
                    <div class="col-12 col-sm-8 col-lg-2">
                        <g:select class="form-control custom-select" name="typeTravail"
                                  from="${this.projetCuisine?.constrainedProperties.typeTravail.inList}"
                                  required=""
                                  value="${this.projetCuisine?.typeTravail}" />
                    </div>
                  </div>
                  <div class="form-group row">
                      <label class="col-12 col-sm-3 col-form-label text-sm-right">Quel est le délai de réalisation du projet ?</label>
                      <div class="col-12 col-sm-8 col-lg-2">
                          <input style="padding: 10px" class="form-control" type="week" name="dateDelai" required
                                 value="${actualDate.replace("-", "-W")}"
                                 min="${minDateSelect.replace("-", "-W")}" onchange="verifierDisponibilite()">
                      </div>
                  </div>

                <div class="form-group row" id="disponibilite">

                </div>

<%--
                  <div class="form-group row">

                      <label class="col-12 col-sm-3 col-form-label text-sm-right">Quel est le délai de réalisation du projet ?</label>

                      <div id="datePicker" class="input-group col-12 col-sm-8 col-lg-2">
                          <input type="text" name="dateDelai" class="form-control" id="date" aria-describedby="btnGroupAddon"
                                 value="${actualDate}"
                                    min="${minDateSelect}"
                                 autocomplete="off">

                          <div id="dateIcon" style="position: relative; top: 11px; right: 30px;">
                              <i class="fa fa-calendar-o"></i>
                          </div>
                      </div>
                  </div>
                  --%>


                  <div class="form-group row">
                    <label class="col-12 col-sm-3 col-form-label text-sm-right">Quel est votre budget ?</label>
                    <div class="col-12 col-sm-8 col-lg-2">
                        <g:select id="budget" class="form-control custom-select" name="budget"  onchange="showBudgetAutre()" noSelection="${['':'------']}"
                                  from="${this.projetCuisine.constrainedProperties.budget.inList}"
                                  required=""
                                  value="${this.projetCuisine?.budget}" />

                    </div>

                    <label id="labelBudgetAutre" class="col-12 col-sm-3 col-lg-2 col-form-label text-sm-right" style="display:none">Fourchette:</label>
                    <div id="budgetAutre" class="col-12 col-sm-8 col-lg-2" style="display:none">
                      <input class="form-control" type="text" name="budgetAutre" value="${this.projetCuisine?.budgetAutre}">
                    </div>
                  </div>

                  <div class="form-group row">
                    <label class="col-12 col-sm-3 col-form-label text-sm-right">Comment souhaitez-vous financer votre projet ?</label>
                    <div class="col-12 col-sm-8 col-lg-2">
                        <g:select id="financement" class="form-control custom-select" name="financement" onchange="showFinancementAutre()"
                                  from="${this.projetCuisine.constrainedProperties.financement.inList}"
                                  required=""
                                  value="${this.projetCuisine?.financement}" />
                    </div>

                    <label id="labelFinancementAutre" class="col-12 col-sm-3 col-lg-2 col-form-label text-sm-right" style="display:none">Précisez:</label>
                    <div id="financementAutre" class="col-12 col-sm-8 col-lg-2" style="display:none">
                      <input class="form-control" type="text" name="financementAutre" value="${this.projetCuisine?.financementAutre}">
                    </div>
                  </div>

                  <div class="form-group row">
                    <label class="col-12 col-sm-3 col-form-label text-sm-right">Quel style souhaitez-vous ?</label>
                    <div class="col-12 col-sm-8 col-lg-2">
                        <g:select class="form-control custom-select" name="style"
                                  from="${this.projetCuisine.constrainedProperties.style.inList}"
                                  required=""
                                  value="${this.projetCuisine?.style}" />
                    </div>
                  </div>


                  <!-- Cuisine -->

                  <div class="form-group row">
                    <label class="col-12 col-sm-3 col-form-label text-sm-right">Faut-il prévoir un coin repas ?</label>
                    <div class="col-12 col-sm-8 col-lg-2 form-check mt-2">
                      <label class="custom-control custom-radio custom-control-inline">
                        <input id="coinRepasRadioOui" class="custom-control-input" type="radio" name="coinRepasRadio"  value="oui"
                            <g:if test="${this.projetCuisine?.coinRepas}">
                                checked=""
                            </g:if>
                               onchange="showCoinRepasOui()">
                        <span class="custom-control-label">Oui</span>
                      </label>
                      <label class="custom-control custom-radio custom-control-inline">
                        <input class="custom-control-input" type="radio" name="coinRepasRadio"
                            <g:if test="${!this.projetCuisine?.coinRepas}">
                                checked=""
                            </g:if>
                               value="non" onchange="hideCoinRepasOui()">
                        <span class="custom-control-label">Non</span>
                      </label>
                    </div>

                    <label id="labelCoinRepasOui" class="col-6 col-sm-3 col-lg-2 col-form-label text-sm-right" style="display:block">Pour combien de personnes ?</label>
                    <div id="coinRepasOui" class="col-12 col-sm-8 col-lg-2" style="display:block">
                      <input class="form-control" type="number" min="1" name="nombrePersonne" value="${this.projetCuisine?.nombrePersonne}">
                    </div>
                  </div>


                  <!-- Equipements -->


                  <h4>Equipements</h4>
                  <hr>

                        <div class="form-group row">
                          <label class="col-12 col-sm-3 col-form-label text-sm-right">Plaque de cuisson</label>
                          <div class="col-12 col-sm-3 col-lg-2">
                              <g:select class="form-control custom-select" name="plaqueCuisson"
                                        from="${this.projetCuisine.constrainedProperties.plaqueCuisson.inList}"
                                        required=""
                                        value="${this.projetCuisine?.plaqueCuisson}" />
                          </div>

                          <label class="col-12 col-sm-3 col-lg-2 col-form-label text-sm-right">Bouteille de gaz</label>
                          <div class="col-12 col-sm-3 col-lg-2">
                              <g:select class="form-control custom-select" name="bouteilleGaz"
                                        from="${this.projetCuisine.constrainedProperties.bouteilleGaz.inList}"
                                        required=""
                                        value="${this.projetCuisine?.bouteilleGaz}" />
                          </div>
                        </div>


                        <div class="form-group row">
                          <label class="col-12 col-sm-3 col-form-label text-sm-right">Evier</label>
                          <div class="col-12 col-sm-3 col-lg-2">
                              <g:select class="form-control custom-select" name="evier"
                                        from="${this.projetCuisine.constrainedProperties.evier.inList}"
                                        required=""
                                        value="${this.projetCuisine?.evier}" />
                          </div>

                          <label class="col-12 col-sm-3 col-lg-2 col-form-label text-sm-right">Réfrigérateur</label>
                          <div class="col-12 col-sm-3 col-lg-2">
                              <g:select class="form-control custom-select" name="frigo"
                                        from="${this.projetCuisine.constrainedProperties.frigo.inList}"
                                        required=""
                                        value="${this.projetCuisine?.frigo}" />
                          </div>
                        </div>


                        <div class="form-group row">
                          <label class="col-12 col-sm-3 col-form-label text-sm-right"></label>
                          <div class="col-12 col-sm-8 col-lg-6 form-check mt-2">
                            <label class="custom-control custom-checkbox custom-control-inline">
                              <input class="custom-control-input" type="checkbox"
                                  <g:if test="${this.projetCuisine?.congelateur == true}">
                                      checked=""
                                  </g:if>
                                     name="congelateur"><span class="custom-control-label" style="width:170px">Congélateur</span>
                            </label>
                            <label class="custom-control custom-checkbox custom-control-inline">
                              <input class="custom-control-input" type="checkbox"
                                  <g:if test="${this.projetCuisine?.four}">
                                      checked=""
                                  </g:if>
                                     name="four"><span class="custom-control-label" style="width:170px">Four</span>
                            </label>
                            <label class="custom-control custom-checkbox custom-control-inline">
                              <input class="custom-control-input" type="checkbox"
                                  <g:if test="${this.projetCuisine?.microondes}">
                                      checked=""
                                  </g:if>
                                     name="microondes"><span class="custom-control-label" style="width:170px">Micro-ondes</span>
                            </label>
                          </div>
                        </div>


                        <div class="form-group row">
                          <label class="col-12 col-sm-3 col-form-label text-sm-right"></label>
                          <div class="col-12 col-sm-8 col-lg-6 form-check mt-2">
                            <label class="custom-control custom-checkbox custom-control-inline">
                              <input class="custom-control-input" type="checkbox"
                                  <g:if test="${this.projetCuisine?.hotte}">
                                      checked=""
                                  </g:if>
                                     name="hotte"><span class="custom-control-label" style="width:170px">Hotte</span>
                            </label>
                            <label class="custom-control custom-checkbox custom-control-inline">
                              <input class="custom-control-input" type="checkbox"
                                  <g:if test="${this.projetCuisine?.laveVaisselle}">
                                      checked=""
                                  </g:if>
                                     name="laveVaisselle"><span class="custom-control-label" style="width:170px">Lave-vaisselle</span>
                            </label>
                            <label class="custom-control custom-checkbox custom-control-inline">
                              <input class="custom-control-input" type="checkbox"
                                  <g:if test="${this.projetCuisine?.laveLinge}">
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
                                                from="${this.projetCuisine.constrainedProperties.facadeLaquee.inList}"
                                                required=""
                                                value="${this.projetCuisine?.facadeLaquee}"
                                                onchange="showFacadeLaqueeCouleur()"/>
                                  </div>
            
                                  <label id="labelFacadeLaqueeCouleur" class="col-6 col-sm-3 col-lg-2 col-form-label text-sm-right">Couleur(s)</label>
                                  <div id="facadeLaqueeCouleur" class="col-12 col-sm-3 col-lg-5">
                                      <input class="form-control" type="text" name="facadeLaqueeCouleur" value="${this.projetCuisine?.facadeLaqueeCouleur}">
                                  </div>
                              </div>
            
                              <div class="form-group row">
                                  <label class="col-12 col-sm-3 col-form-label text-sm-right">Façade bois</label>
                                  <div class="col-12 col-sm-3 col-lg-2">
                                      <g:select id="facadeBois" class="form-control custom-select" name="facadeBois"
                                                from="${this.projetCuisine.constrainedProperties.facadeBois.inList}"
                                                required=""
                                                value="${this.projetCuisine?.facadeBois}"
                                                onchange="showFacadeBoisCouleur()"/>
                                  </div>
            
                                  <label id="labelFacadeBoisCouleur" class="col-6 col-sm-3 col-lg-2 col-form-label text-sm-right">Couleur(s)</label>
                                  <div id="facadeBoisCouleur" class="col-12 col-sm-3 col-lg-5">
                                      <input class="form-control" type="text" name="facadeBoisCouleur" value="${this.projetCuisine?.facadeBoisCouleur}">
                                  </div>
                              </div>

                              <div class="form-group row">

                                <label class="col-12 col-sm-3 col-form-label text-sm-right">Plan de travail</label>
                                <div class="col-12 col-sm-3 col-lg-2">
                                    <g:select id="planTravail" class="form-control custom-select" name="planTravail"
                                              from="${this.projetCuisine.constrainedProperties.planTravail.inList}"
                                              required=""
                                              value="${this.projetCuisine?.planTravail}" />
                                </div>

                                <label class="col-6 col-sm-3 col-lg-2 col-form-label text-sm-right">Couleur(s)</label>
                                <div class="col-12 col-sm-3 col-lg-5">
                                  <input class="form-control" type="text" name="planTravailCouleur" value="${this.projetCuisine?.planTravailCouleur}">
                                </div>
                              </div>

                              <div class="form-group row">
                                <label class="col-12 col-sm-3 col-form-label text-sm-right">Poignées</label>
                                <div class="col-12 col-sm-3 col-lg-2 form-check mt-2">
                                  <label class="custom-control custom-radio custom-control-inline">
                                    <input id="poigneesOui" class="custom-control-input" type="radio" name="poigneesTexteRadio"
                                        <g:if test="${this.projetCuisine?.poignees}">
                                            checked=""
                                        </g:if>
                                           value="oui" checked="" onchange="showPoigneesModele()">
                                    <span class="custom-control-label">Oui</span>
                                  </label>
                                  <label class="custom-control custom-radio custom-control-inline">
                                    <input class="custom-control-input" type="radio" name="poigneesTexteRadio"
                                        <g:if test="${!this.projetCuisine?.poignees}">
                                            checked=""
                                        </g:if>
                                           value="non" onchange="hidePoigneesModele()">
                                    <span class="custom-control-label">Non</span>
                                  </label>
                                </div>

                                <label id="labelPoigneesModele" class="col-6 col-sm-3 col-lg-2 col-form-label text-sm-right" style="display:block">Modèle</label>
                                <div id="poigneesModele" class="col-12 col-sm-3 col-lg-2" style="display:block">
                                    <g:select id="poignees" class="form-control custom-select" name="poigneesModele"  onchange="showPoigneesAutre()"
                                              from="${this.projetCuisine.constrainedProperties.poigneesModele.inList}"
                                              required=""
                                              value="${this.projetCuisine?.poigneesModele}" />


                                </div>

                                  <label id="labelPoigneesAutre" class="col-12 col-sm-3 col-lg-1 col-form-label text-sm-right"
                                      <g:if test="${this.projetCuisine?.poigneesModele.equals("Autre")}">
                                          style="display:block"
                                      </g:if>
                                      <g:else>
                                          style="display:none"
                                      </g:else>
                                  >Précisez:</label>
                                  <div id="poigneesAutre" class="col-12 col-sm-3 col-lg-2"
                                      <g:if test="${this.projetCuisine?.poigneesModele.equals("Autre")}">
                                          style="display:block"
                                      </g:if>
                                      <g:else>
                                          style="display:none"
                                      </g:else>
                                  >
                                      <input class="form-control" type="text" name="poigneesAutre" value="${this.projetCuisine?.poigneesAutre}">
                                  </div>
                              </div>


                              <div class="form-group row">
                                  <label class="col-12 col-sm-3 col-form-label text-sm-right">Option du meuble</label>
                                  <div class="col-12 col-sm-8 col-lg-2">
                                      <g:select id="optionMeuble" class="form-control custom-select" name="optionMeuble"
                                                from="${this.projetCuisine?.constrainedProperties.optionMeuble.inList}"
                                                required=""
                                                value="${this.projetCuisine?.optionMeuble}" />
                                  </div>
                              </div>

                              <g:hiddenField name="client.id" value="${this.projetCuisine?.client.id}" />


                              <g:hiddenField id="optionMeubleAux"  name="optionMeubleAux" value="" />
                              <g:hiddenField id="planTravailAux" name="planTravailAux" value="" />
                              <g:hiddenField id="poigneesModeleAux" name="poigneesModeleAux" value="" />


              </div>
            </div>
          </div>
</div>
