<%@ page import="org.springframework.security.core.context.SecurityContextHolder; mccorletagencement.Utilisateur" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="layout" content="main"/>
    <title>To do list</title>

</head>

<body>

<div class="card m-2">

    <div class="card card-header">
        <div class="row" style="color: rgba(0,0,0,0.7); vertical-align: middle">
            <div class="col-lg-12" style="font-size: 22px;">
                <i class="fa fa-list-ol"></i> Mémo
            </div>
        </div>

        <hr>
    </div>


    <div class="card-body">

        <div class="row justify-content-center">

            <g:hasErrors bean="${this.activite}">
                <div class="row justify-content-center m-3">
                    <div class="alert alert-theme alert-danger alert-dismissible col-lg-6" role="alert">
                        <button class="close" type="button" data-dismiss="alert" aria-label="Close"><span
                                class="s7-close"
                                aria-hidden="true"></span>
                        </button>

                        <div class="row ml-3 mt-3">
                            <div class="icon">
                                <span class="s7-attention"></span>
                            </div>
                            <strong style="font-size:14px">Erreur !</strong>
                        </div>

                        <div class="message">
                            <ul class="errors" role="alert">
                                <g:eachError bean="${this.activite}" var="error">
                                    <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>>
                                        <g:message error="${error}"/>
                                    </li>
                                </g:eachError>
                            </ul>
                        </div>
                    </div>
                </div>
            </g:hasErrors>


                <div class="col-lg-6">
                    <div class="widget widget-fullwidth todo-list">


                        <div class="todo-list-container">
                            <ul id="todo-tasks" class="todo-tasks">
                                <g:render template="todoTasks" model="[activites: activites]"/>
                            </ul>
                        </div>

                        <div class="todo-new-task">
                            <div class="input-group">
                                <input required id="description" class="form-control" type="text"
                                       placeholder="Description de l'activité ..." autocomplete="off">

                                <a href="#" id="enregistrer" class="input-group-append" onclick="" style="font-size: 18px; background-color: #1a9fdd; color: white" >
                                    <i class="icon s7-plus" style="font-size: 28px!important;"></i>&nbsp;Ajouter
                                </a>

                            </div>
                        </div>
                    </div>
                </div>


        </div>

    </div>

</div>

</body>
</html>