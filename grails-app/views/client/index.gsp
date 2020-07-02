<%@ page import="smc.Loan; smc.Client" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <title>
            Clientes
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
                        <ul class="list-style-none mb-1">
                            <li class="rounded-label f-s-17">
                                <a class="f-w-700" href="javascript:void(0)">
                                    Clientes
                                    <span class="d-none">${Client.count}</span>
                                </a>
                            </li>
                        </ul>
                        <div class="line-title text-center mb-3 mb-md-3">
                            <span class="text">Filtro</span>
                        </div>

                        <div class="form-group">
                            <label for="status-select">Estado</label>
                            <select name="" id="status-select" class="select2">
                                <option value="">Todos</option>
                                <option value="true">Activo</option>
                                <option value="false">Inactivo</option>
                            </select>
                        </div>

                        <div class="d-flex flex-column justify-content-between">
                            <div class="form-group">
                                <label for="filter-dueDate">Data do registo</label>
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
                    <g:link controller="client" action="create" class="btn btn-rounded btn-success text-white mb-md-3">
                        Novo cliente
                    </g:link>
                </div>

                <div class="right-aside" style="min-height: 500px">
                    <div class="right-page-header">
                        <div class="row">
                            <div class="col-6">
                                <h4 class="card-title mt-2" id="payment-title">Todos clientes</h4>
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
%{--                    <small>Cliente: <strong id="text-small-loan"></strong>&nbsp;|&nbsp;Cliente: <strong id="text-small-client"></strong></small>--}%
                    <div class="table-responsive mt-2">
                        <table id="client-table" class="table table-hover table-bordered no-wrap" data-paging="true" data-paging-size="6">
                            <thead>
                            <tr class="text-nowrap">
                                <th class="border"></th>
                                <th class="border">Nome</th>
                                <th class="border">Contacto</th>
                                <th class="border">Outro contacto</th>
                                <th class="border">Email</th>
                            </tr>
                            </thead>
                            <tbody id="client-table-body">
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
                <h6 class="card-title">Código:&nbsp;<strong id="detail-code" class="float-right">33301</strong></h6>

                <hr>
                %{--            <h6 class="card-title">Pagamento</h6>--}%
                <ul class="list-group">
                    <li class="list-group-item d-flex justify-content-between align-items-center list-group-item-megna">
                        Emprestimos
                        <span class="badge badge-pill f-w-600" id="detail-loans">14</span>
                    </li>
                    <li class="list-group-item d-flex justify-content-between align-items-center">
                        Total pedido
                        <span class="badge badge-pill f-w-600" id="detail-loans-total">14</span>
                    </li>
                    <li class="list-group-item d-flex justify-content-between align-items-center">
                        Total pago
                        <span class="badge badge-pill f-w-600" id="detail-loans-paid">2</span>
                    </li>
                    <li class="list-group-item d-flex justify-content-between align-items-center">
                        Dívida
                        <span class="badge badge-pill f-w-600" id="detail-loans-not-paid">0</span>
                    </li>
                </ul>

                <div id="div-auth" class="d-">
                    <hr>
                    <small class="text-muted">Registado por</small>
                    <h6 id="detail-createdBy">Fader</h6>
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
        $(function () {
            $('#li-clients').addClass('active');
            $('table tbody td').addClass('align-middle');

            $('#client-table').footable();

            $(".select2").select2();
            $('.select2').addClass('w-100');

            $(document).on('click', '.btn-details', function () {
                const id = $(this).attr('data-id');
                <g:remoteFunction controller="client" action="getDetails" params="{'id':id}" onSuccess="updateDetails(data)"/>
                const isOpen = $('.shw-rside').length;

                if (isOpen === 1) {
                    console.log('update');
                } else {
                    console.log('first');
                    $(".right-sidebar").slideDown(50).toggleClass("shw-rside");
                }
                $('#client-table tbody tr').removeClass('bg-light-info');
                $('#tr-'+id).addClass('bg-light-info');
            });
        });

        function updateDetails(data) {
            const client = data.client;

            $('#detail-client-name').text(client.fullName);
            $('#detail-code').text(client.code);

            // payment
            $('#detail-loans').text(data.loans);
            $('#detail-loans-total').text(formatValue(data.totalBorrowed));
            $('#detail-loans-paid').text(formatValue(data.totalPaid));
            // $('#detail-loans-not-paid').text(formatValue(data.totalBorrowed-data.totalPaid));

            $('#detail-createdBy').text(data.createdBy);
            $('#detail-updatedBy').text(data.updatedBy);
            $('#detail-dateCreated').text(formatDate(client.dateCreated));
            $('#detail-lastUpdated').text(formatDate(client.lastUpdated));
        }
    </script>
    </body>
</html>