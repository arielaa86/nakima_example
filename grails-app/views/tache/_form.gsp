<%@ page import="mccorletagencement.Tache; java.text.SimpleDateFormat; org.springframework.security.core.context.SecurityContextHolder; mccorletagencement.Utilisateur; mccorletagencement.Etiquette" %>


<div class="container">
    <div class="row row-cols-3">
        <div class="col-lg-5">

            <div id="dateTask" class="form-group m-4" lang="fr">

                <label for="datePicker">Date</label>

                <div id="datePicker" class="input-group">

                    <input type="text" name="dateTache" class="form-control" id="date"
                           value="${this.tache?.date ? new SimpleDateFormat("dd MMMM yyyy", Locale.FRANCE).format(this.tache?.date) : new SimpleDateFormat("dd MMMM yyyy", Locale.FRANCE).format(new Date()) }"
                           autocomplete="off">

                    <div id="dateIcon" style="position: relative; top: 11px; right: 30px;">
                        <i class="fa fa-calendar-o"></i>
                    </div>
                </div>

            </div>


            <div class="m-3">
                <label class="custom-control custom-checkbox m-2 mb-4 col-lg-4">
                    <input class="custom-control-input" id="journee" onclick="displayTimerPickers();"
                           name="journee" type="checkbox" ${this.tache?.journee ? 'checked' : ''}>
                    <span class="custom-control-label">Toute la journée</span>
                </label>
            </div>


            <div class="row m-2">

                <div class="col-lg-6">

                    <label for="timePicker">Heure de début</label>

                    <div id="timePicker">
                        <input type="time" name="heureDebutTache" class="form-control" id="heureDebut"
                               aria-describedby="btnGroupHeureDebut"
                               required = ""
                               value="${this.tache?.heureDebut ? new SimpleDateFormat("HH:mm").format(this.tache?.heureDebut) : ''}"
                               autocomplete="off">


                    </div>

                </div>


                <div class="col-lg-6">

                    <label for="timePicker2">Heure de fin</label>

                    <div id="timePicker2">
                        <input type="time" name="heureFinTache" class="form-control" id="heureFin"
                               required = ""
                               aria-describedby="btnGroupHeureFin"
                               value="${this.tache?.heureFin ? new SimpleDateFormat("HH:mm").format(this.tache?.heureFin) : ''}"
                               autocomplete="off">


                    </div>

                </div>

            </div>

            <div class="form-group m-4">

                <label for="description">Description</label>


                <textarea type="text" required="" name="description" class="form-control" id="description" autocomplete="off" rows="10">${this.tache?.description}</textarea>

            </div>

        </div>

        <div class="col-lg-3">

            <div class="m-4">

                <label class="ml-lg-2">Evènement</label>
                <g:each in="${Etiquette.getAll().sort({it.indice})}" var="etiquette">

                    <div class="p-2 bd-highlight">
                        <div class="d-flex flex-row justify-content-start">
                            <div class="mai-radio-icon form-check form-check-inline">
                                <label class="custom-control custom-radio custom-radio-icon custom-control-inline">
                                    <input class="custom-control-input" id="radioIcon${etiquette.getId()}"
                                           onclick="changeStatus(this.id, '${'labelCheck'+etiquette.getId()}', '${etiquette.getCouleur()}')"
                                           type="radio" name="evenement" value="${etiquette.getId()}">

                                    <span class="custom-control-label labelEvenement" id="labelCheck${etiquette.getId()}"></span>

                                </label>
                            </div>

                            <div class="etiquette">
                                ${etiquette.getEvenement()}
                            </div>
                        </div>

                    </div>

                </g:each>

            </div>

        </div>

        <div class="col-lg-4">


            <div class="form-group m-4">
                <label for="visibilite">Visibilité</label>

                <g:select id="visibilite" class="form-control custom-select" name="visibilite"
                          from="${this.tache ? this.tache?.constrainedProperties.visibilite.inList : new mccorletagencement.Tache().constrainedProperties.visibilite.inList}"
                          required="false"
                          value="${this.tache?.visibilite}" onchange="montrerParticipants()"/>

            </div>


            <div id="participants" class="form-group m-4" style="display: none">
                <label>Participants</label>

                <g:set var="username" value="${Utilisateur.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName()).getUsername()}" ></g:set>

                <g:select class="form-control custom-select" name="participants" id="participantsSelect"
                          from="${Utilisateur.findAllByUsernameNotEqualAndUsernameNotEqual("admin", username )}" multiple="true"
                          required=""
                          value="${this.tache?.participants}"
                          optionKey="id"

                />

            </div>




        </div>

    </div>
</div>










