<%@ page import="smc.Loan" %>
<g:each in="${(List<Loan>) loanList}">
    <tr>
        <td>
            <div class="d-flex justify-content-center">
                <button class="btn btn-sm btn-secondary btn-details mr-3" data-id="${it.id}">
                    <i class="fa fa-eye">&nbsp;</i>Info
                </button>


                <g:if test="${it.status.equalsIgnoreCase('fechado')}">
                    <g:form controller="payment" action="create">
                        <button name="loanID" value="${it.id}" type="submit"
                                class="btn btn-sm btn-megna" data-id="${it.id}">
                            <i class="fa fa-money-bill-alt">&nbsp;</i>Ver pagamentos
                        </button>
                    </g:form>
                </g:if>
                <g:else>
                    <g:form controller="payment" action="create">
                        <button name="loanID" value="${it.id}" type="submit"
                                class="btn btn-sm btn-megna" data-id="${it.id}">
                            <i class="fa fa-money-bill-alt">&nbsp;</i>Fazer pagamento
                        </button>
                    </g:form>
                </g:else>
            </div>
        </td>
        <td>

            <g:link controller="client" action="show" id="${it.client.id}">
                <span class="round text-white d-inline-block text-center rounded-circle bg-light-extra text-muted">
                    ${it.client.fullName[0]}
                </span>
                ${it.client.fullName}
            </g:link>
        </td>
        <td class="number-format">${it.borrowedAmount}</td>
        <td class=""><g:formatNumber number="${it.interestRate}"/></td>
        <td class="number-format">${it.amountPayable}</td>
        <td><g:formatDate format="dd/MM/yyyy" date="${it.dueDate}"/></td>
    </tr>
</g:each>

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