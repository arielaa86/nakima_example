<%@ page import="mccorletagencement.UtilisateurRole; mccorletagencement.Role" %>

<div class="row justify-content-center mb-4">
    <div class="col-lg-6 m-4">

        <div class="form-group">
            <g:if test="${actionName != 'changerPassword'}">
                <label for="username">Nouvel identifiant</label>
                <input type="text" placeholder="Identifiant" class="form-control"
                       name="username" id="username" autocapitalize="none" value="${this.utilisateur?.username}" />
            </g:if>
            <g:else>

                <label for="username">Identifiant: </label> ${this.utilisateur?.username}
                <g:hiddenField name="username" type="text" value="${this.utilisateur?.username}" />
            </g:else>
        </div>

        <div class="form-group">
            <label for="password">Nouveau mot de passe</label>
            <input type="password" placeholder="Your password" class="form-control" name="password" id="password"
                   value=""/>
        </div>

        <div class="form-group">
            <label for="password">Confirmer mot de passe</label>
            <input type="password" placeholder="Confirmer mot de passe" class="form-control" name="repassword"
                   id="repassword"/>
        </div>
    </div>
</div>
