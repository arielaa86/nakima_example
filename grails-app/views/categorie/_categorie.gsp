<%@ page import="java.text.SimpleDateFormat; java.text.DecimalFormat" %>

    <div class="usage" id="${categorie.id}" style="background-color: #afe9f0; cursor: pointer"
         onclick="getDetailscategorie(${categorie.id})"
         data-toggle="modal" data-target="#actualiserCategorie">
        <div class="usage-head">
            <span class="usage-head-title" style="font-size: 20px!important;">
                ${categorie.description}
            </span>
        </div>

        <div class="usage-resume">
            <div class="usage-data">
                <span class="usage-counter">
                    ${categorie.getTotalMois(actualDate) > 0 ? new DecimalFormat("###,###.00 €").format(categorie.getTotalMois(actualDate)).replaceAll(",", " ") : '0.00 €'}
                </span>
            </div>

            <div class="usage-icon">
                <i class="fa-4x fa ${categorie.icon == null ? 'fa-certificate' : categorie.icon}" ></i>
            </div>
        </div>
    </div>

