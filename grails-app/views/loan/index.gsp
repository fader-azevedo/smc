<%@ page import="smc.Loan" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>
        Lista de Empréstimos
    </title>
</head>

<body>

<div class="col-12">
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>

    <div class="card">
        <div class="contact-page-aside">
            <div class="left-aside">
                <ul class="list-style-none">
                    <li class="rounded-label f-s-17">
                        <a class="f-w-700" href="javascript:void(0)">
                            Empréstimos
                            <span>
                                <g:include action="loans"/>
                            </span>
                        </a>
                    </li>
                    <li class="divider mt-3"></li>
                    <li>
                        <a class="filter link" data-status="aberto">Abertos <span>
                            <g:include action="loans" params="[status: 'aberto']"/></span>
                        </a>
                    </li>
                    <li>
                        <a class="filter link" data-status="vencido">Vencidos <span>
                            <g:include action="loans" params="[status: 'vencido']"/></span>
                        </a>
                    </li>
                    <li>
                        <a class="filter link" data-status="fechado">Fechados <span>
                            <g:include action="loans" params="[status: 'fechado']"/></span>
                        </a>
                    </li>
                    <li class="p-2 rounded-label mt-md-5">
                        <g:link controller="loan" action="create"
                                class="btn btn-rounded btn-success text-white">Novo empréstimo</g:link>
                    </li>
                </ul>
            </div>

            <div class="right-aside" style="min-height: 500px">
                <div class="right-page-header">
                    <div class="row">
                        <div class="col-12 col-md-6">
                            <h4 class="card-title mt-2">Empréstimos <span id="loan-title" class="f-w-600">abertos</span></h4>
                        </div>

                        <div class="col-12 col-md-6">
                            <div class="input-icons pt-1 pr-0">
                                <i class="fa fa-search"></i>
                                <input class="form-control input-super-entities pl-5 pl-sm-5" type="text"
                                       placeholder="Pesquisar por cliente">
                            </div>
                        </div>
                    </div>
                </div>
                <hr>

                <div class="table-responsive">
                    <table id="loan-table" class="table table-hover table-bordered no-wrap" data-paging="true" data-paging-size="6">
                        <thead>
                        <tr class="border f-w-700">
                            <th class="border">Accoes</th>
                            <th class="border">Cliente</th>
                            <th class="border">C.Inicial</th>
                            <th class="border">Juros</th>
                            <th class="border">V. pagar</th>
                            <th class="border">Prazo</th>
                        </tr>
                        </thead>
                        <tbody>
                            <g:render template="table"/>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>


<div class="right-sidebar">
    <div class="slimscrollright">
        <div class="rpanel-title">Detalhes<span><i class="ti-close right-side-toggle"></i></span>
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
                    <a class="link"><i class="fa fa-file-word text-info">&nbsp;</i><strong id="detail-contract"></strong></a>
                </span>
            </h6>

            <hr>
            <h6 class="card-title">Pagamento</h6>
            <ul class="list-group">
                <li class="list-group-item d-flex justify-content-between align-items-center">
                    Valor pedido
                    <span class="badge badge-pill" id="detail-borrowedAmount">14</span>
                </li>
                <li class="list-group-item d-flex justify-content-between align-items-center">
                    Valor a pagar
                    <span class="badge badge-pill" id="detail-amountPayable">14</span>
                </li>
                <li class="list-group-item list-group-item-megna d-flex justify-content-between align-items-center">
                    Valor pago
                    <span class="badge badge-pill" id="detail-amountPaid">2</span>
                </li>
                <li class="list-group-item list-group-item-danger d-flex justify-content-between align-items-center">
                    Dívida
                    <span class="badge  badge-pill" id="detail-debit">1</span>
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
            <hr>
            <small class="text-muted">Registado por </small>
            <h6 id="detail-createdBy"></h6>
            <small class="text-muted pt-3 d-block">Registado em</small>
            <h6 id="detail-dateCreated">20/12/2019 13:09</h6>

            <div id="div-update" class="d-none">
                <small class="text-muted pt-4 d-block">Última alteração</small>
                <h6 id="detail-lastUpdated">20/12/2019 13:09</h6>
                <small class="text-muted pt-4 d-block">Alterado por</small>
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
            $('#tr-'+id).addClass('bg-light-info');
        });
        // close details panel
        $('.ti-close').on('click',function () {
            $('#loan-table tbody tr').removeClass('bg-light-info');
        });

        $('#loan-table').footable();
        $('.filter').on('click',function () {
            const status = $(this).attr('data-status');
            $('#loan-title').text(status+'s');
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
        $('#detail-contract').text(loan.code+'.docx');
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

        function formatDate(createdDate) {
            const date = new Date(createdDate);
            let month = (date.getMonth()+1);
            if(month.toString().length === 1){
                month = '0'+month
            }
            return date.getDate()+'/'+month+'/'+date.getFullYear()+'  '+date.getUTCHours()+':'+date.getMinutes();
        }
    }
</script>
</body>
</html>