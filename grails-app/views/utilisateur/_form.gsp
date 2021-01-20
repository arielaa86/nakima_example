<%@ page import="mccorletagencement.UtilisateurRole; mccorletagencement.Role" %>

<div class="row justify-content-center mb-4">
    <div class="col-lg-6 m-4">

      <div class="form-group">
          <label for="prenom">Prénom</label>
          <input type="text" placeholder="Prénom" class="form-control" name="prenom" id="prenom" autocapitalize="none" value="${this.utilisateur?.prenom}"/>
      </div>


      <div class="form-group">
          <label for="nom">Nom</label>
          <input type="text" placeholder="Nom" class="form-control" name="nom" id="nom" autocapitalize="none" value="${this.utilisateur?.nom}"/>
      </div>

      <div class="form-group">
          <label for="telephone">Téléphone</label>
          <input type="text" placeholder="Téléphone" class="form-control" name="telephone" id="telephone" autocapitalize="none" value="${this.utilisateur?.telephone}"/>
      </div>

      <div class="form-group">
          <label for="email">e-mail</label>
          <input type="text" placeholder="e-mail" class="form-control" name="email" id="email" autocapitalize="none" value="${this.utilisateur?.email}"/>
      </div>



        <div class="form-group">
          <label for="role.id">Role</label>
            <g:select class="form-control custom-select" name="role.id" noSelection="['':'---']" required="true"
                      onchange="showSignaturePad()"
                      from="${Role.list()}"
                      optionKey="id"
                      value="${roleId}"
            />
        </div>


        <div class="form-group">
            <label for="username">Identifiant</label>
            <input type="text" placeholder="Identifiant" class="form-control" name="username" id="username" autocapitalize="none" value="${this.utilisateur?.username}"/>
        </div>

        <div class="form-group">
            <label for="password">Mot de passe</label>
            <input type="password" placeholder="Your password" class="form-control" name="password" id="password" value="${this.utilisateur?.password}"/>
        </div>

        <div class="form-group">
            <label for="password">Confirmer mot de passe</label>
            <input type="password" placeholder="Confirmer mot de passe" class="form-control" name="repassword" id="repassword" />
        </div>
    </div>
</div>

<div id="signature-row" class="row justify-content-center m-3" >

    <div id="signature-pad" class="signature-pad col-lg-5 m-lg-2 col-md-12 mb-2"  style="display: inline-block">
        <div id="signature-pad--body" class="signature-pad--body">
            <canvas> </canvas>
        </div>
        <div class="signature-pad--footer">
            <div class="description">Signature</div>

            <div class="signature-pad--actions" style="margin: 10px">
                <div>
                    <button type="button" class="btn btn-outline-secondary" data-action="clear">Effacer</button>

                </div>
                <div>
                    <button type="button" class="btn btn-outline-primary" data-action="save-png">Valider</button>

                </div>
            </div>
        </div>
    </div>

</div>

<g:textArea style="visibility: hidden" id="sig-dataUrl" name="signatureValue" value="" />