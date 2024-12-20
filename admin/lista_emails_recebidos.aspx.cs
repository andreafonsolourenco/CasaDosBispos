using System;
using System.Web.Services;
using System.Data;
using System.IO;
using System.Net.Mail;
using System.Web;
using System.Web.Hosting;

public partial class lista_emails_recebidos : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }

    [WebMethod]
    public static string getGrelha(string pesquisa, string order, string admin)
    {
        string sql = "", html = "", htmlOptions = "";
        string id = "", nome = "", email = "", assunto = "", data_envio = "", corSucesso = "";
        Boolean sucesso = false;

        DataSqlServer oDB = new DataSqlServer();

        html += String.Format(@"<table class='table align-items-center table-flush'>
		                            <thead class='thead-light'>
		                            <tr>
			                            <th scope='col' class='pointer th_text' onclick='ordenaData();'>Data</th>
                                        <th scope='col' class='pointer th_text' onclick='ordenaNome();'>Nome</th>
			                            <th scope='col' class='pointer th_text' onclick='ordenaEmail();'>Email</th>
                                        <th scope='col' class='pointer th_text' onclick='ordenaAssunto();'>Assunto</th>
                                        <th scope='col' class='pointer th_text' onclick='ordenaSucesso();'>Sucesso</th>
                                        {0}
		                            </tr>
		                            </thead>
                                    <tbody>", admin == "1" ? "<th scope='col'></th>" : "");

        sql = string.Format(@"  DECLARE @id int;
                                DECLARE @nome varchar(500);
                                DECLARE @email varchar(500);
                                DECLARE @sucesso bit;
                                DECLARE @data_inicial date;
                                DECLARE @data_final date;

                                select
                                    id,
		                            NOME,
		                            EMAIL,
		                            ASSUNTO,
		                            TEXTO,
		                            SUCESSO,
		                            data_envio,
		                            ctrldata
                                from REPORT_SITE_CONTACTS(@id, @nome, @email, @sucesso, @data_inicial, @data_final)
                                where (nome like {0} or email like {0} or assunto like {0} or data_envio like {0})
                                {1}", String.Format("'%{0}%'", pesquisa), order);

        DataSet oDs = oDB.GetDataSet(sql, "").oData;
        if (oDB.validaDataSet(oDs))
        {
            for (int j = 0; j < oDs.Tables.Count; j++)
            {
                for (int i = 0; i < oDs.Tables[j].Rows.Count; i++)
                {
                    id = oDs.Tables[j].Rows[i]["id"].ToString().Trim();
                    nome = oDs.Tables[j].Rows[i]["NOME"].ToString().Trim();
                    email = oDs.Tables[j].Rows[i]["EMAIL"].ToString().Trim();
                    assunto = oDs.Tables[j].Rows[i]["ASSUNTO"].ToString().Trim();
                    data_envio = oDs.Tables[j].Rows[i]["data_envio"].ToString().Trim();
                    sucesso = Convert.ToBoolean(oDs.Tables[j].Rows[i]["SUCESSO"].ToString().Trim());

                    if (sucesso) corSucesso = "#2DCE89";
                    else corSucesso = "#F5365C";

                    if (admin == "1")
                    {
                        htmlOptions = String.Format(@"  <td class='text-right'>
		                                                    <div class='dropdown'>
			                                                    <a class='btn btn-sm btn-icon-only text-light' href='#' role='button' data-toggle='dropdown' aria-haspopup='true' aria-expanded='false'>
			                                                        <i class='fas fa-ellipsis-v'></i>
			                                                    </a>
                                                                <div class='dropdown-menu dropdown-menu-right dropdown-menu-arrow'>
                                                                    <a class='dropdown-item' href='#' onclick='visualizar({0});'>Visualizar</a>
			                                                    </div>
                                                            </div>
                                                        </td>", id);
                    }

                    html += String.Format(@"    <tr class='pointer'>
		                                            <td><span>{0}</span></td>
		                                            <td><span>{1}</span></td>
                                                    <td><span>{2}</span></td>
		                                            <td><span>{3}</span></td>
                                                    <td style='text-align: center;'>
		                                                <span class='badge badge-dot mr-4'>
			                                                <i class='bg-success' style='height: 20px; width: 20px; background-color:{4} !important' ></i>
		                                                </span>
		                                            </td>
		                                            {5}                   
	                                            </tr>", data_envio, nome, email, assunto, corSucesso, htmlOptions);
                }
            }
        }
        else
        {
            html += String.Format(@"<tr><td colspan='{0}'>Não existem contactos através do site a apresentar!</td></tr>", admin == "1" ? "6" : "5");
        }


        html += "</tbody></table>";


        return html;
    }

    [WebMethod]
    public static string showEmail(string id)
    {
        int timeout = 50000;
        int i = 0;
        string sql = "", nome = "", email = "", assunto = "", texto = "", data_envio = "";
        string cb_nome = "", cb_morada1 = "", cb_morada2 = "", cb_codpostal = "", cb_localidade = "";
        string intro = "", body = "";

        DataSqlServer oDB = new DataSqlServer();

        sql = string.Format(@"  DECLARE @id int;
                                DECLARE @nome varchar(500);
                                DECLARE @email varchar(500);
                                DECLARE @sucesso bit;
                                DECLARE @data_inicial date;
                                DECLARE @data_final date;

                                select
                                    sc.id,
		                            sc.NOME,
		                            sc.EMAIL,
		                            sc.ASSUNTO,
		                            sc.TEXTO,
		                            sc.SUCESSO,
		                            sc.data_envio,
		                            sc.ctrldata,
                                    c.nome as cb_nome,
                                    c.morada1 as cb_morada1,
                                    c.morada2 as cb_morada2,
                                    c.cod_postal as cb_codpostal,
                                    c.localidade as cb_localidade
                                from REPORT_SITE_CONTACTS(@id, @nome, @email, @sucesso, @data_inicial, @data_final) sc
                                inner join REPORT_CONTACTOS() c on 1=1", id);
        DataSet oDs = oDB.GetDataSet(sql, "").oData;

        if (oDB.validaDataSet(oDs))
        {
            nome = oDs.Tables[0].Rows[0]["NOME"].ToString().Trim();
            email = oDs.Tables[0].Rows[0]["EMAIL"].ToString().Trim();
            assunto = oDs.Tables[0].Rows[0]["ASSUNTO"].ToString().Trim();
            texto = oDs.Tables[0].Rows[0]["TEXTO"].ToString().Trim();
            data_envio = oDs.Tables[0].Rows[0]["data_envio"].ToString();

            cb_nome = oDs.Tables[0].Rows[0]["cb_nome"].ToString().Trim();
            cb_morada1 = oDs.Tables[0].Rows[0]["cb_morada1"].ToString().Trim();
            cb_morada2 = oDs.Tables[0].Rows[0]["cb_morada2"].ToString().Trim();
            cb_codpostal = oDs.Tables[0].Rows[0]["cb_codpostal"].ToString().Trim();
            cb_localidade = oDs.Tables[0].Rows[0]["cb_localidade"].ToString();
        }

        try
        {
            MailMessage mailMessage = new MailMessage();

            string emailText = string.Empty;
            emailText = File.ReadAllText(HostingEnvironment.MapPath("~") + Path.DirectorySeparatorChar + "templates/template_email.html");

            intro = assunto;
            body = String.Format(@"Nome: {0}<br />Email: {1}<br />Recebido a: {2}<br />{3}", nome, email, data_envio, texto);

            emailText = emailText.Replace("[EMAIL_INTRO]", intro);
            emailText = emailText.Replace("[EMAIL_TEXTBODY]", body);
            emailText = emailText.Replace("[NAME]", cb_nome);
            emailText = emailText.Replace("[ADDRESS]", cb_morada1 + (String.IsNullOrEmpty(cb_morada2) ? "" : "<br />" + cb_morada2));
            emailText = emailText.Replace("[CITY_POSTAL_CODE]", cb_codpostal + " " + cb_localidade);
            emailText = emailText.Replace("[URL]", "../");

            return emailText;
        }
        catch (Exception ex)
        {
            return "";
        }
    }
}