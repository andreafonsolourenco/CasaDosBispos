using System;
using System.Web.Services;
using System.Data;
using System.Text;
using System.Data.SqlClient;
using System.Configuration;

public partial class config_ficha_textos : System.Web.UI.Page
{
    string id = "null";

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            id = Request.QueryString["id"];
        }
        catch (Exception)
        {
        }

        txtAux.Value = id;
        getImages();
    }



    [WebMethod]
    public static string saveData(string id, string codigo, string nome, string nome_en, string nome_fr, string nome_es, string texto, string texto_en, string texto_fr, 
        string texto_es, string ordem, string idUser, string id_imagem)
    {
        DataSqlServer oDB = new DataSqlServer();

        string sql = "", ret = "1", retMessage = "Dados guardados com sucesso.";

        nome = nome.Replace("##", "\"");
        nome_en = nome_en.Replace("##", "\"");
        nome_fr = nome_fr.Replace("##", "\"");
        nome_es = nome_es.Replace("##", "\"");
        texto = texto.Replace("##", "\"");
        texto_en = texto_en.Replace("##", "\"");
        texto_fr = texto_fr.Replace("##", "\"");
        texto_es = texto_es.Replace("##", "\"");

        sql = string.Format(@"  DECLARE @idUser int = {0};
	                            DECLARE @id INT = {1};
	                            DECLARE @codigo varchar(100) = '{2}';
	                            DECLARE @nome varchar(500) = '{3}';
	                            DECLARE @nome_en varchar(500) = '{4}';
	                            DECLARE @nome_fr varchar(500) = '{5}';
	                            DECLARE @nome_es varchar(500) = '{6}';
	                            DECLARE @texto varchar(max) = '{7}';
	                            DECLARE @texto_en varchar(max) = '{8}';
                                DECLARE @texto_fr varchar(max) = '{9}';
                                DECLARE @texto_es varchar(max) = '{10}';
	                            DECLARE @ordem int = {11};
                                DECLARE @id_imagem int = {12};
	                            DECLARE @ret int;
                                DECLARE @retMsg VARCHAR(max);

                                EXECUTE CRIA_EDITA_TEXTOS @idUser, @id, @codigo, @nome, @nome_en, @nome_fr, @nome_es, @texto, @texto_en, @texto_fr, @texto_es, @ordem, @id_imagem, @ret OUTPUT, @retMsg OUTPUT
                                SELECT @ret ret, @retMsg retMsg ", idUser, String.IsNullOrEmpty(id) ? "NULL" : id, codigo, nome, nome_en, nome_fr, nome_es, texto, texto_en, 
                                    texto_fr, texto_es, ordem, id_imagem);


        DataSet oDs = oDB.GetDataSet(sql, "").oData;

        if (oDB.validaDataSet(oDs))
        {
            ret = oDs.Tables[0].Rows[0]["ret"].ToString().Trim();
            retMessage = oDs.Tables[0].Rows[0]["retMsg"].ToString().Trim();
        }

        return ret + "<#SEP#>" + retMessage;
    }


    [WebMethod]
    public static string getData(string id)
    {
        const string sep = "<#SEP#>";
        string sql = "", codigo = "", nome = "", nome_en = "", nome_fr = "", nome_es = "", texto = "", texto_en = "", texto_fr = "", texto_es = "", ordem = "", id_imagem = "";

        DataSqlServer oDB = new DataSqlServer();


        sql = string.Format(@"  DECLARE @id int = {0}
                                DECLARE @codigo varchar(100);
                                select
                                    id,
		                            CODIGO,
		                            NOME,
		                            NOME_EN,
		                            NOME_FR,
		                            NOME_ES,
		                            TEXTO,
		                            TEXTO_EN,
		                            TEXTO_FR,
		                            TEXTO_ES,
		                            ordem,
                                    id_imagem
                                from REPORT_TEXTOS(@id, @codigo)
                                where codigo <> 'ALOJAMENTO'", id);
        DataSet oDs = oDB.GetDataSet(sql, "").oData;

        if (oDB.validaDataSet(oDs))
        {
            codigo = oDs.Tables[0].Rows[0]["CODIGO"].ToString().Trim();
            nome = oDs.Tables[0].Rows[0]["NOME"].ToString().Trim();
            nome_en = oDs.Tables[0].Rows[0]["NOME_EN"].ToString().Trim();
            nome_fr = oDs.Tables[0].Rows[0]["NOME_FR"].ToString().Trim();
            nome_es = oDs.Tables[0].Rows[0]["NOME_ES"].ToString().Trim();
            texto = oDs.Tables[0].Rows[0]["TEXTO"].ToString().Trim();
            texto_en = oDs.Tables[0].Rows[0]["TEXTO_EN"].ToString().Trim();
            texto_fr = oDs.Tables[0].Rows[0]["TEXTO_FR"].ToString().Trim();
            texto_es = oDs.Tables[0].Rows[0]["TEXTO_ES"].ToString().Trim();
            ordem = oDs.Tables[0].Rows[0]["ordem"].ToString().Trim();
            id_imagem = oDs.Tables[0].Rows[0]["id_imagem"].ToString().Trim();

            nome = nome.Replace("<br />", "\n").Replace("\"", "##");
            nome_en = nome_en.Replace("<br />", "\n").Replace("\"", "##");
            nome_fr = nome_fr.Replace("<br />", "\n").Replace("\"", "##");
            nome_es = nome_es.Replace("<br />", "\n").Replace("\"", "##");
            texto = texto.Replace("<br />", "\n").Replace("\"", "##");
            texto_en = texto_en.Replace("<br />", "\n").Replace("\"", "##");
            texto_fr = texto_fr.Replace("<br />", "\n").Replace("\"", "##");
            texto_es = texto_es.Replace("<br />", "\n").Replace("\"", "##");
        }

        // Prepara o retorno dos dados
        return codigo + sep +
              nome + sep +
              nome_en + sep +
              nome_fr + sep +
              nome_es + sep +
              texto + sep +
              texto_en + sep +
              texto_fr + sep +
              texto_es + sep +
              ordem + sep +
              id_imagem;
    }

    private void getImages()
    {
        var table = new StringBuilder();
        var extensions = new StringBuilder();
        string connectionstring = ConfigurationManager.ConnectionStrings["CS_CDB"].ToString();
        SqlConnection connection = new SqlConnection(connectionstring);
        SqlDataAdapter da = new SqlDataAdapter();
        SqlCommand command = new SqlCommand();
        command.Connection = connection;

        try
        {
            string sql = string.Format(@"   SET DATEFORMAT dmy;
                                            DECLARE @id int
                                            DECLARE @nome varchar(500)
                                            DECLARE @id_tipo int
                                            select
                                                id,
		                                        nome,
		                                        extensao,
                                                nome_tipo
                                            from REPORT_IMAGEM(@id, @nome, @id_tipo)");

            command.CommandText = sql.ToString();
            da.SelectCommand = command;
            DataSet oDs = new DataSet();

            connection.Open();
            da.Fill(oDs);
            connection.Close();

            if (oDs.Tables != null && oDs.Tables.Count > 0 && oDs.Tables[0].Rows.Count > 0)
            {
                table.AppendFormat(@"   <div class='col-md-6'>
                                            <div class='form-group'>
                                                <label class='form-control-label' for='imageSelect'>Imagem de Capa</label>
                                                <select name='imageSelect' id='imageSelect' runat='server' class='form-control form-control-alternative' style='width: 100%; height: auto' onChange='changeImageSelected();'>
                                                <option value='0' selected>Sem imagem atribuida!</option>");

                for (int i = 0; i < oDs.Tables[0].Rows.Count; i++)
                {
                    string id = oDs.Tables[0].Rows[i]["id"].ToString();
                    string nome = oDs.Tables[0].Rows[i]["nome"].ToString();
                    string extensao = oDs.Tables[0].Rows[i]["extensao"].ToString();
                    string nome_tipo = oDs.Tables[0].Rows[i]["nome_tipo"].ToString();

                    table.AppendFormat(@"   <option value='{0}'>{2} - {1}</option>", id, nome, nome_tipo);
                    extensions.AppendFormat(@"  <span class='variaveis' id='extensao{0}'>{1}</span>", id, extensao);
                }

                table.AppendFormat(@"   </select></div></div>
                                        <div class='col-md-6'>
                                            <div class='form-group' style='text-align: center''>
                                                <img src='../img/justlogo.png' id='imageSelected' style='width: auto; height: 150px; margin: auto;' />
                                            </div>
                                        </div>");
            }
            else
            {

            }
        }
        catch (Exception exc)
        {
            rowImageSelector.InnerHtml = exc.ToString();
        }

        rowImageSelector.InnerHtml = table.ToString() + extensions.ToString();
    }
}