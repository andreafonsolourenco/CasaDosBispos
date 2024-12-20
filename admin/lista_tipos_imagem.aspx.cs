using System;
using System.Web.Services;
using System.Data;
using System.IO;
using System.Web;

public partial class lista_tipos_imagem : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    [WebMethod]
    public static string getGrelha(string pesquisa, string order, string admin)
    {
        string sql = "", html = "", htmlOptions = "";
        string id = "", nome = "", ordem = "";

        DataSqlServer oDB = new DataSqlServer();

        html += String.Format(@"<table class='table align-items-center table-flush'>
		                            <thead class='thead-light'>
		                            <tr>
			                            <th scope='col' class='pointer th_text' onclick='ordenaOrdem();'>Ordem</th>
                                        <th scope='col' class='pointer th_text' onclick='ordenaNome();'>Nome</th>
                                        {0}
		                            </tr>
		                            </thead>
                                    <tbody>", admin == "1" ? "<th scope='col'></th>" : "");

        sql = string.Format(@"  DECLARE @id int;
                                DECLARE @nome varchar(500);
                                select
                                    id,
		                            NOME,
                                    ordem
                                from REPORT_IMAGEM_TIPO(@id, @nome)
                                where (nome like {0})
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
                    ordem = oDs.Tables[j].Rows[i]["ordem"].ToString().Trim();

                    if (admin == "1")
                    {
                        htmlOptions = String.Format(@"  <td class='text-right'>
		                                                    <div class='dropdown'>
			                                                    <a class='btn btn-sm btn-icon-only text-light' href='#' role='button' data-toggle='dropdown' aria-haspopup='true' aria-expanded='false'>
			                                                        <i class='fas fa-ellipsis-v'></i>
			                                                    </a>
                                                                <div class='dropdown-menu dropdown-menu-right dropdown-menu-arrow'>
			                                                        <a class='dropdown-item' href='#' onclick='editar({0});'>Editar</a>
                                                                    <a class='dropdown-item' href='#' onclick='eliminar({0});'>Eliminar</a>
			                                                    </div>
                                                            </div>
                                                        </td>", id);
                    }

                    html += String.Format(@"    <tr class='pointer' ondblclick='editar({0});'>
		                                            <td><span>{3}</span></td>
                                                    <td><span>{1}</span></td>
		                                            {2}                   
	                                            </tr>", id, nome, htmlOptions, ordem);
                }
            }
        }
        else
        {
            html += String.Format(@"<tr><td colspan='{0}'>Não existem tipos de imagem a apresentar.</td></tr>", admin == "1" ? "3" : "2");
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

                                select CONCAT(LTRIM(RTRIM(STR(id))), extensao) as imgName from REPORT_IMAGEM(null, null, @id)

                                EXEC DELETE_IMAGEM_TIPO @iduser, @id, @ret OUTPUT, @retMsg OUTPUT
                                SELECT @ret ret, @retMsg retMsg ", id, idUser);


        DataSet oDs = oDB.GetDataSet(sql, "").oData;

        if (oDB.validaDataSet(oDs))
        {
            ret = oDs.Tables[1].Rows[0]["ret"].ToString().Trim();
            retMessage = oDs.Tables[1].Rows[0]["retMsg"].ToString().Trim();

            if(ret == id)
            {
                for (int i = 0; i < oDs.Tables[0].Rows.Count; i++)
                {
                    imgName = oDs.Tables[0].Rows[i]["imgName"].ToString().Trim();

                    var filePath = HttpContext.Current.Server.MapPath("~/img/portfolio/" + imgName);
                    if (File.Exists(filePath))
                    {
                        File.Delete(filePath);
                    }
                }
            }
        }

        return ret + "<#SEP#>" + retMessage;
    }

    protected void Upload_Click(object sender, EventArgs e)
    {
        DataSqlServer oDB = new DataSqlServer();

        if (!FileUploadControl.HasFile)
        {
            uploadFileSuccess.InnerHtml = "";
            uploadFileDanger.InnerHtml = "Por favor, selecione um ficheiro!";
            return;
        }

        if (!FileUploadControl.HasFile)
        {
            uploadFileSuccess.InnerHtml = "";
            uploadFileDanger.InnerHtml = "Por favor, selecione um ficheiro!";
            return;
        }

        if (FileUploadControl.HasFile)
        {
            try
            {
                string filename = Path.GetFileName(FileUploadControl.FileName);
                string extension = Path.GetExtension(FileUploadControl.FileName);
                string pathToSave = Server.MapPath("~") + "uploaded_files/TiposImagem_" + DateTime.Now.ToShortDateString().Replace("/", "") + "_" + DateTime.Now.ToLocalTime().ToShortTimeString().Replace(":", "") + extension;
                
                if(!extension.Contains("csv") && !extension.Contains("xls"))
                {
                    uploadFileSuccess.InnerHtml = "";
                    uploadFileDanger.InnerHtml = "Por favor, selecione um ficheiro Excel válido! (*.csv | *.xls | *.xlsx)";
                    return;
                }

                FileUploadControl.SaveAs(pathToSave);

                if (oDB.insertCSVFileIntoDB(pathToSave, "IMAGES_TYPE", userID.Text))
                {
                    uploadFileSuccess.InnerHtml = "Tipos de Imagem Carregados com sucesso!";
                    uploadFileDanger.InnerHtml = "";
                    return;
                }
                else
                {
                    uploadFileSuccess.InnerHtml = "";
                    uploadFileDanger.InnerHtml = "Ocorreu um erro ao carregar o ficheiro!";
                    return;
                }
            }
            catch (Exception ex)
            {
                uploadFileSuccess.InnerHtml = "";
                uploadFileDanger.InnerHtml = "Ocorreu um erro ao carregar o ficheiro: " + ex.ToString();
                return;
            }
        }
    }
}