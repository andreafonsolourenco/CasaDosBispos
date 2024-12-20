<%@ Page Language="C#" AutoEventWireup="true" CodeFile="index.aspx.cs" Inherits="index" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="Casa dos Bispos Software - Página Inicial">
    <meta name="author" content="André Lourenço">
    <title>Casa dos Bispos Software - Página Inicial</title>
    <!-- Favicon -->
    <link href="../img/favicon.ico" rel="icon" type="image/ico">
    <!-- Fonts -->
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700" rel="stylesheet">
    <!-- Icons -->
    <link href="../general/assets/vendor/nucleo/css/nucleo.css" rel="stylesheet">
    <link href="../general/assets/vendor/@fortawesome/fontawesome-free/css/all.min.css" rel="stylesheet">
    <!-- Argon CSS -->
    <link type="text/css" href="../general/assets/css/argon.css?v=1.0.0" rel="stylesheet">
    <!-- Alerts -->
    <link type="text/css" href="../vendors/sweetalert2/sweetalert2.min.css" rel="stylesheet" />
    <link type="text/css" href="../alertify/css/alertify.min.css" rel="stylesheet" />
    <link type="text/css" href="../alertify/css/themes/default.min.css" rel="stylesheet" />

    <style>
        .navbar-vertical.navbar-expand-md .navbar-brand-img {
            max-height: 5.5rem;
        }

        .dialogWidth {
            width: 90% !important;
            max-width: 100% !important;
        }
    </style>
</head>

