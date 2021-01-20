<%@ page import="org.springframework.security.core.context.SecurityContextHolder; mccorletagencement.Utilisateur; mccorletagencement.ProjetAutre; mccorletagencement.ProjetPlacard; mccorletagencement.ProjetDressing; mccorletagencement.ProjetSalleBain; mccorletagencement.ProjetCuisine" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title><g:message code="default.list.label" args="['des ordres']"/></title>

    <style>

    .nav-tabs-primary + .tab-content {
        background-color: white;
        color: inherit;
        border: solid #eaeaea 1px;
        margin-top: -1px;
    }

    .nav-tabs-primary .nav-link.active {

        border-top-left-radius: 3px;
        border-top-right-radius: 3px;
        background-color: white;
        color: inherit;
        border: solid #eaeaea 1px;
        border-bottom: solid white 1px;
    }



    </style>
</head>

<body>

<g:set var="user" value="${Utilisateur.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName())}"></g:set>


<div class="card card-default m-2 table-responsive">

    <div class="card card-header" style="min-width: 680px">
        <div class="row" style="color: rgba(0,0,0,0.7); vertical-align: middle">
            <div class="col-lg-12" style="font-size: 22px;">
                <i class="fa fa-tasks"></i> Suivi des ordres de production
            </div>
        </div>

        <hr>
    </div>


    <div class="card-body" style="min-width: 680px">

        <div class="col-lg-12">
            <div class="tab-container mb-5">
                <ul class="nav nav-tabs nav-tabs-primary" role="tablist">
                    <li class="nav-item"><a class="nav-link active" href="#nouveau" data-toggle="tab" role="tab"
                                            aria-selected="true">Nouveaux</a></li>

                    <li class="nav-item"><a class="nav-link" href="#ordresEnCours" data-toggle="tab" role="tab"
                                            aria-selected="false">En cours</a></li>

                    <li class="nav-item"><a class="nav-link" href="#ordresPretsVerif" data-toggle="tab" role="tab"
                                            aria-selected="false">Prêt pour vérification</a></li>

                    <li class="nav-item"><a class="nav-link" href="#ordresPretsLivraison" data-toggle="tab" role="tab"
                                            aria-selected="false">Prêt pour livraison</a></li>

                    <li class="nav-item"><a class="nav-link" href="#ordresLivre" data-toggle="tab" role="tab"
                                            aria-selected="false">Livrés</a></li>
                </ul>

                <div id="tab-content" class="tab-content">

                    <div class="tab-pane active" id="nouveau" role="tabpanel">
                        <g:render template="tableauOrdres" model="[ordres: ordres]"/>
                    </div>

                    <div class="tab-pane" id="ordresEnCours" role="tabpanel">
                        <g:render template="tableauOrdres" model="[ordres:ordresEnCours]"/>
                    </div>

                    <div class="tab-pane" id="ordresPretsVerif" role="tabpanel">
                        <g:render template="tableauOrdres" model="[ordres:ordresPretsVerification]"/>
                    </div>

                    <div class="tab-pane" id="ordresPretsLivraison" role="tabpanel">
                        <g:render template="tableauOrdresPretLivraison" model="[ordres:ordresPretsLivraison]"/>
                    </div>

                    <div class="tab-pane" id="ordresLivre" role="tabpanel">
                        <g:render template="tableauOrdresLivres" model="[ordres:ordresLivre]"/>
                    </div>

                </div>
            </div>
        </div>

    </div>
</div>

<asset:javascript src="factureClient/lancerProduction.js" />

</body>
</html>