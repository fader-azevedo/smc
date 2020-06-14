<%--
  Created by IntelliJ IDEA.
  User: Fader Macuvele
  Date: 5/5/2020
  Time: 7:24 AM
--%>

<%@ page import="smc.Loan; smc.Client" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <title>Dashboard</title>
</head>

<body>

<div class="col-12">
%{--    ${barchartData}--}%
    <div class="row">
        <div class="col-lg-3 col-md-6">
            <g:link controller="client" action="index">
                <div class="card">
                    <div class="card-body">
                        <div class="d-flex flex-row">
                            <div class="round round-lg text-white d-inline-block text-center rounded-circle bg-purple">
                                <i class="fa fa-users"></i>
                            </div>

                            <div class="ml-2 align-self-center">
                                <h3 class="mb-0 font-weight-light">${Client.count}</h3>
                                <h5 class="text-muted mb-0">Clientes</h5>
                            </div>
                        </div>
                    </div>
                </div>
            </g:link>
        </div>

        <div class="col-lg-3 col-md-6">
            <g:link controller="loan" action="index">
                <div class="card">
                    <div class="card-body">
                        <div class="d-flex flex-row">
                            <div class="round round-lg text-white d-inline-block text-center rounded-circle bg-info">
                                <i class="mdi mdi-wallet"></i>
                            </div>

                            <div class="ml-2 align-self-center">
                                <h3 class="mb-0 font-weight-light d-flex align-middle">
                                    <span class="py-3 f-w-500">
                                        <g:include controller="loan" action="loans" params="[status:'aberto']"/>&nbsp;
                                    </span>
                                    <span class="text-muted pl-2 f-s-15">Empréstimos <br>Abertos</span>
                                </h3>
                            </div>
                        </div>
                    </div>
                </div>
            </g:link>
        </div>

        <div class="col-lg-3 col-md-6">
            <g:link controller="loan" action="index">
                <div class="card">
                    <div class="card-body">
                        <div class="d-flex flex-row">
                            <div class="round round-lg text-white d-inline-block text-center rounded-circle bg-warning">
                                <i class="mdi mdi-wallet"></i>
                            </div>

                            <div class="ml-2 align-self-center">
                                <h3 class="mb-0 font-weight-light d-flex align-middle">
                                    <span class="py-3 f-w-500">
                                        <g:include controller="loan" action="loans" params="[status:'vencido']"/>&nbsp;
                                    </span>
                                    <span class="text-muted pl-2 f-s-15">Empréstimos <br>Vencidos</span>
                                </h3>
                            </div>
                        </div>
                    </div>
                </div>
            </g:link>
        </div>

        <div class="col-lg-3 col-md-6">
            <g:link controller="loan" action="index">
                <div class="card">
                    <div class="card-body">
                        <div class="d-flex flex-row">
                            <div class="round round-lg text-white d-inline-block text-center rounded-circle bg-megna">
                                <i class="mdi mdi-wallet-membership"></i>
                            </div>

                            <div class="ml-2 align-self-center">
                                <h3 class="mb-0 font-weight-light d-flex align-middle">
                                    <span class="py-3 f-w-500">
                                        <g:include controller="loan" action="loans" params="[status:'fechado']"/>&nbsp;
                                    </span>
                                    <span class="text-muted pl-2 f-s-15">Empréstimos <br>Fechados</span>
                                </h3>
                            </div>
                        </div>
                    </div>
                </div>
            </g:link>
        </div>
    </div>

    <div class="row">
        <div class="col-lg-8">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title"><i class="fa fa-chart-area">&nbsp;</i>Empréstimo por meses</h4>
                    <div id="morris-line-chart"></div>
                </div>
            </div>
        </div>
        <div class="col-lg-4">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title"><i class="fa fa-circle"></i>Estados</h4>
                    <div id="morris-donut-chart"></div>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title"><i class="fa fa-chart-bar">&nbsp;</i>Empréstimos</h4>
                    <div id="morris-bar-chart"></div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    initCharts(2020);

    function initCharts(ano){
        <g:remoteFunction action="lineChart" params="{'ano':ano}" onSuccess="lineChart(data)"/>
        <g:remoteFunction action="barChart" params="{'ano':ano}" onSuccess="barChart(data)"/>
    }


    // LINE CHART
    function lineChart(data){
        new Morris.Line({
            element: 'morris-line-chart',
            resize: true,
            data: data,
            xkey: 'month',
            ykeys: ['value'],
            labels: ['emp'],
            gridLineColor: '#eef0f2',
            lineColors: ['#009efb'],
            lineWidth: 1,
            hideHover: 'auto',
            parseTime:false
        });
    }
    // Dashboard 1 Morris-chart
    $(function () {

        "use strict";
        // Morris donut chart
        Morris.Donut({
            element: 'morris-donut-chart',
            data: [{
                label: "Abertos",
                value: ${loansOpen},

            }, {
                label: "Vencidos",
                value: ${loansExpired}
            }, {
                label: "Fechados",
                value: ${loansClosed}
            }],
            resize: true,
            colors:['#1e88e5', '#ffb22b', '#00897b']
        });
    });
    // bar chart
    function barChart(data){
        Morris.Bar({
            element: 'morris-bar-chart',
            data: data,
            xkey: 'm',
            ykeys: ['a', 'b', 'c'],
            labels: ['Abertos', 'Vencidos', 'Fechados'],
            barColors:['#1e88e5', '#ffb22b', '#00897b'],
            hideHover: 'auto',
            gridLineColor: '#eef0f2',
            resize: true
        });
    }

</script>
</body>
</html>