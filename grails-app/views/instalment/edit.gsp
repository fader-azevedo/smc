<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <title>Editar instalment</title>
    </head>
    <body>
        <div class="col-12 col-sm-12 col-md-12 col-lg-8 col-xl-8">
            <g:if test="${flash.message}">
                <div class="alert alert-success" role="status">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${this.instalment}">
                <div class="alert alert-danger" role="alert">
                    <g:eachError bean="${this.instalment}" var="error">
                        <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                    </g:eachError>
                </div>
            </g:hasErrors>
            <div class="card card-outline-success">
                <div class="card-header pb-0 pb-lg-0">
                    <h5 class="card-title text-white"><i class="fa fa-edit"></i>&nbsp;Editar instalment</h5>
                </div>
                <g:form resource="${this.instalment}" method="PUT">
                    <div class="card-body">
                        <f:all bean="instalment"/>
                    </div>

                    <div class="card-footer">
                        <g:link action="show" resource="${this.instalment}" class="btn btn-sm btn-outline-secondary waves-effect waves-light"><i
                                class="fa fa-times"></i>&nbsp;Cancelar
                        </g:link>
                        <button type="submit" class="btn btn-sm btn-outline-success float-right waves-effect waves-light">
                            <i class="fa fa-save"></i>&nbsp;Actualizar
                        </button>
                    </div>
                </g:form>
            </div>
        </div>
    </body>
</html>
