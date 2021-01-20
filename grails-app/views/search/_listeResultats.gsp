<table class="table" >
    <thead>

    </thead>
    <tbody>

    <g:each in="${resultats}" var="result">
        <tr>
            <td>
                <g:link controller="${result.controller}" action="${result.action}" id="${result.id}">
                    ${result.detail}
                </g:link>
            </td>
            <td>${result.description}</td>

            <td>${result.client}</td>
        </tr>
    </g:each>

    </tbody>
</table>