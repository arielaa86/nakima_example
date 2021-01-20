

<g:set var="reponses" value="${this.questionnaire.reponses.sort{it.id}}"></g:set>


    <g:each in="${reponses.take(8)}" var="reponse" status="i">


        <label class="custom-control custom-checkbox m-3 mb-4">
            <input class="custom-control-input" id="question${i}" name="question${i}" type="checkbox" disabled ${reponse?.selectionne ? 'checked' : '' } data-parsley-multiple="groups" data-parsley-mincheck="2" data-parsley-errors-container="#error-container1">
            <span class="custom-control-label">${reponse.question.texte}</span>
        </label>


    </g:each>


    <label class="custom-control custom-checkbox m-3 mb-4">
        <input class="custom-control-input" id="question8" disabled onclick="showAutreMotif(this.id)" name="question8" type="checkbox" ${reponses.getAt(8)?.selectionne ? 'checked' : '' } data-parsley-multiple="groups" data-parsley-mincheck="2" data-parsley-errors-container="#error-container1">
        <span class="custom-control-label">${reponses.getAt(8).question.texte}</span>
    </label>



    <div class="row">
        <div class="col-lg-10 m-3" id="autreMotiftexte" style="display: none">
            <div class="form-group fadeIn" >
                <label>Merci de préciser le motif :</label>
                <textarea class="form-control" name="texteAutre" disabled rows="3">${reponses.getAt(8)?.texteAutre}</textarea>
            </div>
        </div>
    </div>



