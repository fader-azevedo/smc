<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <title>Registar paymentMethod</title>
    </head>
    <body>

    <div class="col-12 col-sm-12 col-md-12 col-lg-8 col-xl-8">
        <g:if test="${flash.message}">
            <div class="alert alert-success" role="status">${flash.message}</div>
        </g:if>
        <g:hasErrors bean="${this.paymentMethod}">
            <div class="alert alert-danger" role="alert">
                <g:eachError bean="${this.paymentMethod}" var="error">
                    <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                </g:eachError>
            </div>
        </g:hasErrors>
        <div class="card card-outline-success">
            <div class="card-header pb-0 pb-lg-0">
                <h5 class="card-title text-white"><i class="fa fa-pencil-alt"></i>&nbsp;Registar paymentMethod</h5>
            </div>
            <g:form resource="${this.paymentMethod}" method="POST">
                <div class="card-body">
                    <p class="desc">create</p>
                    <f:all bean="paymentMethod"/>
                </div>

                <div class="card-footer">
                    <g:link action="index" class="btn btn-sm btn-outline-secondary waves-effect waves-light"><i
                            class="fa fa-times"></i>&nbsp;Cancelar
                    </g:link>
                    <button type="submit" class="btn btn-sm btn-outline-success float-right waves-effect waves-light">
                        <i class="fa fa-save"></i>&nbsp;Salvar
                    </button>
                </div>
            </g:form>
        </div>
    </div>
    </body>
</html>
