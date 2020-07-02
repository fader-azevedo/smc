<%@ page import="smc.Client" %>
<g:each in="${(List<Client>)clientList}">
    <tr id="tr-${it.id}">
        <td>
            <div class="d-flex justify-content-center">
                <g:link class="btn btn-sm btn-outline-secondary mr-3" action="show" id="${it.id}">
                    <i class="fa fa-eye">&nbsp;</i>
                </g:link>
                <button class="btn btn-sm btn-secondary btn-details mr-3" data-id="${it.id}">
                    <i class="fa fa-info">&nbsp;</i>Detalhes
                </button>

                <g:form controller="loan" action="create">
                    <button name="client" value="${it.id}" type="submit"
                            class="btn btn-sm btn-megna" data-id="${it.id}">
                        <i class="fa fa-edit">&nbsp;</i>Novo empréstimo
                    </button>
                </g:form>
            </div>
        </td>
        <td>
            <g:link controller="client" action="show" class="d-flex" id="${it.id}">
                <span class="round rounded-circle d-flex flex-column justify-content-center bg-light-extra" style="border: 3px solid #84dbe2">
                    <span class="w-100 text-center">
                        <g:include controller="client" action="getInitialChars" params="[name:it.user.fullName]"/>
                    </span>
                </span>
                <span class="d-flex flex-column justify-content-center ml-2">
                    ${it.user.fullName}
                </span>
            </g:link>
        </td>
        <td>${it.contact}</td>
        <td>${it.contact2}</td>
        <td>${it.email}</td>
    </tr>
</g:each>