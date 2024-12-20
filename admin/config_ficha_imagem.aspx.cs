using System;
using System.Web.Services;
using System.Data;
using System.Web.UI;
using System.Configuration;
using System.Web;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI.WebControls;


public partial class config_ficha_imagem : System.Web.UI.Page
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
    }


    [WebMethod]
    public static string getData(string id)
    {
        const string sep = "<#SEP#>";
        string sql = "", nome = "", nome_en = "", nome_fr = "", nome_es = "", ordem = "", slider_inicial = "", id_tipo = "", nome_tipo = "", nome_en_tipo = "",
            nome_fr_tipo = "", nome_es_tipo = "", ordem_tipo = "", extensao = "", id_imagem_capa_tipo = "", img_capa_tipo = "", visivel = "", visivel_tipo = "";

        DataSqlServer oDB = new DataSqlServer();


        sql = string.Format(@"  DECLARE @id int = {0}
                                DECLARE @nome varchar(500);
                                DECLARE @id_tipo int;
                                select
                                    id,
		                            nome_en,
		                            nome_es,
		                            nome_fr,
		                            nome,
		                            ordem,
		                            slider_inicial,
                                    visivel,
		                            id_tipo,
		                            nome_tipo,
		                            nome_en_tipo,
		                            nome_fr_tipo,
		                            nome_es_tipo,
		                            ordem_tipo,
                                    extensao,
                                    id_imagem_capa_tipo,
		                            img_capa_tipo,
                                    visivel_tipo
                                from REPORT_IMAGEM(@id, @nome, @id_tipo)", id);
        DataSet oDs = oDB.GetDataSet(sql, "").oData;

        if (oDB.validaDataSet(oDs))
        {
            id = oDs.Tables[0].Rows[0]["id"].ToString().Trim();
            nome = oDs.Tables[0].Rows[0]["NOME"].ToString().Trim();
            nome_en = oDs.Tables[0].Rows[0]["NOME_EN"].ToString().Trim();
            nome_fr = oDs.Tables[0].Rows[0]["NOME_FR"].ToString().Trim();
            nome_es = oDs.Tables[0].Rows[0]["NOME_ES"].ToString().Trim();
            ordem = oDs.Tables[0].Rows[0]["ordem"].ToString().Trim();
            slider_inicial = Convert.ToBoolean(oDs.Tables[0].Rows[0]["slider_inicial"].ToString().Trim()) ? "1" : "0";
            id_tipo = oDs.Tables[0].Rows[0]["id_tipo"].ToString().Trim();
            nome_tipo = oDs.Tables[0].Rows[0]["nome_tipo"].ToString().Trim();
            nome_en_tipo = oDs.Tables[0].Rows[0]["nome_en_tipo"].ToString().Trim();
            nome_fr_tipo = oDs.Tables[0].Rows[0]["nome_fr_tipo"].ToString().Trim();
            nome_es_tipo = oDs.Tables[0].Rows[0]["nome_es_tipo"].ToString().Trim();
            ordem_tipo = oDs.Tables[0].Rows[0]["ordem_tipo"].ToString().Trim();
            extensao = oDs.Tables[0].Rows[0]["extensao"].ToString().Trim();
            id_imagem_capa_tipo = oDs.Tables[0].Rows[0]["id_imagem_capa_tipo"].ToString().Trim();
            img_capa_tipo = oDs.Tables[0].Rows[0]["img_capa_tipo"].ToString().Trim();
            visivel = Convert.ToBoolean(oDs.Tables[0].Rows[0]["visivel"].ToString().Trim()) ? "1" : "0";
            visivel_tipo = Convert.ToBoolean(oDs.Tables[0].Rows[0]["visivel_tipo"].ToString().Trim()) ? "1" : "0";
        }

        // Prepara o retorno dos dados
        return id + sep +
            nome + sep +
            nome_en + sep +
            nome_fr + sep +
            nome_es + sep +
            ordem + sep +
            slider_inicial + sep +
            id_tipo + sep +
            nome_tipo + sep +
            nome_en_tipo + sep +
            nome_fr_tipo + sep +
            nome_es_tipo + sep +
            ordem_tipo + sep +
            extensao + sep +
            id_imagem_capa_tipo + sep +
            img_capa_tipo + sep +
            visivel + sep +
            visivel_tipo;
    }

    [WebMethod]
    public static string getImageTypesList(string search, string dialogOpen)
    {
        string sql = "", html = "", htmlWithSearch = "";
        string id = "", nome = "", nome_en = "", nome_fr = "", nome_es = "", ordem = "";

        DataSqlServer oDB = new DataSqlServer();

        html += @"  <input id='imageTypesSearchBar' class='form-control' placeholder='Pesquisar...' type='text' style='color: black; width: 75%; float:left;' />
                    <img id='imageTypesSearchIcon' src='../Img/icon_search_image.png' style='width: auto; height: calc(2.75rem + 2px); cursor: pointer; margin-left: 5px; float:right;' alt='Pesquisar Tipos de Imagem' title='Pesquisar Tipos de Imagem' onclick='getImageTypesList();'/>
                    <div id='divTableImageTypes'>";

        html += @"<table class='table align-items-center table-flush'>
		                                <thead class='thead-light'>
		                                    <tr>
			                                    <th scope='col' class='pointer th_text'>Nome</th>
                                            </tr>
		                                </thead>
                                        <tbody>";

        htmlWithSearch += @"<table class='table align-items-center table-flush'>
		                                <thead class='thead-light'>
		                                    <tr>
			                                    <th scope='col' class='pointer th_text'>Nome</th>
                                            </tr>
		                                </thead>
                                        <tbody>";

        sql = String.Format(@"  DECLARE @id int;
                                DECLARE @nome varchar(500);

                                select
                                    id, nome, nome_en, nome_fr, nome_es, ordem, id_imagem_capa, img_capa, visivel
                                from REPORT_IMAGEM_TIPO(@id, @nome)
                                where nome like {0} or nome_en like {0} or nome_fr like {0} or nome_es like {0}
                                order by ordem", String.Format("'%{0}%'", search));

        DataSet oDs = oDB.GetDataSet(sql, "").oData;
        if (oDB.validaDataSet(oDs))
        {
            for (int j = 0; j < oDs.Tables.Count; j++)
            {
                for (int i = 0; i < oDs.Tables[j].Rows.Count; i++)
                {
                    id = oDs.Tables[j].Rows[i]["id"].ToString().Trim();
                    nome = oDs.Tables[j].Rows[i]["nome"].ToString().Trim();
                    nome_en = oDs.Tables[j].Rows[i]["nome_en"].ToString().Trim();
                    nome_fr = oDs.Tables[j].Rows[i]["nome_fr"].ToString().Trim();
                    nome_es = oDs.Tables[j].Rows[i]["nome_es"].ToString().Trim();
                    ordem = oDs.Tables[j].Rows[i]["ordem"].ToString().Trim();

                    html += @"<tr class='pointer' id='imageTypesLine" + i + "' onclick='selectImageTypesRow(" + id + @", " + i + @")'> 
		                    <td><span>" + nome + @"</span></td>                
	                      </tr> ";

                    htmlWithSearch += @"<tr class='pointer' id='imageTypesLine" + i + "' onclick='selectImageTypesRow(" + id + @", " + i + @")'> 
		                    <td><span>" + nome + @"</span></td>                 
	                      </tr> ";
                }

                html += "<span class='variaveis' id='countImageTypes'>" + oDs.Tables[j].Rows.Count + "</span>";

                htmlWithSearch += "<span class='variaveis' id='countImageTypes'>" + oDs.Tables[j].Rows.Count + "</span>";
            }
        }
        else
        {
            html += "<tr><td colspan='3'>Não existem tipos de imagem a apresentar.</td></tr>";
            htmlWithSearch += "<tr><td colspan='3'>Não existem tipos de imagem a apresentar.</td></tr>";
        }


        html += "</tbody></table></div>";
        htmlWithSearch += "</tbody></table></div>";

        return dialogOpen == "0" ? html : htmlWithSearch;
    }

    [WebMethod]
    public static string getImageTypesData(string id)
    {
        string sql = "";
        string sep = "<#SEP#>";
        string nome = "", nome_en = "", nome_fr = "", nome_es = "", ordem = "", id_imagem_capa = "", img_capa = "", visivel = "";

        DataSqlServer oDB = new DataSqlServer();

        sql = String.Format(@"  DECLARE @id int = {0};
                                DECLARE @nome varchar(500);

                                select
                                    id, nome, nome_en, nome_fr, nome_es, ordem, id_imagem_capa, img_capa, visivel
                                from REPORT_IMAGEM_TIPO(@id, @nome)
                                order by ordem", String.IsNullOrEmpty(id) ? "NULL" : id);

        DataSet oDs = oDB.GetDataSet(sql, "").oData;
        if (oDB.validaDataSet(oDs))
        {
            for (int j = 0; j < oDs.Tables.Count; j++)
            {
                for (int i = 0; i < oDs.Tables[j].Rows.Count; i++)
                {
                    id = oDs.Tables[j].Rows[i]["id"].ToString().Trim();
                    nome = oDs.Tables[j].Rows[i]["nome"].ToString().Trim();
                    nome_en = oDs.Tables[j].Rows[i]["nome_en"].ToString().Trim();
                    nome_fr = oDs.Tables[j].Rows[i]["nome_fr"].ToString().Trim();
                    nome_es = oDs.Tables[j].Rows[i]["nome_es"].ToString().Trim();
                    ordem = oDs.Tables[j].Rows[i]["ordem"].ToString().Trim();
                    id_imagem_capa = oDs.Tables[j].Rows[i]["id_imagem_capa"].ToString().Trim();
                    img_capa = oDs.Tables[j].Rows[i]["img_capa"].ToString().Trim();
                    visivel = Convert.ToBoolean(oDs.Tables[0].Rows[0]["visivel"].ToString().Trim()) ? "1" : "0";
                }
            }
        }

        return id + sep + nome + sep + nome_en + sep + nome_fr + sep + nome_es + sep + ordem + sep + id_imagem_capa + sep + img_capa + sep + visivel;
    }

    protected void UploadButton_Click(object sender, EventArgs e)
    {
        string id = aux.Text.ToString();

        if (!FileUploadControl.HasFile && String.IsNullOrEmpty(id))
        {
            StatusLabel.Text = "Por favor, carregue um ficheiro para adicionar!";
            return;
        }

        try
        {
            string filename = FileUploadControl.HasFile ? Path.GetFileName(FileUploadControl.FileName) : String.Empty;
            string extension = FileUploadControl.HasFile ? Path.GetExtension(FileUploadControl.FileName) : String.Empty;
            string fileToSave = "";
            string idUser = userID.Text.ToString();
            int fileSize = FileUploadControl.HasFile ? FileUploadControl.PostedFile.ContentLength : 0;
            string horizontal = String.Empty;

            if(FileUploadControl.HasFile)
            {
                System.Drawing.Image im = System.Drawing.Image.FromStream(FileUploadControl.PostedFile.InputStream);
                double h = im.PhysicalDimension.Height;
                double w = im.PhysicalDimension.Width;

                if(h >= w)
                {
                    horizontal = "0";
                }
                else
                {
                    horizontal = "1";
                }
            }
            
            string sql = "";
            string name = nome.Text.ToString().Replace("'", "''");
            string nome_en = nomeEn.Text.ToString().Replace("'", "''");
            string nome_fr = nomeFr.Text.ToString().Replace("'", "''");
            string nome_es = nomeEs.Text.ToString().Replace("'", "''");
            string order = ordem.Text.ToString();
            string slider_inicial = slider.Text.ToString();
            string nome_tipo = nomeTipo.Text.ToString().Replace("'", "''");
            string nome_en_tipo = nomeEnTipo.Text.ToString().Replace("'", "''");
            string nome_fr_tipo = nomeFrTipo.Text.ToString().Replace("'", "''");
            string nome_es_tipo = nomeEsTipo.Text.ToString().Replace("'", "''");
            string ordem_tipo = ordemTipo.Text.ToString();
            string visivelStr = visivel.Text.ToString();
            string visivelTipoStr = visivelTipo.Text.ToString();
            string ret = "", retMsg = "";

            if (fileSize > 1048576000)
            {
                StatusLabel.Text = "O tamanho do ficheiro excede o tamanho permitido (1GB). Por favor, diminua o tamanho do ficheiro ou carregue outro!";
                return;
            }

            DataSqlServer oDB = new DataSqlServer();

            sql = String.Format(@"  DECLARE @idUser int = {0};
	                                DECLARE @id INT = {1};
	                                DECLARE @nome varchar(500) = '{2}';
	                                DECLARE @nome_en varchar(500) = '{3}';
	                                DECLARE @nome_fr varchar(500) = '{4}';
	                                DECLARE @nome_es varchar(500) = '{5}';
	                                DECLARE @ordem int = {6};
	                                DECLARE @slider_inicial bit = {7};
                                    DECLARE @nome_tipo varchar(500) = '{8}';
	                                DECLARE @nome_en_tipo varchar(500) = '{9}';
	                                DECLARE @nome_fr_tipo varchar(500) = '{10}';
	                                DECLARE @nome_es_tipo varchar(500) = '{11}';
	                                DECLARE @ordem_tipo int = {12};
                                    DECLARE @extensao varchar(10) = {13};
                                    DECLARE @visivel bit = {14};
                                    DECLARE @visivelTipo bit = {15};
                                    DECLARE @horizontal bit = {16};
	                                DECLARE @ret int;
                                    DECLARE @retMsg VARCHAR(max);

                                    EXEC CRIA_EDITA_IMAGEM @idUser, @id, @nome, @nome_en, @nome_fr, @nome_es, @ordem, @slider_inicial, 
                                        @nome_tipo, @nome_en_tipo, @nome_fr_tipo, @nome_es_tipo, @ordem_tipo, @extensao, @visivel, @visivelTipo, @horizontal, @ret OUTPUT, @retMsg OUTPUT

                                    select @ret as ret, @retMsg as retMsg",
                                    idUser, String.IsNullOrEmpty(id) ? "NULL" : id, name, nome_en, nome_fr, nome_es, order, slider_inicial, nome_tipo, nome_en_tipo, nome_fr_tipo,
                                    nome_es_tipo, ordem_tipo, String.IsNullOrEmpty(extension) ? "NULL" : "'" + extension + "'", visivelStr, visivelTipoStr,
                                    String.IsNullOrEmpty(horizontal) ? "NULL" : horizontal);

            DataSet oDs = oDB.GetDataSet(sql, "").oData;
            if (oDB.validaDataSet(oDs))
            {
                for (int j = 0; j < oDs.Tables.Count; j++)
                {
                    for (int i = 0; i < oDs.Tables[j].Rows.Count; i++)
                    {
                        ret = oDs.Tables[j].Rows[i]["ret"].ToString().Trim();
                        retMsg = oDs.Tables[j].Rows[i]["retMsg"].ToString().Trim();
                    }
                }

                if (!String.IsNullOrEmpty(ret) && Convert.ToInt32(ret) > 0)
                {
                    if (FileUploadControl.HasFile)
                    {
                        fileToSave = Server.MapPath("~") + Path.DirectorySeparatorChar + "img" + Path.DirectorySeparatorChar + "portfolio" + Path.DirectorySeparatorChar + ret + extension;

                        FileUploadControl.SaveAs(fileToSave);
                    }

                    StatusLabel.Text = "Imagem adicionada com sucesso!";

                    if (!FileUploadControl.HasFile)
                    {
                        Response.Redirect("lista_imagens.aspx");
                    }
                }
                else
                {
                    StatusLabel.Text = "Ocorreu um erro ao adicionar a imagem!";
                }
            }
            else
            {
                StatusLabel.Text = "Ocorreu um erro ao adicionar a imagem!";
            }
        }
        catch (Exception ex)
        {
            StatusLabel.Text = "Ocorreu um erro ao adicionar a imagem!";
        }
    }
}