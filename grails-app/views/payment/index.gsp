<%@ page import="smc.Loan; smc.Payment; smc.Client" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>
        Pagamentos
    </title>
</head>

<body>

<div class="col-12">
    <g:if test="${flash.message}">
        <div class="alert alert-info" role="status">${flash.message}</div>
    </g:if>

    <div class="card">
        <div class="contact-page-aside">
            <div class="left-aside">
                <ul class="list-style-none">
                    <li class="rounded-label f-s-17">
                        <a class="f-w-700" href="javascript:void(0)">
                            Pagamentos
                            <span class="d-none">${Payment.count}</span>
                        </a>
                    </li>
                    <div class="line-title text-center mt-2 mb-3 mb-md-3">
                        <span class="text">Filtro</span>
                    </div>
                </ul>

                <div class="form-group">
                    <label for="status-select">Estado do Emprestimo</label>
                    <select class="select2" name="status-select" id="status-select">
                        <option value="">Todos</option>
                        <g:each in="${Loan.constrainedProperties.status.inList}">
                            <g:if test="${it.toString().equalsIgnoreCase('aberto')}">
                                <option value="${it}" selected>${it}</option>
                            </g:if>
                            <g:else>
                                <option value="${it}">${it}</option>
                            </g:else>
                        </g:each>
                    </select>
                </div>

                <div class="form-group">
                    <label for="client-select">Cliente</label>
                    <g:select class="select2" name="client-select"
                              from="${Client.all.sort { it.user.fullName.toUpperCase() }}" optionKey="id"
                              optionValue="user"
                              noSelection="${['': 'Todos']}"/>
                </div>

                <div class="form-group" id="div-createdDate">
                    <label for="filter-createdDate">Data</label>
                    <div class='input-group mb-3'>
                        <input type='text' class="form-control shawCalRanges f-s-13 pr-0" id="filter-createdDate"/>

                        <div class="input-group-append">
                            <span class="input-group-text">
                                <span class="ti-calendar"></span>
                            </span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="right-aside" style="min-height: 500px">
                <div class="right-page-header">
                    <div class="row">
                        <div class="col-6">
                            <h4 class="card-title mt-2" id="payment-title">Todos pagamentos</h4>
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
                <small>Emprestimos: <strong id="text-small-loan">Aberto</strong>&nbsp;|&nbsp;Cliente: <strong
                        id="text-small-client">Todos</strong></small>

                <div id="div-all-payment" class="table-responsive mt-2">
                    <table id="payment-table" class="table table-hover table-bordered no-wrap" data-paging="true"
                           data-paging-size="4">
                        <thead>
                        <tr class="border f-w-700">
                            <th class="border">Cliente</th>
                            <th class="border text-right">Total pago</th>
                            <th class="border text-right">Valor pago</th>
                            <th class="border px-3">Prestação</th>
                            <th class="border">F.pagamento</th>
                            <th class="border text-center">Data</th>
                            <th class="border">Recibo</th>
                        </tr>
                        </thead>
                        <tbody id="payment-table-body">
                        <g:render template="all"/>
                        </tbody>
                    </table>
                </div>

                <div id="div-client-payment" class="d-none mt-2">
                    <table id="table-client-payment" class="table table-bordered no-wrap">
                        <thead>
                        <tr>
                            <th></th>
                            <th></th>
                            <th class="text-right">Capital inicial</th>
                            <th class="text-right">Total a pagar</th>
                            <th class="text-right">Total pago</th>
                            <th>Estado</th>
                        </tr>
                        </thead>
                        <tbody id="table-body-client-payment">
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    const clientSelect = $('#client-select');
    const statusSelect = $('#status-select');
    const createdDateSelect =$('#filter-createdDate');
    let whoIsShow;
    let dateOne;
    let dateTwo;
    $(function () {
        $(".select2").select2();
        $('.select2').addClass('w-100');
        $('#payment-table tbody td > hr:last-child').remove();
        $('#payment-table').footable();

        createdDateSelect.daterangepicker(
            {
                ranges: {
                    'Todos': [moment().subtract(73000, 'days'), moment().add(36500, 'days')],
                    'Hoje': [moment(), moment().add(1,'days')],
                    'Ontem': [moment().subtract(1, 'days'), moment()],
                    'Últimos 7 dias': [moment().subtract(6, 'days'), moment().add(1,'days')],
                    'Últimos 30 dias': [moment().subtract(29, 'days'), moment().add(1,'days')],
                    'Este Mês': [moment().startOf('month'), moment().endOf('month')],
                    'Mês Passado': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')],
                },
                locale: {
                    applyLabel: "Aplicar",
                    cancelLabel: 'Cancelar',
                    startLabel: 'Data inicio',
                    endLabel: 'Data fim',
                    customRangeLabel: 'Customizar',
                    daysOfWeek: ['Do', 'Seg', 'Te', 'Qu', 'Qu', 'Se', 'Sa'],
                    monthNames: ['Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho', 'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro'],
                    firstDay: 1,
                    format: 'DD/MM/YYYY',
                },
                startDate: moment().subtract(73000, 'days'),
                endDate: moment().add(36500, 'days'),
                showDropdowns: true,

                // alwaysShowCalendars: true,
            }, function (start, end) {
                dateOne = start.format('DD/MM/YYYY').trim();
                dateTwo = end.format('DD/MM/YYYY').trim();
                $(this).val('');
                filter()
            }
        );

        statusSelect.on('change', function () {
            filter()
        });

        clientSelect.on('change', function () {
            const id = $(this).val();

            if (id) {
                $('#payment-title').html('Pagamentos de <strong>' + $('#client-select option:selected').text() + '</strong>');
                $("#div-all-payment").fadeOut("fast", function () {
                    $("#div-client-payment").fadeIn("fast").addClass('month-table').removeClass('d-none');
                    whoIsShow = 'client';
                    $('#div-createdDate').fadeOut('slow').addClass('d-none');
                    filter();
                });
            } else {
                $('#payment-title').text('Todos pagamentos');
                $('#text-small-client').text('Todos');
                $("#div-client-payment").fadeOut("fast", function () {
                    $("#div-all-payment").fadeIn("fast");
                    $('#div-client-payment').removeClass('month-table').addClass('d-none');
                    whoIsShow = 'all';
                    $('#div-createdDate').fadeIn('slow').removeClass('d-none');
                });
            }
        });
        // clientSelect.val('').trigger('change')
        fromLoans()
    });

    function upp() {
        if ($('#table-body-client-payment tr').length === 0) {
            $('#table-body-client-payment').html(
                '<tr><td colspan="6" class="text-center">Sem pagamento registado</td></tr>'
            )
        }
    }

    function filter() {
        const status_ = statusSelect.val();
        const client_ = clientSelect.val();
        const clientName = $('#client-select option:selected').text();
        $('#text-small-client').text(clientName);

        if (status_) {
            $('#text-small-loan').text(status_)
        } else {
            $('#text-small-loan').text('Todos')
        }

        if (whoIsShow === 'client' && client_) {
            <g:remoteFunction action="_byClient" params="{'id':client_,'status':status_}" update="table-body-client-payment" onSuccess="upp(data)"/>
        } else {
            <g:remoteFunction action="_filterPaymentByLoanStatus" params="{'status':status_,'dateOne':dateOne,'dateTwo':dateTwo}" update="payment-table-body" onSuccess="updateAll()"/>
        }
    }

    function updateAll() {
        $('#payment-table').footable();

        $('#payment-table tbody td > hr:last-child').remove();
        $('table tbody td').addClass('align-middle');
    }

    let sourceClient = '${params.loanClientStatus}';

    function fromLoans() {
        if(sourceClient){
            const loanClient = sourceClient.split('_');//[0]=loanId, [1]=clientId, [2]=loanStatus
            clientSelect.val(loanClient[1]).trigger('change');
            statusSelect.val(loanClient[2]).trigger('change');
        }

        if ( window.history.replaceState ) {
            window.history.replaceState( null, null, window.location.href );
        }
    }

    $(document).on('click','.open-receipt',function () {
        const id = $(this).attr('data-id');
        <g:remoteFunction controller="payment" action="getReceipt" params="{'id':id}" onSuccess="openReceipt(id)"/>
    });

    function openReceipt(id) {
        window.open('<g:createLink controller="payment" action="receipt" params="{'id':id}"/>', '_blank');
    }
</script>
</body>
</html>