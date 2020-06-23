<%@ page import="smc.Loan" %>
<g:each in="${(List<Loan>) loanList}">
    <tr id="tr-${it.id}">
        <td class="w-25">
            <div class="d-flex justify-content-start">
                <button class="btn btn-sm btn-secondary btn-details mr-3" data-id="${it.id}" title="Ver detalhes">
                    <i class="fa fa-info">&nbsp;</i>Detalhes
                </button>
                <g:if test="${it.status.equalsIgnoreCase('fechado')}">
                    <g:form controller="payment" action="index">
                        <button name="loanClientStatus" value="${it.id}_${it.client.id}_Fechado" type="submit"
                                class="btn btn-sm btn-megna">
                            <i class="fa fa-money-bill-alt">&nbsp;</i>Pagamentos
                        </button>
                    </g:form>
                </g:if>
                <g:else>
                    <g:remoteLink controller="payment" action="list" params="[loanClientStatus:it.id+'_'+it.client.id+'_'+it.status]" after="list()">
                        <button type="button"
                                class="btn btn-sm btn-megna mr-3" title="Ver pagamentos">
                            <i class="fa fa-money-bill-alt">&nbsp;</i>Pagamentos
                        </button>
                    </g:remoteLink>
                    <g:remoteLink controller="payment" action="newPayment"  params="[loanID:it.id]" after="newPayment()">
                        <button name="loanID" type="button"
                                class="btn btn-sm btn-success btn-redirect" title="Efectuar pagamento">
                            <i class="fa fa-edit">&nbsp;</i>Pagamento
                        </button>
                    </g:remoteLink>
                </g:else>
            </div>
        </td>
        <td>
            <g:link controller="client" action="show" class="d-flex" id="${it.client.id}">
                <span class="round rounded-circle d-flex flex-column justify-content-center bg-light-extra" style="border: 3px solid #84dbe2">
                    <span class="w-100 text-center">
                        ${it.client.fullName[0]}
                    </span>
                </span>
                <span class="d-flex flex-column justify-content-center ml-2">
                    ${it.client.fullName}
                </span>
            </g:link>
        </td>
        <td class="number-format">${it.borrowedAmount}</td>
        <td class="text-right"><g:formatNumber number="${it.interestRate}"/></td>
        <td class="number-format">${it.amountPayable}</td>
        <td class="text-center"><g:formatDate format="dd/MM/yyyy" date="${it.dueDate}"/></td>
    </tr>
</g:each>

<script>
    $('.number-format').each(function () {
        const value = parseFloat($(this).text());
        $(this).text(formatValue(value)).addClass('text-right')
    });

    function newPayment() {
        window.location = '<g:createLink controller="payment" action="create"/>'
    }

    function list() {
        window.location = '<g:createLink controller="payment" action="index"/>'
    }
</script>

%{--<td class="d-none">--}%
%{--    <g:if test="${it.status.equalsIgnoreCase('aberto')}">--}%
%{--        <span class="badge badge-info w-100">Aberto</span>--}%
%{--    </g:if>--}%
%{--    <g:if test="${it.status.equalsIgnoreCase('vencido')}">--}%
%{--        <span class="badge badge-warning w-100">Vencido</span>--}%
%{--    </g:if>--}%
%{--    <g:if test="${it.status.equalsIgnoreCase('fechado')}">--}%
%{--        <span class="badge badge-megna w-100">Fechado</span>--}%
%{--    </g:if>--}%
%{--</td>--}%