<%@ page import="java.text.DecimalFormat" %>
<div class="row justify-content-center">
    <div class="col-lg-10 table-responsive-md" style="margin-bottom: 50px">

        <h4 class="mt-3">Poses prévisionnelles</h4>

        <table class="table table-hover" style="min-width: 850px">
            <thead class="bg-primary text-white">
            <tr>
                <th class="noExport noSorting"></th>
                <th class="noSorting center">Date</th>
                <th class="noSorting center">Projet</th>
                <th class="noSorting center">Type</th>
                <th class="noSorting ">Client</th>
                <th class="noSorting center">Montant</th>
                <th class="noSorting center">Supplément</th>
                <th class="noSorting center">Total</th>
            </tr>
            </thead>
            <tbody>

            <g:each in="${previsionnelles.sort{it.date}}" var="ordre" status="i">
                <tr style="font-size: 16px">
                    <td></td>
                    <td class="center"><g:formatDate format="EEEE dd" locale="fr" date="${ordre.date}"/></td>
                    <td class="">${ordre.idInsitu}</td>
                    <td class="">${ordre.typeProjet}</td>
                    <td class="">${ordre.client}</td>
                    <td class="center">${ordre.montant > 0 ? new DecimalFormat("###,###.00 €").format(ordre.montant).replaceAll(",", " ") : "0.00 €"}</td>
                    <td class="center">
                        ${ordre.supplement > 0 ? new DecimalFormat("###,###.00 €").format(ordre.supplement).replaceAll(",", " ") : "0.00 €"}
                        <i class="fa fa-edit ml-3" id="${ordre.idDevis}" data-toggle="modal" data-target="#poseSupplementModal" onclick="getDevisId(this.id)"></i>
                    </td>
                    <td class="center">${ordre.total > 0 ? new DecimalFormat("###,###.00 €").format(ordre.total).replaceAll(",", " ") : "0.00 €"}</td>
                </tr>
            </g:each>

            </tbody>
        </table>



        <h4 class="mt-6">Poses réalisées</h4>

        <table class="table table-hover" style="min-width: 850px">
            <thead class="bg-primary text-white">
            <tr>
                <th class="noExport noSorting"></th>
                <th class="noSorting center">Date</th>
                <th class="noSorting center">Projet</th>
                <th class="noSorting center">Type</th>
                <th class="noSorting ">Client</th>
                <th class="noSorting center">Montant</th>
                <th class="noSorting center">Supplément</th>
                <th class="noSorting center">Total</th>
            </tr>
            </thead>
            <tbody>

            <g:each in="${realisees.sort{it.date}}" var="ordre" status="i">
                <tr style="font-size: 16px">
                    <td></td>
                    <td class="center"><g:formatDate format="EEEE dd" locale="fr" date="${ordre.date}"/></td>
                    <td class="">${ordre.idInsitu}</td>
                    <td class="">${ordre.typeProjet}</td>
                    <td class="">${ordre.client}</td>
                    <td class="center">${ordre.montant > 0 ? new DecimalFormat("###,###.00 €").format(ordre.montant).replaceAll(",", " ") : "0.00 €"}</td>
                    <td class="center">
                        ${ordre.supplement > 0 ? new DecimalFormat("###,###.00 €").format(ordre.supplement).replaceAll(",", " ") : "0.00 €"}
                        <i class="fa fa-edit ml-3" id="${ordre.idDevis}" data-toggle="modal" data-target="#poseSupplementModal" onclick="getDevisId(this.id)"></i>
                    </td>
                    <td class="center">${ordre.total > 0 ? new DecimalFormat("###,###.00 €").format(ordre.total).replaceAll(",", " ") : "0.00 €"}</td>
                </tr>
            </g:each>
            <tr style="background-color: #ececed; font-size: 18px;">
                <td></td>
                <td colspan="4"></td>
                <td class="font-weight-bold  center">TOTAL</td>
                <td class="center font-weight-bold">
                    ${totalSupplement > 0 ? new DecimalFormat("###,###.00 €").format(totalSupplement).replaceAll(",", " ") : "0.00 €"}
                </td>
                <td class="center font-weight-bold">
                    ${totalPaiements > 0 ? new DecimalFormat("###,###.00 €").format(totalPaiements).replaceAll(",", " ") : "0.00 €"}
                </td>
            </tr>

            </tbody>
        </table>

    </div>
</div>











