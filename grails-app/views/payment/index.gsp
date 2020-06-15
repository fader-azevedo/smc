<%@ page import="smc.Loan; smc.Payment; smc.Client" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <title>
            Pagamentos
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
                                Pagamentos
                                <span>
                                    <g:include action="loans"/>
                                </span>
                            </a>
                        </li>
                        <li class="divider mt-3"></li>
                        <li>
                            <a class="filter link" data-status="aberto">Todos
                                <span>${Payment.count}</span>
                            </a>
                        </li>
                    </ul>
                    <div class="line-title text-center mb-4 mb-md-4">
                        <span class="text">Filtro</span>
                    </div>
                    <div class="form-group">
                        <label for="client-select">Estado do Emprestimo</label>
                        <g:select class="select2" name="status-select"
                                  from="${Loan.constrainedProperties.status.inList}"
                                  noSelection="${['':'Todos']}"
                        />
                    </div>
                    <div class="form-group">
                        <label for="client-select">Cliente</label>
                        <g:select class="select2" name="client-select"
                                  from="${Client.all.sort{it.fullName.toUpperCase()}}" optionKey="id" optionValue="fullName"
                                  noSelection="${['':'Todos']}"
                        />
                    </div>
                </div>

                <div class="right-aside" style="min-height: 500px">
                    <div class="right-page-header">
                        <div class="row">
                            <div class="col-6">
                                <h4 class="card-title mt-2" id="payment-title">Todos pagamentos</h4>
                            </div>

                            <div class="col-6 dialogFooter d-flex justify-content-end">
                                <div class="btn-group  w-75" role="group" aria-label="Basic example">
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
                    <small>Emprestimos: <strong id="text-small-loan"></strong>&nbsp;|&nbsp;Cliente: <strong id="text-small-client"></strong></small>
                    <div id="div-all-payment" class="table-responsive mt-2">
                        <table id="payment-table" class="table table-hover table-bordered no-wrap" data-paging="true" data-paging-size="6">
                            <thead>
                            <tr class="border f-w-700">
                                <th class="border">Total pago</th>
                                <th class="border">Valor pago</th>
                                <th class="border px-3">Prestação</th>
                                <th class="border">F.Pagamento</th>
                                <th class="border">Recibo</th>
                                <th class="border">Cliente</th>
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
                                <th>C.inicial</th>
                                <th>Totl a pagar</th>
                                <th>Total pago</th>
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
        let whoIsShow;
        $(function () {
            $(".select2").select2();
            $('.select2').addClass('w-100');

            statusSelect.on('change',function () {
                if($(this).val()){
                    $('#text-small-loan').text($(this).val())
                }else{
                    $('#text-small-loan').text('Todos')
                }
                filter()
            });
            statusSelect.val('Aberto').trigger('change');

            $('.number-format').each(function () {
                const value = parseFloat($(this).text());
                $(this).text(formatValue(value))
            });

            $('#payment-table tbody td > hr:last-child').remove();

            clientSelect.on('change',function () {
                const id = $(this).val();
                const clientName = $('#client-select option:selected').text();
                $('#text-small-client').text(clientName);

                if(id){
                    $('#payment-title').html('Pagamentos de <strong>'+clientName+'</strong>');
                    $("#div-all-payment").fadeOut("fast", function () {
                        $("#div-client-payment").fadeIn("fast").addClass('month-table').removeClass('d-none');
                        whoIsShow = 'client';
                        filter();
                    });
                }else{
                    $('#payment-title').text('Todos pagamentos');
                    $("#div-client-payment").fadeOut("fast", function () {
                        $("#div-all-payment").fadeIn("fast");
                        $('#div-client-payment').removeClass('month-table').addClass('d-none');
                        whoIsShow = 'all';
                    });
                }

            });
            clientSelect.val('').trigger('change')
        });
        function upp() {
            if($('#table-body-client-payment tr').length === 0){
                $('#table-body-client-payment').html(
                    '<tr><td colspan="6" class="text-center">Sem pagamento registado</td></tr>'
                )
            }
        }

        function filter() {
            const status_ = statusSelect.val();
            const client_ = clientSelect.val();
            if(whoIsShow === 'client' && client_){
                <g:remoteFunction action="_byClient" params="{'id':client_,'status':status_}" update="table-body-client-payment" onSuccess="upp(data)"/>
            }else{
                <g:remoteFunction action="_filterPaymentByLoanStatus" params="{'status':status_}" update="payment-table-body" onSuccess="updateAll()"/>
            }
        }
        
        function updateAll() {
            $('#payment-table tbody td > hr:last-child').remove();
            $('table tbody td').addClass('align-middle');
        }
    </script>
    </body>
</html>