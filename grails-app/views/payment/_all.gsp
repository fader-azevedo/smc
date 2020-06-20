<%@ page import="smc.Payment" %>
<g:each in="${(List<Payment>)paymentList}" var="payment">
    <tr class="tr-all">
        <td class="number-format">${payment.totalPaid}</td>
        <% def ip = payment.getInstalmentPayments(); def ipSize = ip.size()%>
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
            <a class="link open-receipt" data-id="${payment.id}"><i class="fa fa-file-pdf text-danger">&nbsp;</i>Recibo-${payment.code.concat('.pdf')}</a>
        </td>
        <td>${payment.loan.client.fullName}</td>
    </tr>
</g:each>

<script>
    $('.tr-all .number-format').each(function () {
        const value = parseFloat($(this).text());
        $(this).text(formatValue(value)).addClass('text-right')
    });
</script>