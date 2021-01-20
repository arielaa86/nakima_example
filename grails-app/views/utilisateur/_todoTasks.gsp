<g:each in="${activites}" var="activite">
    <li class="todo-task">
        <label class="custom-control custom-checkbox">
            <input class="custom-control-input" type="checkbox" onclick="barreActivite('${activite.id}')" ${activite.active ? '' : 'checked'}>
            <span class="custom-control-label">${activite.description}</span>
        </label>
        <a id="${activite.id}" class="close" href="#" onclick="effacerActivite(this.id, 'Etes-vous sûr de vouloir supprimer ?');"><span class="icon s7-close"></span></a>
    </li>
</g:each>
