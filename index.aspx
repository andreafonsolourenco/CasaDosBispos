<%@ Page Language="C#" AutoEventWireup="true" CodeFile="index.aspx.cs" Inherits="index" Culture="auto" UICulture="auto" %>
<meta name="viewport" content="width=device-width, initial-scale=1">

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="CASA DOS BISPOS">
    <meta name="author" content="André Afonso Lourenço">
    <meta name="keywords" content="Casa dos Bispos, Aveloso, Turismo Rural, Turismo, Rural, Casa, Bispos, Mêda">
    <link rel='shortcut icon' type='image/x-icon' href='img/favicon.ico' />

    <title>Casa dos Bispos - Turismo Rural</title>
    
    <%--
    
    
    <!-- Add icon library -->--%>
    
    <%--<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="bootstrap/css/bootstrap-grid.min.css" rel="stylesheet">
    <link href="bootstrap/css/bootstrap-reboot.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">--%>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <link href="css/main.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link href="jquery-ui/jquery-ui.min.css" rel="stylesheet">
    <link href="jquery-ui/jquery-ui.structure.min.css" rel="stylesheet">
    <link href="jquery-ui/jquery-ui.theme.min.css" rel="stylesheet">
    <link href="alertifyjs/css/alertify.min.css" rel="stylesheet" type='text/css'/>
    <link href="alertifyjs/css/themes/semantic.min.css" rel="stylesheet" type='text/css'/>
    <link href="alertifyjs/css/themes/default.min.css" rel="stylesheet" type='text/css'/>
    <%--<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">--%>

    <style type="text/css">
        /* Style all font awesome icons */
        .fa {
            padding: 20px;
            font-size: 30px;
            width: auto;
            text-align: center;
            text-decoration: none;
        }

            /* Add a hover effect if you want */
            .fa:hover {
                opacity: 0.7;
            }

        /* Set a specific color for each brand */

        /* Facebook */
        .fa-facebook {
            background: #3B5998;
            color: white;
        }

        /* Twitter */
        .fa-twitter {
            background: #55ACEE;
            color: white;
        }

        .black_overlay {
            display: none;
            position: fixed;
            top: 0%;
            left: 0%;
            width: 100%;
            height: 100%;
            background-color: black;
            z-index: 1001;
            -moz-opacity: 0.8;
            opacity: .80;
            filter: alpha(opacity=80);
        }

        .carouselSlider {
            z-index: 1002;
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 75%;
            max-height: 100vh !important;
        }

        .stopScroll {
            overflow: hidden;
        }

        .maxheightclass {
            max-height: 100vh !important;
        }

        .opacity {
            opacity: 0.5;
        }

        .divPortfolioMargin {
            margin-bottom: 50px !important;
        }

        .btn {
            background-color: #78bc9d;
            color: #000;
            transition: 0.5s;
            font-size-adjust: inherit;
            font-size: x-large;
            height: auto;
        }

            .btn:hover {
                background-color: #4B94C4;
                color: #000;
                font-size-adjust: inherit;
                font-size: x-large;
                height: auto;
            }

        .textSizeSmall {
            font-size: x-small;
        }

        .titulo {
            display: block;
        }

        /* When the screen is less than 600 pixels wide, hide all links, except for the first one ("Home"). Show the link that contains should open and close the topnav (.icon) */
        @media screen and (max-width: 600px) {
            .w3-top {
                font-size: x-small;
            }

            .titulo {
                display: none;
            }
        }

        .variaveis {
            display: none !important;
        }

        .padding_logo_navbar {
            padding-top: 0 !important;
            padding-bottom: 0 !important;
        }

        .parallax {
            /* Full height */
            height: 50vh; 

            /* Create the parallax scrolling effect */
            background-attachment: fixed;
            background-position: center;
            background-repeat: no-repeat;
            background-size: cover;

            padding-left: 0 !important;
            padding-right: 0 !important;
        }

        .pt {
            background-image: url(img/pt.svg);
            background-size: 100% 100%;
            background-position: center center;
            background-repeat: no-repeat;
        }

        .en {
            background-image: url(img/en.svg);
            background-size: 100% 100%;
            background-position: center center;
            background-repeat: no-repeat;
        }

        .es {
            background-image: url(img/es.svg);
            background-size: 100% 100%;
            background-position: center center;
            background-repeat: no-repeat;
        }

        .fr {
            background-image: url(img/fr.svg);
            background-size: 100% 100%;
            background-position: center center;
            background-repeat: no-repeat;
        }

        .divLanguages {
            position: fixed;
            top: 50%;
            left: 50%;
            -webkit-transform: translate(-50%, -50%);
            -moz-transform: translate(-50%, -50%);
            -ms-transform: translate(-50%, -50%);
            -o-transform: translate(-50%, -50%);
            transform: translate(-50%, -50%);
            width: 75%;
            height: 25%;
            z-index: 1032 !important;
            opacity: 1;
            max-height: 90%;
            display: none;
        }

        .divSelectLanguage {
            height: 100% !important;
            cursor: pointer !important;
            float: left !important;
            -webkit-box-flex: 0 !important;
            -ms-flex: 0 0 25% !important;
            flex: 0 0 25% !important;
            max-width: 25% !important;
        }

        .img_slider {
            max-height: 800px !important;
            width: auto !important;
            margin: auto !important;
        }

        .mySlides {
            display:none;
            text-align: center !important;
        }

        .w3-left, .w3-right, .w3-badge {
            cursor:pointer
        }

        .w3-badge {
            height:13px;
            width:13px;
            padding:0
        }

        .imgSlides {
            width: auto; 
            height: auto;
            margin: auto !important;
            max-width: 100% !important;
            max-height: 100vh !important;
        }

        .imgSliderInicial {
            width: auto; 
            height: auto;
            margin: auto !important;
            max-width: 100% !important;
            max-height: 100vh !important;
        }

        .logoHome {
            width: auto !important;
            max-width: 100% !important;
            margin: auto !important;
        }

        .home {
            background-color: #7D0C0E;
            text-align: center;
            max-width: 100vh !important;
            max-height: 100vh !important;
            width: 100% !important;
            max-width: 100% !important;
        }

        .carousel {
            z-index: 1002;
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 75%;
            max-height: 100%;
            max-width: 100vw !important;
        }

        .closeIcon {
            top: 0;
            height: 20px;
            width: auto;
            float: right;
            cursor: pointer;
        }

        .cursorPointer {
            cursor: pointer;
        }

        #divTermosCondicoes {
            z-index: 1002;
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 95%;
            height: 95%;
            max-height: 95% !important;
            max-width: 100vw !important;
            color: #000;
            overflow-y: scroll;
            background-color: #FFF;
            border-radius: 25px;
        }
    </style>
