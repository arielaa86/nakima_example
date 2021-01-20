<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="noMenu"/>
    <title>Mot de passe oublié</title>

    <style>
    @media only screen and (max-width: 767px) {
        body {
            margin-top: 0em;
            height: auto;
        }
    }

    @media only screen and (min-width: 767px) {
        body {
            margin-top: 0em;
            height: auto;
        }
    }

    </style>

</head>
<body>

<div class="card card-default m-2">


    <div class="card-body m-6">

        <div class="row justify-content-center" style="color: rgba(0,0,0,0.7); vertical-align: middle">

            <h2>Réinitialiser le mot de passe</h2>

        </div>

        <hr>

        <g:form action="restorePassword" method="POST" onsubmit="submit.disabled = true; return true;">


            <div class="row justify-content-center m-4">
               <div class="form-group col-lg-4">
                   <smal>Renseignez l'adresse email que vous utilisez pour vous connecter. Les instructions pour changer votre mot de passe vous seront envoyées.</smal>
                   <input type="text" class="form-control mt-3" name="email" id="email" autocapitalize="none" value=""/>

               </div>
            </div>

               <div class="row justify-content-center m-4">
                   <div class="col-lg-2 m-4">

                       <button id="submit" class="btn btn-lg btn-success btn-block" type="submit" id="submit">
                           <i class="fa fa-send"></i>
                            Continuer
                       </button>
                   </div>
               </div>

            </g:form>


    </div>
</div>





</body>
</html>
