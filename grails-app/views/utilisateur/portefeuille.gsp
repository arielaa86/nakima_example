<%@ page import="java.text.DecimalFormat" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <title>Portefeuille</title>

    </head>
    <body>

            <div class="card card-default m-2">

                  <div class="card card-header">
                      <div class="row" style="color: rgba(0,0,0,0.7); vertical-align: middle">
                          <div class="col-lg-12" style="font-size: 22px;">
                              <i class="fa fa-folder-open-o"></i> Mon portefeuille

                          </div>
                      </div>

                      <hr>
                  </div>

              <div class="card-body">

                 <g:render template="portefeuilleTableau" model="[projetListe: projetListe, transfert: false]" />

              </div>
            </div>


    </body>
</html>
