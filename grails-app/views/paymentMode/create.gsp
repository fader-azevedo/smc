<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <title>Registar paymentMode</title>
    </head>
    <body>

    <div class="col-12 col-sm-12 col-md-12 col-lg-8 col-xl-8">
        <g:if test="${flash.message}">
            <div class="alert alert-success" role="status">${flash.message}</div>
        </g:if>
        <g:hasErrors bean="${this.paymentMode}">
            <div class="alert alert-danger" role="alert">
                <g:eachError bean="${this.paymentMode}" var="error">
                    <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                </g:eachError>
            </div>
        </g:hasErrors>
        <div class="card card-outline-success">
            <div class="card-header pb-0 pb-lg-0">
                <h5 class="card-title text-white"><i class="fa fa-pencil-alt"></i>&nbsp;Registar paymentMode</h5>
            </div>
            <g:form resource="${this.paymentMode}" method="POST">
                <div class="card-body">
                    <p class="desc">create</p>
                    <f:all bean="paymentMode"/>
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
