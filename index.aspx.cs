using System;
using System.Web.UI;
using System.Web.Services;
using System.Data;
using System.Text;
using System.Web;
using System.Net.Mail;
using System.IO;

public partial class index : Page
{
    static string lingua = "";

    protected void Page_Init(object sender, EventArgs e)
    {

    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            
        }

        getLanguage();
        getUrl();
        getSliderInicial();
        getMenu();
        getTextos();
        getPortfolio();
        getContactos();
        getNumeroRegisto();
        getTermosCondicoes();
        tagFichaOperacao.InnerHtml = getTranslation("Consulte aqui a Ficha de Operação");
    }

    private void getLanguage()
    {
        try
        {
            lingua = Request.QueryString["language"];

            if(string.IsNullOrEmpty(lingua) || lingua == null)
            {
                lingua = "PT";
            }
        }
        catch(Exception e)
        {
            lingua = "PT";
        }

        txtAuxLanguage.InnerHtml = lingua;
        selectLanguageTag.InnerHtml = getTranslation("Selecione a língua");
    }

    private static string getTranslation(string word)
    {
        if(lingua.ToUpper() == "EN")
        {
            switch(word)
            {
                case "Sobre Nós":
                    return "About Us";
                case "Galeria":
                    return "Gallery";
                case "Contactos":
                    return "Contacts";
                case "Nome":
                    return "Name";
                case "Email":
                    return "Email";
                case "Assunto":
                    return "Subject";
                case "Texto":
                    return "Text";
                case "Escreva o seu texto aqui...":
                    return "Write your text here...";
                case "ENVIAR":
                    return "SEND";
                case "Ocorreu um erro ao enviar o email! Por favor, tente novamente ou contacte-nos através do email acima! Obrigado!":
                    return "An error occurred while sending the email! Please try again or contact us via the email above! Thanks!";
                case "Agradecemos a sua mensagem! Tentaremos responder o mais brevemente possível. Obrigado!":
                    return "Thank you for your message! We will try to respond as soon as possible. Thank you!";
                case "Email de Contacto através do site":
                    return "Contact Email from the site";
                case "Esta resposta é enviada automaticamente! Por favor, não responda a este email. Para qualquer contacto, utilize o nosso site ou o email presente neste rodapé. Obrigado!":
                    return "This reply is sent automatically! Please do not reply to this email. For any contact, please use our website or the email in this footer. Thank you!";
                case "Turismo Rural":
                    return "Rural Tourism";
                case "Selecione a língua":
                    return "Select language";
                case "Alojamento":
                    return "Housing";
                case "Anterior":
                    return "Previous";
                case "Seguinte":
                    return "Next";
                case "Consulte aqui a Ficha de Operação":
                    return "Consult the Operation Form here";
                case "FECHAR":
                    return "CLOSE";
                default:
                    return word;
            }
        }

        if (lingua.ToUpper() == "FR")
        {
            switch (word)
            {
                case "Sobre Nós":
                    return "À propôs de nous";
                case "Galeria":
                    return "Galerie";
                case "Contactos":
                    return "Contacts";
                case "Nome":
                    return "Prénom, Nom";
                case "Email":
                    return "Email";
                case "Assunto":
                    return "Sujet";
                case "Texto":
                    return "Texte";
                case "Escreva o seu texto aqui...":
                    return "Écrivez vorte texte ici...";
                case "ENVIAR":
                    return "ENVOYER";
                case "Ocorreu um erro ao enviar o email! Por favor, tente novamente ou contacte-nos através do email acima! Obrigado!":
                    return "Une erreur s'est produite lors de l'envoi du email! Veuillez réessayer ou nous contacter par l'e-mail ci-dessus! Nous vous remercions de votre attention!";
                case "Agradecemos a sua mensagem! Tentaremos responder o mais brevemente possível. Obrigado!":
                    return "Merci pour votre message! Nous nous efforcerons de vous répondre dans les meilleurs délais. Nous nous efforcerons de vous répondre dans les plus brefs délais!";
                case "Email de Contacto através do site":
                    return "Contact par email via le site web";
                case "Esta resposta é enviada automaticamente! Por favor, não responda a este email. Para qualquer contacto, utilize o nosso site ou o email presente neste rodapé. Obrigado!":
                    return "Cette réponse est envoyée automatiquement! Ne répondez pas à cet e-mail. Pour tout contact, veuillez utiliser notre site web ou l'adresse électronique figurant dans ce pied de page. Merci de votre compréhension!";
                case "Turismo Rural":
                    return "Tourisme Rural";
                case "Selecione a língua":
                    return "Choix de la langue";
                case "Alojamento":
                    return "Hébergement";
                case "Anterior":
                    return "Précédent";
                case "Seguinte":
                    return "Suivant";
                case "Consulte aqui a Ficha de Operação":
                    return "Consultez la Fiche d'Utilisation ici";
                case "FECHAR":
                    return "FERMER";
                default:
                    return word;
            }
        }

        if (lingua.ToUpper() == "ES")
        {
            switch (word)
            {
                case "Sobre Nós":
                    return "Quiénes Somos";
                case "Galeria":
                    return "Galería";
                case "Contactos":
                    return "Contactos";
                case "Nome":
                    return "Nombre";
                case "Email":
                    return "Correo Electrónico";
                case "Assunto":
                    return "Asunto";
                case "Texto":
                    return "Texto";
                case "Escreva o seu texto aqui...":
                    return "Escriba aquí su texto...";
                case "ENVIAR":
                    return "ENVIAR";
                case "Ocorreu um erro ao enviar o email! Por favor, tente novamente ou contacte-nos através do email acima! Obrigado!":
                    return "¡Se ha producido un error al enviar el correo electrónico! ¡Inténtelo de nuevo o póngase en contacto con nosotros a través del correo electrónico anterior! ¡Gracias!";
                case "Agradecemos a sua mensagem! Tentaremos responder o mais brevemente possível. Obrigado!":
                    return "¡Gracias por su mensaje! Intentaremos responderle lo antes posible. ¡Gracias!";
                case "Email de Contacto através do site":
                    return "Contacto por correo electrónico a través del sitio";
                case "Esta resposta é enviada automaticamente! Por favor, não responda a este email. Para qualquer contacto, utilize o nosso site ou o email presente neste rodapé. Obrigado!":
                    return "¡Esta respuesta se envía automáticamente! Por favor, no responda a este correo electrónico. Para cualquier contacto, utilice nuestro sitio web o el correo electrónico de este pie de página. ¡Gracias!";
                case "Turismo Rural":
                    return "Turismo Rural";
                case "Selecione a língua":
                    return "Seleccionar idioma";
                case "Alojamento":
                    return "Alojamiento";
                case "Anterior":
                    return "Anterior";
                case "Seguinte":
                    return "Siguiente";
                case "Consulte aqui a Ficha de Operação":
                    return "Consulte aquí la Ficha de Funcionamiento";
                case "FECHAR":
                    return "CERRAR";
                default:
                    return word;
            }
        }

        return word;
    }

    private void getUrl()
    {
        DataSqlServer oDB = new DataSqlServer();

        try
        {
            string sql = string.Format(@"   SET DATEFORMAT dmy;
                                            select [url] from report_configs()");

            DataSet oDs = oDB.GetDataSet(sql, "").oData;

            if (oDB.validaDataSet(oDs))
            {
                for (int i = 0; i < oDs.Tables[0].Rows.Count; i++)
                {
                    string url = oDs.Tables[0].Rows[i]["url"].ToString();

                    txtAuxUrl.InnerHtml = url;
                }
            }
            else
            {

            }
        }
        catch (Exception exc)
        {
            txtAuxUrl.InnerHtml = "https://www.casadosbispos.pt";
        }
    }

    private void getMenu()
    {
        var table = new StringBuilder();

        try
        {
            table.AppendFormat(@"   <a href='#' onclick='openLanguagesMenu();' class='w3-bar-item w3-button w3-margin-right' id='btnLanguage'></a>
                                    <a href='#textos' class='w3-bar-item w3-button w3-primary-color w3-margin-right'>{0}</a>
                                    <a href='#gallery' class='w3-bar-item w3-button w3-primary-color w3-margin-right'>{1}</a>
                                    <a href='#contact' class='w3-bar-item w3-button w3-primary-color'>{2}</a>", getTranslation("Sobre Nós"), getTranslation("Alojamento"), getTranslation("Contactos"));
        }
        catch (Exception exc)
        {
            divMenuElements.InnerHtml = String.Empty;
        }

        divMenuElements.InnerHtml = table.ToString();
    }

    private void getTextos()
    {
        var table = new StringBuilder();
        DataSqlServer oDB = new DataSqlServer();

        try
        {
            string sql = string.Format(@"   SET DATEFORMAT dmy;
                                            DECLARE @id_texto int
                                            DECLARE @codigo varchar(100)
                                            DECLARE @lingua varchar(10) = '{0}';
                                            select nome, texto, id_imagem, extensao_imagem 
                                            from SITE_REPORT_TEXTOS(@codigo, @id_texto, @lingua)
                                            where codigo not in ('ALOJAMENTO', 'NUMERO_REGISTO', 'TERMOSECONDICOES')
                                            order by ordem asc", lingua);

            DataSet oDs = oDB.GetDataSet(sql, "").oData;

            if (oDB.validaDataSet(oDs))
            {
                for (int i = 0; i < oDs.Tables[0].Rows.Count; i++)
                {
                    string id_imagem = oDs.Tables[0].Rows[i]["id_imagem"].ToString();
                    string extensao_imagem = oDs.Tables[0].Rows[i]["extensao_imagem"].ToString();
                    string nome = oDs.Tables[0].Rows[i]["nome"].ToString();
                    string texto = oDs.Tables[0].Rows[i]["texto"].ToString();

                    table.AppendFormat(@"<div class='w3-padding-32 w3-col l12 m12 s12 w3-padding-small w3-justify'><h3 class='w3-text-primary-color'>{0}</h3><p>{1}</p></div>", nome, texto);

                    if(id_imagem != "0")
                    {
                        table.AppendFormat(@"<div class='w3-col l12 m12 s12 w3-padding-small w3-justify parallax' id='parallax{0}'></div>", i);
                        table.AppendFormat(@"<span class='variaveis' id='imgText{0}'>{1}</span>", i, id_imagem + extensao_imagem);
                    }
                }

                table.AppendFormat(@"<span class='variaveis' id='countTexts'>{0}</span>", oDs.Tables[0].Rows.Count);
            }
            else
            {

            }
        }
        catch (Exception exc)
        {
            textos.InnerHtml = exc.ToString();
        }

        textos.InnerHtml = table.ToString();
    }

    private void getContactos()
    {
        var table = new StringBuilder();
        DataSqlServer oDB = new DataSqlServer();

        try
        {
            string sql = string.Format(@"   SET DATEFORMAT dmy;
                                            select nome, morada1, morada2, cod_postal, localidade, telefone, email
                                            from REPORT_CONTACTOS()");

            DataSet oDs = oDB.GetDataSet(sql, "").oData;

            if (oDB.validaDataSet(oDs))
            {
                table.AppendFormat(@"<h3 class='w3-border-bottom w3-border-light-grey w3-padding-16 w3-text-primary-color w3-padding-top'>{0}</h3><p>", getTranslation("Contactos"));

                for (int i = 0; i < oDs.Tables[0].Rows.Count; i++)
                {
                    string nome = oDs.Tables[0].Rows[i]["nome"].ToString();
                    string morada1 = oDs.Tables[0].Rows[i]["morada1"].ToString();
                    string morada2 = oDs.Tables[0].Rows[i]["morada2"].ToString();
                    string cod_postal = oDs.Tables[0].Rows[i]["cod_postal"].ToString();
                    string localidade = oDs.Tables[0].Rows[i]["localidade"].ToString();
                    string telefone = oDs.Tables[0].Rows[i]["telefone"].ToString();
                    string email = oDs.Tables[0].Rows[i]["email"].ToString();

                    table.AppendFormat(@"{0}<br />{1}<br />{2}{3} {4}{5}{6}", nome, morada1, String.IsNullOrEmpty(morada2) ? String.Empty : (morada2 + "<br />"), cod_postal, localidade,
                        String.IsNullOrEmpty(telefone) ? String.Empty : ("<br />" + telefone), String.IsNullOrEmpty(email) ? String.Empty : ("<br />" + email));
                }

                table.AppendFormat(@"   </p><input class='w3-input w3-border' type='text' placeholder='{0}' required name='nome' id='nome' />
                                        <input class='w3-input w3-section w3-border' type='text' placeholder='{1}' required name='email' id='email' />
                                        <input class='w3-input w3-section w3-border' type='text' placeholder='{2}' required name='assunto' id='assunto' />
                                        <textarea class='w3-input w3-section w3-border' placeholder='{3}' required name='texto' rows='5' id='texto'></textarea>
                                        <input class='form-control btn w3-button w3-primary-color w3-margin-bottom' type='button' value='{4}' onclick='sendEmail();' />
                                        <div style='width: 100%; height: auto; text-align: center; margin-bottom: 20px !important;' >
                                            <span style='display: none; color: red;' id='errorMsgEmail'></span>
                                            <span style='display: none; color: green;' id='successMsgEmail'></span>
                                        </div>

                                        <div id='googleMap' style='width: 100%; height: 450px;'>
                                            <iframe src='https://www.google.com/maps/embed?pb=!1m17!1m12!1m3!1d24111.426339144306!2d-7.326666019928657!3d40.93923738239909!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m2!1m1!2zNDDCsDU2JzAyLjIiTiA3wrAxOCc1OC4yIlc!5e0!3m2!1spt-PT!2spt!4v1677429667146!5m2!1spt-PT!2spt' frameborder='0' style='border: 0; width: 100%; height: 100%;' allowfullscreen></iframe>
                                        </div>", getTranslation("Nome"), getTranslation("Email"), getTranslation("Assunto"), getTranslation("Escreva aqui o seu texto..."),
                                        getTranslation("ENVIAR"));
            }
            else
            {

            }
        }
        catch (Exception exc)
        {
            contact.InnerHtml = exc.ToString();
        }

        contact.InnerHtml = table.ToString();
    }

    private void getSliderInicial()
    {
        var table = new StringBuilder();
        DataSqlServer oDB = new DataSqlServer();

        try
        {
            string sql = string.Format(@"   SET DATEFORMAT dmy;
                                            DECLARE @img varchar(500);

                                            select imagem, ordem
                                            from SITE_REPORT_MAIN_IMAGES(@img)
                                            order by ordem, imagem");

            DataSet oDs = oDB.GetDataSet(sql, "").oData;

            table.AppendFormat(@"<img class='w3-image imgSliderInicial' src='img/capa.jpeg' alt='CASA DOS BISPOS' id='capaHome'>");

            if (oDB.validaDataSet(oDs))
            {
                for (int i = 0; i < oDs.Tables[0].Rows.Count; i++)
                {
                    table.AppendFormat(@"<img class='w3-image imgSliderInicial' src='img/portfolio/{0}' style='margin:auto !important';>", oDs.Tables[0].Rows[i]["imagem"].ToString());
                }
            }
        }
        catch (Exception exc)
        {
            divSliderInicial.InnerHtml = exc.ToString();
        }

        divSliderInicial.InnerHtml = table.ToString();
    }

    private void getPortfolio()
    {
        var table = new StringBuilder();
        DataSqlServer oDB = new DataSqlServer();

        try
        {
            string sql = string.Format(@"   SET DATEFORMAT dmy;
                                            DECLARE @id_tipo int;
                                            DECLARE @lingua varchar(10) = '{0}';
                                            DECLARE @id_texto int
                                            DECLARE @codigo varchar(100) = '{1}';
                                           
                                            select nome, texto 
                                            from SITE_REPORT_TEXTOS(@codigo, @id_texto, @lingua)
                                            order by ordem asc

                                            select
                                                id,
		                                        nome,
		                                        ordem,
		                                        id_imagem_capa,
		                                        img_capa
                                            from SITE_REPORT_IMAGEM_TIPO(@id_tipo, @lingua)
                                            where visivel = 1
                                            order by ordem", lingua, "ALOJAMENTO");

            DataSet oDs = oDB.GetDataSet(sql, "").oData;

            if (oDB.validaDataSet(oDs))
            {
                for (int i = 0; i < oDs.Tables[0].Rows.Count; i++)
                {
                    var titulo = oDs.Tables[0].Rows[i]["nome"].ToString();
                    var texto = oDs.Tables[0].Rows[i]["texto"].ToString();

                    table.AppendFormat(@"   <h3 class='w3-border-bottom w3-border-light-grey w3-padding-16 w3-text-primary-color'>{0}</h3><p>{1}</p>", titulo, texto);
                }

                var widthClass = "";
                int rowsCount = oDs.Tables[1].Rows.Count;

                if (rowsCount % 2 == 0 || rowsCount % 4 == 0)
                {
                    widthClass = " l6 m6 ";
                }
                else if (rowsCount % 3 == 0)
                {
                    widthClass = " l4 m12 ";
                }
                else
                {
                    widthClass = " l12 m12 ";
                }

                for (int i = 0; i < rowsCount; i++)
                {
                    var id_tipo = oDs.Tables[1].Rows[i]["id"].ToString();
                    var nome_tipo = oDs.Tables[1].Rows[i]["nome"].ToString();
                    var ordem_tipo = oDs.Tables[1].Rows[i]["ordem"].ToString();
                    var img_capa = oDs.Tables[1].Rows[i]["img_capa"].ToString();
                    var id_img_capa = oDs.Tables[1].Rows[i]["id_imagem_capa"].ToString();

                    table.AppendFormat(@"   <div class='w3-col {3} w3-margin-bottom w3-padding-small' onclick='buildMyCarousel({2});' style='cursor: pointer;'>
                                                <div class='w3-display-container divPortfolioMargin'>
                                                    <div class='w3-display-topleft w3-primary-color w3-padding'>{1}</div>
                                                    {0}
                                                </div>
                                            </div>", string.Format(@"<img src='img/portfolio/{0}' alt='{1}' style='width:100%'>", String.IsNullOrEmpty(img_capa) ? "noimg.png" : img_capa, nome_tipo), nome_tipo, id_tipo, widthClass);
                }

                gallery.InnerHtml = table.ToString();
            }
            else
            {
                gallery.InnerHtml = String.Empty;
            }
        }
        catch (Exception exc)
        {
            gallery.InnerHtml = String.Empty;
        }
    }

    private void getNumeroRegisto()
    {
        DataSqlServer oDB = new DataSqlServer();

        try
        {
            string sql = string.Format(@"   SET DATEFORMAT dmy;
                                            DECLARE @id_texto int
                                            DECLARE @codigo varchar(100) = 'NUMERO_REGISTO';
                                            DECLARE @lingua varchar(10) = '{0}';
                                            select texto 
                                            from SITE_REPORT_TEXTOS(@codigo, @id_texto, @lingua)", lingua);

            DataSet oDs = oDB.GetDataSet(sql, "").oData;

            if (oDB.validaDataSet(oDs))
            {
                for (int i = 0; i < oDs.Tables[0].Rows.Count; i++)
                {
                    string texto = oDs.Tables[0].Rows[i]["texto"].ToString();

                    tagNumeroRegisto.InnerHtml = texto;
                }
            }
        }
        catch (Exception exc)
        {
            tagNumeroRegisto.InnerHtml = exc.ToString();
        }
    }

    private void getTermosCondicoes()
    {
        DataSqlServer oDB = new DataSqlServer();

        try
        {
            string sql = string.Format(@"   SET DATEFORMAT dmy;
                                            DECLARE @id_texto int
                                            DECLARE @codigo varchar(100) = 'TERMOSECONDICOES';
                                            DECLARE @lingua varchar(10) = '{0}';
                                            select nome, texto 
                                            from SITE_REPORT_TEXTOS(@codigo, @id_texto, @lingua)", lingua);

            DataSet oDs = oDB.GetDataSet(sql, "").oData;

            if (oDB.validaDataSet(oDs))
            {
                for (int i = 0; i < oDs.Tables[0].Rows.Count; i++)
                {
                    string texto = oDs.Tables[0].Rows[i]["texto"].ToString();
                    string titulo = oDs.Tables[0].Rows[i]["nome"].ToString();
                    string textoFinal = String.Format(@"<div class='w3-padding-32 w3-col l12 m12 s12 w3-padding-small w3-justify'>
                                                            <h3 class='w3-border-bottom w3-border-light-grey w3-padding-16 w3-text-primary-color'>{0}</h3>
                                                            <p>{1}</p>
                                                            <input class='form-control btn w3-button w3-primary-color w3-margin-bottom' type='button' value='{2}' onclick='closeTermosCondicoes();' />
                                                        </div>", titulo, texto, getTranslation("FECHAR"));

                    tagTermosCondicoes.InnerHtml = titulo;
                    divTermosCondicoes.InnerHtml = textoFinal;
                }
            }
        }
        catch (Exception exc)
        {
            tagTermosCondicoes.InnerHtml = exc.ToString();
            divTermosCondicoes.InnerHtml = exc.ToString();
        }
    }

    [WebMethod]
    public static string registerSiteContact(string nome, string email, string assunto, string texto, string sucesso)
    {
        var table = new StringBuilder();
        DataSqlServer oDB = new DataSqlServer();

        try
        {
            string sql = string.Format(@"   SET DATEFORMAT dmy;
                                            DECLARE @nome varchar(500) = '{0}';
                                            DECLARE @email varchar(500) = '{1}';
                                            DECLARE @assunto varchar(500) = '{2}';
                                            DECLARE @texto varchar(max) = '{3}';
                                            DECLARE @sucesso bit = {4};
                                            DECLARE @ret int;
                                            DECLARE @retMsg varchar(max);

                                            EXEC REGISTA_CONTACTO_SITE @nome, @email, @assunto, @texto, @sucesso, @ret OUTPUT, @retMsg OUTPUT

                                            SELECT @ret as ret, @retMsg as retMsg", nome, email, assunto, texto, sucesso);

            DataSet oDs = oDB.GetDataSet(sql, "").oData;
            if (oDB.validaDataSet(oDs))
            {
                for (int i = 0; i < oDs.Tables[0].Rows.Count; i++)
                {
                    table.AppendFormat(@"{0}<#SEP#>{1}", oDs.Tables[0].Rows[i]["ret"].ToString(), oDs.Tables[0].Rows[i]["retMsg"].ToString());
                }

                return table.ToString();
            }
        }
        catch (Exception exc)
        {
            return "-1<#SEP#>Ocorreu um erro ao enviar o email! Por favor, tente novamente!";
        }

        return "-1<#SEP#>Ocorreu um erro ao enviar o email! Por favor, tente novamente!";
    }



    [WebMethod]
    public static string sendEmailFromTemplate(string assunto, string nome, string email, string body)
    {
        var table = new StringBuilder();
        DataSqlServer oDB = new DataSqlServer();
        string sendEmail = "", sendEmailPwd = "", sendEmailSTMP = "", sendEmailSMTPPort = "", sendEmailEmailsAlerta = "", url = "";
        string cdbNome = "", cdbMorada1 = "", cdbMorada2 = "", cdbCodPostal = "", cdbLocalidade = "", cdbEmail = "", cdbTelefone = "";

        try
        {
            string sql = string.Format(@"   SET DATEFORMAT dmy;
                                            
	                                        select
		                                        email, 
		                                        email_password, 
		                                        email_smtp, 
		                                        email_smtpport, 
		                                        emails_alerta, 
		                                        sessaomaxmin,
		                                        [url]
                                            from REPORT_CONFIGS()

                                            select
		                                        NOME,
		                                        MORADA1,
		                                        MORADA2,
		                                        COD_POSTAL,
		                                        LOCALIDADE,
		                                        email,
		                                        telefone
	                                        from REPORT_CONTACTOS()");

            DataSet oDs = oDB.GetDataSet(sql, "").oData;
            if (oDB.validaDataSet(oDs))
            {
                for (int i = 0; i < oDs.Tables[0].Rows.Count; i++)
                {
                    sendEmail = oDs.Tables[0].Rows[i]["email"].ToString();
                    sendEmailPwd = oDs.Tables[0].Rows[i]["email_password"].ToString();
                    sendEmailSTMP = oDs.Tables[0].Rows[i]["email_smtp"].ToString();
                    sendEmailSMTPPort = oDs.Tables[0].Rows[i]["email_smtpport"].ToString();
                    sendEmailEmailsAlerta = oDs.Tables[0].Rows[i]["emails_alerta"].ToString();
                    url = oDs.Tables[0].Rows[i]["url"].ToString();
                }

                for (int i = 0; i < oDs.Tables[1].Rows.Count; i++)
                {
                    cdbNome = oDs.Tables[1].Rows[i]["NOME"].ToString();
                    cdbMorada1 = oDs.Tables[1].Rows[i]["MORADA1"].ToString();
                    cdbMorada2 = oDs.Tables[1].Rows[i]["MORADA2"].ToString();
                    cdbCodPostal = oDs.Tables[1].Rows[i]["COD_POSTAL"].ToString();
                    cdbLocalidade = oDs.Tables[1].Rows[i]["LOCALIDADE"].ToString();
                    cdbEmail = oDs.Tables[1].Rows[i]["email"].ToString();
                    cdbTelefone = oDs.Tables[1].Rows[i]["telefone"].ToString();
                }
            }
            else
            {
                return "-1<#SEP#>" + getTranslation("Ocorreu um erro ao enviar o email! Por favor, tente novamente ou contacte-nos através do email acima! Obrigado!");
            }

            MailMessage mailMessage = new MailMessage();
            string emailBody = "";

            string newsletterText = string.Empty;
            newsletterText = File.ReadAllText(HttpContext.Current.Server.MapPath("~") + "\\templates\\template_email.html");

            emailBody += "Nome: " + nome + "<br />";
            emailBody += "Email: " + email + "<br />";
            emailBody += body.Replace("\n", "<br />") + "<br /><br />";
 
            // ------------------------------------
            // Processa o template 
            // ------------------------------------
            newsletterText = newsletterText.Replace("[EMAIL_INTRO]", "Email de Contacto através do site www.casadosbispos.pt<br />" + assunto);
            newsletterText = newsletterText.Replace("[EMAIL_TEXTBODY]", emailBody);
            newsletterText = newsletterText.Replace("[SUBJECT]", assunto);
            newsletterText = newsletterText.Replace("[URL]", url);
            newsletterText = newsletterText.Replace("[NAME]", cdbNome);
            newsletterText = newsletterText.Replace("[ADDRESS]", cdbMorada1 + (String.IsNullOrEmpty(cdbMorada2) ? String.Empty : "<br />" + cdbMorada2));
            newsletterText = newsletterText.Replace("[CITY_POSTAL_CODE]", cdbCodPostal + " " + cdbLocalidade);
            newsletterText = newsletterText.Replace("[PHONE]", (String.IsNullOrEmpty(cdbTelefone) ? String.Empty : cdbTelefone));
            newsletterText = newsletterText.Replace("[EMAIL]", (String.IsNullOrEmpty(cdbEmail) ? String.Empty : cdbEmail));
            newsletterText = newsletterText.Replace("[DO_NOT_ANSWER]", "");


            // ------------------------------------
            mailMessage.From = new MailAddress(sendEmail, "CASA DOS BISPOS - Turismo Rural");

            int x = 0;

            foreach (var word in sendEmailEmailsAlerta.Split(';'))
            {
                if (x == 0)
                {
                    mailMessage.To.Add(word);
                }
                else
                {
                    mailMessage.Bcc.Add(word);
                }
                x++;
            }

            mailMessage.Subject = assunto;
            mailMessage.Body = newsletterText;
            mailMessage.IsBodyHtml = true;
            mailMessage.Priority = MailPriority.Normal;

            string html = "html";

            mailMessage.SubjectEncoding = System.Text.Encoding.UTF8;
            mailMessage.BodyEncoding = System.Text.Encoding.UTF8;

            System.Net.Mail.SmtpClient smtpClient = new System.Net.Mail.SmtpClient(sendEmailSTMP);
            System.Net.NetworkCredential mailAuthentication = new System.Net.NetworkCredential(sendEmail, sendEmailPwd);

            smtpClient.EnableSsl = false;
            smtpClient.UseDefaultCredentials = false;
            smtpClient.Credentials = mailAuthentication;
            smtpClient.Timeout = 50000;
            smtpClient.DeliveryMethod = System.Net.Mail.SmtpDeliveryMethod.Network;

            smtpClient.Send(mailMessage);
            smtpClient.Dispose();

            newsletterText = string.Empty;
            newsletterText = File.ReadAllText(HttpContext.Current.Server.MapPath("~") + "\\templates\\template_email.html");

            emailBody = string.Empty;
            emailBody += getTranslation("Agradecemos a sua mensagem! Tentaremos responder o mais brevemente possível. Obrigado!") + "<br /><br />";
            emailBody += getTranslation("Nome") + ": " + nome + "<br />";
            emailBody += getTranslation("Email") + ": " + email + "<br />";
            emailBody += body.Replace("\n", "<br />") + "<br /><br />";
            newsletterText = newsletterText.Replace("[EMAIL_INTRO]", getTranslation("Email de Contacto através do site") + " " + url + "<br />" + assunto);
            newsletterText = newsletterText.Replace("[EMAIL_TEXTBODY]", emailBody);
            newsletterText = newsletterText.Replace("[SUBJECT]", assunto);
            newsletterText = newsletterText.Replace("[URL]", url);
            newsletterText = newsletterText.Replace("[NAME]", cdbNome);
            newsletterText = newsletterText.Replace("[ADDRESS]", cdbMorada1 + (String.IsNullOrEmpty(cdbMorada2) ? String.Empty : "<br />" + cdbMorada2));
            newsletterText = newsletterText.Replace("[CITY_POSTAL_CODE]", cdbCodPostal + " " + cdbLocalidade);
            newsletterText = newsletterText.Replace("[PHONE]", (String.IsNullOrEmpty(cdbTelefone) ? String.Empty : cdbTelefone));
            newsletterText = newsletterText.Replace("[EMAIL]", (String.IsNullOrEmpty(cdbEmail) ? String.Empty : cdbEmail));
            newsletterText = newsletterText.Replace("[DO_NOT_ANSWER]", getTranslation("Esta resposta é enviada automaticamente! Por favor, não responda a este email. Para qualquer contacto, utilize o nosso site ou o email presente neste rodapé. Obrigado!"));

            mailMessage.From = new MailAddress(sendEmail, "CASA DOS BISPOS - " + getTranslation("Turismo Rural"));

            mailMessage.To.Add(email);

            foreach (var word in sendEmailEmailsAlerta.Split(';'))
            {
                mailMessage.Bcc.Add(word);
            }

            mailMessage.Subject = assunto;
            mailMessage.Body = newsletterText;
            mailMessage.IsBodyHtml = true;
            mailMessage.Priority = MailPriority.Normal;

            mailMessage.SubjectEncoding = System.Text.Encoding.UTF8;
            mailMessage.BodyEncoding = System.Text.Encoding.UTF8;

            smtpClient = new System.Net.Mail.SmtpClient(sendEmailSTMP);
            mailAuthentication = new System.Net.NetworkCredential(sendEmail, sendEmailPwd);

            //smtpClient.Port = Convert.ToInt32(_smtpport);
            smtpClient.EnableSsl = false;
            smtpClient.UseDefaultCredentials = false;
            smtpClient.Credentials = mailAuthentication;
            smtpClient.Timeout = 50000;
            smtpClient.DeliveryMethod = System.Net.Mail.SmtpDeliveryMethod.Network;

            smtpClient.Send(mailMessage);
            smtpClient.Dispose();

            return registerSiteContact(nome, email, assunto, body, "1");
        }
        catch (Exception ex)
        {
            registerSiteContact(nome, email, assunto, body, "0");

            return "-1<#SEP#>" + getTranslation("Ocorreu um erro ao enviar o email! Por favor, tente novamente ou contacte-nos através do email acima! Obrigado!");
        }
    }

    [WebMethod]
    public static string loadImagesCarousel(string id_tipo, string lingua)
    {
        var table = new StringBuilder();
        DataSqlServer oDB = new DataSqlServer();

        try
        {
            string sql = string.Format(@"   SET DATEFORMAT dmy;
                                            DECLARE @id int;
                                            DECLARE @id_tipo int = {0};
                                            DECLARE @lingua varchar(10) = '{1}';

                                            select
                                                id,
		                                        nome,
		                                        ordem,
		                                        slider_inicial,
		                                        extensao,
		                                        id_tipo,
		                                        nome_tipo,
		                                        ordem_tipo,
		                                        id_imagem_capa_tipo,
		                                        img_capa_tipo
                                            from SITE_REPORT_IMAGEM(@id, @id_tipo, @lingua)
                                            where visivel = 1
                                            and visivel_tipo = 1
                                            order by ordem", id_tipo, lingua);

            DataSet oDs = oDB.GetDataSet(sql, "").oData;
            //if (oDB.validaDataSet(oDs))
            //{
            //    int rows = oDs.Tables[0].Rows.Count;

            //    table.AppendFormat(@"<ol class='carousel-indicators'>");

            //    for (int i = 0; i < rows; i++)
            //    {
            //        table.AppendFormat(@"<li data-target='#myCarousel' data-slide-to='{0}' {1}></li>", i.ToString(), i == 0 ? "class='active'" : "");
            //    }

            //    table.AppendFormat(@"</ol><div class='carousel-inner'>");

            //    for (int i = 0; i < rows; i++)
            //    {
            //        var id = oDs.Tables[0].Rows[i]["id"].ToString();
            //        var nome = oDs.Tables[0].Rows[i]["nome"].ToString();
            //        var extensao = oDs.Tables[0].Rows[i]["extensao"].ToString();
            //        var tipo = oDs.Tables[0].Rows[i]["nome_tipo"].ToString();

            //        table.AppendFormat(@"   <div class='item {1}' style='max-height: 800px !important; width: auto !important; margin: auto !important;'>
            //                                    <img src='img/portfolio/{0}' alt='{2} - {3}' />
            //                                    <div class='carousel-caption'>
            //                                        <h3>{2}</h3>
            //                                        <p>{3}</p>
            //                                    </div>
            //                                </div>", (id + extensao), i == 0 ? "active" : "", tipo, nome);
            //    }

            //    table.AppendFormat(@"</div>
            //                            <a class='left carousel-control' href='#myCarousel' data-slide='prev'>
            //                                <span class='glyphicon glyphicon-chevron-left' aria-hidden='true'></span>
            //                                <span class='sr-only'>{0}</span>
            //                            </a>
            //                            <a class='right carousel-control' href='#myCarousel' data-slide='next'>
            //                                <span class='glyphicon glyphicon-chevron-right' aria-hidden='true'></span>
            //                                <span class='sr-only'>{1}</span>
            //                            </a>", getTranslation("Anterior"), getTranslation("Seguinte"));
            //}
            if (oDB.validaDataSet(oDs))
            {
                int rows = oDs.Tables[0].Rows.Count;

                table.AppendFormat(@"<div class='w3-content w3-display-container' id='divSlideshow'>");

                for (int i = 0; i < rows; i++)
                {
                    var id = oDs.Tables[0].Rows[i]["id"].ToString();
                    var nome = oDs.Tables[0].Rows[i]["nome"].ToString();
                    var extensao = oDs.Tables[0].Rows[i]["extensao"].ToString();
                    var tipo = oDs.Tables[0].Rows[i]["nome_tipo"].ToString();
                    var imgName = "img/portfolio/" + id + extensao;

                    table.AppendFormat(@"   <div class='w3-display-container mySlides'>
                                                <img class='imgSlides' src='{0}'>
                                                <div class='w3-display-topmiddle w3-medium w3-container w3-padding-16 w3-black w3-opacity-min' style='text-align:center;'>
                                                    <p>{1}</p>
                                                    <p>{2}</p>
                                                </div>
                                            </div>", imgName, tipo, nome);
                }

                table.AppendFormat(@"   <button class='w3-button w3-black w3-display-left' onclick='plusDivs(-1)'>&#10094;</button>
                                        <button class='w3-button w3-black w3-display-right' onclick='plusDivs(1)'>&#10095;</button>
                                        <div class='w3-center w3-container w3-section w3-large w3-text-white w3-display-bottommiddle' style='width:100%'>");

                for (int i = 0; i < rows; i++)
                {
                    table.AppendFormat(@"   <span class='w3-badge demo w3-border w3-transparent w3-hover-white' onclick='currentDiv({0})'></span>", (i + 1).ToString());
                }

                table.AppendFormat(@"</div></div>");
            }
            else
            {
                return String.Empty;
            }
        }
        catch (Exception exc)
        {
            return String.Empty;
        }

        return table.ToString() + "<#SEP#>" + (HttpContext.Current.Request.Browser.IsMobileDevice ? "1" : "0");
    }
}
