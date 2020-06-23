<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Ver client</title>
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
                        <h4>${client.fullName}</h4>

                        <p>${client.code}</p>
                        <p class="text-right">
                            <a href="#" class="btn btn-sm btn-success width-100">Editar</a>
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
                        <table class="">
                            <tbody>
                            <tr>
                                <td class="field">Data de nasciemnto</td>
                                <td class="value">
                                    <g:formatDate format="dd-MM-yyyy" date="${client.birthDate}"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="field">Tipo de docuemnto</td>
                                <td class="value">
                                    <f:display bean="client" property="documentType.name"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="field">Número do docuemnto</td>
                                <td class="value">
                                    <f:display bean="client" property="documentNumber"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="field">Estado civil</td>
                                <td class="value">
                                    <f:display bean="client" property="maritalStatus"/>
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
                            </tbody>
                        </table>
                    </div>
                    <div class="tab-pane fade" id="profile-photos">
                        <div class="m-b-10"><b>Photos (30)</b></div>
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
</body>
</html>
