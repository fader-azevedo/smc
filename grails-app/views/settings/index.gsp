<%@ page import="smc.Settings" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>
        Definições
    </title>
</head>

<body>
<% def settings = Settings.all.first() %>
<div class="col-10">
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <div class="card">
        <div class="card-body p-0 shadow br">
            <ul class="nav nav-tabs customtab" role="tablist">
                <li class="nav-item">
                    <a class="nav-link active" data-toggle="tab" href="#tab-pane-settings" role="tab">
                        <span class="hidden-sm-up"><i class="ti-settings"></i></span>
                        <span class="hidden-xs-down">Definições</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" data-toggle="tab" href="#tab-pane-contract" role="tab">
                        <span class="hidden-sm-up"><i class="fa fa-file-word"></i></span>
                        <span class="hidden-xs-down">Contracto do empréstimo</span>
                    </a>
                </li>
            </ul>
            <div class="tab-content">
                <div class="tab-pane active" id="tab-pane-settings" role="tabpanel">
                    <ul class="setting-list br">
                        <li class="setting-title">Dados gerais</li>
                        <li>
                            <div class="field">Logo</div>

                            <div class="value">
                                <div class="m-b-5 card-img">
                                    <img class="br" alt="" src="<g:createLink controller="settings" action="getLogo"/>"
                                         width="200"/>
                                </div>
                            </div>

                            <div class="action">
                                <button class="btn btn-outline-secondary btn-edit" data-title="Logo" data-attr="logo" data-value="image">Editar</button>
                            </div>
                        </li>
                        <li>
                            <div class="field">Nome</div>

                            <div class="value">
                                ${settings.name ? settings.name : 'Não definido'}
                            </div>

                            <div class="action">
                                <button class="btn btn-default btn-edit" data-title="Nome" data-attr="name" data-value="${settings.name ? settings.name : 'Não definido'}">Editar</button>
                            </div>
                        </li>
                        <li>
                            <div class="field">Slogan</div>

                            <div class="value">
                                ${settings.slogan ? settings.slogan : 'Não definido'}
                            </div>

                            <div class="action">
                                <button class="btn btn-default btn-edit" data-title="Slogan" data-attr="slogan" data-value="${settings.slogan ? settings.slogan : 'Não definido'}">Editar</button>
                            </div>
                        </li>
                        <li>
                            <div class="field">Address</div>

                            <div class="value">
                                ${settings.address ? settings.address : 'Não definido'}
                            </div>

                            <div class="action">
                                <button class="btn btn-default btn-edit" data-title="Endereço" data-attr="address" data-value="${settings.address ? settings.address : 'Não definido'}">Editar</button>
                            </div>
                        </li>
                        <li>
                            <div class="field">Nuit</div>

                            <div class="value">
                                ${settings.nuit ? settings.nuit : 'Não definido'}
                            </div>

                            <div class="action">
                                <button class="btn btn-default btn-edit" data-title="Nuit" data-attr="nuit" data-value="${settings.nuit ? settings.nuit : 'Não definido'}">Editar</button>
                            </div>
                        </li>
                        <li>
                            <div class="field">Contacto</div>

                            <div class="value">
                                ${settings.cellPhone ? settings.cellPhone : 'Não definido'}
                            </div>

                            <div class="action">
                                <button class="btn btn-default btn-edit" data-title="Contacto" data-attr="cellPhone" data-value="${settings.cellPhone ? settings.cellPhone : 'Não definido'}">Editar</button>
                            </div>
                        </li>
                        <li>
                            <div class="field">Contacto 2</div>

                            <div class="value">
                                ${settings.cellPhone2 ? settings.cellPhone2 : 'Não definido'}
                            </div>

                            <div class="action">
                                <button class="btn btn-default btn-edit" data-title="Contacto 2" data-attr="cellPhone2" data-value="${settings.cellPhone2 ? settings.cellPhone2 : 'Não definido'}">Editar</button>
                            </div>
                        </li>
                        <li>
                            <div class="field">Email</div>

                            <div class="value">
                                ${settings.email ? settings.email : 'Não definido'}
                            </div>

                            <div class="action">
                                <button class="btn btn-default btn-edit" data-title="Email" data-attr="email" data-value="${settings.email ? settings.email : 'Não definido'}">Editar</button>
                            </div>
                        </li>
                        <li>
                            <div class="field">Responsavel (Mutuante)</div>

                            <div class="value">
                                ${settings.lender ? settings.lender : 'Não definido'}
                            </div>

                            <div class="action">
                                <button class="btn btn-default btn-edit" data-title="Responsavel" data-attr="lender" data-value="${settings.lender ? settings.lender : 'Não definido'}">Editar</button>
                            </div>
                        </li>
                        <li class="setting-title">Idioma do sistema</li>
                        <li class="br-b">
                            <div class="field">Idioma</div>

                            <div class="value">
                                ${settings.language ? settings.language : 'Não definido'}
                            </div>

                            <div class="action">
                                <button class="btn btn-default btn-edit" data-title="Idioma" data-attr="language" data-value="${settings.language ? settings.language : 'Não definido'}">Editar</button>
                            </div>
                        </li>
                    </ul>
                </div>
                <div class="tab-pane" id="tab-pane-contract" role="tabpanel">
                    <div id="div-contract-hidden" class="d-none">${settings.contract}</div>

                    <ul class="setting-list br ">
