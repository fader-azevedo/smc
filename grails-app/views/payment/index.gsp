<%@ page import="smc.Payment; smc.Client" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <title>
            Lista de payments
        </title>
    </head>
    <body>
    <script>
        function formatValue(value) {
            return value.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&.').replace(/.([^.]*)$/, ',$1')
        }
    </script>
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
                        <li class="divider mt-3"></li>

                    </ul>
                    <div class="form-group">
                        <label for="client">Cliente</label>
                        <g:select class="select2" name="client"
                                  from="${Client.all.sort{it.fullName.toUpperCase()}}" optionKey="id" optionValue="fullName"
                                  noSelection="${['':'Todos']}"
                        />
                    </div>

                    <div id="client-loans" class="d-none">
                        <h6 class="card-title">Empréstimos</h6>
                        <ul class="list-group">
                            <li class="list-group-item d-flex justify-content-between align-items-center">
                                <a class="link"><span class="f-w-800">1º</span> Empréstimo</a>
                            </li>
                            <li class="list-group-item d-flex justify-content-between align-items-center">
                                <a class="link"><span class="f-w-800">2º</span> Empréstimo</a>
                            </li>
                        </ul>
                    </div>
                </div>

                <div class="right-aside" style="min-height: 500px">
                    <div class="right-page-header">
                        <div class="row">
                            <div class="col-6">
                                <h4 class="card-title mt-2">Todos pagamentos </h4>
                            </div>

                            <div class="col-6">
                                <div class="btn-group  w-50" role="group" aria-label="Basic example">
                                    <button type="button" class="btn btn-outline-light text-danger">
                                        <i class="fa fa-file-pdf"></i>
                                    </button>
                                    <button type="button" class="btn btn-outline-light text-info"><i
                                            class="fa fa-file-word"></i></button>
                                    <button type="button" class="btn btn-outline-light text-megna"><i
                                            class="fa fa-file-excel"></i>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <hr>

                    <div class="table-responsive">
                        <table id="payment-table" class="table table-hover table-bordered no-wrap" data-paging="true" data-paging-size="6">
                            <thead>
                            <tr class="border f-w-700">
                                <th class="border">Total pago</th>
                                <th class="border px-3">Prestação</th>
                                <th class="border">Valor pago</th>
                                <th class="border">F.Pagamento</th>
                                <th class="border">Recibo</th>
                            </tr>
                            </thead>
                            <tbody>
                                <g:each in="${(List<Payment>)paymentList}" var="payment">
                                    <tr>
                                        <td class="number-format">${payment.totalPaid}</td>
                                        <% def ip = payment.getInstalmentPayments(); def ipSize = ip.size()%>
                                        <td class="px-0">
                                            <g:each in="${ip}" var="inp">
                                                <p class="my-1 py-1 px-3">${inp.instalment.type.name}</p>
                                                <hr>
                                            </g:each>
                                        </td>
                                        <td class="px-0">
                                            <g:each in="${ip}" var="inp">
                                                <p class="number-format my-2 py-1 px-3">${inp.amountPaid}</p>
                                                <hr>
                                            </g:each>
                                        </td>
                                        <td class="px-0">
                                            <g:each in="${ip}" var="inp">
                                                <p class="my-2 py-1 px-3">${inp.paymentMothod.name}</p>
                                                <hr>
                                            </g:each>
                                        </td>
                                        <td class="">
                                            <a class="link"><i class="fa fa-file-pdf text-danger">&nbsp;</i>Recibo-${payment.code.concat('.pdf')}</a>
                                        </td>
                                    </tr>
                                </g:each>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        $(function () {
            $(".select2").select2();
            $('.select2').addClass('w-100');

            $('.number-format').each(function () {
                const value = parseFloat($(this).text());
                $(this).text(formatValue(value))
            });

            // $('#payment-table tbody td > p:last-child').removeClass('border-bottom')
            $('#payment-table tbody td > hr:last-child').remove()

        })
    </script>
    </body>
</html>