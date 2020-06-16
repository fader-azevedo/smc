<%@ page import="auth.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="Fader Azevedo Macuvele">
    %{--    <link rel="icon" type="image/png" sizes="16x16" href="../assets/images/favicon.png">--}%
    <title class="text-capitalize">
        <g:layoutTitle default="SMC">
            SMC -
        </g:layoutTitle>
    </title>

    <asset:stylesheet src="application.css"/>
    <asset:javascript src="application.js"/>
</head>

<sec:ifLoggedIn>
<body id="body" class="fix-header fix-sidebar card-no-border">
<div class="preloader">
    <svg class="circular" viewBox="25 25 50 50">
        <circle class="path" cx="50" cy="50" r="20" fill="none" stroke-width="2" stroke-miterlimit="10"/></svg>
</div>

<div id="main-wrapper">
    <header class="topbar">
        <nav class="navbar top-navbar navbar-expand-md navbar-light">
            <div class="navbar-header">
                <g:link class="navbar-brand text-white font-20">
                    <b>
                        SMC
                    </b>
                </g:link>
            </div>

            <div class="navbar-collapse" id="navbarSupportedContent" data-navbarbg="skin2">
                <ul class="navbar-nav mr-auto mt-md-0">
                    <li class="nav-item">
                        <a class="nav-side nav-link nav-toggler d-block d-md-none text-muted waves-effect waves-dark"
                           href="javascript:void(0)"><i class="mdi mdi-menu"></i>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-side nav-link sidebartoggler d-none d-md-block text-muted waves-effect waves-dark"
                            href="javascript:void(0)"><i class="ti-menu"></i>
                        </a>
                    </li>
                </ul>
                <ul class="navbar-nav my-lg-0">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle text-muted text-muted waves-effect waves-dark" href="#"
                           data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i
                                class="mdi mdi-bell-ring-outline"></i>

                            <div class="notify"><span class="heartbit"></span> <span class="point"></span></div>
                        </a>

                        <div class="dropdown-menu dropdown-menu-right mailbox scale-up">
                            <ul>
                                <li>
                                    <h5 class="font-medium py-3 px-4 border-bottom mb-0">Notificações</h5>
                                </li>
                                <li>
                                    <div class="message-center position-relative">
                                        <!-- Message -->
                                        <a href="#" class="border-bottom d-block text-decoration-none py-2 px-3">
                                            <div class="btn btn-danger btn-circle mr-2"><i class="fa fa-link"></i>
                                            </div>

                                            <div class="mail-contnet d-inline-block align-middle">
                                                <h5 class="my-1">Luanch Admin</h5> <span
                                                    class="mail-desc font-12 text-truncate overflow-hidden text-nowrap d-block">Just
                                                see the my new
                                                admin!</span> <span
                                                    class="time font-12 mt-1 text-truncate overflow-hidden text-nowrap d-block">9:30
                                                AM</span>
                                            </div>
                                        </a>
                                        <!-- Message -->
                                        <a href="#" class="border-bottom d-block text-decoration-none py-2 px-3">
                                            <div class="btn btn-success btn-circle mr-2"><i class="ti-calendar"></i>
                                            </div>

                                            <div class="mail-contnet d-inline-block align-middle">
                                                <h5 class="my-1">Event today</h5> <span
                                                    class="mail-desc font-12 text-truncate overflow-hidden text-nowrap d-block">Just
                                                a reminder that
                                                you have event</span> <span
                                                    class="time font-12 mt-1 text-truncate overflow-hidden text-nowrap d-block">9:10
                                                AM</span>
                                            </div>
                                        </a>
                                        <!-- Message -->
                                        <a href="#" class="border-bottom d-block text-decoration-none py-2 px-3">
                                            <div class="btn btn-info btn-circle mr-2"><i class="ti-settings"></i>
                                            </div>

                                            <div class="mail-contnet d-inline-block align-middle">
                                                <h5 class="my-1">Settings</h5> <span
                                                    class="mail-desc font-12 text-truncate overflow-hidden text-nowrap d-block">You
                                                can customize this
                                                template as you want</span> <span
                                                    class="time font-12 mt-1 text-truncate overflow-hidden text-nowrap d-block">9:08
                                                AM</span>
                                            </div>
                                        </a>
                                        <!-- Message -->
                                        <a href="#" class="border-bottom d-block text-decoration-none py-2 px-3">
                                            <div class="btn btn-primary btn-circle mr-2"><i class="ti-user"></i>
                                            </div>

                                            <div class="mail-contnet d-inline-block align-middle">
                                                <h5 class="my-1">Pavan kumar</h5> <span
                                                    class="mail-desc font-12 text-truncate overflow-hidden text-nowrap d-block">Just
                                                see the my
                                                admin!</span>
                                                <span
                                                        class="time font-12 mt-1 text-truncate overflow-hidden text-nowrap d-block">9:02
                                                AM</span>
                                            </div>
                                        </a>
                                    </div>
                                </li>
                                <li>
                                    <a class="nav-link text-center border-top pt-3" href="javascript:void(0);">
                                        <strong>Check all
                                        notifications</strong> <i class="fa fa-angle-right"></i></a>
                                </li>
                            </ul>
                        </div>
                    </li>

                    <sec:ifLoggedIn>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle text-muted waves-effect waves-dark" href="#"
                               data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <asset:image src="avatar_white.png" alt="user" class="profile-pic"/>
                            </a>

                            <div class="dropdown-menu dropdown-menu-right scale-up">
                                <ul class="dropdown-user">
                                    <li>
                                        <div class="dw-user-box d-flex">
                                            <div class="u-img">
                                                <asset:image src="avatar_big.png" alt="user"/>
                                            </div>

                                            <div class="d-flex flex-column justify-content-center">
                                                <h4 class="pl-md-2 text-capitalize">
                                                    ${User.get(sec.loggedInUserInfo(field: 'id') as Serializable).fullName}
                                                </h4>
                                            </div>
                                        </div>
                                    </li>
                                    <li role="separator" class="divider"></li>
                                    <li>
                                        <g:link controller="user" action="show"
                                                id="${sec.loggedInUserInfo(field: 'id')}">
                                            <i class="ti-user"></i> Meu Perfil
                                        </g:link>
                                    </li>
                                    <li role="separator" class="divider"></li>
                                    <li><g:link controller="logout"><i class="fa fa-power-off"></i>&nbsp;Logout</g:link>
                                    </li>
                                </ul>
                            </div>
                        </li>
                    </sec:ifLoggedIn>
                </ul>
            </div>
        </nav>
    </header>

    <aside style="overflow: visible;" class="left-sidebar">
        <div class="scroll-sidebar">
            %{--            <div class="user-profile" style="background: url(${resource(dir: 'images',file: 'background/user-info.jpg')}) no-repeat;">--}%
            <div class="user-profile bg-light">
                <div class="profile-img"><asset:image src="avatar.png" alt="user"/></div>

                <div class="profile-text">
                    <sec:ifLoggedIn>
                        <a class="dropdown-toggle u-dropdown text-capitalize" data-toggle="dropdown" role="button"
                           aria-haspopup="true" aria-expanded="true">
                            ${User.get(sec.loggedInUserInfo(field: 'id') as Serializable).fullName}
                        </a>

                        <div class="dropdown-menu animated flipInY">
                            <g:link controller="user" action="show" id="${sec.loggedInUserInfo(field: 'id')}"
                                    class="dropdown-item"><i class="ti-user"></i>&nbsp;Meu Perfil</g:link>
                            <div class="dropdown-divider"></div>
                            <g:link controller="logout" class="dropdown-item">
                                <i class="fa fa-power-off"></i>&nbsp;Logout
                            </g:link>
                        </div>
                    </sec:ifLoggedIn>
                </div>
            </div>
            <!-- End User profile text-->
            <!-- Sidebar navigation-->
            <nav class="sidebar-nav">
                <ul id="sidebarnav">
                    <li class="nav-small-cap">Menu</li>
                    <li class="" id="li-dashboard">
                        <g:link controller="dashboard" class="waves-effect waves-dark">
                            <i class="mdi mdi-view-dashboard"></i>
                            <span class="hide-menu">Inicio</span>
                        </g:link>
                    </li>
                    <li id="li-loan">
                        <a class="has-arrow waves-effect waves-dark">
                            <i class="mdi mdi-bank"></i>
                            <span class="hide-menu">Emprestimos</span>
                        </a>
                        <ul aria-expanded="false" class="collapse pl-3">
                            <li><g:link controller="loan" action="index" class="index"><i
                                    class="mdi mdi-view-list"></i>&nbsp;Lista</g:link></li>
                            <li><g:link controller="loan" action="create" class="create"><i
                                    class="mdi mdi-plus"></i>&nbsp;Novo</g:link></li>
                        </ul>
                    </li>
                    <li id="li-payment">
                        <g:link controller="payment" class="waves-effect waves-dark">
                            <i class="mdi mdi-credit-card-multiple"></i>
                            <span class="hide-menu">Pagamentos</span>
                        </g:link>
                    </li>
                    <li id="li-clients">
                        <g:link controller="client" class="waves-effect waves-dark">
                            <i class="mdi mdi-account-multiple"></i>
                            <span class="hide-menu">Clientes</span>
                        </g:link>
                    </li>
                    <li>
                        <a class="waves-effect waves-dark" href="#" aria-expanded="false">
                            <i class="mdi mdi-chart-line"></i>
                            <span class="hide-menu">Estatística</span>
                        </a>
                    </li>
                    <li>
                        <a class="has-arrow waves-effect waves-dark" href="#" aria-expanded="false"><i
                                class="mdi mdi-table"></i><span class="hide-menu">Relátorios</span></a>
                        <ul aria-expanded="false" class="collapse">
                            <li><a href="table-basic.html">Basic Tables</a></li>
                            <li><a href="table-layout.html">Table Layouts</a></li>
                        </ul>
                    </li>
                </ul>
            </nav>
        </div>

        <div class="sidebar-footer">
            <a href="#" class="link" data-toggle="tooltip" title="Settings"><i
                    class="ti-settings"></i></a>
            <a href="#" class="link" data-toggle="tooltip" title="Email"><i
                    class="mdi mdi-gmail"></i></a>
            <g:link controller="logout" class="link" data-toggle="tooltip" title="Logout">
                <i class="mdi mdi-power"></i>
            </g:link>
        </div>
    </aside>

    <div class="page-wrapper">
        <div class="container-fluid">
            <div class="row justify-content-center pt-4">
                <g:layoutBody/>
            </div>
        </div>

        <footer class="footer">
            © <script>document.write(new Date().getFullYear())</script> by Skuba
        </footer>
    </div>
</div>

<script>
    let isMin = true;
    $(document).ready(function () {
        $('table').addClass('table');
        $('table tbody td').addClass('align-middle');

        $('.nav-side').on('click', function () {
            if(isMin){
                return
            }
            const min = $('.mini-sidebar').length;
            let  sidebar = 'mini-sidebar';
            if(min === 0){
                sidebar = '.'
            }
            isMin =true;
            <g:remoteFunction controller="dashboard" action="sidebar" params="{'sidebar':sidebar}"/>
        });

        <g:remoteFunction controller="dashboard" action="getSidebar" onSuccess="setSidebar(data)"/>
    });
    function setSidebar(data) {
        if(data.toString() === 'mini-sidebar'){
            isMin = true;
            $('.nav-side').trigger('click');
            $('#body').addClass(data);
            isMin = false;
        }else {
            $('#body').addClass(data);
            isMin = false;
        }
    }
</script>
</body>
</sec:ifLoggedIn>
</html>