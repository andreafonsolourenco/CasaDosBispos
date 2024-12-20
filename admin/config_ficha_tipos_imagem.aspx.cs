using System;
using System.Web.Services;
using System.Data;
using System.Text;


public partial class config_ficha_tipos_imagem : System.Web.UI.Page
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

        getImagemCapaList();
    }



    [WebMethod]
    public static string saveData(string id, string nome, string nome_en, string nome_fr, string nome_es, string idUser, string ordem, string id_imagem_capa, string visivel)
    {
        DataSqlServer oDB = new DataSqlServer();

        string sql = "", ret = "1", retMessage = "Dados guardados com sucesso.";

        nome = nome.Replace("'", "''");
        nome_en = nome_en.Replace("'", "''");
        nome_fr = nome_fr.Replace("'", "''");
        nome_es = nome_es.Replace("'", "''");

        sql = string.Format(@"  DECLARE @idUser int = {0};
	                            DECLARE @id INT = {1};
	                            DECLARE @nome varchar(500) = '{2}';
	                            DECLARE @nome_en varchar(500) = '{3}';
	                            DECLARE @nome_fr varchar(500) = '{4}';
	                            DECLARE @nome_es varchar(500) = '{5}';
                                DECLARE @ordem int = {6};
                                DECLARE @id_img_capa int = {7};
                                DECLARE @visivel bit = {8};
	                            DECLARE @ret int;
                                DECLARE @retMsg VARCHAR(max);

                                EXECUTE CRIA_EDITA_IMAGEM_TIPO @idUser, @id, @nome, @nome_en, @nome_fr, @nome_es, @ordem, @id_img_capa, @visivel, @ret OUTPUT, @retMsg OUTPUT
                                SELECT @ret ret, @retMsg retMsg ", idUser, String.IsNullOrEmpty(id) ? "NULL" : id, nome, nome_en, nome_fr, nome_es, ordem, id_imagem_capa, visivel);


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
        string sql = "", nome = "", nome_en = "", nome_fr = "", nome_es = "", ordem = "", visivel = "";

        DataSqlServer oDB = new DataSqlServer();


        sql = string.Format(@"  DECLARE @id int = {0}
                                DECLARE @nome varchar(500);
                                select
                                    id,
		                            NOME,
		                            NOME_EN,
		                            NOME_FR,
		                            NOME_ES,
                                    ordem,
                                    visivel
                                from REPORT_IMAGEM_TIPO(@id, @nome)", id);
        DataSet oDs = oDB.GetDataSet(sql, "").oData;

        if (oDB.validaDataSet(oDs))
        {
            nome = oDs.Tables[0].Rows[0]["NOME"].ToString().Trim();
            nome_en = oDs.Tables[0].Rows[0]["NOME_EN"].ToString().Trim();
            nome_fr = oDs.Tables[0].Rows[0]["NOME_FR"].ToString().Trim();
            nome_es = oDs.Tables[0].Rows[0]["NOME_ES"].ToString().Trim();
            ordem = oDs.Tables[0].Rows[0]["ordem"].ToString().Trim();
            visivel = Convert.ToBoolean(oDs.Tables[0].Rows[0]["visivel"].ToString().Trim()) ? "1" : "0";
        }

        // Prepara o retorno dos dados
        return nome + sep +
              nome_en + sep +
              nome_fr + sep +
              nome_es + sep +
              ordem + sep +
              visivel;
    }

    private void getImagemCapaList()
    {
        var table = new StringBuilder();
        DataSqlServer oDB = new DataSqlServer();

        try
        {
            string sql = string.Format(@"   SET DATEFORMAT dmy;
                                            DECLARE @id int;
                                            DECLARE @id_tipo int = {0};
                                            DECLARE @lingua varchar(10);

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
                                            order by ordem_tipo", String.IsNullOrEmpty(id) ? "null" : id);

            DataSet oDs = oDB.GetDataSet(sql, "").oData;

            if (oDB.validaDataSet(oDs) && !String.IsNullOrEmpty(id))
            {
                for (int i = 0; i < oDs.Tables[0].Rows.Count; i++)
                {
                    var id = oDs.Tables[0].Rows[i]["id"].ToString();
                    var nome = oDs.Tables[0].Rows[i]["nome"].ToString();
                    var id_img_capa = oDs.Tables[0].Rows[i]["id_imagem_capa_tipo"].ToString();
                    var img_capa = oDs.Tables[0].Rows[i]["img_capa_tipo"].ToString();
                    var extensao = oDs.Tables[0].Rows[i]["extensao"].ToString();

                    if (i==0)
                    {
                        table.AppendFormat(@"   <div class='col-md-6'>
                                                    <div class='form-group'>
                                                        <label class='form-control-label' for='selectImgCapa'>Imagem de Capa</label>
                                                        <select name='selectImgCapa' id='selectImgCapa' class='form-control form-control-alternative form-select' onChange='changeImageSelected();'>
                                                            <option value='0'{0}>Sem imagem associada!</option>", id_img_capa == "0" ? " selected " : "");
                    }

                    table.AppendFormat(@"   <option value='{0}'{2}>{1}</option>", id, String.Format(@"{0}{1}", id, extensao), id_img_capa == id ? " selected " : "");

                    if(i == oDs.Tables[0].Rows.Count - 1)
                    {
                        table.AppendFormat(@"   </select></div></div>
                                                <div class='col-md-6'>
                                                    <img src='../img/portfolio/{0}' style='width: auto !important; height: 150px !important; margin: auto !important;' id='imgCapa' />
                                                </div>", id_img_capa == "0" ? "noimg.png" : img_capa);
                    }
                }
            }
            else
            {
                table.AppendFormat(@"   <div class='col-md-6'>
                                                <div class='form-group'>
                                                    <label class='form-control-label' for='selectImgCapa'>Imagem de Capa</label>
                                                    <select name='selectImgCapa' id='selectImgCapa' class='form-control form-control-alternative form-select' onChange='changeImageSelected();'>
                                                        <option value='0'>Sem imagem associada!</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class='col-md-6'>
                                                <img src='../img/portfolio/{0}' style='width: auto !important; height: 150px !important; margin: auto !important;' id='imgCapa' />
                                            </div>", "noimg.png");
            }
        }
        catch (Exception exc)
        {
            rowSelectImgCapa.InnerHtml = String.Empty;
        }

        rowSelectImgCapa.InnerHtml = table.ToString();
    }
}