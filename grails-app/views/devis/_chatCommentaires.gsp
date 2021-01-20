<%@ page import="mccorletagencement.Commentaire" %>


<div class="pl-3 pr-3 pb-0"
     style="height: 280px; max-height: 280px; overflow-y: auto; background-color: #f5f5f5" id="commentaires">

</div>

<div class="todo-new-task">
    <div class="input-group">


        <input name="texte" required="" class="form-control" type="text" value=""
               placeholder="Ecrivez ici votre message" autocomplete="off" ${controllerName.equals("factureClient") ? 'disabled' : '' }>

            <a href="#" class="btn" onclick="saveCommentaire();return false;" style="font-size: 18px; background-color: #1a9fdd; color: white" >
                <i class="icon s7-share" style="font-size: 28px!important;"></i> Envoyer
            </a>

    </div>
</div>