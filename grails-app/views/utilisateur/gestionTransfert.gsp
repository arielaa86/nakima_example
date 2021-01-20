<%@ page import="java.text.DecimalFormat" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Portefeullie</title>

</head>

<body>

<div class="card card-default m-2">

    <div class="card-body">

        <div class="row justify-content-center">
            <g:each in="${commerciaux}" var="commercial">
                <div class="col-lg-3 item" id="${commercial.id}" onclick="portefeuillePersonnel(this.id, '${commercial.nom}','${commerciaux}')">
                    <div class="usage" style="background-color: #95d697;">
                        <div class="usage-resume" style="cursor: pointer">
                            <div class="usage-data">
                                <span class="usage-counter" style="font-size: 26px">
                                    ${commercial.nom}
                                </span>
                            </div>

                            <div class="usage-icon">
                                <i class="fa-3x fa fa-folder-open-o"></i>
                            </div>

                        </div>
                    </div>

                </div>
            </g:each>
        </div>


        <div class="row">

            <div class="col-lg-12" id="portefeuille">

            </div>

        </div>

        <!-- Modal -->
        <div class="modal fade" id="transfertModal" tabindex="-1" aria-labelledby="exampleModalLabel"
             aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Transférer projet</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>

                    <div class="modal-body">

                        <label>Concepteur:</label>
                        <label id="commercialNom"></label>

                        <br>
                        <br>


                        <label>Transférer à:</label>
                        <select class="form-control custom-select" name="commercialId" id="commercialId">

                        </select>

                        <g:hiddenField name="projetId" id="projetId" value="" />
                        <g:hiddenField name="commercialOrigineId" id="commercialOrigineId" value="" />

                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Annuler</button>
                        <button type="button" class="btn btn-success" id="transferer">Transférer</button>
                    </div>
                </div>
            </div>
        </div>

    </div>

</div>



<asset:javascript src="utilisateur/actions.js"/>

</body>
</html>
