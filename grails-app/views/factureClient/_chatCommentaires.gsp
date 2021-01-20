<%@ page import="mccorletagencement.Commentaire" %>


<div class="pl-3 pr-3 pb-0"
     style="height: 280px; max-height: 280px; overflow-y: auto; background-color: #f5f5f5" id="commentaires">

    <g:render template="showCommentaires" model="[commentaires: commentaires]" />

</div>

<div class="todo-new-task">
    <div class="input-group">


        <input name="texte" required="" class="form-control" type="text" value=""
               placeholder="Ecrivez ici votre message" autocomplete="off" disabled />

            <a href="" class="btn" onclick="return false;" style="font-size: 18px; background-color: #e5e5e5; color: #ffffff" >
                <i class="icon s7-share" style="font-size: 28px!important;"></i> Envoyer
            </a>

    </div>
</div>