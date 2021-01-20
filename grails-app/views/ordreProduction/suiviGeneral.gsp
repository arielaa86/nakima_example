<%@ page import="org.springframework.security.core.context.SecurityContextHolder; mccorletagencement.Utilisateur" contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Suivi general des ordres de production</title>

    <style>
        .monAccordion {
            border: solid 1px #e9e9e9!important;
        }

        .buttonAccordion{
            color: #646363 !important;
        }

        .badge-pill{
            padding: 0.1935rem 0.5rem;
            border-radius: 50%;
            height: 35px;
            width: 35px;
            line-height: 27px;
            margin-top: 16px;
            font-size: 18px;
            background-color: #fa6163;
        }



    </style>

</head>

<body>

<div class="card card-default card-table m-2">

    <div class="card card-header">
        <div class="row" style="color: rgba(0,0,0,0.7); vertical-align: middle">
            <div class="col-lg-12" style="font-size: 22px;">
                <i class="fa fa-th"></i>   Planning prévisionnel annuel
            </div>
        </div>

        <hr>
    </div>

    <div class="card-body" id="cardBody">

        <div class="row justify-content-center">

            <div class="col-lg-3 m-2 mb-4">
            <g:select class="form-control custom-select" name="annee" onchange="getPlanning(this.value)"
                      from="${actuelle .. prochaine}"
                      required=""
                      value="" />
            </div>

        </div>


                <g:render template="suiviMois" model="[planning: planning, user: user]" />


    </div>
</div>


<asset:javascript src="ordreProduction/actions.js"/>

</body>
</html>