<div class="row">
    <div class="col-lg-12">
        <div class="card card-default card-table">

            <div class="card-body">
                <table width="100%" class="table dataTable table-striped table-hover">

                    <thead>
                    <tr>
                        <th class="noExport noSorting"></th>
                        <th>Facture No.</th>
                        <th>Poste de dépenses</th>
                        <th>Date</th>
                        <th>Fournisseur</th>
                        <th>Description</th>
                        <th>Montant</th>
                        <th class="noExport noSorting"></th>
                    </tr>
                    </thead>
                    <tbody>
                    <g:each var="facture" in="${ factures }">
                        <tr>
                            <td></td>
                            <td>
                                ${facture.numero}
                            </td>
                            <td>
                                ${facture.categorie}
                            </td>
                            <td>
                                <g:formatDate format="dd/MM/yyyy" locale="fr" date="${facture.date}"/>
                            </td>
                            <td>
                                ${facture.fournisseur}
                            </td>
                            <td>
                                ${facture.description}
                            </td>
                            <td>
                                ${new java.text.DecimalFormat("###,###.00 €").format(facture.montant).replaceAll(",", " ")}
                            </td>
                            <td>
                                <g:form controller="factureFournisseur" action="delete" method="DELETE">

                                    <g:hiddenField name="id" value="${facture.id}" />
                                    <g:link class="mr-4" target="_blank" controller="factureFournisseur"
                                            action="showDocument" id="${facture.id}">
                                        <i class="fa fa-search" style="color: grey"></i>
                                    </g:link>


                                    <button type="submit" class="mr-4" controller="factureFournisseur"
                                            style="border:none; background-color: transparent; outline:none; font-size: 16px; color: #ff7474 "
                                            onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');">
                                        <i class="fa fa-trash"></i>
                                    </button>
                                </g:form>
                            </td>

                        </tr>

                    </g:each>

                    </tbody>

                </table>
            </div>
        </div>
    </div>
</div>
