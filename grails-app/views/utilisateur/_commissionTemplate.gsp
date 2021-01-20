<div class="row justify-content-center">
    <div class="col-lg-10 table-responsive-md" style="margin-bottom: 50px">

        <table class="table table-hover" style="min-width: 850px">
            <thead class="bg-primary text-white">
            <tr>
                <th class="noExport noSorting"></th>
                <th class="noSorting center">Projet</th>
                <th class="noSorting ">Client</th>
                <th class="noSorting center">Base de calcul</th>
                <th class="noSorting center">Commission</th>
            </tr>
            </thead>
            <tbody>

            <g:each in="${suiviCommercialDAO.getDevisListe()}" var="devis" status="i">
                <tr style="font-size: 16px">
                    <td></td>
                    <td class="center">${devis.projet.idInsitu}</td>
                    <td class="">${devis.projet.client}</td>
                    <td class="center">${new java.text.DecimalFormat("###,###.00 €").format(devis.obtenirBaseCalcul()).replaceAll(",", " ")}</td>
                    <td class="center">${new java.text.DecimalFormat("###,###.00 €").format(devis.obtenirCommission() ).replaceAll(",", " ")}</td>
                 </tr>
            </g:each>
            <tr style="background-color: #ececed; font-size: 18px;">
                <td></td>
                 <td></td>
                <td class="font-weight-bold  center">TOTAL</td>
                <td class="center font-weight-bold">
                    ${suiviCommercialDAO.getTotalBaseCalcul() > 0 ? new java.text.DecimalFormat("###,###.00 €").format(suiviCommercialDAO.getTotalBaseCalcul()).replaceAll(",", " ") : "0.00 €"}
                </td>
                <td class="center font-weight-bold">${suiviCommercialDAO.getCommission() > 0 ? new java.text.DecimalFormat("###,###.00 €").format(suiviCommercialDAO.getCommission()).replaceAll(",", " ") : "0.00 €"}</td>

            </tr>

            </tbody>
        </table>

    </div>
</div>







