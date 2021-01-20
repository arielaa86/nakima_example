<html>
<head>
    <meta name="layout" content="${gspLayout ?: 'main'}"/>
    <title>Authentification - accéder à mon compte</title>

    <style>

        .navbar{

            display: none;

        }

        .fa-eye, .fa-eye-slash{

            font-size: 18px;
            margin-top: 12px;

        }


        .splash-container .user-message {
            padding: 215px 30px 40px!important;
        }



        @media only screen and (min-width: 767px) {
            body {
                margin-top: 0px!important;
            }
        }

        @media only screen and (max-width: 767px) {
            body {
                margin-top: 0px!important;
            }
        }



    </style>

</head>

<body>


<div class="mai-wrapper mai-login">
    <div class="main-content container">
        <div class="splash-container row">
            <div class="col-md-6 user-message">
                <span class="splash-message text-right">
                    Bonjour! <br>
                    C'est bon de te revoir</span>
            </div>
            <div class="col-md-6 form-message">
                <asset:image class="logo-img mb-4" src="img/logo.png" alt="logo" width="246" height="36" />

                <span class="splash-description text-center mt-5 mb-5">Accéder à votre compte</span>
                <g:if test='${flash.message}'>

                    <div class="alert alert-theme alert-danger alert-dismissible" role="alert">
                        <button class="close" type="button" data-dismiss="alert" aria-label="Close"><span class="s7-close" aria-hidden="true"></span></button>
                        <div class="icon"><span class="s7-attention"></span></div>
                        <div class="message">${flash.message}</div>
                    </div>

                </g:if>
                <form class="form-signin" action="${postUrl ?: '/login/authenticate'}" method="POST" id="loginForm" autocomplete="off">
                    <div class="form-group">
                        <div class="input-group">
                            <div class="input-group-prepend"><i class="icon s7-user"></i></div>
                            <input class="form-control" id="username" type="text" placeholder="Nom d'utilisateur" autocomplete="off"
                                   name="${usernameParameter ?: 'username'}" id="username" autocapitalize="none"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="input-group">
                            <div class="input-group-prepend"><i class="icon s7-lock"></i></div>
                            <input class="form-control" id="password" type="password" placeholder="Mot de passe" name="${passwordParameter ?: 'password'}" />
                            <i class="fa fa-eye" id="passwordToggler" title="toggle password display" onclick="passwordDisplayToggle()"></i>
                        </div>
                    </div>

                    <div class="form-group login-submit">
                        <button id="submit" class="btn btn-lg btn-primary btn-block" type="submit" data-dismiss="modal">Me connecter</button>
                    </div>


                    <div class="form-group row login-tools">
                        <div class="col-sm-6 login-remember">
                            <label class="custom-control custom-checkbox mt-2">
                                <input type="checkbox" class="custom-control-input"
                                       name="${rememberMeParameter ?: 'remember-me'}"
                                       id="remember_me" <g:if test='${hasCookie}'>checked="checked"</g:if>/> <span class="custom-control-label">Se souvenir de moi</span>
                            </label>
                        </div>

                    </div>

                    <div class="form-group row login-tools justify-content-end">
                        <div class="col-sm-6">
                          <g:link controller="utilisateur" action="forgotPassword" >
                              Mot de passe oublié ?
                          </g:link>
                        </div>

                    </div>
                </form>


            </div>
        </div>
    </div>
</div>




<script type="text/javascript">
    document.addEventListener("DOMContentLoaded", function(event) {
        document.forms['loginForm'].elements['username'].focus();
    });
    function passwordDisplayToggle() {
        var toggleEl = document.getElementById("passwordToggler");
        var passEl = document.getElementById("password");

        if (passEl.type === "password") {
            toggleEl.classList.remove("fa-eye");
            toggleEl.classList.add("fa-eye-slash");
            passEl.type = "text";
        } else {

            toggleEl.classList.remove("fa-eye-slash");
            toggleEl.classList.add("fa-eye");
            passEl.type = "password";
        }
    }
</script>
</body>



</html>