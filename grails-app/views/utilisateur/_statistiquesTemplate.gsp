<%@ page import="mccorletagencement.Role; mccorletagencement.Utilisateur" %>
<div class="row justify-content-center">
    <div class="col-lg-10">

        <table width="100%" cellspacing="0" class="table dataTable table-hover">
            <thead class="bg-primary text-white">
            <tr>
                <th class="noExport noSorting"></th>
                <th class="noSorting">Commercial</th>
                <th class="noSorting center">Devis en attente</th>
                <th class="noSorting center">Devis déclinés</th>
                <th class="noSorting center">Factures impayées</th>
                <th class="noSorting center">Factures en cours</th>
                <th class="noSorting center">Factures acquittées</th>
            </tr>
            </thead>
            <tbody>

            <g:each in="${suiviGeneralCommerciaux.getInfoComerciaux()}" var="suiviDAO">
                <tr style="font-size: 16px">
                    <td></td>
                    <td>${suiviDAO.utilisateur.prenom + " " + suiviDAO.utilisateur.nom}</td>
                    <td class="center">${suiviDAO.devisAttente}</td>
                    <td class="center">${suiviDAO.devisDecline}</td>
                    <td class="center">${suiviDAO.facturesImpayees}</td>
                    <td class="center">${suiviDAO.facturesEnCours}</td>
                    <td class="center">${suiviDAO.facturesAcquitees}</td>
                </tr>
            </g:each>
            <tr style="background-color: #ececed; font-size: 18px;">
                <td></td>
                <td class="font-weight-bolder">TOTAL</td>
                <td class="center font-weight-bolder">${suiviGeneralCommerciaux.getTotalAttente()}</td>

                <td class="center font-weight-bolder">${suiviGeneralCommerciaux.getTotalDecline()}</td>

                <td class="center font-weight-bolder">${suiviGeneralCommerciaux.getTotalFacturesImpayee()}</td>

                <td class="center font-weight-bolder">${suiviGeneralCommerciaux.getTotalFacturesEnCours()}</td>

                <td class="center font-weight-bolder">${suiviGeneralCommerciaux.getTotalFacturesAcquittee()}</td>

            </tr>

            </tbody>
        </table>

    </div>
</div>



<script>


    activeDataTables();

</script>







