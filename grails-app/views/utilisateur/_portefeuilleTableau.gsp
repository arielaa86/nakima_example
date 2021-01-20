<%@ page import="java.text.DecimalFormat" %>
<table width="100%" class="table dataTable table-hover table-bordered table-striped">
    <thead>
    <tr>
        <th class="noExport"></th>
        <th>No. dossier</th>
        <th>Client</th>
        <th>Projet</th>
        <th>Date de création</th>
        <th>Montant</th>
        <th>Etat</th>
        <g:if test="${transfert}">
            <th class="noExport noSorting" style="text-align: center">Transférer</th>
        </g:if>

    </tr>
    </thead>
    <tbody>
    <g:each var="projet" in="${this.projetListe}">

        <tr>
            <td></td>
            <td>
                <g:if test="${projet.devis == true}">
                    <g:link controller="devis" action="show" id="${projet.devisId}"> ${projet.idInsitu}</g:link>
                </g:if>
                <g:if test="${projet.devis == false}">
                    <g:link controller="projet" action="show" id="${projet.id}"> ${projet.idInsitu}</g:link>
                </g:if>
            </td>
            <td>
                ${projet.client}
            </td>
            <td>
                ${projet.typeProjet}
            </td>
            <td>
                <g:formatDate format="dd MMMM yyyy" date="${projet.date}"/>
            </td>

            <td>
                ${projet.montant != '' ? new DecimalFormat("###,###.00 €").format(projet.montant).replaceAll(",", " ") : ''}
            </td>
            <td>
                ${projet.etat}
            </td>


            <g:if test="${transfert}">
                <td style="text-align: center; font-size: 16px">
                    <i class="fa fa-refresh" data-toggle="modal" data-target="#transfertModal" onclick="setProjetId(${projet.id})"></i>
                </td>
            </g:if>

        </tr>

    </g:each>
    </tbody>
</table>