</head>
<body>
    <div id="black_overlay" class="black_overlay" onclick="closeSlider();">
        <img src="img/icon_close.png" class="closeIcon" onclick="closeSlider();" />
    </div>

    <div id="myCarousel" class="carousel slide" data-ride="carousel"></div>

    <div id="black_overlay_termoscondicoes" class="black_overlay" onclick="closeTermosCondicoes();">
        <img src="img/icon_close.png" class="closeIcon" onclick="closeTermosCondicoes();" />
    </div>

    <div id="divTermosCondicoes" runat="server"></div>

    <!-- Navbar (sit on top) -->
    <div class="w3-top" id="navbar">
        <div class="w3-bar w3-white w3-wide w3-padding w3-card" id="navBarDiv">
            <a href="#home" class="w3-bar-item w3-button titulo padding_logo_navbar" id="homeBar"></a>
            <!-- Float links to the right. Hide them on small screens -->
            <div class="w3-right w3-hide-small" id="divMenuElements" runat="server"></div>
        </div>
    </div>

    <!-- Header -->
    <header class="w3-display-container w3-content w3-wide home" id="home">
        <div id="divSliderInicial" runat="server" class="w3-content w3-display-container"></div>
        <div class="w3-display-middle w3-margin-top w3-margin-bottom w3-center cursorPointer" onclick="openFederPage();">
            <img src="img/logo_casadosbispos_feder.png" id="logoHome" class="logoHome" />
        </div>
    </header>

    <!-- Page content -->
    <div class="w3-content w3-padding" id="content">

        <!-- About Section -->
        <%--<div class="w3-container w3-padding-32" id="about" runat="server"></div>--%>

        <div class="w3-container" id="textos" runat="server"></div>

        <%--<div class="w3-row-padding w3-grayscale" id="divEspecialidades" runat="server"></div>--%>

        <!-- Project Section -->
        <div class="w3-container w3-padding-32" id="gallery" runat="server"></div>

        <!-- Contact Section -->
        <div class="w3-container w3-padding-32" id="contact" runat="server"></div>

        <!-- End page content -->
    </div>

    <div class="black_overlay" id="overlayLanguages">
        <img src="img/icon_close.png" class="closeIcon" onclick="closeLanguagesMenu();" />
        <div id='divLanguages' class='w3-center w3-padding-16 divLanguages' runat='server'>
            <h3 class='w3-border-bottom w3-border-light-grey w3-padding-16 w3-text-primary-color w3-padding-top' id="selectLanguageTag" runat="server">Selecione a língua</h3>
            <div class="w3-padding-32 w3-col l3 m3 s3 w3-padding-small w3-justify pt divSelectLanguage" onclick="selectLanguage('PT');"></div>
            <div class="w3-padding-32 w3-col l3 m3 s3 w3-padding-small w3-justify en divSelectLanguage" onclick="selectLanguage('EN');"></div>
            <div class="w3-padding-32 w3-col l3 m3 s3 w3-padding-small w3-justify fr divSelectLanguage" onclick="selectLanguage('FR');"></div>
            <div class="w3-padding-32 w3-col l3 m3 s3 w3-padding-small w3-justify es divSelectLanguage" onclick="selectLanguage('ES');"></div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="w3-center w3-primary-color w3-padding-16">
        <p>
            <img src="img/logo_aal_white.png" style="width:100px; height: auto; margin: auto"/> &copy; 2023
        </p>
        <p class="cursorPointer" id="tagFichaOperacao" runat="server" onclick="openFichaOperacao();"></p>
        <p id="tagNumeroRegisto" runat="server"></p>
        <p id="tagTermosCondicoes" runat="server" onclick="openTermosCondicoes();" class="cursorPointer"></p>
    </footer>

    <span class="variaveis" id="txtAuxLanguage" runat="server"></span>
    <span class="variaveis" id="txtAuxUrl" runat="server"></span>

    <%--<!-- Custom scripts for this template -->--%>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="alertifyjs/alertify.min.js"></script>
    
    <%--<script type="text/javascript" src="js/jquery-3.3.1.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>--%>
    <%--<script type="text/javascript" src="jquery-ui/jquery-ui.min.js"></script>--%>
    <%--<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>--%>

    <script type="text/javascript">
        //override defaults
        alertify.defaults.transition = "slide";
        alertify.defaults.theme.ok = "btn btn-primary";
        alertify.defaults.theme.cancel = "btn btn-danger";
        alertify.defaults.theme.input = "form-control";

        var contador = 0;
        var imgDots = [];
        var totalImgs = 0;
        var slideIndex = 0;
        var sliderInicialIndex = 0;

        $("a[href^='#']").click(function (e) {
            e.preventDefault();

            var position = $($(this).attr("href")).offset().top;

            $("body, html").animate({
                scrollTop: position
            }, 2000);
        });

        $(document).ready(function () {
            ajustaTamanhos();
            carousel();

            var h = $('#divMenuElements').height();
            var element = '<img src="img/logo.png" style="height:' + h + 'px; width: auto;" id="logoTopBar"/>';
            $('#homeBar').html(element);

            fillParallaxImageEffects();

            setLanguage();
        });

        $(window).on('resize', function () {
            ajustaTamanhos();
        });

        function fillParallaxImageEffects() {
            var nrImages = $('#countTexts').html();
            var url = '';

            for (var i = 0; i < nrImages; i++) {
                if ($('#imgText' + i).length > 0) {
                    url = 'img/portfolio/' + $('#imgText' + i).html();

                    if ($('#parallax' + i).length > 0) {
                        $('#parallax' + i).css('background-image', 'url("' + url + '")');
                    }
                }
            }
        }

        function fillImgArray() {
            totalImgs = parseInt($('#countNrImg').html());

            for (var i = 0; i < totalImgs; i++) {
                imgDots.push($('#img' + i.toString()).html());
            }
        }

        function ajustaTamanhos() {
            var height = window.innerHeight;
            var width = window.innerWidth;

            $('#content').css({ "max-width": width });
            $('#home').css({ "margin-top": $('#navbar').height(), "height": height - $('#navbar').height(), "max-height": height - $('#navbar').height(), "max-width": width });
            //$('#capaHome').css({ "height": height - $('#navbar').height(), "max-height": height - $('#navbar').height(), "width": "auto" });
            $('#logoHome').css({ "height": ($('#capaHome').height() / 4), "max-height": height - $('#navbar').height() });
            $('#black_overlay').css({ "max-width": width });
            $('#overlayLanguages').css({ "max-width": width });
            $('#myCarousel').css({ "max-width": width });
            $('#navbar').css({ "max-width": width });
        }

        function closeSlider() {
            $('#black_overlay').fadeOut();
            $('#myCarousel').fadeOut();
        }

        function buildMyCarousel(x) {
            $('#myCarousel').html('');
            $.ajax({
                type: "POST",
                url: "index.aspx/loadImagesCarousel",
                data: '{"id_tipo":"' + x + '", "lingua":"' + $('#txtAuxLanguage').html() + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (res) {
                    if (res.d != null && res.d != '') {
                        var dados = res.d.split('<#SEP#>');
                        var carousel = dados[0];
                        var mobile = parseInt(dados[1]);
                        //$('#myCarousel').html(res.d);
                        //$('.carousel-caption').addClass('maxheightclass');
                        //$('#black_overlay').fadeIn();
                        //$('#myCarousel').fadeIn();
                        //$(".d-block.w-80").addClass('maxheightclass');
                        //$('.carousel-inner').addClass('maxheightclass');

                        $('#myCarousel').html(carousel);
                        $('#divSlideshow').addClass('maxheightclass');
                        $('#black_overlay').fadeIn();
                        $('#myCarousel').fadeIn();
                        $('#mySlides').addClass('maxheightclass');
                        $('#myCarousel').css({ "max-width": width });

                        slideIndex = 1;
                        showDivs(slideIndex);
                    }
                }
            });
        }

        function openTermosCondicoes() {
            $('#black_overlay_termoscondicoes').fadeIn();
            $('#divTermosCondicoes').fadeIn();
        }

        function closeTermosCondicoes() {
            $('#black_overlay_termoscondicoes').fadeOut();
            $('#divTermosCondicoes').fadeOut();
        }

        function plusDivs(n) {
            showDivs(slideIndex += n);
        }

        function currentDiv(n) {
            showDivs(slideIndex = n);
        }

        function showDivs(n) {
            var i;
            var x = document.getElementsByClassName("w3-display-container mySlides");
            var y = document.getElementsByClassName("imgSlides");
            var dots = document.getElementsByClassName("demo");
            if (n > x.length) { slideIndex = 1 }
            if (n < 1) { slideIndex = x.length }
            for (i = 0; i < x.length; i++) {
                x[i].style.display = "none";
            }
            for (i = 0; i < dots.length; i++) {
                dots[i].className = dots[i].className.replace(" w3-white", "");
            }
            x[slideIndex - 1].style.display = "block";
            dots[slideIndex - 1].className += " w3-white";
        }

        function sendEmail() {
            var assunto = $('#assunto').val().trim();
            var nome = $('#nome').val().trim();
            var email = $('#email').val().trim();
            var body = $('#texto').val().trim();

            if (assunto == '' || nome == '' || email == '' || body == '') {
                $('#errorMsgEmail').html('Por favor, para que o email seja enviado preencha todos os dados!');
                $('#errorMsgEmail').fadeIn();
                return;
            }

            $.ajax({
                type: "POST",
                url: "index.aspx/sendEmailFromTemplate",
                data: '{"assunto":"' + assunto + '", "nome":"' + nome + '", "email":"' + email + '", "body":"' + body + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (res) {
                    if (res.d != null) {
                        var dados = res.d.split('<#SEP#>');

                        if (parseInt(dados[0]) >= 0) {
                            $('#assunto').val('');
                            $('#nome').val('');
                            $('#email').val('');
                            $('#texto').val('');
                            $('#errorMsgEmail').fadeOut();
                            $("#successMsgEmail").html(dados[1]);
                            $("#successMsgEmail").fadeIn();
                            setTimeout(function () { $("#successMsgEmail").fadeOut(); }, 5000);
                        }
                        else {
                            $('#errorMsgEmail').html(dados[1]);
                            $('#errorMsgEmail').fadeIn();
                        }
                    }
                }
            });
        }

        function selectLanguage(language) {
            window.open(getUrlPage(language), '_self');
        }

        function getUrlPage(language) {
            if (window.location.href.includes('localhost')) {
                var url = window.location.href;

                if (url.includes('language=')) {
                    url = url.replace('=' + $('#txtAuxLanguage').html(), '=' + language);
                }
                else {
                    url = url + "?language=" + language;
                }

                return url;
            }

            return $('#txtAuxUrl').html() + "/index.aspx?language=" + language;
        }

        function setLanguage() {
            if ($('#txtAuxLanguage').html() == 'PT') {
                $('#btnLanguage').addClass('pt');
            }
            else if ($('#txtAuxLanguage').html() == 'EN') {
                $('#btnLanguage').addClass('en');
            }
            else if ($('#txtAuxLanguage').html() == 'FR') {
                $('#btnLanguage').addClass('fr');
            }
            else if ($('#txtAuxLanguage').html() == 'ES') {
                $('#btnLanguage').addClass('es');
            }

            var h = $('#logoTopBar').height();
            $('#btnLanguage').css({ "height": h, "width": "auto !important" });
        }

        function openLanguagesMenu() {
            $('#overlayLanguages').fadeIn();
            $('#divLanguages').fadeIn();
        }

        function closeLanguagesMenu() {
            $('#overlayLanguages').fadeOut();
            $('#divLanguages').fadeOut();
        }

        function carousel() {
            var height = window.innerHeight;
            var navbarHeight = $('#navbar').height();
            var h = height - navbarHeight;
            var hStr = h.toString() + "px";
            var i;
            var x = document.getElementsByClassName("imgSliderInicial");
            for (i = 0; i < x.length; i++) {
                x[i].style.display = "none";
            }
            sliderInicialIndex++;
            if (sliderInicialIndex > x.length) { sliderInicialIndex = 1 }
            x[sliderInicialIndex - 1].style.display = "block";
            x[sliderInicialIndex - 1].style.height = hStr;
            x[sliderInicialIndex - 1].style.maxHeight = hStr;
            x[sliderInicialIndex - 1].style.width = "auto";
            setTimeout(carousel, 5000);
        }

        function openFederPage() {
            window.open('https://www.europarl.europa.eu/factsheets/pt/sheet/95/el-fondo-europeo-de-desarrollo-regional-feder-', '_blank');
        }

        function openFichaOperacao() {
            var url = '';

            if (window.location.href.includes('localhost')) {
                url = window.location.href;

                if (url.includes('language=')) {
                    url = url.replace('?language=' + $('#txtAuxLanguage').html(), '');
                }

                url = url.replace('index.aspx', '');
            }
            else {
                url = $('#txtAuxUrl').html();
            }

            url += '/docs/FichaOperacao.pdf';

            window.open(url, '_blank');
        }
    </script>
</body>
</html>