
<table width="100%" cellspacing="0" class="table dataTableRapport table-hover table-bordered">

    <thead>
    <tr>
        <th class="noExport"></th>
        <th>Date</th>
        <th>No. Dossier</th>
        <th>Client</th>
        <th>Montant</th>
        <th>Moyen de paiement</th>
    </tr>
    </thead>
    <tbody>

    <g:each in="${listeEncaissements}" var="encaissement">

        <tr>
            <td>

            </td>
            <td>
                <g:formatDate date="${encaissement?.date}" format="dd/MM/yyyy" locale="fr"/>
            </td>
            <td>
                ${encaissement.facture.devis.projet.idInsitu}
            </td>
            <td>
                ${encaissement.facture.devis.projet.client}
            </td>

            <td>
                ${encaissement.montant > 0 ? new java.text.DecimalFormat("###,###.00 €").format(encaissement.montant).replaceAll(",", " ") : "0.00 €"}
            </td>
            <td>
                ${encaissement.moyen}
            </td>

        </tr>

    </g:each>

    </tbody>
</table>
