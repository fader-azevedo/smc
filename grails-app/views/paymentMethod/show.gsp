<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <title>Ver paymentMethod</title>
    </head>
    <body>
        <div class="col-12 col-sm-12 col-md-12 col-lg-8 col-xl-8">
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>
            <div class="card card-outline-success">
                <div class="card-header pb-0 pb-lg-0">
                    <h5 class="card-title text-white"><i class="fa fa-eye"></i>&nbsp;paymentMethod
                        <g:link class="btn btn-xs btn-outline-light float-right waves-effect waves-light"
                                action="edit" resource="${this.paymentMethod}">
                            <i class="fa fa-edit"></i>&nbsp;Editar
                        </g:link>
                    </h5>
                </div>

                <div class="card-body">
                    <f:display bean="paymentMethod" />
                </div>

                <div class="card-footer d-none">
                    <g:form resource="${this.paymentMethod}" method="DELETE">
                        <input class="delete" type="submit" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('Are you sure?')" />
                    </g:form>
                </div>
            </div>
        </div>
    </body>
</html>
