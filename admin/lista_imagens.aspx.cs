using System;
using System.Web.Services;
using System.Data;
using System.IO;
using System.Collections.Generic;
using System.Web;

public partial class lista_imagens : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }

    [WebMethod]
    public static string getGrelha(string pesquisa, string order, string admin)
    {
        string sql = "", html = "", htmlOptions = "";
        string id = "", nome = "", ordem = "", nome_tipo = "", ordem_tipo = "", corSliderInicial = "";
        Boolean slider_inicial = false;

        DataSqlServer oDB = new DataSqlServer();

        html += String.Format(@"<table class='table align-items-center table-flush'>
		                            <thead class='thead-light'>
		                            <tr>
			                            <th scope='col' class='pointer th_text' onclick='ordenaTipo();'>Tipo de Img</th>
                                        <th scope='col' class='pointer th_text' onclick='ordenaOrdemTipo();'>Ordem do Tipo</th>
			                            <th scope='col' class='pointer th_text' onclick='ordenaImagem();'>Imagem</th>
                                        <th scope='col' class='pointer th_text' onclick='ordenaOrdemImagem();'>Ordem da Imagem</th>
                                        <th scope='col' class='pointer th_text' style='text-align:center' onclick='ordenaSlider();'>Slider Inicial</th>
                                        {0}
		                            </tr>
		                            </thead>
                                    <tbody>", admin == "1" ? "<th scope='col'></th>" : "");

        sql = string.Format(@"  DECLARE @id int;
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
		                            id_tipo,
		                            nome_tipo,
		                            nome_en_tipo,
		                            nome_fr_tipo,
		                            nome_es_tipo,
		                            ordem_tipo
                                from REPORT_IMAGEM(@id, @nome, @id_tipo)
                                where (nome like {0} or nome_tipo like {0})
                                {1}", String.Format("'%{0}%'", pesquisa), order);

        DataSet oDs = oDB.GetDataSet(sql, "").oData;
        if (oDB.validaDataSet(oDs))
        {
            for (int j = 0; j < oDs.Tables.Count; j++)
            {
                for (int i = 0; i < oDs.Tables[j].Rows.Count; i++)
                {
                    id = oDs.Tables[j].Rows[i]["id"].ToString().Trim();
                    nome = oDs.Tables[j].Rows[i]["nome"].ToString().Trim();
                    ordem = oDs.Tables[j].Rows[i]["ordem"].ToString().Trim();
                    nome_tipo = oDs.Tables[j].Rows[i]["nome_tipo"].ToString().Trim();
                    ordem_tipo = oDs.Tables[j].Rows[i]["ordem_tipo"].ToString().Trim();
                    slider_inicial = Convert.ToBoolean(oDs.Tables[j].Rows[i]["slider_inicial"].ToString().Trim());

                    if (slider_inicial) corSliderInicial = "#2DCE89";
                    else corSliderInicial = "#F5365C";

                    if (admin == "1")
                    {
                        htmlOptions = String.Format(@"  <td class='text-right'>
		                                                    <div class='dropdown'>
			                                                    <a class='btn btn-sm btn-icon-only text-light' href='#' role='button' data-toggle='dropdown' aria-haspopup='true' aria-expanded='false'>
			                                                        <i class='fas fa-ellipsis-v'></i>
			                                                    </a>
                                                                <div class='dropdown-menu dropdown-menu-right dropdown-menu-arrow'>
                                                                    <a class='dropdown-item' href='#' onclick='visualizar({0});'>Visualizar</a>
			                                                        <a class='dropdown-item' href='#' onclick='editar({0});'>Editar</a>
                                                                    <a class='dropdown-item' href='#' onclick='eliminar({0});'>Eliminar</a>
                                                                    {1}
			                                                    </div>
                                                            </div>
                                                        </td>", id, slider_inicial ? String.Format(@"<a class='dropdown-item' href='#' onclick='retirarSlider({0});'>Retirar do Slider Inicial</a>", id) : String.Format(@"<a class='dropdown-item' href='#' onclick='inserirSlider({0});'>Inserir no Slider Inicial</a>", id));
                    }

                    html += String.Format(@"    <tr class='pointer' ondblclick='editar({6});'>
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
	                                            </tr>", nome_tipo, ordem_tipo, nome, ordem, corSliderInicial, htmlOptions, id);
                }
            }
        }
        else
        {
            html += String.Format(@"<tr><td colspan='{0}'>Sem imagens no servidor!</td></tr>", admin == "1" ? "6" : "5");
        }


        html += "</tbody></table>";


        return html;
    }

    [WebMethod]
    public static string delRow(string id, string idUser)
    {
        string sql = "", ret = "1", retMessage = "Registo eliminado com sucesso.", imgName = "";
        DataSqlServer oDB = new DataSqlServer();


        sql = string.Format(@"  DECLARE @id INT = {0};
                                DECLARE @idUser int = {1};
                                DECLARE @ret int
                                DECLARE @retMsg VARCHAR(255)
                                DECLARE @imgName varchar(max) = (select CONCAT(LTRIM(RTRIM(STR(id))), extensao) from REPORT_IMAGEM(@id, null, null))

                                EXEC DELETE_IMAGEM @iduser, @id, @ret OUTPUT, @retMsg OUTPUT
                                SELECT @ret ret, @retMsg retMsg, @imgName as imgName", id, idUser);


        DataSet oDs = oDB.GetDataSet(sql, "").oData;

        if (oDB.validaDataSet(oDs))
        {
            ret = oDs.Tables[0].Rows[0]["ret"].ToString().Trim();
            retMessage = oDs.Tables[0].Rows[0]["retMsg"].ToString().Trim();
            imgName = oDs.Tables[0].Rows[0]["imgName"].ToString().Trim();

            var filePath = HttpContext.Current.Server.MapPath("~/img/portfolio/" + imgName);
            if (File.Exists(filePath))
            {
                File.Delete(filePath);
            }
        }

        return ret + "<#SEP#>" + retMessage;
    }

    [WebMethod]
    public static string updateSliderInicial(string id, string idUser, string slider_inicial)
    {
        string sql = "", ret = "1", retMessage = "Imagem atualizada com sucesso!";
        DataSqlServer oDB = new DataSqlServer();


        sql = string.Format(@"  DECLARE @id INT = {0};
                                DECLARE @idUser int = {1};
                                DECLARE @slider_inicial bit = {2};
                                DECLARE @ret int
                                DECLARE @retMsg VARCHAR(255)

                                EXEC UPDATE_SLIDER_INICIAL @iduser, @id, @slider_inicial, @ret OUTPUT, @retMsg OUTPUT
                                SELECT @ret ret, @retMsg retMsg ", id, idUser, slider_inicial);


        DataSet oDs = oDB.GetDataSet(sql, "").oData;

        if (oDB.validaDataSet(oDs))
        {
            ret = oDs.Tables[0].Rows[0]["ret"].ToString().Trim();
            retMessage = oDs.Tables[0].Rows[0]["retMsg"].ToString().Trim();
        }

        return ret + "<#SEP#>" + retMessage;
    }

    [WebMethod]
    public static string getImage(string id)
    {
        string sql = "", html = "";
        string image = "", nome = "", nome_tipo = "";

        DataSqlServer oDB = new DataSqlServer();

        sql = string.Format(@"  DECLARE @id int = {0};
                                DECLARE @nome varchar(500);
                                DECLARE @id_tipo int;
                                select
                                    nome_tipo, nome, CONCAT(LTRIM(RTRIM(STR(id))), extensao) as imagem
                                from REPORT_IMAGEM(@id, @nome, @id_tipo)", id);

        DataSet oDs = oDB.GetDataSet(sql, "").oData;
        if (oDB.validaDataSet(oDs))
        {
            for (int j = 0; j < oDs.Tables.Count; j++)
            {
                for (int i = 0; i < oDs.Tables[j].Rows.Count; i++)
                {
                    nome_tipo = oDs.Tables[j].Rows[i]["nome_tipo"].ToString().Trim();
                    image = oDs.Tables[j].Rows[i]["imagem"].ToString().Trim();
                    nome = oDs.Tables[j].Rows[i]["nome"].ToString().Trim();

                    html += String.Format(@"<div class='card-body'>
                                                <div class='row'>
                                                    <div class='col-md-12' style='text-align:center'>
                                                        <img src='../img/portfolio/{0}' style='width:75%; max-width: 100%; height: auto; margin: auto' />
                                                    </div>
                                                </div>
                                            </div>", image);
                }
            }
        }
        else
        {
            html += String.Format(@"<div class='card-body'>
                                                <div class='row'>
                                                    <div class='col-md-12' style='text-align:center'>
                                                        <span class='text-nowrap text-primary'>Imagem não encontrada!</span>
                                                    </div>
                                                </div>
                                            </div>", image);
        }


        return nome + "<#SEP#>" + html + "<#SEP#>" + nome_tipo;
    }
}