%{--                        <li class="setting-title">Cabecalho do documento</li>--}%
                        <li class="setting-title">Corpo do documento</li>
                        <li>
                            <div class="value p-0 f-w-100">
                                <div id="summer-note" class="overflow-auto px-3 pt-3" style="height: 500px"></div>
                                <div class="border-top p-2 d-flex justify-content-between">
                                    <button id="edit" class="btn btn-default bg-light mr-2" type="button"><i class="fa fa-edit">&nbsp;</i>Editar</button>
                                    <button id="pdf" class="btn btn-success" type="button"><i class="fa fa-file-pdf">&nbsp;</i>Visualizar</button>
                                    <button id="save" class="btn btn-megna" type="button"><i class="fa fa-save">&nbsp;</i>Salvar</button>
                                </div>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="modal-edit" class="modal fade in" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">Editar <strong id="title-attr"></strong></h4>

                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            </div>

            <div class="modal-body">
                <form class="form-horizontal" id="form-edit">
                    <div class="form-group">
                        <div class="col-md-12">
                            <input type="text" name="attr"  class="form-control" id="new-value" placeholder="Introduza...">
                        </div>
                    </div>
                </form>
            </div>

            <div class="modal-footer d-flex justify-content-between">
                <button type="button" class="btn btn-danger waves-effect" data-dismiss="modal">Cancelar</button>
                <button type="button" class="btn btn-megna waves-effect" id="btn-submit-edit">
                    <i class="fa fa-save">&nbsp;</i>Salvar
                </button>
            </div>
        </div>
    </div>
</div>

<script>
    let attr ='';
    let title ='';

    $(document).ready(function () {
        $('.btn-edit').addClass('btn-outline-secondary').on('click', function () {
            title = $(this).attr('data-title');
            attr = $(this).attr('data-attr');
            const value = $(this).attr('data-value');
            $('#title-attr').text(title);
            $('#modal-edit').modal('toggle');
            $('#new-value').val(value)
        });

        $('#btn-submit-edit').on('click',function () {
            const value = $('#new-value').val();
           <g:remoteFunction action="updateItem" params="{'attr':attr,'value':value}" onSuccess="successEdit(data)"/>
        });


        //contract card
        const contract = $('#div-contract-hidden').text();
        $('#summer-note').html(contract)
        $('.card-header').after('<hr class="mt-0 pt-0">');

        $('#save').on('click',function () {
            title = 'Contrato';
            $("#summer-note").summernote('destroy');
            const value = ($('#summer-note').html());
            <g:remoteFunction action="updateItem" params="{'attr':'contract','value':value}" onSuccess="successEdit(data)"/>
        });

        $('#edit').on('click',function () {
            $("#summer-note").summernote(options);
            $('.note-resizebar').remove()
        });

        %{--$('#pdf').on('click',function () {--}%
        %{--    const value = ($('#summer-note').html());--}%
        %{--    <g:remoteFunction controller="dashboard" action="contract" params="{'value':value}" onSuccess="console.log('saved')"/>--}%
        %{--})--}%
    });

    function successEdit(data) {
        if(data.status.toString()==='ok'){
            swal('',title+' actualizado com sucesso','success').then(function () {
                if(title.toString() === 'Contrato'){
                    const value = ($('#summer-note').html());
                    <g:remoteFunction controller="settings" action="generateContract" params="{'details':value}" onSuccess="window.location.reload()"/>
                }else{
                    window.location.reload();
                }
            })
        }else{
            swal('','Erro ao actualizar '+title,'error')
        }
    }
    const options = {
        height: 500, // set editor height
        focus: false, // set focus to editable area after initializing summernote
    };
</script>

</body>
</html>