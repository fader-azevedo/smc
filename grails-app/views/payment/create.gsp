<%@ page import="java.text.DecimalFormat; org.springframework.validation.FieldError; smc.Instalment; smc.Loan" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Pagamento</title>
</head>

<body>
<g:set var="loanID" value="${params.loanID}"/>

<g:if test="${loanID && !Loan.get(loanID as Serializable).status.equalsIgnoreCase('fechado')}">
    <div class="col-12">
        <g:if test="${flash.message}">
            <div class="alert alert-success" role="status">${flash.message}</div>
        </g:if>
        <g:hasErrors bean="${this.payment}">
            <div class="alert alert-danger" role="alert">
                <g:eachError bean="${this.payment}" var="error">
                    <li <g:if test="${error in FieldError}">data-field-id="${error.field}"</g:if>><g:message
                            error="${error}"/></li>
                </g:eachError>
            </div>
        </g:hasErrors>

        <% def loan = Loan.get(new Long(loanID as String))
        def client = loan.client
        def installments = Instalment.findAllByStatusAndLoan('pendente', loan)
        %>

        <div class="row">
            <div class="col-12 col-md-4">
                <div class="card">
                    <div class="card-body row">
                        <div class="col-lg-12 col-md-12">
                            <div class="w-100 d-flex">
                                <div class="d-flex flex-column justify-content-center">
                                    <i class="fa fa-user fa-3x"></i>
                                </div>

                                <div class="pt-2">
                                    %{--                                    <br>--}%
                                    <p class="text-muted pl-2 pt-3 mb-0" id="detail-client-name">name</p>
                                </div>
                            </div>
                            <hr>

                            <h6 class="card-title">Empréstimo</h6>
                            <ul class="list-group">
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    Valor pedido
                                    <span class="badge badge-pill" id="detail-borrowedAmount">${loan.borrowedAmount}
                                    </span>
                                </li>
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    Valor a pagar
                                    <span class="badge badge-pill"
                                          id="detail-amountPayable">${loan.amountPayable}</span>
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
                                    <span class="" id="detail-installment-all"></span>

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
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-12 col-md-8">
                <div class="card">
                    <div class="card-body">
                        <g:if test="${installments.size() > 0}">
                            <div class="row">
                                <div class="col-12 col-md-7 pt-md-3 pt-sm-0">
                                    <h5 class="card-title"><i class="fa fa-list"></i>&nbsp;Pestações a pagar</h5>
                                </div>

                                <div class="col-12 col-md-5">
                                    <div class="input-group">
                                        <input type="text" class="form-control bg-white" id="input-value-to"
                                               placeholder="introduza o valor">

                                        <div class="input-group-append">
                                            <span class="input-group-text">Mt</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <hr>

                            <div class="month-table">
                                <div class="table-responsive mt-3">
                                    <table class="table stylish-table mb-0">
                                        <thead>
                                        <tr>
                                            <th>Tipo</th>
                                            <th>Prazo</th>
                                            <th>Valor</th>
                                            <th class="pb-1">
                                                <input type="checkbox" id="check-all" class="filled-in"/>
                                                <label for="check-all" class="mb-0">Todas</label>
                                            </th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <g:each in="${installments}" var="it" status="i">
                                            <tr id="tr-${i}" class="tr text-nowrap" data-id="${it.id}">
                                                <td>${it.type}</td>
                                                <td><g:formatDate format="dd/MM/yyyy" date="${it.dueDate}"/></td>
                                                <% def installmentDebit = new DecimalFormat('#.00').format(include(controller: 'loan', action: 'getInstallDebit', params: [id: it.id]) as double) %>

                                                <td class="number-format">${installmentDebit}</td>
                                                <input type="hidden" class="current" data-id="${it.id}"
                                                       id="line-value-${it.id}"
                                                       value="${installmentDebit}">
                                                <td>
                                                    <input type="checkbox" id="check-${it.id}"
                                                           class="filled-in input-check"
                                                           data-id="${it.id}"/>
                                                    <label for="check-${it.id}" class="mb-0"></label>
                                                </td>
                                            </tr>
                                        </g:each>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <hr>

                            <button id="btn-save" class="btn btn-megna waves-effect waves-green float-right"
                                    type="button">
                                <i class="fa fa-save">&nbsp;</i>Salvar</button>
                        </g:if>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>

        const loanId = ${loan.id}

            $(document).ready(function () {
                save();

                $('#li-payment').addClass('active');

                $('.number-format').each(function () {
                    const value = parseFloat($(this).text());
                    $(this).text(formatValue(value))
                });

                calculateByCheck();
                // calculateInstalments();
                %{--const amountPayable = parseFloat(${loan.amountPayable});--}%

                setInputFilter(document.getElementById('input-value-to'), function (value) {
                    // return /^\d*\.?\d*$/.test(value) && (value === "" || parseFloat(value) <= amountPayable);
                    return /^\d*\.?\d*$/.test(value);
                });

                <g:remoteFunction controller="loan" action="getDetails" params="{'id':loanId}" onSuccess="updateDetails(data)"/>
            });

        let change = 0;
        let installParceledID = 0;

        function calculateInstalments() {
            change = 0;
            installParceledID = 0;
            let value = parseFloat($('#input-value-to').val());
            $('.current').each(function () {
                let currentValue = parseFloat($(this).val()).toFixed(2);
                const id = $(this).attr('data-id');

                if (value >= currentValue) {
                    $('#check-' + id).prop('checked', true);
                    value -= currentValue;
                    change = value;
                } else {
                    $('#check-' + id).prop('checked', false);
                }
            });
            const i = $('.input-check:checked').length; //input checked
            $('.change').remove();
            const lineParceled = $('#tr-' + i);
            installParceledID = lineParceled.attr('data-id');

            if (change > 0) {
                // const lineParceled = $('#tr-'+i);
                lineParceled.before('<tr class="change bg-light f-w-700"><td>Parcela</td><td>--------------</td>' +
                    '<td><span>' + formatValue(change) + '</span></td>' +
                    '<td><label class="f-s-21"><i class="fa fa-check-square"></i></label></td></tr>')
            } else if (value) {
                change = value; //i use changeValue when save payments
                lineParceled.before('<tr class="change bg-light f-w-700"><td>Parcela</td><td>--------------</td>' +
                    '<td><span>' + formatValue(value) + '</span></td>' +
                    '<td><label class="f-s-21"><i class="fa fa-check-square"></i></label></td></tr>')
            }
        }

        function calculateByCheck() {
            $('#check-all').on('change', function () {
                $("input:checkbox").prop('checked', $(this).prop("checked"));
                $('.input-check').trigger('change')
            });

            const checks = $('.input-check');

            checks.on('change', function () {
                let total = 0;
                const checksChecked = $('.input-check:checked');

                checksChecked.each(function () {
                    const id = $(this).attr('data-id');
                    const value = parseFloat($('#line-value-' + id).val());
                    total += value;
                });

                $('.change').remove();
                change = 0;
                installParceledID = 0;

                if (total !== 0) {
                    $('#input-value-to').val(total)
                } else {
                    $('#input-value-to').val('');
                }

                if (!$(this).prop("checked")) {
                    $('#check-all').prop('checked', false)
                }
                if ($('.input-check:not(:checked)').length === 0) {
                    $('#check-all').prop('checked', true)
                }
            });
        }

        function setInputFilter(textbox, inputFilter) {
            ["input", "change", "keydown", "keyup", "mousedown", "mouseup", "select", "contextmenu", "drop"].forEach(function (event) {
                textbox.addEventListener(event, function () {
                    if (inputFilter(this.value)) {
                        if (this.value === '.') {
                            this.value = '';
                            return false
                        }
                        this.oldValue = this.value;
                        this.oldSelectionStart = this.selectionStart;
                        this.oldSelectionEnd = this.selectionEnd;
                        calculateInstalments()
                    } else if (this.hasOwnProperty("oldValue")) {
                        this.value = this.oldValue;
                        this.setSelectionRange(this.oldSelectionStart, this.oldSelectionEnd);
                    } else {
                        this.value = "";
                    }
                });
            });
        }

        function updateDetails(data) {
            const loan = data.loan;
            const client = data.client;

            $('#detail-client-name').text(client.fullName);
            $('#detail-installment-all').text(data.instAll);
            $('#detail-installment-payed').text(data.instPayed);
            $('#detail-installment-pend').text(data.instPend);
            // payment
            $('#detail-installment-type').text(data.instalmentType);
            $('#detail-borrowedAmount').text(formatValue(loan.borrowedAmount));
            $('#detail-amountPayable').text(formatValue(loan.amountPayable));
            $('#detail-amountPaid').text(formatValue(data.valuePaid));
            $('#detail-debit').text(formatValue(data.debit))
        }

        let instalments = [];

        function save() {
            $('#btn-save').on('click', function () {
                if (!$('#input-value-to').val()) {
                    swal({
                        type: "info",
                        title: "",
                        text: "Seleciona a prestação a pagar!",
                        confirmButtonText: "Fechar",
                        confirmButtonColor: '#858585'
                    });
                } else {
                    instalments = [];
                    const totalPaid = $('#input-value-to').val();

                    $('.input-check:checked').each(function () {
                        const id = $(this).attr('data-id');
                        const value = parseFloat($('#line-value-' + id).val());

                        const line = {'id': id, 'value': value, 'part': false};
                        instalments.push(line)
                    });
                    if (change !== 0) {
                        const line = {'id': installParceledID, 'value': change, 'part': true};
                        instalments.push(line);
                    }
                    instalments = JSON.stringify(instalments);

                    Swal.fire({
                        title: "",
                        text: "Pretendes salvar o pagamento?",
                        type: "question",
                        showCancelButton: true,
                        confirmButtonColor: "#00a897",
                        confirmButtonText: "Sim",
                        cancelButtonText: 'Não',
                        showLoaderOnConfirm: true,
                        preConfirm: () => {
                            const url = '/payment/save?loan='+loanId+'&instalments='+encodeURI(instalments)+'&totalPaid='+totalPaid+'';
                            return fetch(url,{
                                method: 'POST',
                                headers: {
                                    'Content-Type': 'application/json;charset=utf-8'
                                }
                            }).then(response => {
                                if (!response.ok) {
                                    throw new Error(response.statusText)
                                }
                                return response.json()
                            }).catch(error => {
                                Swal.fire({
                                    title: 'error',
                                })
                            })
                        },
                        allowOutsideClick: () => !Swal.isLoading(),
                    }).then((result) => {
                        if (result.value) {
                            Swal.fire({
                                title:'',
                                text:'Pagamento salvo com sucesso',
                                type:'success'
                            }).then(function () {
                                const id = result.value.payment;
                                <g:remoteFunction controller="payment" action="getReceipt" params="{'id':id}" onSuccess="openReceipt()"/>
                            })
                        }
                    });
                }
            })
        }

        function openReceipt() {
            window.open('<g:createLink controller="payment" action="receipt"/>', '_blank');
        }
    </script>
</g:if>
<g:else>
    <script>
        window.location = '<g:createLink controller="loan" action="index"/>'
    </script>
</g:else>
%{--<g:remoteFunction action="save" params="{'loan':loanId,'instalments':instalments,'totalPaid':totalPaid}"/>--}%
</body>
</html>
