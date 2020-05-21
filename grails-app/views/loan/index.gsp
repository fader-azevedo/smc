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
            <div class="card-header pb-0 pb-lg-0">
                <h5 class="card-title text-white"><i class="fa fa-list"></i>&nbsp;Lista de Empréstimos
                    <g:link class="btn btn-xs btn-outline-light float-right waves-effect waves-light" action="create"><i class="fa fa-plus"></i>&nbsp;Registar empréstimo</g:link>
                </h5>
            </div>

            <div class="card-body">
                <div class="table-responsive">
                    <table id="loan-table" class="table-bordered table-hover">
                    <thead>
                    <tr class="text-nowrap">
                        <th><i class="fa fa-code-branch">&nbsp;</i>Codigo</th>
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
                        <tr class="tr pointer-event" data-id="${it.id}">
                            <td>${it.code}</td>
                            <td>${it.client.fullName}</td>
                            <td class="text-right number-format"><g:formatNumber number="${it.borrowedAmount}"/></td>
                            <td class="text-right"><g:formatNumber number="${it.interestRate}"/></td>
                            <td class="text-right number-format"><g:formatNumber number="${it.amountPayable}"/></td>
                            <td>
                                <g:if test="${it.status.equalsIgnoreCase('aberto')}">
                                    <span class="badge badge-inverse">Pendente</span>
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
                            <h4 class="card-title">Prestações</h4>
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
                        </div>
                    </div>
                    <hr>
                    <div class="text-center">
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
        $(document).ready(function () {
            $('.number-format').each(function () {
                const value = parseFloat($(this).text());
                $(this).text(formatValue(value))
            });

            $('#loan-table').DataTable();
            $('.dataTables_wrapper div:first').remove();
            $('#loan-table_info').remove();
            $('#loan-table_paginate ul').addClass('bg-white');
            $('#loan-table_paginate li').removeClass('paginate_button')

            $('.tr').on('click',function () {
                $('#right-modal').modal('toggle')
            })
        })
    </script>
    </body>
</html>