<%@ page import="smc.Client" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <title>
            Lista de clientes
        </title>
    </head>
    <body>
    <div class="col-12">
        <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
        </g:if>
        <div class="card card-outline-success">
            <div class="card-header pb-0 pb-lg-2">
                <h5 class="card-title text-white"><i class="fa fa-list"></i>&nbsp;Lista de clientes
                    <g:link class="btn btn-sm btn-light float-right waves-effect waves-light" action="create"><i class="fa fa-plus"></i>&nbsp;Registar cliente</g:link>
                </h5>
            </div>

            <div class="card-body">
                <div class="table-responsive">
                    <table id="loan-table" class="table-bordered table-hover">
                        <thead>
                        <tr class="text-nowrap">
                            <th><i class="fa fa-code-branch">&nbsp;</i>Codigo</th>
                            <th><i class="fa fa-image">&nbsp;</i>Image</th>
                            <th style="width: 25%"><i class="fa fa-user">&nbsp;</i>Nome</th>
                            <th style="width: 25%"><i class="fa fa-circle">&nbsp;</i>Estado cívil</th>
                            <th style="width: 25%"><i class="fa fa-phone">&nbsp;&nbsp;</i>Contacto</th>
                            <th style="width: 25%"><i class="fa fa-at">&nbsp;</i>Email</th>
                        </tr>
                        </thead>
                        <tbody>
                        <g:each in="${(List<Client>)clientList}">
                            <tr class="" data-id="${it.id}">
                                <td>${it.code}</td>
                                <td>
                                    <span class="round text-white d-inline-block text-center rounded-circle bg-info">
                                        ${it.fullName[0]}
                                    </span>
                                </td>
                                <td>${it.fullName}</td>
                                <td>${it.maritalStatus}</td>
                                <td>${it.contact}</td>
                                <td>${it.email}</td>
                            </tr>
                        </g:each>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    </body>
</html>