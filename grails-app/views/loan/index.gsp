<%@ page import="smc.Loan" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <title>
            Lista de Empréstimos
        </title>
    </head>
    <body>
    <div class="col-12 col-sm-12 col-md-12 col-lg-11">
        <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
        </g:if>
        <div class="card card-outline-success">
            <div class="card-header pb-2 pb-lg-2">
                <h5 class="card-title text-white"><i class="fa fa-list"></i>&nbsp;Lista de Empréstimos
                    <g:link class="btn btn-sm btn-light float-right waves-effect waves-light" action="create"><i class="fa fa-plus"></i>&nbsp;Registar empréstimo</g:link>
                </h5>
            </div>

            <div class="card-body">
                <div class="row">
                    <div class="col-12 col-sm-4">
                        <div class="input-icons pt-1 pr-0">
                            <i class="fa fa-search"></i>
                            <input class="form-control input-super-entities pl-5 pl-sm-5" type="text" placeholder="Pesquisar por cliente">
                        </div>
                    </div>
                </div>
                <hr>
                <div class="table-responsive">
                    <table id="loan-table" class="table table-bordered no-wrap table-hover">
                    <thead>
                    <tr class="text-nowrap">
                        <th><i class="fa fa-code-branch">&nbsp;</i></th>
                        <th style="width: 25%"><i class="fa fa-user">&nbsp;</i>Cliente</th>
                        <th><i class="fa fa-money-bill-alt">&nbsp;</i>Valor</th>
                        <th><i class="fa fa-arrows-alt"></i>Taxa</th>
                        <th><i class="fa fa-money-bill-alt">&nbsp;</i>V. pagar</th>
                        <th><i class="fa fa-info">&nbsp;</i>Estado</th>
                        <th><i class="fa fa-calendar">&nbsp;</i>Prazo</th>
                    </tr>
                    </thead>
                    <tbody>
                    <g:each in="${(List<Loan>)loanList}">
                        <tr>
                            <td>
                                <div class="d-flex justify-content-center">
                                    <button class="btn btn-sm btn-secondary btn-details mr-3" data-id="${it.id}">
                                        <i class="fa fa-eye">&nbsp;</i>Info
                                    </button>

                                    <g:form controller="payment" action="create">
                                        <button name="loanID" value="${it.id}" type="submit" class="btn btn-sm btn-megna" data-id="${it.id}">
                                            <i class="fa fa-money-bill-alt">&nbsp;</i>Pagamento
                                        </button>
                                    </g:form>
                                </div>
                            </td>
                            <td>

                                <g:link controller="client" action="show" id="${it.client.id}">
                                    <span class="round text-white d-inline-block text-center rounded-circle bg-light-extra text-muted">
                                        ${it.client.fullName[0]}
                                    </span>
                                    ${it.client.fullName}
                                </g:link>
                            </td>
                            <td class="text-right number-format">${it.borrowedAmount}</td>
                            <td class="text-right"><g:formatNumber number="${it.interestRate}"/></td>
                            <td class="text-right number-format">${it.amountPayable}</td>
                            <td>
                                <g:if test="${it.status.equalsIgnoreCase('aberto')}">
                                    <span class="badge badge-info w-100">Aberto</span>
                                </g:if>
                                <g:if test="${it.status.equalsIgnoreCase('vencido')}">
                                    <span class="badge badge-warning w-100">Vencido</span>
                                </g:if>
                                <g:if test="${it.status.equalsIgnoreCase('fechado')}">
                                    <span class="badge badge-megna w-100">Fechado</span>
                                </g:if>
                            </td>
                            <td class="text-center"><g:formatDate format="dd/MM/yyyy" date="${it.dueDate}"/></td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
                </div>
            </div>
        </div>
    </div>

    <div id="right-modal" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-right w-25">
            <div class="modal-content" >
                <div class="modal-header border-0">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                </div>
                <div class="modal-body" >
                    <div class="row">
                        <div class="col-lg-12 col-md-12">
                            <div class="w-100 d-flex">
                                <div class="d-flex flex-column justify-content-center">
                                    <i class="fa fa-user fa-3x"></i>
                                </div>
                                <div class="pt-2">
                                    <br>
                                    <p class="text-muted pl-2">name</p>
                                </div>
                            </div>
                            <hr>
                            <h6 class="card-title">Prestações</h6>
                            <ul class="list-group">
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    Todas
                                    <span class="badge badge-secondary badge-pill">14</span>
                                </li>
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    Pagas
                                    <span class="badge badge-success badge-pill">2</span>
                                </li>
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    Pendentes
                                    <span class="badge badge-danger badge-pill">1</span>
                                </li>
                            </ul>
                            <hr>

                            <h6 class="card-title">Pagamento</h6>
                            <ul class="list-group">
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    Valor pedido
                                    <span class="badge badge-secondary badge-pill">14</span>
                                </li>
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    Valor pago
                                    <span class="badge badge-success badge-pill">2</span>
                                </li>
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    divida
                                    <span class="badge badge-danger badge-pill">1</span>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="text-center pt-2">
                        <button type="button" class="btn btn-danger btn-sm" data-dismiss="modal">Fechar</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script>
        function formatValue(value){
            return value.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&.').replace(/.([^.]*)$/, ',$1')
        }
        const datePro ={
            "language": {
                "paginate": {
                    "previous": "Anterior",
                    "next": "Próximo"
                }
            },
            // responsive: true
        };
        $(document).ready(function () {
            $('.number-format').each(function () {
                const value = parseFloat($(this).text());
                $(this).text(formatValue(value))
            });

            $('#loan-table').DataTable(datePro);
            $('.dataTables_wrapper div:first').remove();
            $('#loan-table_info').remove();
            $('#loan-table_paginate ul').addClass('bg-white');
            $('#loan-table_paginate li').removeClass('paginate_button');

            $(document).on('click','.btn-details',function () {
                $('#right-modal').modal('toggle')
            });
        })
    </script>
    </body>
</html>