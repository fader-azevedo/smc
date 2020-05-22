<%@ page import="smc.Instalment; smc.Loan" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Registar payment</title>
</head>

<body>

<g:if test="${params.loanID}">

    <div class="col-12 col-sm-12 col-md-12 col-lg-9">
        <g:if test="${flash.message}">
            <div class="alert alert-success" role="status">${flash.message}</div>
        </g:if>
        <g:hasErrors bean="${this.payment}">
            <div class="alert alert-danger" role="alert">
                <g:eachError bean="${this.payment}" var="error">
                    <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message
                            error="${error}"/></li>
                </g:eachError>
            </div>
        </g:hasErrors>

        <% def loan = Loan.get(new Long(params.loanID))
        def client = loan.client
        def installments = Instalment.findAllByStatusAndLoan('pendente', loan)
        %>

        <div class="card">
            <div class="card-body">
                <div class="row">
                    <div class="col-md-4 d-flex">
                        <div class="d-flex flex-column justify-content-center">
                            <i class="fa fa-user fa-3x"></i>
                        </div>

                        <div class="pt-2">
                            <br>

                            <p class="text-muted pl-2">${client.fullName}</p>
                        </div>
                    </div>

                    <div class="col-md-8 border-left py-0 pl-0">
                        <p class="pl-3 pt-2 pb-2 my-0 text-muted text-nowrap border-bottom"><i
                                class="fa fa-phone f-w-800"></i>&nbsp;${client.contact}</p>

                        <p class="pl-3 my-0 pt-3 text-muted text-nowrap"><i
                                class="fa fa-at f-w-800"></i>&nbsp;${client.email}</p>
                    </div>
                </div>
                <hr>

                <div class="row">
                    <div class="col-md-3 col-xs-6 border-right"><strong>Valor pedido</strong>
                        <br>

                        <p class="text-muted number-format">${loan.borrowedAmount}</p>
                    </div>

                    <div class="col-md-3 col-xs-6 border-right"><strong>Taxa de juros</strong>
                        <br>

                        <p class="text-muted number-format">${loan.interestRate}</p>
                    </div>

                    <div class="col-md-3 col-xs-6 border-right"><strong>Valor a pagar</strong>
                        <br>

                        <p class="text-muted number-format">${loan.amountPayable}</p>
                        <input type="hidden" id="loan-amountPayable" value="${loan.amountPayable}">
                    </div>

                    <div class="col-md-3 col-xs-6"><strong>D. empréstimo</strong>
                        <br>

                        <p class="text-muted"><g:formatDate format="dd/MM/yyyy" date="${loan.signatureDate}"/></p>
                    </div>
                </div>
                <hr>
                <g:if test="${installments.size() > 0}">
                    <div class="row">
                        <div class="col-6 pt-3">
                            <h5 class="card-title"><i class="fa fa-list"></i>&nbsp;Pestações</h5>
                        </div>

                        <div class="col-6">
                            <div class="input-icons pt-1 pr-0">
                                <i class="fa fa-money-bill-alt"></i>
                                <input id="input-value-to" class="form-control input-super-entities pl-5 pl-sm-5"
                                       type="text" placeholder="introduza o valor a pagar">
                            </div>
                        </div>
                    </div>
                    <hr>

                    <div class="month-table">
                        <div class="table-responsive mt-3">
                            <table class="table stylish-table mb-0">
                                <thead>
                                <tr>
                                    <th>#</th>
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
                                    <tr id="tr-${i}" class="tr">
                                        <td>${i + 1}</td>
                                        <td>${it.type.name}</td>
                                        <td><g:formatDate format="dd/MM/yyyy" date="${it.dueDate}"/></td>
                                        <td class="number-format">${it.amountPayable}</td>
                                        <input type="hidden" class="current" data-id="${i}" id="line-value-${i}"
                                               value="${it.amountPayable}">
                                        <td>
                                            <input type="checkbox" id="check-${i}" class="filled-in input-check"
                                                   data-id="${i}"/>
                                            <label for="check-${i}" class="mb-0"></label>
                                        </td>
                                    </tr>
                                </g:each>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <hr>

                    <div class="row">
                        <div class="col-lg-12">
                            <div class="input-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text">Valor a pagar</span>
                                </div>
                                <input type="text" class="form-control" id="total" readonly>
                                %{--                            <input type="hidden" class="form-control" id="totalHidden" readonly>--}%
                                <div class="input-group-append">
                                    <button class="btn btn-success" type="button"><i
                                            class="fa fa-money-bill-alt">&nbsp;</i>Pagar</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </g:if>
            </div>
        </div>
    </div>

    <script>
        $(document).ready(function () {

            $('#li-payment').addClass('active');

            $('.number-format').each(function () {
                const value = parseFloat($(this).text());
                $(this).text(formatValue(value))
            });

            calculateByCheck();
            calculateInstalments();
            const amountPayable = parseFloat($('#loan-amountPayable').val());

            setInputFilter(document.getElementById('input-value-to'), function(value) {
                return /^\d*\.?\d*$/.test(value);
            });
        });


        function calculateInstalments() {
            let cuu = parseFloat($('#input-value-to').val());
            let value = parseFloat($('#input-value-to').val());
            let change = 0;
            $('.current').each(function () {
                let currentValue = parseFloat($(this).val()).toFixed(2);
                const id = $(this).attr('data-id');

                if (value >= currentValue) {
                    $('#check-' + id).prop('checked', true).trigger('change');
                    value -= currentValue;
                    change = value;
                } else {
                    $('#check-' + id).prop('checked', false).trigger('change');
                }
            });
            const i = $('.input-check:checked').length;
            if (change > 0) {
                $('#tr-' + i).addClass('bg-light');
                const newTotal = parseFloat($('#total').val()) + change;
                console.log('new total: ' + newTotal + ' change: ' + change+' value: '+cuu);
            } else if (change === 0) {
                $('.tr').removeClass('bg-light');
                if(value > 0){
                    $('#tr-' + 0).addClass('bg-info');
                }
            }
        }


        function calculateByCheck() {
            $('#check-all').on('change', function () {
                $("input:checkbox").prop('checked', $(this).prop("checked"));
                $('.input-check').trigger('change')
            });

            $('.input-check').on('change', function () {
                let total = 0;

                $('.input-check:checked').each(function () {
                    const id = $(this).attr('data-id');
                    const value = parseFloat($('#line-value-' + id).val());
                    total += value;
                });

                $('#total').val(total);

                if (!$(this).prop("checked")) {
                    $('#check-all').prop('checked', false)
                }
                if ($('.input-check:not(:checked)').length === 0) {
                    $('#check-all').prop('checked', true)
                }
            });
        }

        function formatValue(value) {
            return value.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&.').replace(/.([^.]*)$/, ',$1')
        }

        function setInputFilter(textbox, inputFilter) {
            ["input","change", "keydown", "keyup", "mousedown", "mouseup", "select", "contextmenu", "drop"].forEach(function(event) {
                textbox.addEventListener(event, function() {
                    if (inputFilter(this.value)) {
                        if(this.value === '.'){
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
    </script>
</g:if>
<g:else>
    <script>
        window.location = '<g:createLink action="index"/>'
    </script>
</g:else>
</body>
</html>
