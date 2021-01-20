<!DOCTYPE html>
<html>
    <head>

        <style>

            .btn{

                display: inline-block;
                font-weight: 400;
                color: #545454;
                text-align: center;
                vertical-align: middle;
                user-select: none;
                min-width:200px;
                background-color: #ba3f45;
                border: 1px solid transparent;
                padding: 0.81rem 0.7692rem;
                font-size: 1rem;
                line-height: 1;
                border-radius: 0;
                transition: color 0.15s ease-in-out, background-color 0.15s ease-in-out, border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
            }

            a{
                color: white!important;
                text-decoration: none;
                font-weight: bold;
            }

            hr{

                border-bottom: thin lightgray!important;

            }

            .row{
                text-align: center;
                width: 100%;
                margin-top: 2em;
            }

            .big{
                font-size: 20px;
                font-weight: bold;
            }

        </style>
    </head>
    <body>
                <div class="row big">
                   Pour changer votre mot de passe, veuillez cliquer sur le bouton ci-dessous.
                </div>
                 <hr>

                <div class="row">

                    <g:if env="development">

                        <a href="http://localhost:8080/utilisateur/changerPassword?code=${code}" class="btn" >Changer mot de passe</a>

                    </g:if>
                    <g:else>

                        <a href="https://mccorlet.com/utilisateur/changerPassword?code=${code}" class="btn" >Changer mot de passe</a>

                    </g:else>

                </div>

    </body>
</html>