<body style="overflow: hidden;">
    <!-- Sidenav -->
    <nav class="navbar navbar-vertical fixed-left navbar-expand-md navbar-light bg-white" id="sidenav-main">
        <div class="container-fluid">
            <!-- Toggler -->
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#sidenav-collapse-main" aria-controls="sidenav-main" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <!-- Brand -->
            <a class="navbar-brand pt-0 pointer">
                <img id="partner_logo" class="navbar-brand-img" src="../img/logo.png" />
            </a>
            <!-- User -->
            <ul class="nav align-items-center d-md-none">
                <%--<li class="nav-item dropdown variaveis">
                    <a class="nav-link nav-link-icon" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <i class="ni ni-bell-55"></i>
                    </a>
                    <div class="dropdown-menu dropdown-menu-arrow dropdown-menu-right" aria-labelledby="navbar-default_dropdown_1">
                        <a class="dropdown-item" href="#">Action</a>
                        <a class="dropdown-item" href="#">Another action</a>
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item" href="#">Something else here</a>
                    </div>
                </li>--%>
                <li class="nav-item dropdown">
                    <a class="nav-link" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <div class="media align-items-center">
                            <span class="avatar avatar-sm rounded-circle">
                                <img alt="Image placeholder" id="logo" src="../img/logo.png">
                            </span>
                        </div>
                    </a>
                    <div class="dropdown-menu dropdown-menu-arrow dropdown-menu-right">
                        <div class=" dropdown-header noti-title">
                            <h6 class="text-overflow m-0" id="txtUsername"></h6>
                        </div>

                        <div class="dropdown-divider"></div>
                        <a href="#!" class="dropdown-item">
                            <i class="ni ni-button-power"></i>
                            <span onclick="finishSession();">Terminar Sessão</span>
                        </a>
                    </div>
                </li>
            </ul>
            <!-- Collapse -->
            <div class="collapse navbar-collapse" id="sidenav-collapse-main">
                <!-- Collapse header -->
                <div class="navbar-collapse-header d-md-none">
                    <div class="row">
                        <div class="col-6 collapse-brand pointer">
                            <a onclick="loadMainPage();" class="pointer">
                                <img id="logo2" class="pointer" src="../img/logo.png">
                            </a>
                        </div>
                        <div class="col-6 collapse-close">
                            <button type="button" class="navbar-toggler" data-toggle="collapse" data-target="#sidenav-collapse-main" aria-controls="sidenav-main" aria-expanded="false" aria-label="Toggle sidenav">
                                <span></span>
                                <span></span>
                            </button>
                        </div>
                    </div>
                </div>
                <!-- Form -->
                <form class="mt-4 mb-3 d-md-none">
                    <div class="input-group input-group-rounded input-group-merge">
                        <input type="search" class="form-control form-control-rounded form-control-prepended" placeholder="Pesquisar" aria-label="Pesquisar">
                        <div class="input-group-prepend">
                            <div class="input-group-text">
                                <span class="fa fa-search"></span>
                            </div>
                        </div>
                    </div>
                </form>
                <!-- Navigation -->
                <ul class="navbar-nav">
                    <li id="menuDashboard" class="nav-item pointer" onclick="loadUrl('dashboard.aspx');" data-toggle="collapse" data-target="#sidenav-collapse-main">
                        <a class="nav-link">
                            <i class="ni ni-chart-pie-35 text-primary"></i>Dashboard
                        </a>
                    </li>

                    <%--<li id="menuAbout" class="nav-item pointer" onclick="loadAboutPage();" data-toggle="collapse" data-target="#sidenav-collapse-main">
                        <a class="nav-link">
                            <i class="fa fa-address-card text-default"></i>Sobre Nós
                        </a>
                    </li>--%>

                    <li id="menuContacts" class="nav-item pointer" onclick="loadUrl('config_ficha_contactos.aspx');" data-toggle="collapse" data-target="#sidenav-collapse-main">
                        <a class="nav-link">
                            <i class="fas fa-address-book text-secondary"></i>Contactos
                        </a>
                    </li>

                    <li id="menuTexts" class="nav-item pointer" onclick="loadUrl('lista_textos.aspx');" data-toggle="collapse" data-target="#sidenav-collapse-main">
                        <a class="nav-link">
                            <i class="fa fa-text-height text-primary"></i>Textos
                        </a>
                    </li>

                    <li id="menuEspecialidades" class="nav-item pointer" onclick="loadUrl('config_ficha_texto_alojamento.aspx');" data-toggle="collapse" data-target="#sidenav-collapse-main">
                        <a class="nav-link">
                            <i class="ni ni-building text-secondary"></i>Alojamento - Texto
                        </a>
                    </li>

                    <li id="menuTipoImagem" class="nav-item pointer" onclick="loadUrl('lista_tipos_imagem.aspx');" data-toggle="collapse" data-target="#sidenav-collapse-main">
                        <a class="nav-link">
                            <i class="ni ni-collection text-primary"></i>Tipos de Imagens
                        </a>
                    </li>

                    <li id="menuPortfolioImages" class="nav-item pointer" onclick="loadUrl('lista_imagens.aspx');" data-toggle="collapse" data-target="#sidenav-collapse-main">
                        <a class="nav-link">
                            <i class="ni ni-album-2 text-secondary"></i>Gestão de Imagens
                        </a>
                    </li>

                    <li id="menuEmailsRecebidos" class="nav-item pointer" onclick="loadUrl('lista_emails_recebidos.aspx');" data-toggle="collapse" data-target="#sidenav-collapse-main">
                        <a class="nav-link">
                            <i class="ni ni-email-83 text-primary"></i>Emails Recebidos
                        </a>
                    </li>

                    <li id="menuUtilizadores" class="nav-item pointer" onclick="loadUrl('lista_utilizadores.aspx');" data-toggle="collapse" data-target="#sidenav-collapse-main">
                        <a class="nav-link">
                            <i class="ni ni-circle-08 text-secondary"></i>Utilizadores
                        </a>
                    </li>

                    <li id="menuLogs" class="nav-item pointer" onclick="loadUrl('lista_logs.aspx');" data-toggle="collapse" data-target="#sidenav-collapse-main">
                        <a class="nav-link">
                            <i class="fa fa-list text-primary"></i>Registo de Atividade
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    <!-- Main content -->
    <div class="main-content">
        <iframe id="fraContent" style="width: 100%; padding-right: 1px; height: 100%"></iframe>
    </div>

    <div id="hiddenVals" class="variaveis">
        <input id="txtAux" runat="server" type="text" class="variaveis" />
    </div>

    <!-- Argon Scripts -->
    <!-- Optional JS -->
    <script src="../general/assets/vendor/chart.js/dist/Chart.js"></script>
    <script src="../general/assets/vendor/chart.js/dist/Chart.extension.js"></script>
    <!-- Argon JS -->
    <script src="../general/assets/js/argon.js?v=1.0.0"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
    <script src="../vendors/sweetalert2/sweetalert2.min.js"></script>
    <script src="../alertify/alertify.min.js"></script>
    <!-- Core -->
    <script src="../general/assets/vendor/jquery/dist/jquery.min.js"></script>
    <script src="../general/assets/vendor/bootstrap/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        var administrador;

        $(document).ready(function () {
            setAltura();
            loga();
        });

        $(window).resize(function () {
            setAltura();
        });

        function finishSession() {
            window.top.location = "../general/login.aspx";
        }

        function loga() {
            var id = localStorage.loga;
            $('#txtAux').val(id);

            if (id == null || id == 'null' || id == undefined || id == '') {
                swal({
                    title: "CASA DOS BISPOS SOFTWARE",
                    text: 'Utilizador Inválido!',
                    type: "warning",
                    showCancelButton: false,
                    confirmButtonColor: '#007351',
                    cancelButtonColor: '#d33',
                    confirmButtonText: "Confirmar"
                }).then(function () {
                    finishSession();
                });
                return;
            }

            $.ajax({
                type: "POST",
                url: "index.aspx/trataExpiracao",
                data: '{"i":"' + id + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (res) {
                    var dados = res.d.split('<#SEP#>');
                    var ret = parseInt(dados[0]);
                    var retMsg = dados[1];
                    administrador = parseInt(dados[2]);
                    var nome = dados[3];

                    // OK
                    if (ret == 0) {
                        swal({
                            title: "CASA DOS BISPOS SOFTWARE",
                            text: retMsg,
                            type: "warning",
                            showCancelButton: false,
                            confirmButtonColor: '#007351',
                            cancelButtonColor: '#d33',
                            confirmButtonText: "Confirmar"
                        }).then(function () {
                            finishSession();
                        });
                        return;
                    }

                    $('#txtUsername').html("Olá, " + nome.split(' ')[0] + "!");

                    if (administrador == 0) {
                        $('#menuLogs').addClass('variaveis');
                    }
                    else {
                        $('#menuLogs').removeClass('variaveis');
                    }

                    loadUrl('dashboard.aspx');
                }
            });
        }

        function setAltura() {
            $("#fraContent").height($(window).height());
        }

        function loadUrl(url) {
            $('#fraContent').attr('src', url);
        }

        function loadAboutPage() {
            $.ajax({
                type: "POST",
                url: "index.aspx/getAboutId",
                //data: '{"i":"' + id + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (res) {
                    var id = res.d;

                    loadUrl('config_ficha_textos.aspx?id=' + id);
                }
            });
        }
    </script>
</body>
</html>
