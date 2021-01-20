<!doctype html>
<html>
    <head>
        <title><g:if env="development">Grails Runtime Exception</g:if><g:else>Error</g:else></title>
        <meta name="layout" content="main">
        <g:if env="development"><asset:stylesheet src="errors.css"/></g:if>
    </head>
    <body>
        <g:if env="development">
            <g:if test="${Throwable.isInstance(exception)}">
                <g:renderException exception="${exception}" />
            </g:if>
            <g:elseif test="${request.getAttribute('javax.servlet.error.exception')}">

                <g:renderException exception="${request.getAttribute('javax.servlet.error.exception')}" />
                <!--
                <div class="mai-wrapper mai-error mai-error-404">
                    <div class="main-content container">
                        <div class="error-container">
                            <div class="error-image">
                                <asset:image src="img/notfound.png" />
                            </div>
                            <div class="error-number"> <span>404</span></div>
                            <div class="error-description">The page you are looking for might have been removed.</div>
                            <div class="error-goback-text">Would you like to go home?</div>
                            <div class="error-goback-button"><a class="btn btn-lg btn-primary" href="index.html">Let's go home</a></div>
                            <div class="footer"> <span class="copy">© 2016 </span><span>Your Company</span></div>
                        </div>
                    </div>
                </div>

                -->

            </g:elseif>
            <g:else>
                <ul class="errors">
                    <li>An error has occurred</li>
                    <li>Exception: ${exception}</li>
                    <li>Message: ${message}</li>
                    <li>Path: ${path}</li>
                </ul>
            </g:else>
        </g:if>
        <g:else>

            <g:if test="${Throwable.isInstance(exception)}">
                <g:renderException exception="${exception}" />
            </g:if>

        </g:else>
    </body>
</html>
