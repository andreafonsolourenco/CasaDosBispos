using System;
using System.Web.Services;
using System.Data;


public partial class config_ficha_contactos : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }

    [WebMethod]
    public static string saveData(string id, string nome, string morada1, string morada2, string codpostal, string localidade, string idUser, string email, string telefone)
    {
        DataSqlServer oDB = new DataSqlServer();

        string sql = "", ret = "1", retMessage = "Dados guardados com sucesso.";

        sql = string.Format(@"  DECLARE @idUser int = {0};
	                            DECLARE @id INT = {1};
	                            DECLARE @nome varchar(500) = '{2}';
	                            DECLARE @morada1 varchar(500) = '{3}';
	                            DECLARE @morada2 varchar(500) = '{4}';
	                            DECLARE @codpostal varchar(500) = '{5}';
	                            DECLARE @localidade varchar(500) = '{6}';
                                DECLARE @telefone varchar(20) = '{7}';
	                            DECLARE @email varchar(500) = '{8}';
	                            DECLARE @ret int;
                                DECLARE @retMsg VARCHAR(max);

                                EXECUTE CRIA_EDITA_CONTACTOS @idUser, @id, @nome, @morada1, @morada2, @codpostal, @localidade, @telefone, @email, @ret OUTPUT, @retMsg OUTPUT
                                SELECT @ret ret, @retMsg retMsg ", idUser, String.IsNullOrEmpty(id) ? "NULL" : id, nome, morada1, morada2, codpostal, localidade, telefone, email);


        DataSet oDs = oDB.GetDataSet(sql, "").oData;

        if (oDB.validaDataSet(oDs))
        {
            ret = oDs.Tables[0].Rows[0]["ret"].ToString().Trim();
            retMessage = oDs.Tables[0].Rows[0]["retMsg"].ToString().Trim();
        }

        return ret + "<#SEP#>" + retMessage;
    }


    [WebMethod]
    public static string getData()
    {
        const string sep = "<#SEP#>";
        string sql = "", id = "", nome = "", morada1 = "", morada2 = "", codpostal = "", localidade = "", telefone = "", email = "";

        DataSqlServer oDB = new DataSqlServer();


        sql = string.Format(@"  select
                                    id,
		                            NOME,
		                            MORADA1,
		                            MORADA2,
		                            COD_POSTAL,
		                            LOCALIDADE,
                                    telefone,
                                    email
                                from REPORT_CONTACTOS()");
        DataSet oDs = oDB.GetDataSet(sql, "").oData;

        if (oDB.validaDataSet(oDs))
        {
            id = oDs.Tables[0].Rows[0]["id"].ToString().Trim();
            nome = oDs.Tables[0].Rows[0]["NOME"].ToString().Trim();
            morada1 = oDs.Tables[0].Rows[0]["MORADA1"].ToString().Trim();
            morada2 = oDs.Tables[0].Rows[0]["MORADA2"].ToString().Trim();
            codpostal = oDs.Tables[0].Rows[0]["COD_POSTAL"].ToString().Trim();
            localidade = oDs.Tables[0].Rows[0]["LOCALIDADE"].ToString().Trim();
            telefone = oDs.Tables[0].Rows[0]["telefone"].ToString().Trim();
            email = oDs.Tables[0].Rows[0]["email"].ToString().Trim();
        }

        // Prepara o retorno dos dados
        return id + sep +
              nome + sep +
              morada1 + sep +
              morada2 + sep +
              codpostal + sep +
              localidade + sep +
              telefone + sep +
              email;
    }
}