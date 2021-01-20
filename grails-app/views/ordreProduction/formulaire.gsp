<%@ page import="org.springframework.security.core.context.SecurityContextHolder; mccorletagencement.Utilisateur; mccorletagencement.ProjetAutre; mccorletagencement.ProjetPlacard; mccorletagencement.ProjetDressing; mccorletagencement.ProjetSalleBain; mccorletagencement.ProjetCuisine" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Formulaire de pose</title>

    <style>

    </style>
</head>

<body>

<g:set var="user" value="${Utilisateur.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName())}"></g:set>


<div class="card card-default m-2">

    <div class="card card-header">
        <div class="row" style="color: rgba(0,0,0,0.7); vertical-align: middle">
            <div class="col-lg-12" style="font-size: 22px;">
                Formulaire de pose - projet No. ${ordre.factureClient.devis.projet.idInsitu}
                <i class="fa fa-circle" style="color: ${ordre.incomplete ? '#fa6163' : '#509834'}"></i>
            </div>
        </div>

        <hr>
    </div>

    <div class="card-body">
            <div class="row justify-content-center">
                <div class="col-lg-12">
                    <object id="docPdf" width="850px" height="980px" style="text-align: center"
                            data="<g:createLink controller="ordreProduction" action="showFormulaire"
                                                params="[id: ordre.id]"/>"
                            trusted="yes" application="yes">
                    </object>
                </div>
            </div>

        </div>


    </div>
</div>


</body>
</html>