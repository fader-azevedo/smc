<%@ page import="smc.District; smc.Province; smc.DocumentType; smc.Client" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <title>Registar client</title>
    </head>
    <body>

    <div class="col-12 col-12 col-md-12 col-lg-8 col-xl-8">
        <g:if test="${flash.message}">
            <div class="alert alert-success" role="status">${flash.message}</div>
        </g:if>
        <g:hasErrors bean="${this.client}">
            <div class="alert alert-danger" role="alert">
                <g:eachError bean="${this.client}" var="error">
                    <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                </g:eachError>
            </div>
        </g:hasErrors>
        <div class="card">
            <div class="card-header pb-0 pb-lg-0 bg-light">
                <h5 class="card-title"><i class="fa fa-pencil-alt"></i>&nbsp;Registar client</h5>
            </div>
            <g:form resource="${this.client}" method="POST">
                <div class="card-body">
%{--                    <f:all bean="client"/>--}%
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="fullName">Nome completo&nbsp;<span class="text-danger">*</span></label>
                                <input type="text" class="form-control  typeahead" id="fullName" name="fullName" required>
                            </div>

                            <div class="form-group">
                                <label for="birthDate">Data de Nascimento</label>
                                <input type='text' class="form-control  date" name="birthDate_" id="birthDate" required/>
                            </div>

                            <div class="form-group">
                                <label for="maritalStatus">Estado Cívil&nbsp;<span class="text-danger">*</span>
                                </label>
                                <g:select name="maritalStatus"
                                          from="${Client.constrainedProperties.maritalStatus.inList}"
                                          class="form-control "/>
                            </div>

                            <div class="form-group">
                                <label for="documentNumber">Nº do documento&nbsp;<span class="text-danger">*</span>
                                </label>
                                <input type="text" class="form-control " name="documentNumber" id="documentNumber" required>
                            </div>

                            <div class="form-group">
                                <label for="documentType">Documento&nbsp;<span class="text-danger">*</span></label>
                                <g:select name="documentType" from="${DocumentType.all.sort { it.name }}"
                                          optionValue="name" optionKey="id" class="form-control "/>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="province">Província&nbsp;<span class="text-danger">*</span></label>
                                <g:select name="province" from="${Province.all.sort { it.name }}"
                                          optionValue="name" optionKey="id" class="form-control "/>
                            </div>

                            <div class="form-group">
                                <label for="district">Distrito&nbsp;<span class="text-danger">*</span></label>
                                <g:select name="district" from="${District.all.sort { it.name }}"
                                          optionValue="name" optionKey="id" class="form-control "/>
                            </div>

                            <div class="form-group">
                                <label for="address">Endereço&nbsp;<span class="text-danger">*</span></label>
                                <input type="text" class="form-control " id="address" name="address" required>
                            </div>

                            <div class="form-group">
                                <label for="contact">Contacto&nbsp;<span class="text-danger">*</span></label>
                                <input type="text" class="form-control " id="contact" name="contact" required>
                            </div>

                            <div class="form-group">
                                <label for="email">Email&nbsp;</label>
                                <input type="text" class="form-control " id="email" name="email">
                            </div>
                        </div>

                        <div class="form-group col-12 d-none">
                            <label for="profession">Profissão&nbsp;<span class="text-danger">*</span></label>
                            <input type="text" class="form-control  typeahead" id="profession" name="profession">
                        </div>
                    </div>
                </div>

                <div class="card-footer">
                    <g:link action="index" class="btn btn btn-outline-secondary waves-effect waves-light"><i
                            class="fa fa-times"></i>&nbsp;Cancelar
                    </g:link>
                    <button type="submit" class="btn btn btn-outline-success float-right waves-effect waves-light">
                        <i class="fa fa-save"></i>&nbsp;Salvar
                    </button>
                </div>
            </g:form>
        </div>
    </div>

    <script>
        %{--const input = $('#fullName');--}%

        %{--input.typeahead({--}%
        %{--    hint: true,--}%
        %{--    highlight: true,--}%
        %{--    minLength: 1--}%
        %{--}, {--}%
        %{--    name: 'clients',--}%
        %{--    source: substringMatcher(clients)--}%
        %{--});--}%

        %{--input.focusout(function () {--}%
        %{--    const name = $(this).val();--}%
        %{--    if(clients.includes(name)){--}%
        %{--        <g:remoteFunction controller="client" action="getClient" params="{'name':name}" onSuccess="updateInputs(data)"/>--}%
        %{--    }--}%
        %{--});--}%

        %{--function updateInputs(data){--}%
        %{--    const client = data.client;--}%
        %{--    $('#documentNumber').val(client.documentNumber);--}%
        %{--    $('#address').val(client.address);--}%
        %{--}--}%

        %{--const clients = [];--}%
        %{--<g:each in="${Client.all}">--}%
        %{--clients.push('${it.fullName}');--}%
        %{--</g:each>--}%

        %{--const substringMatcher = function (strs) {--}%
        %{--    return function findMatches(q, cb) {--}%
        %{--        let matches, substringRegex;--}%
        %{--        matches = [];--}%
        %{--        const substrRegex = new RegExp(q, 'i');--}%
        %{--        $.each(strs, function (i, str) {--}%
        %{--            if (substrRegex.test(str)) {--}%
        %{--                matches.push(str);--}%
        %{--            }--}%
        %{--        });--}%
        %{--        cb(matches);--}%
        %{--    };--}%
        %{--};--}%

        const birthDate = $('#birthDate');
        birthDate.datepicker({
            language:'pt',
            autoclose: true,
            weekStart: 1,
            title: 'Data de assinatura',
        });
        birthDate.datepicker('setDate',new Date());
    </script>
    </body>
</html>
