<%@ page import="smc.Client" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <title>Registar client</title>
    </head>
    <body>

    <div class="col-12 col-sm-12 col-md-12 col-lg-8 col-xl-8">
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
                    <p class="desc">create</p>
                    <f:all bean="client"/>
                </div>

                <div class="card-footer">
                    <g:link action="index" class="btn btn-sm btn-outline-secondary waves-effect waves-light"><i
                            class="fa fa-times"></i>&nbsp;Cancelar
                    </g:link>
                    <button type="submit" class="btn btn-sm btn-outline-success float-right waves-effect waves-light">
                        <i class="fa fa-save"></i>&nbsp;Salvar
                    </button>
                </div>
            </g:form>
        </div>
    </div>

    <script>
        const input = $('#fullName');

        input.typeahead({
            hint: true,
            highlight: true,
            minLength: 1
        }, {
            name: 'clients',
            source: substringMatcher(clients)
        });

        input.focusout(function () {
            const name = $(this).val();
            if(clients.includes(name)){
                <g:remoteFunction controller="client" action="getClient" params="{'name':name}" onSuccess="updateInputs(data)"/>
            }
        });

        function updateInputs(data){
            const client = data.client;
            $('#documentNumber').val(client.documentNumber);
            $('#address').val(client.address);
        }

        const clients = [];
        <g:each in="${Client.all}">
        clients.push('${it.fullName}');
        </g:each>


        const substringMatcher = function (strs) {
            return function findMatches(q, cb) {
                let matches, substringRegex;
                matches = [];
                const substrRegex = new RegExp(q, 'i');
                $.each(strs, function (i, str) {
                    if (substrRegex.test(str)) {
                        matches.push(str);
                    }
                });
                cb(matches);
            };
        };
    </script>
    </body>
</html>
