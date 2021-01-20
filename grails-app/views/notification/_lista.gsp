<g:each in="${notifications}" var="notification">

    <li>
        <g:link controller="${notification.controleur}" action="${notification.action}" id="${notification.idObjet}">
            <g:if test="${notification.typeNotification.equals("devisAttente")}">
                <div class="icon"><span class='s7-alarm'></span></div>
            </g:if>

            <g:if test="${notification.typeNotification.equals("devisValide")}">
                <div class="icon"><span class='s7-check'></span></div>
            </g:if>

            <g:if test="${notification.typeNotification.equals("devisReouvert")}">
                <div class="icon"><span class='s7-folder'></span></div>
            </g:if>

            <g:if test="${notification.typeNotification.equals("devisRefuse")}">
                <div class="icon"><span class='s7-close'></span></div>
            </g:if>

            <g:if test="${notification.typeNotification.equals("devisExpiration")}">
                <div class="icon"><span class='s7-hourglass'></span></div>
            </g:if>

            <g:if test="${notification.typeNotification.equals("calendrier")}">
                <div class="icon"><span class='s7-date'></span></div>
            </g:if>

            <g:if test="${notification.typeNotification.equals("tacheAnnule")}">
                <div class="icon"><span class='s7-date'></span></div>
            </g:if>

            <g:if test="${notification.typeNotification.equals("verificationAtelier")}">
                <div class="icon"><span class='s7-like2'></span></div>
            </g:if>

            <g:if test="${notification.typeNotification.equals("correctionsEffectuees")}">
                <div class="icon"><span class='s7-like2'></span></div>
            </g:if>

            <g:if test="${notification.typeNotification.equals("nouvelOrdre")}">
                <div class="icon"><span class='s7-tools'></span></div>
            </g:if>

            <g:if test="${notification.typeNotification.equals("correctionsAfaire")}">
                <div class="icon"><span class='s7-pin'></span></div>
            </g:if>

            <g:if test="${notification.typeNotification.equals("pretLivraison")}">
                <div class="icon"><span class='s7-cart'></span></div>
            </g:if>
            <g:if test="${notification.typeNotification.equals("poseComplete")}">
                <div class="icon"><span class='fa fa-truck'></span></div>
            </g:if>
            <g:if test="${notification.typeNotification.equals("commentaireProd")}">
                <div class="icon"><span class='fa fa-edit'></span></div>
            </g:if>
            <g:if test="${notification.typeNotification.equals("erreurVerfication")}">
                <div class="icon"><span class='s7-attention'></span></div>
            </g:if>


            <div class="content">
                <span class="desc">${notification.texte}</span>
                <span class="date">${notification.tempsEcoule}</span></div>
        </g:link>
    </li>

</g:each>


