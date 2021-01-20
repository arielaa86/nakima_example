<g:each in="${categories.sort({it.id})}" var="categorie">

    <div class="col-lg-3" id="categorie${categorie.id}" >
        <g:render template="categorie" model="[categorie: categorie, actualDate: actualDate]"/>
    </div>

</g:each>

<div class="col-lg-3">
    <div class="usage" style="border: solid 1px lightgray; cursor: pointer;" data-toggle="modal"
         data-target="#nouvelleCategorie" >
        <div class="usage-head">
            <span class="usage-head-title" style="font-size: 20px!important;">
                Nouveau poste de dépense
            </span>
        </div>

        <div class="usage-resume">
            <div class="usage-data">
                <span class="usage-counter" style="color: white">
                    0.00
                </span>
            </div>

            <div class="usage-icon"><span class="icon s7-plus"></span></div>
        </div>
    </div>
</div>