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

    a {
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

<div class="row big">
    Pour signer la facture, cliquez sur le bouton ci-dessous
</div>
<hr>

<div class="row">

    <g:set var="user" value="${Utilisateur.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName())}"></g:set>




    <g:if env="development">

        <g:if test="${user.authorities.contains(Role.findByAuthority("ROLE_DIRECTEUR"))}">

            <a href="http://localhost:8080/factureClient/signaturePadDirecteur/${factureClient.id}" class="btn">Signer</a>

        </g:if>
        <g:else>

            <a href="http://localhost:8080/factureClient/signaturePad/${factureClient.id}" class="btn">Signer</a>

        </g:else>



    </g:if>
    <g:else>


        <g:if test="${user.authorities.contains(Role.findByAuthority("ROLE_DIRECTEUR"))}">

            <a href="https://mccorlet.com/factureClient/signaturePadDirecteur/${factureClient.id}" class="btn">Signer</a>

        </g:if>
        <g:else>

            <a href="https://mccorlet.com/factureClient/signaturePad/${factureClient.id}" class="btn">Signer</a>

        </g:else>



    </g:else>

</div>

</body>
</html>