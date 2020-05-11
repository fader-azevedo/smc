<%--
  Created by IntelliJ IDEA.
  User: Fader Macuvele
  Date: 5/5/2020
  Time: 5:55 AM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Iniciar Sessão</title>
    <asset:stylesheet src="style.css"/>
</head>

<body>
<div class="preloader">
    <svg class="circular" viewBox="25 25 50 50">
        <circle class="path" cx="50" cy="50" r="20" fill="none" stroke-width="2" stroke-miterlimit="10" /> </svg>
</div>
<!-- ============================================================== -->
<!-- Main wrapper - style you can find in pages.scss -->
<!-- ============================================================== -->
<section id="wrapper">
    <div class="login-register">
        <div class="login-box card">
            <div class="card-body">
                <form class="floating-labels" action="/login/authenticate" method="POST" id="loginForm" autocomplete="off">

                    <div class="d-flex justify-content-center mb-sm-3 mb-lg-4">
                        <asset:image src="login.png" width="200"/>
                    </div>

                    <div class="form-group mb-5 focused">
                        <input type="text" class="form-control" id="username" name="username">
                        <span class="bar"></span>
                        <label for="username">username</label>
                    </div>
                    <div class="form-group">
                        <input type="password" class="form-control" id="password" name="password">
                        <span class="bar"></span>
                        <label for="password">password</label>
%{--                        <i id="passwordToggler" title="toggle password display" onclick="passwordDisplayToggle()">&#128065;</i>--}%
                    </div>
                    <div class="form-group">
                        <div class="checkbox checkbox-primary pt-0">
                            <input type="checkbox" class="chk" name="remember-me" id="remember_me" />
                            <label for="remember_me">Remember me</label>
                        </div>
                    </div>

                    <div class="form-group text-center mt-3">
                        <div class="col-xs-12">
                            <button class="btn btn-success btn-lg btn-block text-capitalize waves-effect waves-light" type="submit">
                                Entrar&nbsp;<i class="fa fa-sign-in-alt"></i>
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</section>

<script type="text/javascript">
    document.addEventListener("DOMContentLoaded", function(event) {
        document.forms['loginForm'].elements['username'].focus();
    });

    function passwordDisplayToggle() {
        var toggleEl = document.getElementById("passwordToggler");
        var eyeIcon = '\u{1F441}';
        var xIcon = '\u{2715}';
        var passEl = document.getElementById("password");

        if (passEl.type === "password") {
            toggleEl.innerHTML = xIcon;
            passEl.type = "text";
        } else {
            toggleEl.innerHTML = eyeIcon;
            passEl.type = "password";
        }
    }
</script>

<asset:javascript src="plugins/jquery/jquery.min.js"/>
<!-- Bootstrap tether Core JavaScript -->
<asset:javascript src="plugins/popper/popper.min.js"/>
<asset:javascript src="plugins/bootstrap/js/bootstrap.min.js"/>
<!-- slimscrollbar scrollbar JavaScript -->
<asset:javascript src="jquery.slimscroll.js"/>
<!--Wave Effects -->
<asset:javascript src="waves.js"/>
<!--Menu sidebar -->
<asset:javascript src="sidebarmenu.js"/>
<!--stickey kit -->
<asset:javascript src="plugins/sticky-kit-master/dist/sticky-kit.min.js"/>
<asset:javascript src="plugins/sparkline/jquery.sparkline.min.js"/>
<!--Custom JavaScript -->
<asset:javascript src="custom.min.js"/>
<!-- ============================================================== -->
<!-- This page plugins -->
<!-- ============================================================== -->
<!-- chartist chart -->
<!-- Chart JS -->
%{--<asset:javascript src="dashboard1.js"/>--}%
<!-- ============================================================== -->
<!-- Style switcher -->
<!-- ============================================================== -->
<asset:javascript src="plugins/styleswitcher/jQuery.style.switcher.js"/>

</body>
</html>