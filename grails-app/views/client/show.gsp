<%@ page import="smc.Loan" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Cliente</title>
</head>

<body>
<div class="col-8">
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <div class="card">
        <div class="card-body p-0">
            <div class="profile-header">
                <div class="profile-header-cover"></div>
                <div class="profile-header-content">
                    <div class="profile-header-img border">
                        <asset:image src="avatar_white.png" width="108"/>
                    </div>

                    <div class="profile-header-info">
                        <h4>${client.user.fullName}</h4>

                        <p>${client.code}</p>
                        <p class="text-right">
                            <g:link action="edit" id="${client.id}" class="btn btn-sm btn-success width-100"><i class="fa fa-edit">&nbsp;</i>Editar</g:link>
                        </p>
                    </div>
                </div>
                <ul class="profile-header-tab nav nav-tabs">
                    <li class="nav-item"><a href="#profile-about" class="nav-link active" data-toggle="tab">Info</a>
                    </li>
                    <li class="nav-item"><a href="#profile-photos" class="nav-link" data-toggle="tab">Empréstimos</a></li>
                </ul>
            </div>
            <div class="profile-container">
                <div class="tab-content p-0">
                    <div class="tab-pane fade show active" id="profile-about">
                        <table>
                            <tbody>
                            <tr>
                                <td class="field">Tipo de docuemnto</td>
                                <td class="value">
                                    <f:display bean="client" property="documentType.name"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="field">Número do docuemnto</td>
                                <td class="value">
                                    <f:display bean="client" property="docNumber"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="field">Contacto</td>
                                <td class="value">
                                    <f:display bean="client" property="contact"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="field">Email</td>
                                <td class="value">
                                    <f:display bean="client" property="email"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="field">Endereço</td>
                                <td class="value">
                                    <f:display bean="client" property="address"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="field">Distrito | Provincia</td>
                                <td class="value">
                                    <f:display bean="client" property="district.name"/> |
                                    <f:display bean="client" property="district.province.name"/>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="tab-pane fade p-0" id="profile-photos">
                        <div class="">
                            <table class="table mb-1 no-wrap" id="table-loans" data-paging="true" data-paging-size="5">
                                <thead>
                                <tr>
                                    <th></th>
                                    <th class="text-right">Valor pedido</th>
                                    <th class="text-right">Juros(%)</th>
                                    <th class="text-right">Valor pago</th>
                                    <th>Estado</th>
                                </tr>
                                </thead>
                                <tbody>
                                <g:each in="${client.loans}" var="it" status="i">
                                    <tr>
                                        <td class="w-auto">
                                            <div class="d-flex justify-content-center">
                                                <g:link class="btn btn-sm btn-outline-secondary mr-3" controller="loan" action="show" id="${it.id}">
                                                    <i class="fa fa-eye">&nbsp;</i>Ver empréstimo
                                                </g:link>
                                            </div>
                                        </td>
                                        <td class="number-format">${it.borrowedAmount}</td>
                                        <td class="text-right"><g:formatNumber number="${it.interestRate}"/></td>
                                        <td class="number-format">${it.amountPayable}</td>
                                        <td>
                                            <g:if test="${it.status.equalsIgnoreCase('aberto')}">
                                                <span class="badge badge-info w-100">Aberto</span>
                                            </g:if>
                                            <g:if test="${it.status.equalsIgnoreCase('vencido')}">
                                                <span class="badge badge-warning w-100">Vencido</span>
                                            </g:if>
                                            <g:if test="${it.status.equalsIgnoreCase('fechado')}">
                                                <span class="badge badge-megna w-100">Fechado</span>
                                            </g:if>
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

        <div class="card-footer d-none">
            <g:form resource="${this.client}" method="DELETE">
                <input class="delete" type="submit"
                       value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                       onclick="return confirm('Are you sure?')"/>
            </g:form>
        </div>
    </div>
</div>

<script>
    $(document).ready(function () {
        $('#li-clients').addClass('active');
        $('#table-loans').footable({
            empty: 'Sem empréstimos'
        });

        $('.value').addClass('f-w-600');
        $('.number-format').each(function () {
            const value = parseFloat($(this).text());
            $(this).text(formatValue(value)).addClass('text-right')
        });
    })
</script>
</body>
</html>
