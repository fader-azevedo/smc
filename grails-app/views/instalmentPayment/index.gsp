<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <title>
            Lista de instalmentPayments
        </title>
    </head>
    <body>
    <div class="col-12 col-sm-12 col-md-12 col-lg-8 col-xl-8">
        <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
        </g:if>
        <div class="card card-outline-success">
            <div class="card-header pb-0 pb-lg-0">
                <h5 class="card-title text-white"><i class="fa fa-list"></i>&nbsp;Lista de instalmentPayments
                    <g:link class="btn btn-xs btn-outline-light float-right waves-effect waves-light" action="create"><i class="fa fa-plus"></i>&nbsp;instalmentPayment</g:link>
                </h5>
            </div>

            <div class="card-body">
                <div class="table-responsive">
                    <f:table collection="${instalmentPaymentList}"/>
                </div>
            </div>
        </div>
    </div>
    </body>
</html>