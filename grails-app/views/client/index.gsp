<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <title>
            Lista de clients
        </title>
    </head>
    <body>
    <div class="col-12">
        <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
        </g:if>
        <div class="card card-outline-success">
            <div class="card-header pb-0 pb-lg-0">
                <h5 class="card-title text-white"><i class="fa fa-list"></i>&nbsp;Lista de clients
                    <g:link class="btn btn-xs btn-outline-light float-right waves-effect waves-light" action="create"><i class="fa fa-plus"></i>&nbsp;client</g:link>
                </h5>
            </div>

            <div class="card-body">
                <div class="table-responsive">
                    <f:table collection="${clientList}"/>
                </div>
            </div>
        </div>
    </div>
    </body>
</html>