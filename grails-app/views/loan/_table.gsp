<%@ page import="smc.Loan" %>
<g:each in="${(List<Loan>) loanList}">
    <tr id="tr-${it.id}">
        <td>
            <div class="d-flex justify-content-center">
                <button class="btn btn-sm btn-secondary btn-details mr-3" data-id="${it.id}">
                    <i class="fa fa-info">&nbsp;</i>Detalhes
                </button>

                <g:if test="${it.status.equalsIgnoreCase('fechado')}">
                    <g:form controller="payment" action="index">
                        <button name="loanClientStatus" value="${it.id}-${it.client.id}-${it.status}" type="submit"
                                class="btn btn-sm btn-megna">
                            <i class="fa fa-money-bill-alt">&nbsp;</i>Ver pagamentos
                        </button>
                    </g:form>
                </g:if>
                <g:else>
                    <g:form controller="payment" action="create">
                        <button name="loanID" value="${it.id}" type="submit"
                                class="btn btn-sm btn-megna" data-id="${it.id}">
                            <i class="fa fa-edit">&nbsp;</i>Efectuar pagamento
                        </button>
                    </g:form>
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