<%@ Page Language="C#" AutoEventWireup="true" CodeFile="config_ficha_tipos_imagem.aspx.cs" Inherits="config_ficha_tipos_imagem" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="Casa dos Bispos Software - Ficha de Tipos de Imagem">
    <meta name="author" content="André Lourenço">
    <title>Casa dos Bispos Software - Ficha de Tipos de Imagem</title>
    <!-- Favicon -->
    <link href="../general/assets/img/brand/favicon.png" rel="icon" type="image/png">
    <!-- Fonts -->
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700" rel="stylesheet">
    <!-- Icons -->
    <link href="../general/assets/vendor/nucleo/css/nucleo.css" rel="stylesheet">
    <link href="../general/assets/vendor/@fortawesome/fontawesome-free/css/all.min.css" rel="stylesheet">
    <!-- Argon CSS -->
    <link type="text/css" href="../general/assets/css/argon.css?v=1.0.0" rel="stylesheet">
    <link href="../general/assets/css/mbs_div.css" rel="stylesheet" />
    <link href="../vendors/sweetalert2/sweetalert2.min.css" rel="stylesheet" />
    <link type="text/css" href="../alertify/css/alertify.min.css" rel="stylesheet" />
    <link type="text/css" href="../alertify/css/themes/default.min.css" rel="stylesheet" />

    <style>
        .col-xl-8 {
            max-width: 99%;
            flex: 0 0 99%;
        }

        .autocomplete-items {
            position: absolute;
            border: 1px solid #d4d4d4;
            border-bottom: none;
            border-top: none;
            z-index: 99;
            /*position the autocomplete items to be the same width as the container:*/
            top: 100%;
            left: 0;
            right: 0;
        }

            .autocomplete-items div {
                padding: 10px;
                cursor: pointer;
                background-color: #fff;
                border-bottom: 1px solid #d4d4d4;
            }

                .autocomplete-items div:hover {
                    /*when hovering an item:*/
                    background-color: #e9e9e9;
                }

        .autocomplete-active {
            /*when navigating through the items using the arrow keys:*/
            background-color: DodgerBlue !important;
            color: #ffffff;
        }

        .bg-gradient-primary {
            background: linear-gradient(87deg, #7D0C0E, #7D0C0E 100%) !important;
        }

        .bg-gradient-secondary {
            background: linear-gradient(87deg, #C80C0E, #C80C0E 100%) !important;
        }

        .bg-gradient-default {
            background: linear-gradient(87deg, #000, #000 100%) !important;
        }
    </style>
</head>

<body>

    <!-- Main content -->
    <div class="main-content">
        <!-- Top navbar -->
        <nav class="navbar navbar-top navbar-expand-md navbar-dark" id="navbar-main">
            <div class="container-fluid">
                <!-- Brand -->
                <a class="h4 mb-0 text-white text-uppercase d-none d-lg-inline-block">Tipos de Portfolio</a>
                <!-- User -->
                <ul class="navbar-nav align-items-center d-none d-md-flex">
                    <li class="nav-item dropdown">
                        <a class="nav-link pr-0" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <div class="media align-items-center">

                                <div class="media-body ml-2 d-none d-lg-block">
                                    <span id="spanNomeUser" class="mb-0 text-sm font-weight-bold"></span>
                                </div>
                            </div>
                        </a>
                        <div class="dropdown-menu dropdown-menu-arrow dropdown-menu-right">
                            <div class=" dropdown-header noti-title">
                                <h6 id="spanOla" class="text-overflow m-0"></h6>
                            </div>



                            <div class="dropdown-divider"></div>
                            <a href="#!" class="dropdown-item" onclick="finishSession();">
                                <i class="ni ni-button-power"></i>
                                <span>Terminar sessão</span>
                            </a>
                        </div>
                    </li>
                </ul>
            </div>
        </nav>
        <!-- Header -->
        <div class="header pb-8 pt-5 pt-lg-8 d-flex align-items-center" style="min-height: 200px; background-size: cover; background-position: center top;" id="divInfo">
            <!-- Mask -->
            <span class="mask bg-gradient-primary opacity-8"></span>
            <!-- Header container -->
            <div class="container-fluid d-flex align-items-center">
                <div class="row">
                    <div class="col-lg-12 col-md-10">
                        <h1 class="display-2 text-white">Tipos de Imagens</h1>
                        <p class="text-white mt-0 mb-5">Crie/Edite o Tipo de Imagem</p>
                        <a href="#!" class="btn btn-secondary" onclick="confirmSave();">Guardar alterações</a>
                    </div>
                </div>
            </div>
        </div>
        <!-- Page content -->
        <div class="container-fluid mt--7">
            <div class="row">

                <div class="col-xl-8 order-xl-1">
                    <div class="card bg-secondary shadow">
                        <div class="card-header bg-white border-0">
                            <div class="row align-items-center">
                                <table style="width: 100%; margin-left: 15px">
                                    <tr>
                                        <td style="width: 90%">
                                            <h3 class="mb-0">Tipos de Imagens</h3>
                                        </td>
                                        <td style="width: 10%; text-align: right">
                                            <img id="backButton" src='../general/assets/img/theme/setae.png' style='width: 30px; height: 30px; cursor: pointer' alt='Back' title='Back' onclick='retroceder();'/>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                        <div class="card-body" id="divGrelha">
                            <form>
                                <%--<h6 class="heading-small text-muted mb-4">Informação de utilização</h6>--%>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label class="form-control-label" for="txtNome">Nome</label>
                                            <input type="text" id="txtNome" class="form-control form-control-alternative" placeholder="Nome">
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label class="form-control-label" for="txtNomeEn">Nome (EN)</label>
                                            <input type="text" id="txtNomeEn" class="form-control form-control-alternative" placeholder="Nome (EN)">
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label class="form-control-label" for="txtNomeFr">Nome (FR)</label>
                                            <input type="text" id="txtNomeFr" class="form-control form-control-alternative" placeholder="Nome (FR)">
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label class="form-control-label" for="txtNomeEs">Nome (ES)</label>
                                            <input type="text" id="txtNomeEs" class="form-control form-control-alternative" placeholder="Nome (ES)">
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label class="form-control-label" for="txtOrdem">Ordem</label>
                                            <input type="text" id="txtOrdem" class="form-control form-control-alternative" placeholder="Ordem">
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="custom-control custom-control-alternative custom-checkbox">
                                            <input class="custom-control-input" id="chkVisivel" type="checkbox" runat="server">
                                            <label class="custom-control-label" for="chkVisivel">
                                                <span class="text-muted">Visivel</span>
                                            </label>
                                        </div>
                                    </div>
                                </div>
                                <div class="row" id="rowSelectImgCapa" runat="server"></div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>


            <!-- Footer -->
            <footer class="footer">
                <div class="row align-items-center justify-content-xl-between">
                    <div class="col-xl-6">
                        <div class="copyright text-center text-xl-left text-muted">
                            <%--&copy; 2019, Plataforma desenvolvida por <a href="http://www.mbsolutions.pt" class="font-weight-bold ml-1" target="_blank">MBSolutions</a>--%>
                        </div>
                    </div>
                </div>
            </footer>

            <div id="hiddenVals" class="variaveis">
                <input id="txtAux" runat="server" type="text" class="variaveis" />
            </div>
        </div>
    </div>

    <!-- Argon Scripts -->
    <!-- Core -->
    <script src="../general/assets/vendor/jquery/dist/jquery.min.js"></script>
    <script src="../general/assets/vendor/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Argon JS -->
    <script src="../general/assets/js/argon.js?v=1.0.0"></script>
    <script src="../vendors/sweetalert2/sweetalert2.min.js"></script>
    <script src="../alertify/alertify.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
    

    <script>
        var administrador;

        $(document).ready(function () {
            loga();
            setAltura();
            getData();
        });

        $(window).resize(function () {
            setAltura();
        });

        function setAltura() {
            $("#fraContent").height($(window).height());
        }

        function showPopup(id) {
            document.getElementById(id).style.display = 'block';
        }

        function hidePopup(id) {
            document.getElementById(id).style.display = 'none';
        }

        function loga() {
            var id = localStorage.loga;

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

                    $('#spanNomeUser').html(nome);
                    $('#spanOla').html("Olá, " + nome.split(' ')[0] + "!");
                    getData();
                }
            });
        }

        function finishSession() {
            window.top.location = "../general/login.aspx";
        }

        function getData() {
            var id = $('#txtAux').val();
            if (id != null && id != 'null' && id != '' && id != '0') {
                $.ajax({
                    type: "POST",
                    url: "config_ficha_tipos_imagem.aspx/getData",
                    data: '{"id":"' + id + '"}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (res) {
                        var dados = res.d.split('<#SEP#>');

                        var nome = dados[0];
                        var nome_en = dados[1];
                        var nome_fr = dados[2];
                        var nome_es = dados[3];
                        var ordem = dados[4];
                        var visivel = dados[5];

                        $('#txtNome').val(nome);
                        $('#txtNomeEn').val(nome_en);
                        $('#txtNomeFr').val(nome_fr);
                        $('#txtNomeEs').val(nome_es);
                        $('#txtOrdem').val(ordem);

                        if (visivel == "0")
                            $('#chkVisivel').attr('checked', false);
                        else
                            $('#chkVisivel').attr('checked', true);
                    }
                });
            }
            else {
                $('#txtNome').val('');
                $('#txtNomeEn').val('');
                $('#txtNomeFr').val('');
                $('#txtNomeEs').val('');
                $('#txtOrdem').val('0');
                $('#chkVisivel').attr('checked', true);
            }
        }

        function saveData() {
            var id = $('#txtAux').val();

            var nome = $('#txtNome').val();
            var nomeEn = $('#txtNomeEn').val();
            var nomeFr = $('#txtNomeFr').val();
            var nomeEs = $('#txtNomeEs').val();
            var ordem = $('#txtOrdem').val();
            var id_img_capa = $('#selectImgCapa').val();
            var visivel = $("#chkVisivel").is(":checked") ? '1' : '0';

            if (nome == '' || nome == null || nome == undefined) {
                sweetAlertWarning('Nome', 'Por favor indique o nome do Tipo de Especialidade');
                return;
            }

            if (ordem == '' || ordem == null || ordem == undefined || ordem.length === 0) {
                ordem = '0';
            }

            if (id_img_capa == '' || id_img_capa == null || id_img_capa == undefined || id_img_capa.length === 0 || id_img_capa == '0') {
                id_img_capa = 'NULL';
            }

            $.ajax({
                type: "POST",
                url: "config_ficha_tipos_imagem.aspx/saveData",
                data: '{"id":"' + id + '","nome":"' + nome + '","nome_en":"' + nomeEn + '","nome_fr":"' + nomeFr + '","nome_es":"' + nomeEs
                    + '","idUser":"' + localStorage.loga + '","ordem":"' + ordem + '","id_imagem_capa":"' + id_img_capa + '","visivel":"' + visivel + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (res) {
                    var dados = res.d.split('<#SEP#>');

                    if (parseInt(dados[0]) > 0) {
                        loadUrl('lista_tipos_imagem.aspx');
                    }
                    else {
                        sweetAlertWarning('Aviso', dados[1]);
                    }
                }
            });
        }


        function loadUrl(url) {
            window.location = url;
        }

        function retroceder() {
            swal({
                title: "SAIR",
                text: "Tem a certeza que pretende sair? Todos os dados serão perdidos.",
                type: 'question',
                showCancelButton: true,
                confirmButtonColor: '#007351',
                cancelButtonColor: '#d33',
                confirmButtonText: "Confirmar",
                cancelButtonText: "Cancelar"
            }).then(function (isConfirm) {
                if (isConfirm) {
                    loadUrl('lista_tipos_imagem.aspx');
                }
            });
        }

        function confirmSave() {
            swal({
                title: "GUARDAR",
                text: "Tem a certeza que deseja guardar a informação?",
                type: "question",
                showCancelButton: true,
                confirmButtonColor: '#007351',
                cancelButtonColor: '#d33',
                confirmButtonText: "Confirmar",
                cancelButtonText: "Cancelar"
            }).then(function (isConfirm) {
                if (isConfirm) {
                    saveData();
                }
            });
        }

        function sweetAlertWarning(subject, msg) {
            swal(
                subject,
                msg,
                'warning'
            )
        }

        function replaceAll(str, find, replace) {
            return str.replace(new RegExp(escapeRegExp(find), 'g'), replace);
        }

        function changeImageSelected() {
            var id = $('#selectImgCapa').val();
            var imgSelected = $("#selectImgCapa option:selected").text();
            var img = '../img/portfolio/' + imgSelected;

            if (id == '0') {
                img = '../img/portfolio/noimg.png';
            }

            $('#imgCapa').attr('src', img);
        }
    </script>
</body>

</html>
