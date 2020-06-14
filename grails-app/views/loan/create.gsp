<%@ page import="smc.GuaranteeType; org.springframework.validation.FieldError; smc.PaymentMode; smc.District; smc.Province; smc.Client; smc.DocumentType" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <title>Registar Emprestimo</title>
    </head>
    <body>
    <style>
    .select2-container--default .select2-selection--single {
        background-color: #fff;
        /*border: 1px solid #aaa;*/
        border-radius:  4px 0 0 4px
    }
    </style>
    <div class="card shadow-sm d-none">
        <label for="mdate" class="mt-3">Default Material Date Picker</label>
        <input type="text" class="form-control" placeholder="2020-06-04" id="mdate">
        <div class="card-header bg-white">
            Imagem
        </div>
        <div class="bg-light-inverse py-2" id="image" style="height: 160px">
            <asset:image src="avatar.png" class="mx-auto d-block"/>
        </div>
        <div class="d-flex justify-content-center py-2">
            <div class="d-flex justify-content-between w-25">
                <button class="btn btn-sm btn-secondary"><i class="fa fa-upload"></i></button>
                <button class="btn btn-sm btn-success"><i class="fa fa-camera"></i></button>
            </div>
        </div>
    </div>
    <div class="col-12 col-sm-12 col-md-8">
        <g:if test="${flash.message}">
            <div class="alert alert-success" role="status">${flash.message}</div>
        </g:if>
        <g:hasErrors bean="${this.loan}">
            <div class="alert alert-danger" role="alert">
                <g:eachError bean="${this.loan}" var="error">
                    <li <g:if test="${error in FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                </g:eachError>
            </div>
        </g:hasErrors>

        <div class="card card-outline-success shadow">
            <div class="card-header pb-0 pb-lg-0">
                <h5 class="card-title text-white"><i class="fa fa-pencil-alt"></i>&nbsp;Registar Empréstimo</h5>
            </div>

            <g:form resource="${this.loan}" method="POST" class="wizard" autocomplete="off">
                <div class="card-body" id="div-form-loan">
                    <div class="wizard-steps bg-white mb-lg-4 mb-4">
                        <div class="wizard-progress mt-1">
                            <div class="wizard-progress-line" data-now-value="50" data-number-of-steps="2"></div>
                        </div>

                        <div class="wizard-step active col-12 col-sm-6">
                            <div class="wizard-step-icon d-block mx-auto pt-1"><i class="mdi mdi-credit-card-plus"></i></div>
                            <p class="text-nowrap ">Dados do Emprestimo</p>
                        </div>

                        <div class="wizard-step col-12 col-sm-6">
                            <div class="wizard-step-icon d-block mx-auto pt-1">
                                <i class="mdi mdi-folder-account"></i>
                            </div>
                            <p class="text-nowrap">Garantias & Testemunhas</p>
                        </div>
                    </div>

                    <fieldset>
                        <div class="row">
                            <g:hiddenField name="code"/>
                            <div class="col-12 col-sm-12 col-lg-12">
                                <div class="form-group ">
                                    <label for="client">Cliente</label>
                                    <div class="d-flex">
                                        <g:select class="select2" name="client"
                                              from="${Client.all.sort{it.fullName.toUpperCase()}}" optionKey="id" optionValue="fullName"
                                            noSelection="${['':'Selecione']}"
                                        />
                                        <button class="btn btn-light btn-appended waves-effect waves-button-input text-nowrap"
                                                type="button" data-target="#client-modal" data-toggle="modal">&nbsp;Novo
                                        </button>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="form-group col-lg-6 pr-lg-2">
                                        <label for="borrowedAmount" class="text-nowrap">Valor a emprestar</label>
                                        <input type="text" id="borrowedAmount" name="borrowedAmount" class="form-control input-number">
                                    </div>
                                    <div class="form-group col-lg-6 pl-lg-2" id="form-group-interestRate">
                                        <label for="interestRate" class="text-nowrap">Taxa de juros</label>
                                        <input type="text" id="interestRate" name="interestRate"
                                               class="form-control input-number touchSpin"
                                               data-bts-button-down-class="btn btn-light btn-appended"
                                               data-bts-button-up-class="btn btn-light btn-appended"
                                               value="30"
                                        />
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="form-group col-lg-6 pr-lg-2">
                                        <label for="paymentMode">Modo de pagamento</label>
                                        <select name="paymentMode" id="paymentMode" class="form-control">
                                            <option value="">Selecione</option>
                                            <g:each in="${PaymentMode.all.sort{it.id}}">
                                                <option value="${it.id}">${it.name}</option>
                                            </g:each>
                                        </select>
                                    </div>
                                    <div class="form-group col-lg-6 pl-lg-2">
                                        <label for="instalmentsNumber">Nº de prestações</label>
                                        <input type="text" id="instalmentsNumber" name="instalmentsNumber" class="form-control input-number touchSpin"
                                               data-bts-button-down-class="btn btn-light btn-appended"
                                               data-bts-button-up-class="btn btn-light btn-appended"
                                               value="1"
                                        />
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="form-group col-lg-6 pr-lg-2">
                                        <label for="amountPerInstalmentInput">Valor por prestação</label>
                                        <div class="input-group">
                                            <input value="0" readonly type="text" class="form-control text-dark" id="amountPerInstalmentInput">
                                            <input type="hidden" id="amountPerInstalment" name="amountPerInstalment">
                                            <div class="input-group-append">
                                                <span class="input-group-text">MT</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group col-lg-6 pl-lg-2">
                                        <label for="amountPayableInput">Total a pagar</label>
                                        <div class="input-group">
                                            <input value="0" readonly type="text" class="form-control text-dark" id="amountPayableInput">
                                            <input readonly type="hidden" id="amountPayable" name="amountPayable">
                                            <div class="input-group-append">
                                                <span class="input-group-text">MT</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="form-group col-lg-4 pr-lg-2">
                                        <label for="payDate">Data de pagamento</label>
                                        <input type='text' class="form-control date" name="payDate_" id="payDate"/>
                                    </div>

                                    <div class="form-group col-lg-4 pl-lg-2">
                                        <label for="dueDate">Prazo de pagamento</label>
                                        <input type='text' class="form-control date" name="dueDate_" id="dueDate"/>
                                    </div>

                                    <div class="form-group col-lg-4 pl-lg-2">
                                        <label for="signatureDate">Data de assinatura</label>
                                        <input type='text' class="form-control date" name="signatureDate_" id="signatureDate"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <button type="button" class="btn btn-sm btn-outline-secondary btn-next float-right waves-effect waves-light">
                            Próximo&nbsp;<i class="mdi mdi-arrow-right"></i>
                        </button>
                    </fieldset>
                    <fieldset>
                        <div class="accordion mb-3" id="accordion">
                            <div class="card mb-2">
                                <div class="card-header bg-white" id="headingGuarantee">
                                    <button  data-toggle="collapse" data-target="#collapseGuarantee" type="button"
                                             class="btn btn-link text-muted bg-light">
                                        <i class="mdi mdi-television-guide text-red"></i>
                                        <strong> Garantias</strong>
                                    </button>

                                    <div class="float-right mt-2 p-0">
                                        <input type="checkbox" id="guarantee-check" name="guarantee_check" class="filled-in m-0" checked/>
                                        <label for="guarantee-check" class="m-0">Registar garantias</label>
                                    </div>
                                </div>
                                <hr class="mt-0 pt-0 mb-0">
                                <div id="collapseGuarantee" class="collapse show" aria-labelledby="headingGuarantee" data-parent="#accordion">
                                    <div class="card-body pb-0">
                                        <datalist id="guaranteeTypeList">
                                            <g:each in="${GuaranteeType.all}">
                                                <option value="${it.name}"></option>
                                            </g:each>
                                        </datalist>
                                        <div class="row" id="div-form-guarantee">
                                            <div class="col-12 col-sm-12 col-md-12 col-lg-6" id="dynamic-form-guarantee">
                                                <div class="form-group">
                                                    <input list="guaranteeTypeList" required="required" placeholder="Tipo de garantia" name="guaranteeType" id="guaranteeType" type="text"  class="form-control form-control-sm mb-2 guaranteeType">
                                                    <div class="input-group">
                                                        <div class="input-group-prepend">
                                                            <span class="input-group-text bg-white w-100 p-0">
                                                                <div class="container-image py-1 px-1 mt-0">
                                                                    <asset:image src="guarantee.jpg"/>
                                                                    <label class="btn btn-xs btn-success" type="button"><i class="fa fa-upload"></i></label>
                                                                </div>
                                                            </span>
                                                        </div>
                                                        <textarea required="required" placeholder="descrição" class="form-control text-dark f-s-12" id="description" name="description"></textarea>

                                                        <div class="input-append">
                                                            <span class="input-group-text none-border h-100 d-flex flex-column justify-content-between" style="border-radius: 0 3px 3px 0; border-left: none">
                                                                <a href="javascript:void(0)" class="btn btn-primary btn-xs waves-effect waves-purple btn-plus-guarantee" id="plus-guarantee"><i class="fa fa-plus"></i></a>
                                                                <a href="javascript:void(0)" class="btn btn-danger btn-xs waves-effect waves-red btn-minus-guarantee" id="minus-guarantee"><i class="fa fa-minus"></i></a>
                                                            </span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="card">
                                <div class="card-header bg-white" id="headingWitness">
                                    <button data-toggle="collapse" data-target="#collapseWitness" type="button"
                                             class="btn btn-link text-muted bg-light" >
                                        <i class="mdi mdi-account-multiple text-red"></i>
                                        <strong> Testemunhas</strong>
                                    </button>

                                    <div class="float-right mt-2 p-0">
                                        <input type="checkbox" id="witness-check" class="filled-in m-0" checked />
                                        <label for="witness-check" class="m-0">Registar testemunhas</label>
                                    </div>
                                </div>
                                <div id="collapseWitness" class="collapse" aria-labelledby="headingWitness" data-parent="#accordion">
                                    <div class="card-body px-0 pt-0" id="div-form-witness">
                                        <div class="row line py-2 px-3" id="dynamic-form-witness">
                                            <div class="col-12 col-sm-4 pr-lg-0 form-group-sm">
                                                <input type="text" class="form-control form-control-sm" name="witnessName" placeholder="Nome">
                                            </div>
                                            <div class="col-12 col-sm-3 pr-lg-0 form-group-sm">
                                                <input type="text" class="form-control form-control-sm" name="witnessAddress" placeholder="Endereço">
                                            </div>
                                            <div class="col-12 col-sm-3 pr-lg-0 form-group-sm">
                                                <input type="text" class="form-control form-control-sm" name="witnessContact" placeholder="Contacto">
                                            </div>
                                            <div class="col-sm-2 form-group-sm d-flex justify-content-between">
                                                <a href="javascript:void(0)" class="btn btn-primary btn-sm waves-effect waves-purple" id="plus-witness"><i class="fa fa-plus"></i></a>
                                                <a href="javascript:void(0)" class="btn btn-danger btn-sm waves-effect waves-red" id="minus-witness"><i class="fa fa-minus"></i></a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <button type="button" class="btn btn-sm btn-outline-secondary btn-previous">
                            <i class="mdi mdi-arrow-left"></i>&nbsp;Anterior
                        </button>
                        <button type="submit" class="btn btn-sm btn-outline-success float-right waves-effect waves-light">
                            <i class="fa fa-save"></i>&nbsp;Salvar
                        </button>
                    </fieldset>
                </div>
            </g:form>
        </div>
    </div>

    <div id="client-modal" class="modal fade" tabindex="-1" role="dialog"
         aria-labelledby="client-modalLabel" aria-hidden="true" data-backdrop="static">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header pb-2 pt-2">
                    <h5 class="modal-title" id="client-modalLabel"><i class="mdi mdi-account-edit"></i>&nbsp;Registar cliente</h5>
                    <button type="button" class="close" data-dismiss="modal"
                            aria-hidden="true">×</button>
                </div>

                <form action="" id="client-form">
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group-sm">
                                    <label for="fullName">Nome completo&nbsp;<span class="text-danger">*</span></label>
                                    <input type="text" class="form-control form-control-sm typeahead" id="fullName">
                                </div>

                                <div class="form-group-sm">
                                    <label for="birthDate">Data de Nascimento</label>
                                    <input type='text' class="form-control form-control-sm date" name="birthDate" id="birthDate"/>
                                </div>

                                <div class="form-group-sm">
                                    <label for="maritalStatus">Estado Cívil&nbsp;<span class="text-danger">*</span>
                                    </label>
                                    <g:select name="maritalStatus"
                                              from="${Client.constrainedProperties.maritalStatus.inList}"
                                              class="form-control form-control-sm"/>
                                </div>

                                <div class="form-group-sm">
                                    <label for="documentNumber">Nº do documento&nbsp;<span class="text-danger">*</span>
                                    </label>
                                    <input type="text" class="form-control form-control-sm" name="documentNumber" id="documentNumber" required value=";sad">
                                </div>

                                <div class="form-group-sm">
                                    <label for="documentType">Documento&nbsp;<span class="text-danger">*</span></label>
                                    <g:select name="documentType" from="${DocumentType.all.sort { it.name }}"
                                              optionValue="name" optionKey="id" class="form-control form-control-sm"/>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="form-group-sm">
                                    <label for="province">Província&nbsp;<span class="text-danger">*</span></label>
                                    <g:select name="province" from="${Province.all.sort { it.name }}"
                                              optionValue="name" optionKey="id" class="form-control form-control-sm"/>
                                </div>

                                <div class="form-group-sm">
                                    <label for="district">Distrito&nbsp;<span class="text-danger">*</span></label>
                                    <g:select name="district" from="${District.all.sort { it.name }}"
                                              optionValue="name" optionKey="id" class="form-control form-control-sm"/>
                                </div>

                                <div class="form-group-sm">
                                    <label for="address">Endereço&nbsp;<span class="text-danger">*</span></label>
                                    <input type="text" class="form-control form-control-sm" id="address" name="address" required value="sad">
                                </div>

                                <div class="form-group-sm">
                                    <label for="contact">Contacto&nbsp;<span class="text-danger">*</span></label>
                                    <input type="text" class="form-control form-control-sm" id="contact" name="contact" required value="sadsa">
                                </div>

                                <div class="form-group-sm">
                                    <label for="email">Email&nbsp;<span class="text-danger">*</span></label>
                                    <input type="text" class="form-control form-control-sm" id="email" name="email" value="sadsad">
                                </div>
                            </div>

                            <div class="form-group-sm col-12">
                                <label for="profession">Profissão&nbsp;<span class="text-danger">*</span></label>
                                <input type="text" class="form-control form-control-sm typeahead" id="profession" name="profession">
                            </div>
                        </div>

                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-light"
                                data-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-primary">Save changes</button>
                    </div>
                </form>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->
    
    <script>
        function calculateAmount(){
            const borrowedAmount = parseFloat($('#borrowedAmount').val());
            const interestRate = parseInt($('#interestRate').val()) / 100;
            const instalmentsNumber = parseInt($('#instalmentsNumber').val());
            const amountPerInstalmentINPUT = $('#amountPerInstalmentInput');
            const amountPerInstalmentHidden = $('#amountPerInstalment');
            const amountPayableINPUT = $('#amountPayableInput');
            const amountPayableHidden = $('#amountPayable');
            const paymentMode = $('#paymentMode').val();

            if(borrowedAmount && interestRate && instalmentsNumber && paymentMode){
                const amountPayable = borrowedAmount + borrowedAmount * interestRate;
                amountPayableINPUT.val(formatValue(amountPayable));
                amountPayableHidden.val(amountPayable);

                const amountPerInstalment = amountPayable / instalmentsNumber;
                amountPerInstalmentINPUT.val(formatValue(amountPerInstalment));
                amountPerInstalmentHidden.val(amountPerInstalment.toFixed(2));
                returnDueDate()
            }else{
                amountPayableINPUT.val(0);
                amountPayableHidden.val(0);
                amountPerInstalmentINPUT.val(0);
                amountPerInstalmentHidden.val(0);
            }
        }

        function returnDueDate() {
            if($('#paymentMode').val() && $('#payDate').val()) {
                const paymentMode = $('#paymentMode option:selected').text().trim().toLowerCase();
                const instalmentsNumber = parseInt($('#instalmentsNumber').val());

                const splitDate = $('#payDate').val().split('/');
                const dueDate = new Date(splitDate[1] + '/' + splitDate[0] + '/' + splitDate[2]);

                if (paymentMode === 'diaria') {
                    dueDate.setDate(dueDate.getDate() + instalmentsNumber - 1);
                } else if (paymentMode === 'semanal') {
                    dueDate.setDate(dueDate.getDate() + 7 * instalmentsNumber);
                } else if (paymentMode === 'quinzenal') {
                    dueDate.setDate(dueDate.getDate() + 15 * instalmentsNumber);
                } else if (paymentMode === 'mensal') {
                    dueDate.setMonth(dueDate.getMonth() + instalmentsNumber);
                }

                if (paymentMode !== 'mensal') {
                    dueDate.setMonth(dueDate.getMonth() + 1)
                }

                const newDueDate = dueDate.getDate() + '/' + dueDate.getMonth() + '/' + dueDate.getFullYear();

                $('#dueDate').datepicker('update',newDueDate)
            }
        }

        function formatValue(value){
            return value.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&.').replace(/.([^.]*)$/, ',$1')
        }

        function resizeInputs(){
            $('#div-form-loan label').addClass('f-s-12');
            $('#div-form-loan input,select').addClass('form-control-sm');
            $('#div-form-loan .form-group').addClass('form-group-sm mb-3');
            $('#div-form-loan .input-group').addClass('input-group-sm');
        }

        $(document).ready(function () {

            $('#li-loan').addClass('active');
            $('#li-loan .create').addClass('active');


            $(".select2").select2();
            $('.select2').addClass('w-100');

            $('#client-form label').addClass('mb-0 f-s-11');
            $('#client-form .form-group-sm').addClass('mb-3');

            $('#interestRate').TouchSpin({
                verticalbuttons: true,
                min: 1,
                postfix: '%'
            });

            $('#instalmentsNumber').TouchSpin({
                verticalbuttons: true,
                min: 1,
            });

            $('.touchSpin, #paymentMode').on("change", function() {
                calculateAmount()
            });

            const payDate = $('#payDate');
            payDate.datepicker({
                language:'pt',
                autoclose: true,
                weekStart: 1,
                title: 'Data de pagamento',
            });


            payDate.datepicker().on('changeDate',function () {
                returnDueDate();
            });

            $('#dueDate').datepicker({
                language:'pt',
                autoclose: true,
                weekStart: 1,
                title: 'Prazo de pagamento',
            });

            const signatureDate = $('#signatureDate');
            signatureDate.datepicker({
                language:'pt',
                autoclose: true,
                weekStart: 1,
                title: 'Data de assinatura',
            });
           signatureDate.datepicker('setDate',new Date());

            $("#dynamic-form-guarantee").dynamicForm("#dynamic-form-guarantee", "#plus-guarantee", "#minus-guarantee", {
                limit: 3,
                formPrefix: "dynamic-form-guarantee",
                normalizeFullForm: false
            });

            $("#dynamic-form-witness").dynamicForm("#dynamic-form-witness", "#plus-witness", "#minus-witness", {
                limit: 3,
                formPrefix: "dynamic-form-witness",
                normalizeFullForm: false
            });

            // resizeInputs()

            const guaranteeCheck = $('#guarantee-check');
            guaranteeCheck.on('change',function () {
                $(this).val($(this).prop("checked"));
                if($(this).prop("checked")){
                    $('input[name="guaranteeType"]').each(function () {
                        $(this).attr('required', true).prop('readonly',false).val('');
                    });
                    $('textarea[name="description"]').each(function () {
                        $(this).attr('required',  true).prop('readonly',false);
                    });
                    $('.btn-plus-guarantee').removeClass('disabled')
                }else {
                    $('input[name="guaranteeType"]').each(function () {
                        $(this).attr('required', false).prop('readonly', true).val('');
                    });
                    $('textarea[name="description"]').each(function () {
                        $(this).attr('required',  false).prop('readonly',  true);
                    });
                    $('.btn-plus-guarantee').addClass('disabled');
                    $('.btn-minus-guarantee').trigger('click') //remove all(except first) guarantee cards
                }
            });
            guaranteeCheck.trigger('change');
        });

        $('.input-number').each(function () {
            const id = $(this).attr('id');
            setInputFilter(document.getElementById(id), function(value) {
                return /^\d*\.?\d*$/.test(value);
            });
        });

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
                        calculateAmount()
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
    </body>
</html>
