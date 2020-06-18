<%@ page import="smc.Loan" %>
<g:set var="i" value="${new Integer('0')}"/>
<g:set var="show" value="show"/>
<g:each in="${(List<Loan>) loanList}" var="it">
    <g:if test="${it.payments.size() > 0}">
        <tr id="tr-${it.id}" class="line-table-inside" onclick="switchBtn(${it.id})" data-toggle="collapse"
            href="#collapse-${it.id}">
            <td>
                <i class="fa fa-eye text-primary"></i>
            </td>

            <td>
                <a class="link">
                    <span class="f-w-800">${i + 1}º</span> Empréstimo
                </a>
            </td>
            <g:set var="i" value="${i + 1}"/>
            <td class="number-format">${it.borrowedAmount}</td>
            <td class="number-format">${it.amountPayable}</td>
            <td class="number-format"><g:include controller="loan" action="totalPaid" params="[id: it.id]"/></td>
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

    %{--        inside table--}%
        <tr class="">
            <td colspan="6" class="py-0">
                <div id="collapse-${it.id}" class="collapse ${show}">
                    <g:set var="show" value=""/>
                    <div class="col-12 pt-1 px-0">
                        <div class="line-title text-center mb-3 mb-md-3">
                            <span class="text">Pagamentos do <strong class="f-w-700">${i}º Empréstimo</strong></span>
                        </div>

                        <div class="table-responsive">
                            <table class="table table-bordered table-inside">
                                <thead>
                                <tr>
                                    <th class="border">Total pago</th>
                                    <th class="border">Valor pago</th>
                                    <th class="border px-3">Prestação</th>
                                    <th class="border">F.pagamento</th>
                                    <th class="border">Data</th>
                                    <th class="border">Recibo</th>
                                </tr>
                                </thead>
                                <tbody>
                                <g:each in="${it.payments.sort{it.dateCreated}.reverse()}" var="payment">
                                    <tr class="tr-inside">
                                        <td class="number-format">${payment.totalPaid}</td>
                                        <% def ip = payment.getInstalmentPayments(); def ipSize = ip.size() %>
                                        <td class="px-0">
                                            <g:each in="${ip}" var="inp">
                                                <p class="number-format my-0 px-3">${inp.amountPaid}</p>
                                                <hr>
                                            </g:each>
                                        </td>
                                        <td class="px-0">
                                            <g:each in="${ip}" var="inp">
                                                <p class="my-0  px-3">${inp.instalment.type.name}</p>
                                                <hr>
                                            </g:each>
                                        </td>
                                        <td class="px-0">
                                            <g:each in="${ip}" var="inp">
                                                <p class="my-0  px-3">${inp.paymentMothod.name}</p>
                                                <hr>
                                            </g:each>
                                        </td>
                                        <td class="text-center">
                                            <g:formatDate format="dd/MM/yyyy HH:mm" date="${payment.dateCreated}"/>
                                        </td>
                                        <td class="">
                                            <a class="link"><i
                                                    class="fa fa-file-pdf text-danger">&nbsp;</i>Recibo-${payment.code.concat('.pdf')}
                                            </a>
                                        </td>
                                    </tr>
                                </g:each>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </td>
        </tr>
    </g:if>
</g:each>

<script>
    $('#table-body-client-payment tr:first').addClass('bg-light-info');

    function switchBtn(id) {
        $('.collapse').removeClass('show');

        $('#table-body-client-payment tr').removeClass('bg-light-info');
        $('#tr-' + id).addClass('bg-light-info');
    }
    // line-table-inside

    formatN('.line-table-inside');
    formatN('.tr-inside');
    function formatN(tr){
        $(tr+' .number-format').each(function () {
            const value = parseFloat($(this).text());
            $(this).text(formatValue(value)).addClass('text-right')
        });
    }

    $('.table-inside tbody td > hr:last-child').remove();
    $('.table-inside tbody td').addClass('align-middle');

</script>

