<g:select class="form-control custom-select" name="fournisseur" id="fournisseur" onclick="getSelectItem()"
          from="${listeFournisseurs}"
          required=""
          optionKey="id"
          optionValue="${{it.nom}}"
          multiple=""/>