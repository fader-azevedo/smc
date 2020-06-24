<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <title>Registar instalment</title>
    </head>
    <body>

    <div class="col-12 col-sm-12 col-md-12 col-lg-8 col-xl-8">
        <g:if test="${flash.message}">
            <div class="alert alert-success" role="status">${flash.message}</div>
        </g:if>
        <g:hasErrors bean="${this.instalment}">
            <div class="alert alert-danger" role="alert">
                <g:eachError bean="${this.instalment}" var="error">
                    <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                </g:eachError>
            </div>
        </g:hasErrors>
        <div class="card">
            <div class="card-header pb-0 pb-lg-0">
                <h5 class="card-title text-white"><i class="fa fa-pencil-alt"></i>&nbsp;Registar instalment</h5>
            </div>
%{--            <g:form resource="${this.instalment}" method="POST">--}%
%{--                <div class="card-body">--}%
%{--                    <p class="desc">create</p>--}%
%{--                    <f:all bean="instalment"/>--}%
%{--                </div>--}%

%{--                <div class="card-footer">--}%
%{--                    <g:link action="index" class="btn btn-sm btn-outline-secondary waves-effect waves-light"><i--}%
%{--                            class="fa fa-times"></i>&nbsp;Cancelar--}%
%{--                    </g:link>--}%
%{--                    <button type="submit" class="btn btn-sm btn-outline-success float-right waves-effect waves-light">--}%
%{--                        <i class="fa fa-save"></i>&nbsp;Salvar--}%
%{--                    </button>--}%
%{--                </div>--}%
%{--            </g:form>--}%



                <div class="card-body">
                    <div id="summer-note"></div>
                    <button id="edit" class="btn btn-info btn-rounded" onclick="edit()" type="button">Edit</button>
                    <button id="save" class="btn btn-success btn-rounded" onclick="save()" type="button">Save</button>
                </div>
        </div>
    </div>
    <script>
        const options = {
            height: 350, // set editor height
            // minHeight: null, // set minimum height of editor
            // maxHeight: null, // set maximum height of editor
            // focus: true, // set focus to editable area after initializing summernote
            // toolbar: [
            //     // [groupName, [list of button]]
            //
            //     ['style', ['style']],
            //     ['font', ['bold', 'underline', 'clear']],
            //     ['fontname', ['fontname']],
            //
            //     // ['style', ['bold', 'italic', 'underline', 'clear']],
            //
            //     ['fontsize', ['fontsize']],
            //     ['color', ['color']],
            //     ['para', ['ul', 'ol', 'paragraph']],
            //     ['height', ['height']],
            //     ['view', ['fullscreen', 'codeview', 'help']],
            // ]
        };

        const summer = function(){
            $('#summer-note').summernote(options);
        };

        $(document).ready(function () {
            summer()
        });

        window.edit = function () {
            $("#summer-note").summernote(options)
        };

        window.save = function () {
            $("#summer-note").summernote('destroy');
            getValues()
        };

        function getValues() {
            $('#summer-note u').each(function () {
                const value = $(this).text();
                $(this).replaceWith(value);
                console.log(value);
            });
            const value = ($('#summer-note').html());
            <g:remoteFunction controller="dashboard" action="contract" params="{'value':value}" onSuccess="console.log('saved')"/>
            console.log(value)
        }
    </script>
    </body>
</html>
