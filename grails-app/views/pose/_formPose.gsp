<%@ page import="mccorletagencement.Role" %>
<div class="row m-4 justify-content-center">

    <div class="col-lg-4 col-md-4 col-sm-4" style="border: solid 1px gray; text-align: center">

        <p style="font-size: 16px; font-weight: bold">Poseur indépendant</p>

    </div>

    <div class="col-lg-6 col-md-6 col-sm-6">
        <asset:image src="img/logomccorlet.jpg" style="width: 100%"/>
    </div>

</div>

<div class="row m-4 justify-content-center">

    <div class="col-lg-12 mb-0 mr-4 ml-4 mt-6" style="text-align: center; border-bottom: solid 1px gray">
        <h2 class="font-weight-bold">Formulaire de Pose</h2>
    </div>

</div>

<div class="row m-4 justify-content-center">
    <div class="col-lg-10 mb-0 mt-0 ml-6 mr-6" style="text-align: center; border: solid 1px gray">
        <h2 class="font-weight-bold mt-2">Informations Client</h2>
    </div>
</div>


<div class="row justify-content-center">
    <div class="col-lg-10 mt-0 mb-4 mr-6 ml-6">
        <table class="no-border no-strip skills">
            <tbody class="no-border-x no-border-y">
            <tr>

                <td class="item"><span>Au nom de:</span>

                    <g:if test="${ordre.anonyme && user.authorities.contains(Role.findByAuthority("ROLE_TECHNICIEN"))}">
                       
                    </g:if>
                    <g:else>
                        ${ordre.factureClient?.devis.projet.client}
                    </g:else>
                </td>

            </tr>
            <tr>
                <td class="item">
                    <span>Téléphone:</span>

                    <g:if test="${ordre.anonyme && user.authorities.contains(Role.findByAuthority("ROLE_TECHNICIEN"))}">

                    </g:if>
                    <g:else>
                        ${ordre.factureClient?.devis.projet.client.telephone + (ordre.factureClient?.devis.projet.client.telephoneFixe != null ? " / " + ordre.factureClient?.devis.projet.client.telephoneFixe : "")}
                    </g:else>

                </td>
            </tr>

            <tr>
                <td class="item"><span>Adresse de livraison:</span>


                    <g:if test="${ordre.anonyme && user.authorities.contains(Role.findByAuthority("ROLE_TECHNICIEN"))}">

                    </g:if>
                    <g:else>
                        ${ordre.factureClient?.devis.getProjet().client.adresse + "  " + ordre.factureClient?.devis.getProjet().client.codePostal + " " + ordre.factureClient?.devis.getProjet().client.ville}
                    </g:else>
                </td>
            </tr>

            </tbody>
        </table>
    </div>

</div>


<div class="row m-4 justify-content-center">
    <div class="col-lg-10 mt-4 mr-6 ml-6 mb-4" style="text-align: center; border: solid 1px gray">
        <h2 class="font-weight-bold mt-2">Informations Pose</h2>
    </div>


    <div class="item col-lg-3 col-md-3 col-sm-3"><span>Type de projet:</span> ${ordre.factureClient.devis.projet.getType()}
    </div>

    <div class="item col-lg-3 col-md-3 col-sm-3"><span>Plan de travail:</span> ${ordre.factureClient.devis.projet.getPlanDeTravail()}
    </div>

    <div class="item col-lg-3 col-md-3 col-sm-3 "><span>Date de livraison:</span>
        <g:if test="${ordre.livraison}">
            <g:formatDate date="${ordre.livraison}" format="dd MMMM yyyy" locale="fr"/>
        </g:if><g:else>
            Non renseignée
        </g:else>
    </div>

</div>


<div class="row ml-4 mb-0 mr-4 mt-6 justify-content-center">
    <div class="col-lg-10 ml-6 mr-6 mt-4" style="text-align: center; border: solid 1px gray">
        <h2 class="font-weight-bold mt-2">Remarques</h2>
    </div>

</div>

<div class="row m-4 justify-content-center">
    <div class="col-lg-10 col-md-10 col-sm-10 line"></div>

    <div class="col-lg-10 col-md-10 col-sm-10 line"></div>

    <div class="col-lg-10 col-md-10 col-sm-10 line"></div>

    <div class="col-lg-10 col-md-10 col-sm-10 line"></div>

    <div class="col-lg-10 col-md-10 col-sm-10 line"></div>

</div>


<div class="row m-4 justify-content-center">
    <div class="col-lg-10 mt-0 mr-6 ml-6 mb-4 mt-6" style="text-align: center; border: solid 1px gray">
        <h2 class="font-weight-bold mt-2">Satisfaction Client</h2>
    </div>

</div>

<div class="d-flex justify-content-between" style="margin: 0em 10em 2em 10em">

    <div class="">
        <i class="fa fa-frown-o fa-3x"></i>
    </div>

    <div class="">
        <i class="fa fa-meh-o fa-3x"></i>
    </div>


    <div class="">
        <i class="fa fa-smile-o fa-3x"></i>
    </div>

</div>


<div class="row m-4 justify-content-center">
    <div class="col-lg-10 mt-0 mr-6 ml-6 mb-4 mt-6" style="text-align: center; font-size: 18px">
        <table border="1" width="100%">
            <thead>
            <tr>
                <th scope="col">Signature Client</th>
                <th scope="col">Signature Poseur</th>
            </tr>
            </thead>
            <tbody>
            <tr style="height: 150px!important;">
                <td></td>
                <td></td>
            </tr>

            </tbody>
        </table>
    </div>

</div>

<div class="row m-4 justify-content-end">
    <button class="btn btn-space btn-outline-secondary" type="button" onclick="window.print()" style="min-width: 150px">
        <i class="fa fa-print"></i> Imprimer
    </button>
</div>
