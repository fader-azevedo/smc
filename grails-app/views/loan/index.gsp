<%@ page import="smc.Client; smc.Loan" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>
        Empréstimos
    </title>
</head>

<body>

<div class="col-12">
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>

    <div class="card">
        <div class="contact-page-aside">
            <div class="left-aside d-flex flex-column justify-content-between h-100">
                <div>
                    <ul class="list-style-none mb-3">
                        <li class="rounded-label f-s-17">
                            <a class="f-w-700" href="javascript:void(0)">
                                Empréstimos
                                <span>
                                    <g:include action="loans"/>
                                </span>
                            </a>
                        </li>
                        <div class="line-title text-center mt-2 mb-3 mb-md-3">
                            <span class="text">Filtro</span>
                        </div>
                        <li>
                            <a class="filter link btn btn btn-light d-flex justify-content-between px-3"
                               data-status="aberto">
                                <span>Abertos</span>
                                <span><g:include action="loans" params="[status: 'aberto']"/></span>
                            </a>
                        </li>
                        <li>
                            <a class="filter link btn btn btn-light d-flex justify-content-between px-3 mt-2"
                               data-status="vencido">
                                <span>Vencidos</span>
                                <span><g:include action="loans" params="[status: 'vencido']"/></span>
                            </a>
                        </li>
                        <li>
                            <a class="filter link btn btn btn-light d-flex justify-content-between px-3 mt-2"
                               data-status="fechado">
                                <span>Fechados</span>
                                <span><g:include action="loans" params="[status: 'fechado']"/></span>
                            </a>
                        </li>
                    </ul>

                    <div class="d-flex flex-column justify-content-between">
                        <div class="form-group">
                            <label for="filter-client">Cliente</label>
                            <g:select class="select2" name="filter-client"
                                      from="${Client.all.sort { it.fullName.toUpperCase() }}" optionKey="id"
                                      optionValue="fullName"
                                      noSelection="${['': 'Todos']}"/>
                        </div>

                        <div class="form-group">
                            <label for="filter-dueDate">Prazo</label>

                            <div class='input-group mb-3'>
                                <input type='text' class="form-control shawCalRanges f-s-13 pr-0" id="filter-dueDate"/>

                                <div class="input-group-append">
                                    <span class="input-group-text">
                                        <span class="ti-calendar"></span>
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <g:link controller="loan" action="create"
                        class="btn btn-rounded btn-success text-white mb-md-3">Novo empréstimo</g:link>
            </div>

            <div class="right-aside" style="min-height: 500px">
                <div class="right-page-header">
                    <div class="row">
                        <div class="col-md-6">
                            <h4 class="card-title mt-2">Empréstimos <span id="loan-title" class="f-w-600">abertos</span>
                            </h4>
                        </div>

                        <div class="col-6 d-flex py-2 justify-content-end">
                            <div class="btn-group" role="group" aria-label="Basic example">
                                <button type="button" class="btn btn-outline-light text-danger">
                                    <i class="fa fa-file-pdf"></i>&nbsp;pdf
                                </button>
                                <button type="button" class="btn btn-outline-light text-info">
                                    <i class="fa fa-file-word"></i>&nbsp;word
                                </button>
                                <button type="button" class="btn btn-outline-light text-megna">
                                    <i class="fa fa-file-excel"></i>&nbsp;excel
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                <hr>

                <div class="table-responsive">
                    <table id="loan-table" class="table table-hover table-bordered no-wrap" data-paging="true"
                           data-paging-size="6">
                        <thead>
                        <tr class="border f-w-700">
                            <th class="border"></th>
                            <th class="border">Cliente</th>
                            <th class="border">C.Inicial</th>
                            <th class="border">Juros(%)</th>
                            <th class="border">V. pagar</th>
                            <th class="border">Prazo</th>
                        </tr>
                        </thead>
                        <tbody>
                        <g:render template="table"/>
                        </tbody>
                        <tfoot id="loan-footer">

                        </tfoot>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>


