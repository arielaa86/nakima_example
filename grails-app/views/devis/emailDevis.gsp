<%@ page import="mccorletagencement.Role; org.springframework.security.core.context.SecurityContextHolder; mccorletagencement.Utilisateur" %>
<!DOCTYPE html>
<html>
<head>

    <style>

    .btn {

        display: inline-block;
        font-weight: 400;
        color: #545454;
        text-align: center;
        vertical-align: middle;
        user-select: none;
        background-color: #ba3f45;
        border: 1px solid transparent;
        padding: 0.81rem 0.7692rem;
        font-size: 1rem;
        line-height: 1;
        border-radius: 0;
        transition: color 0.15s ease-in-out, background-color 0.15s ease-in-out, border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
    }

    .row a {
        color: white !important;
        text-decoration: none;
        font-weight: bold;
    }

    hr {

        border-bottom: thin lightgray !important;

    }

    .row {
        text-align: center;
        width: 100%;
        margin-top: 2em;
    }

    .big {
        font-size: 20px;
        font-weight: bold;
    }



    </style>
</head>

<body>

<div class="row m-4 justify-content-center">


    <img src="cid:springsourceInlineImage" style="width: 40%"/>


    <p class="mt-4 ml-5" style="font-size: 16px">
        Zac de Peters Maillet 97270 SAINT-ESPRIT <br>
        Téléphone 0596 70 41 31  - Télécopie 0596 56 69 97<br>
        SIRET : 818 034 829 00015 – APE 3102Z<br>
    </p>
</div>

<div class="row big">
    Bonjour, vous avez sollicité MCCorlet Agencement pour un devis.
    <br>
    <br>
    Pour le consulter, veuillez cliquer sur le bouton ci-dessous
</div>
<hr>

<div class="row">

    <g:if env="development">

            <a href="http://localhost:8080/devis/showDevis?codeEmail=${devis.codeEmail}" class="btn">Consulter le devis</a>

    </g:if>
    <g:else>

            <a href="https://mccorlet.com/devis/showDevis/showDevis?codeEmail=${devis.codeEmail}" class="btn">Consulter le devis</a>

    </g:else>

</div>
<br>
<br>

Merci de ne pas répondre à cette adresse email.<br>
Pour toute question, nous vous invitons à contacter le commercial en charge de votre projet aux coordonnées suivantes:
<br>
<br>
Commercial: ${ devis.projet.concepteur }
<br>
Email. ${ devis.projet.concepteur.email }
<br>
Téléphone: ${devis.projet.concepteur.telephone}
<br>
<br>
Nous vous remercions de votre confiance.

</body>
</html>