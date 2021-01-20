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

    <g:if test="${flash.message}">
        <div class="row justify-content-center m-4" style="min-height: 500px">
            <div class="alert alert-success alert-icon alert-icon-colored alert-dismissible col-lg-6" role="alert" style="margin-top: 10em">
                <div class="icon"><span class="s7-check"></span></div>

                <div class="message">
                    <button class="close" type="button" data-dismiss="alert" aria-label="Close">
                        <span class="s7-close" aria-hidden="true"></span>
                    </button>
                    ${flash.message}
                </div>
            </div>
        </div>
    </g:if>

    <g:if test="${flash.error}">
        <div class="row justify-content-center m-4" style="min-height: 500px">
            <div class="alert alert-danger alert-icon alert-icon-colored alert-dismissible col-lg-6" role="alert" style="margin-top: 10em">
                <div class="icon"><span class="s7-attention"></span></div>

                <div class="message">
                    <button class="close" type="button" data-dismiss="alert" aria-label="Close">
                        <span class="s7-close" aria-hidden="true"></span>
                    </button>
                    ${flash.error}
                </div>
            </div>
        </div>
    </g:if>

</div>

</body>
</html>