<div class="right-sidebar">
    <div class="slimscrollright">
        <div class="rpanel-title">Detalhes
            <span><i class="ti-close right-side-toggle"></i></span>
        </div>

        <div class="panel-body p-2">
            <div class="w-100 d-flex">
                <div class="d-flex flex-column justify-content-center">
                    <i class="fa fa-user fa-3x"></i>
                </div>

                <div class="pt-2">
                    <br>

                    <p class="text-muted pl-2" id="detail-client-name">name</p>
                </div>
            </div>
            <hr>
            <h6 class="card-title d-none">Código:&nbsp;<strong id="detail-code" class="float-right">33301</strong></h6>
            <h6 class="card-title">Contracto:&nbsp;
                <span class="float-right">
                    <a class="link"><i class="fa fa-file-word text-info">&nbsp;</i><strong
                            id="detail-contract"></strong></a>
                </span>
            </h6>

            <hr>
            %{--            <h6 class="card-title">Pagamento</h6>--}%
            <ul class="list-group">
                <li class="list-group-item d-flex justify-content-between align-items-center">
                    Valor pedido
                    <span class="badge badge-pill f-w-600" id="detail-borrowedAmount">14</span>
                </li>
                <li class="list-group-item d-flex justify-content-between align-items-center">
                    Valor a pagar
                    <span class="badge badge-pill f-w-600" id="detail-amountPayable">14</span>
                </li>
                <li class="list-group-item list-group-item-megna d-flex justify-content-between align-items-center">
                    Valor pago
                    <span class="badge badge-pill f-w-600" id="detail-amountPaid">2</span>
                </li>
                <li class="list-group-item list-group-item-danger d-flex justify-content-between align-items-center">
                    Dívida
                    <span class="badge badge-pill f-w-600" id="detail-debit">1</span>
                </li>
            </ul>
            <hr>
            <h6 class="card-title">Prestações</h6>
            <ul class="list-group">
                <li class="list-group-item list-group-item-light-megna">
                    Prestação <strong id="detail-installment-type">diaria</strong>
                </li>
                <li class="list-group-item d-flex justify-content-between align-items-center">
                    Todas
                    <span class="" id="detail-installment-all">14</span>
                </li>
                <li class="list-group-item d-flex justify-content-between align-items-center">
                    Pagas
                    <span class="text-megna" id="detail-installment-payed">2</span>
                </li>
                <li class="list-group-item d-flex justify-content-between align-items-center">
                    Pendentes
                    <span class="text-danger" id="detail-installment-pend">1</span>
                </li>
            </ul>

            <div id="div-auth" class="d-none">
                <hr>
                <small class="text-muted">Registado por</small>
                <h6 id="detail-createdBy"></h6>
                <small class="text-muted pt-2 d-block">Registado em</small>
                <h6 id="detail-dateCreated">20/12/2019 13:09</h6>

                <small class="text-muted pt-2 d-block">Última alteração</small>
                <h6 id="detail-lastUpdated">20/12/2019 13:09</h6>
                <small class="text-muted pt-2 d-block">Alterado por</small>
                <h6 id="detail-updatedBy">20/12/2019 13:09</h6>
            </div>
        </div>
    </div>
</div>

<script>


    $(document).ready(function () {
        $('#li-loan').addClass('active');
        $('#li-loan .index').addClass('active');
        $('table tbody td').addClass('align-middle');

        $(".select2").select2();
        $('.select2').addClass('w-100');

        $('#filter-dueDate').daterangepicker({
            ranges: {
                'Hoje': [moment(), moment()],
                'Ontem': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
                'Últimos 7 dias': [moment().subtract(6, 'days'), moment()],
                'Últimos 30 dias': [moment().subtract(29, 'days'), moment()],
                'Este Mês': [moment().startOf('month'), moment().endOf('month')],
                'Último Mês': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
            },
            // alwaysShowCalendars: true,
        });


        $(document).on('click', '.btn-details', function () {
            const id = $(this).attr('data-id');
            <g:remoteFunction controller="loan" action="getDetails" params="{'id':id}" onSuccess="updateDetails(data)"/>
            const isOpen = $('.shw-rside').length;

            if (isOpen === 1) {
                console.log('update');
            } else {
                console.log('first');
                $(".right-sidebar").slideDown(50).toggleClass("shw-rside");
            }
            $('#loan-table tbody tr').removeClass('bg-light-info');
            $('#tr-' + id).addClass('bg-light-info');
        });
        // close details panel
        $('.ti-close').on('click', function () {
            $('#loan-table tbody tr').removeClass('bg-light-info');
        });

        $('#loan-table').footable();
        $('.filter').on('click', function () {
            const status = $(this).attr('data-status');
            $('#loan-title').text(status + 's');
            <g:remoteFunction action="filter" params="{'status':status}" onSuccess="updateTable(data)"/>
        });
    });

    function updateTable(data) {
        $("#loan-table tbody").fadeOut("fast", function () {
            $('#loan-table tbody').html(data);
            $('#loan-table').footable();


            $("#loan-table tbody").fadeIn("slow");
            $('table tbody td').addClass('align-middle');
        });
    }

    function updateDetails(data) {
        const loan = data.loan;
        const client = data.client;

        $('#detail-client-name').text(client.fullName);
        $('#detail-code').text(loan.code);
        $('#detail-contract').text(loan.code + '.docx');
        $('#detail-installment-all').text(data.instAll);
        $('#detail-installment-payed').text(data.instPayed);
        $('#detail-installment-pend').text(data.instPend);

        // payment
        $('#detail-installment-type').text(data.instalmentType);
        $('#detail-borrowedAmount').text(formatValue(loan.borrowedAmount));
        $('#detail-amountPayable').text(formatValue(loan.amountPayable));
        $('#detail-amountPaid').text(formatValue(data.valuePaid));
        $('#detail-debit').text(formatValue(data.debit));


        $('#detail-createdBy').text(data.createdBy);
        $('#detail-updatedBy').text(data.updatedBy);
        $('#detail-dateCreated').text(formatDate(loan.dateCreated));
        $('#detail-lastUpdated').text(formatDate(loan.lastUpdated));
    }
</script>
</body>
</html>