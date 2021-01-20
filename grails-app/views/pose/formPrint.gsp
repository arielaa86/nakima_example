<%@ page import="java.text.SimpleDateFormat; mccorletagencement.Etape; mccorletagencement.ProjetComplementaire; mccorletagencement.Role; org.springframework.security.core.context.SecurityContextHolder; mccorletagencement.Utilisateur; mccorletagencement.ProjetAutre; mccorletagencement.ProjetPlacard; mccorletagencement.ProjetDressing; mccorletagencement.ProjetSalleBain; mccorletagencement.ProjetCuisine" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="noMenu"/>

    <title>Imprimer formulaire de pose</title>


    <style>

        hr{
            background: gray!important;
        }

    .item {
        font-size: 16px;
    }

    .item span {
        font-weight: bold;
    }


    .line{
       border-bottom: solid 1px gray;
        margin-bottom: 10px;
        margin-top: 30px;

    }

    @page {
        margin: 1cm
    }


    @media print {

        .card-table {
            top: 0px !important;
        }

        .btn{
            display: none;
        }

    }

    .card-table {
        top: -154px;
    }

    @media only screen and (max-width: 770px) {
        .card-table {
            top: -90px;
        }

    }


    </style>

</head>

<body>

<div class="card card-default card-table m-2">

    <div class="card-body" id="cardBody">

        <g:render template="formPose" model="[ordre: ordre, user:user]"/>

    </div>

</div>

</body>
</html>
