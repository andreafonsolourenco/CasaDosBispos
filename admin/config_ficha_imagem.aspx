<%@ Page Language="C#" AutoEventWireup="true" CodeFile="config_ficha_imagem.aspx.cs" Inherits="config_ficha_imagem" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="Casa dos Bispos Software - Ficha de Imagem">
    <meta name="author" content="André Lourenço">
    <title>Casa dos Bispos Software - Ficha de Imagem</title>
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

        .dialogWidth {
            width: 75% !important;
            max-width: 100% !important;
        }

        .highlight_line {
            background-color: cornsilk;
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
                <a class="h4 mb-0 text-white text-uppercase d-none d-lg-inline-block">Imagens</a>
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
                        <h1 class="display-2 text-white">Imagens</h1>
                        <p class="text-white mt-0 mb-5">Crie/Edite as Imagens</p>
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
                                            <h3 class="mb-0">Imagens</h3>
                                        </td>
                                        <td style="width: 10%; text-align: right">
                                            <img id="backButton" src='../general/assets/img/theme/setae.png' style='width: 30px; height: 30px; cursor: pointer' alt='Back' title='Back' onclick='retroceder();'/>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                        <div class="card-body" id="divGrelha">
                            <div class="row">
                                <table style="width: 100%; margin-left: 15px;">
                                    <tr>
                                        <td style="width: 90%">
                                            <h6 class="heading-small text-muted mb-4 pointer" onclick="showHideImageTypes();">TIPO DE IMAGEM</h6>
                                        </td>
                                        <td style="width: 10%; text-align: right">
                                            <img src='../Img/icon_search_image.png' style='width: 30px; height: 30px; cursor: pointer; margin-left: 10px;' alt='Pesquisar Tipo de Imagem' title='Pesquisar Tipo de Imagem' onclick='searchImageTypes();'/>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div class="row" id="rowImageTypeNameNameEN">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="form-control-label" for="txtNomeTipo">Tipo de Imagem Nome</label>
                                        <input type="text" id="txtNomeTipo" class="form-control form-control-alternative" placeholder="Tipo de Imagem Nome" runat="server">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="form-control-label" for="txtNomeEnTipo">Tipo de Imagem Nome (EN)</label>
                                        <input type="text" id="txtNomeEnTipo" class="form-control form-control-alternative" placeholder="Tipo de Imagem Nome (EN)" runat="server">
                                    </div>
                                </div>
                            </div>
                            <div class="row" id="rowImageTypeNameFRNameES">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="form-control-label" for="txtNomeFrTipo">Tipo de Imagem Nome (FR)</label>
                                        <input type="text" id="txtNomeFrTipo" class="form-control form-control-alternative" placeholder="Tipo de Imagem Nome (FR)" runat="server">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="form-control-label" for="txtNomeEsTipo">Tipo de Imagem Nome (ES)</label>
                                        <input type="text" id="txtNomeEsTipo" class="form-control form-control-alternative" placeholder="Tipo de Imagem Nome (ES)" runat="server">
                                    </div>
                                </div>
                            </div>
                            <div class="row" id="rowImageTypeOrder">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="form-control-label" for="txtOrdemTipo">Tipo de Imagem Ordem</label>
                                        <input type="number" id="txtOrdemTipo" class="form-control form-control-alternative" placeholder="Tipo de Imagem Ordem" runat="server">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="custom-control custom-control-alternative custom-checkbox">
                                        <input class="custom-control-input" id="chkVisivelTipo" type="checkbox" runat="server">
                                        <label class="custom-control-label" for="chkVisivelTipo">
                                            <span class="text-muted">Visivel (Tipo)</span>
                                        </label>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <table style="width: 100%; margin-left: 15px;">
                                    <tr>
                                        <td style="width: 100%">
                                            <h6 class="heading-small text-muted mb-4 pointer" onclick="showHideImage();">DADOS DA IMAGEM</h6>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div class="row" id="rowImageNameNameEN">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="form-control-label" for="txtNome">Nome</label>
                                        <input type="text" id="txtNome" class="form-control form-control-alternative" placeholder="Nome" runat="server">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="form-control-label" for="txtNomeEn">Nome (EN)</label>
                                        <input type="text" id="txtNomeEn" class="form-control form-control-alternative" placeholder="Nome (EN)" runat="server">
                                    </div>
                                </div>
                            </div>
                            <div class="row" id="rowImageNameFRNameES">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="form-control-label" for="txtNomeFr">Nome (FR)</label>
                                        <input type="text" id="txtNomeFr" class="form-control form-control-alternative" placeholder="Nome (FR)" runat="server">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="form-control-label" for="txtNomeEs">Nome (ES)</label>
                                        <input type="text" id="txtNomeEs" class="form-control form-control-alternative" placeholder="Nome (ES)" runat="server">
                                    </div>
                                </div>
                            </div>
                            <div class="row" id="rowImageOrderSliderVisible">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label class="form-control-label" for="txtOrdem">Ordem</label>
                                        <input type="text" id="txtOrdem" class="form-control form-control-alternative" placeholder="Ordem" runat="server">
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="custom-control custom-control-alternative custom-checkbox">
                                        <input class="custom-control-input" id="chkSlider" type="checkbox" runat="server">
                                        <label class="custom-control-label" for="chkSlider">
                                            <span class="text-muted">Slider Inicial</span>
                                        </label>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="custom-control custom-control-alternative custom-checkbox">
                                        <input class="custom-control-input" id="chkVisivel" type="checkbox" runat="server">
                                        <label class="custom-control-label" for="chkVisivel">
                                            <span class="text-muted">Visivel</span>
                                        </label>
                                    </div>
                                </div>
                            </div>
                            <form id="formUploadPhoto" runat="server" style="margin-top: 20px;">
                                <div class="row" id="rowUploadPhoto">
                                    <div class="col-md-6">
                                        <asp:FileUpload id="FileUploadControl" runat="server" CssClass="btn btn-primary"/>
                                    </div>
                                    <div class="col-md-6">
                                        <asp:Label runat="server" id="StatusLabel" text="Nenhuma Fotografia Carregada!" />
                                    </div>
                                </div>
                                <div class="row" id="rowImagePhoto" style="margin-top: 10px; margin-bottom: 10px;">
                                    <div class="col-md-12" style="text-align:center">
                                        <h6 class="heading-small text-muted mb-4 pointer">Foto Atual</h6>
                                        <img src="" style="width: 150px; height: auto; margin: auto !important" id="img" />
                                    </div>
                                </div>
                                <div class="row" id="rowButtonUpload">
                                    <div class="col-md-12">
                                        <asp:Button runat="server" id="UploadButton" text="Guardar alterações" onclick="UploadButton_Click" CssClass="btn btn-primary variaveis"/>
                                        <a href="#!" class="btn btn-primary" onclick="confirmSave();" style="width:100%;">Guardar alterações</a>
                                    </div>
                                </div>
                                <div id="hiddenVals" class="variaveis">
                                    <asp:TextBox id="userID" runat="server"></asp:TextBox>
                                    <asp:TextBox id="aux" runat="server"></asp:TextBox>
                                    <asp:TextBox id="nome" runat="server"></asp:TextBox>
                                    <asp:TextBox id="nomeEn" runat="server"></asp:TextBox>
                                    <asp:TextBox id="nomeFr" runat="server"></asp:TextBox>
                                    <asp:TextBox id="nomeEs" runat="server"></asp:TextBox>
                                    <asp:TextBox id="ordem" runat="server"></asp:TextBox>
                                    <asp:TextBox id="slider" runat="server"></asp:TextBox>
                                    <asp:TextBox id="nomeTipo" runat="server"></asp:TextBox>
                                    <asp:TextBox id="nomeEnTipo" runat="server"></asp:TextBox>
                                    <asp:TextBox id="nomeFrTipo" runat="server"></asp:TextBox>
                                    <asp:TextBox id="nomeEsTipo" runat="server"></asp:TextBox>
                                    <asp:TextBox id="ordemTipo" runat="server"></asp:TextBox>
                                    <asp:TextBox id="visivel" runat="server"></asp:TextBox>
                                    <asp:TextBox id="visivelTipo" runat="server"></asp:TextBox>
                                    <input id="txtAux" runat="server" type="text" class="variaveis" />
                                    <input id="txtIDUser" runat="server" type="text" class="variaveis" />
                                </div>
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
        var imageTypesDialogOpen = false;
        var tableImageTypes = "";
        var imageTypesIDSelected = "";

        $(document).ready(function () {
            loga();
            setAltura();
            getData();
            getImageTypesList();
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
                    $('#txtIDUser').val(id);

                    if ($('#StatusLabel').val() == 'Imagem adicionada com sucesso!') {
                        loadUrl('lista_imagens.aspx');
                    }
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
                    url: "config_ficha_imagem.aspx/getData",
                    data: '{"id":"' + id + '"}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (res) {
                        var dados = res.d.split('<#SEP#>');

                        var id = dados[0];
                        var nome = dados[1];
                        var nome_en = dados[2];
                        var nome_fr = dados[3];
                        var nome_es = dados[4];
                        var ordem = dados[5];
                        var slider_inicial = dados[6];
                        var id_tipo = dados[7];
                        var nome_tipo = dados[8];
                        var nome_en_tipo = dados[9];
                        var nome_fr_tipo = dados[10];
                        var nome_es_tipo = dados[11];
                        var ordem_tipo = dados[12];
                        var extensao = dados[13];
                        var id_img_capa_tipo = dados[14];
                        var img_capa_tipo = dados[15];
                        var visivel = dados[16];
                        var visivelTipo = dados[17];
                        var img = '../img/portfolio/' + id + extensao;

                        $('#txtNome').val(nome);
                        $('#txtNomeEn').val(nome_en);
                        $('#txtNomeFr').val(nome_fr);
                        $('#txtNomeEs').val(nome_es);
                        $('#txtOrdem').val(ordem);

                        if (slider_inicial == "0")
                            $('#chkSlider').attr('checked', false);
                        else
                            $('#chkSlider').attr('checked', true);

                        if (visivel == "0")
                            $('#chkVisivel').attr('checked', false);
                        else
                            $('#chkVisivel').attr('checked', true);

                        if (visivelTipo == "0")
                            $('#chkVisivelTipo').attr('checked', false);
                        else
                            $('#chkVisivelTipo').attr('checked', true);

                        $('#txtNomeTipo').val(nome_tipo);
                        $('#txtNomeEnTipo').val(nome_en_tipo);
                        $('#txtNomeFrTipo').val(nome_fr_tipo);
                        $('#txtNomeEsTipo').val(nome_es_tipo);
                        $('#txtOrdemTipo').val(ordem_tipo);
                        $('#rowImagePhoto').fadeIn();
                        $("#img").attr('src', img);
                    }
                });
            }
            else {
                $('#txtNome').val('');
                $('#txtNomeEn').val('');
                $('#txtNomeFr').val('');
                $('#txtNomeEs').val('');
                $('#txtOrdem').val('0');
                $('#chkSlider').attr('checked', true);
                $('#txtNomeTipo').val('');
                $('#txtNomeEnTipo').val('');
                $('#txtNomeFrTipo').val('');
                $('#txtNomeEsTipo').val('');
                $('#txtOrdemTipo').val('0');
                $('#rowImagePhoto').fadeOut();
                $('#chkVisivel').attr('checked', true);
                $('#chkVisivelTipo').attr('checked', true);
            }
        }

        function saveData() {
            var id = $('#txtAux').val();
            var idUser = $('#txtIDUser').val();
            var nome = $('#txtNome').val();
            var nomeEn = $('#txtNomeEn').val();
            var nomeFr = $('#txtNomeFr').val();
            var nomeEs = $('#txtNomeEs').val();
            var ordem = $('#txtOrdem').val();
            var slider = $("#chkSlider").is(":checked") ? '1' : '0';
            var nomeTipo = $('#txtNomeTipo').val();
            var nomeEnTipo = $('#txtNomeEnTipo').val();
            var nomeFrTipo = $('#txtNomeFrTipo').val();
            var nomeEsTipo = $('#txtNomeEsTipo').val();
            var ordemTipo = $('#txtOrdemTipo').val();
            var visivel = $("#chkVisivel").is(":checked") ? '1' : '0';
            var visivelTipo = $("#chkVisivelTipo").is(":checked") ? '1' : '0';

            if (nome == '' || nome == null || nome == undefined) {
                sweetAlertWarning('Nome', 'Por favor indique o nome da imagem');
                return;
            }

            if (ordem == '' || ordem == null || ordem == undefined || ordem.length === 0) {
                ordem = '0';
            }

            if (nomeTipo == '' || nomeTipo == null || nomeTipo == undefined) {
                sweetAlertWarning('Tipo de Imagem Nome', 'Por favor indique o nome do tipo da imagem');
                return;
            }

            if (ordemTipo == '' || ordemTipo == null || ordemTipo == undefined || ordemTipo.length === 0) {
                ordemTipo = '0';
            }

            $('#userID').val(idUser);
            $('#aux').val(id);
            $('#nome').val(nome);
            $('#nomeEn').val(nomeEn);
            $('#nomeFr').val(nomeFr);
            $('#nomeEs').val(nomeEs);
            $('#ordem').val(ordem);
            $('#slider').val(slider);
            $('#nomeTipo').val(nomeTipo);
            $('#nomeEnTipo').val(nomeEnTipo);
            $('#nomeFrTipo').val(nomeFrTipo);
            $('#nomeEsTipo').val(nomeEsTipo);
            $('#ordemTipo').val(ordemTipo);
            $('#visivel').val(visivel);
            $('#visivelTipo').val(visivelTipo);

            $('#UploadButton').click();
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
                    loadUrl('lista_imagens.aspx');
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

        function showHideImageTypes() {
            if ($('#rowImageTypeNameNameEN').is(":visible")) {
                $('#rowImageTypeNameNameEN').fadeOut();
                $('#rowImageTypeNameFRNameES').fadeOut();
                $('#rowImageTypeOrder').fadeOut();
            }
            else {
                $('#rowImageTypeNameNameEN').fadeIn();
                $('#rowImageTypeNameFRNameES').fadeIn();
                $('#rowImageTypeOrder').fadeIn();
            }
        }

        function showHideImage() {
            if ($('#rowImageNameNameEN').is(":visible")) {
                $('#rowImageNameNameEN').fadeOut();
                $('#rowImageNameFRNameES').fadeOut();
                $('#rowImageOrderSliderVisible').fadeOut();
            }
            else {
                $('#rowImageNameNameEN').fadeIn();
                $('#rowImageNameFRNameES').fadeIn();
                $('#rowImageOrderSliderVisible').fadeIn();
            }
        }

        function searchImageTypes() {
            imageTypesDialogOpen = true;

            swal({
                title: "<strong>TIPOS DE IMAGEM</strong>",
                html: tableImageTypes,
                customClass: 'dialogWidth',
                showCancelButton: true,
                confirmButtonColor: "#DD6B55",
                confirmButtonText: "Confirmar",
                cancelButtonText: "Cancelar"
            }).then(function (isConfirm) {
                imageTypesDialogOpen = false;

                if (isConfirm) {
                    getImageTypesData();
                }
            });
        }

        function getImageTypesList() {
            var search = "";
            var open = "0";

            if (imageTypesDialogOpen) {
                search = $('#imageTypesSearchBar').val().trim();
                open = "1";
            }

            $.ajax({
                type: "POST",
                url: "config_ficha_imagem.aspx/getImageTypesList",
                data: '{"search":"' + search + '","dialogOpen":"' + open + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (res) {
                    if (imageTypesDialogOpen) {
                        $('#divTableImageTypes').html(res.d);
                    }
                    else {
                        tableImageTypes = res.d;
                    }
                }
            });
        }

        function selectImageTypesRow(id, i) {
            if (id == imageTypesIDSelected) {
                imageTypesIDSelected = "0";
                $('#imageTypesLine' + i).removeClass('highlight_line');
                return;
            }

            var total = parseInt($('#countImageTypes').html());

            for (let x = 0; x < total; x++) {
                $('#imageTypesLine' + x).removeClass('highlight_line');
            }

            imageTypesIDSelected = id;
            $('#imageTypesLine' + i).addClass('highlight_line');
        }

        function getImageTypesData() {
            $.ajax({
                type: "POST",
                url: "config_ficha_imagem.aspx/getImageTypesData",
                data: '{"id":"' + imageTypesIDSelected + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (res) {
                    var dados = res.d.split('<#SEP#>');

                    var id = dados[0];
                    var nome = dados[1];
                    var nome_en = dados[2]
                    var nome_fr = dados[3];
                    var nome_es = dados[4];
                    var ordem = dados[5];
                    var id_imagem_capa = dados[6];
                    var img_capa = dados[7];
                    var visivel = dados[8];

                    $('#txtNomeTipo').val(nome);
                    $('#txtNomeEnTipo').val(nome_en);
                    $('#txtNomeFrTipo').val(nome_fr);
                    $('#txtNomeEsTipo').val(nome_es);
                    $('#txtOrdemTipo').val(ordem);

                    if (visivel == "0")
                        $('#chkVisivelTipo').attr('checked', false);
                    else
                        $('#chkVisivelTipo').attr('checked', true);

                    imageTypesIDSelected = "";
                    $('#txtNome').focus();
                }
            });
        }

        function checkIfImageExists(url) {
            const img = new Image();
            img.src = url;

            if (img.complete) {
                return true;
            } else {
                img.onload = () => {
                    return true;
                };

                img.onerror = () => {
                    return false;
                };
            }

            return false;
        }
    </script>
</body>

</html>
