<%@ page import="mccorletagencement.Commentaire" %>


<div class="pl-3 pr-3 pb-0"
     style="height: 280px; max-height: 280px; overflow-y: auto; background-color: #f5f5f5; border: solid lightgray; border-width: 1px 1px 0px 1px;"
     id="commentairesRelance${devis.id}">
</div>

<div class="todo-new-task" style="border: solid lightgray; border-width: 0px 1px 1px 1px;">
    <div class="input-group" style="${controllerName =='questionnaire' ? 'display: none' : ''}">


        <input name="texte" id="texteCommentaireRelance${devis.id}" required="" class="form-control" type="text" value=""
               placeholder="Ecrivez ici votre commentaire" autocomplete="off">

            <a href="#" class="btn btn-success" id="${devis.id}" onclick="saveCommentaireRelance(this.id);return false;" style="font-size: 18px;" >
                Enregistrer
            </a>

    </div>
</div>