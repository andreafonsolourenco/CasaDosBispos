using System;
using System.Web.Services;
using System.Data;
using System.Net;
using Newtonsoft.Json.Linq;

public partial class index : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }

    [WebMethod]
    public static string trataExpiracao(string i)
    {
        DataSqlServer oDB = new DataSqlServer();

        string sql = "", ret = "-1", retMessage = "Sessão expirada", admin = "", name = "";

        sql = string.Format(@"  DECLARE @id int = {0};
                                DECLARE @ret bit;
                                DECLARE @admin bit;
                                DECLARE @name varchar(max);

                                EXEC [VALIDATE_USER_SESSION] @id, @ret output, @admin output, @name output

                                select @ret as ret, @admin as admin, @name as name", i);

        DataSet oDs = oDB.GetDataSet(sql, "").oData;

        if (oDB.validaDataSet(oDs))
        {
            ret = Convert.ToInt32(Convert.ToBoolean(oDs.Tables[0].Rows[0]["ret"].ToString().Trim())).ToString();
            retMessage = ret == "1" ? "Sessão válida e ativa" : "Sessão expirada";
            admin = Convert.ToInt32(Convert.ToBoolean(oDs.Tables[0].Rows[0]["admin"].ToString().Trim())).ToString();
            name = oDs.Tables[0].Rows[0]["name"].ToString().Trim();
        }

        return ret + "<#SEP#>" + retMessage + "<#SEP#>" + admin + "<#SEP#>" + name;
    }

    [WebMethod]
    public static string getTotais(string id)
    {
        string sql = "", html = "";
        string label1 = "", total1 = "", rodape1 = "", label2 = "", total2 = "", rodape2 = "", label3 = "", total3 = "", rodape3 = "";

        DataSqlServer oDB = new DataSqlServer();

        sql = @"    SET LANGUAGE Portuguese

                    select
                        label1,
                        total1,
                        rodape1,
                        label2,
                        total2,
                        rodape2,
                        label3,
                        total3,
                        rodape3
                    from REPORT_DASHBOARD_DATA()";

        DataSet oDs = oDB.GetDataSet(sql, "").oData;
        if (oDB.validaDataSet(oDs))
        {
            label1 = oDs.Tables[0].Rows[0]["label1"].ToString().Trim();
            total1 = oDs.Tables[0].Rows[0]["total1"].ToString().Trim();
            rodape1 = oDs.Tables[0].Rows[0]["rodape1"].ToString().Trim();

            label2 = oDs.Tables[0].Rows[0]["label2"].ToString().Trim();
            total2 = oDs.Tables[0].Rows[0]["total2"].ToString().Trim();
            rodape2 = oDs.Tables[0].Rows[0]["rodape2"].ToString().Trim();

            label3 = oDs.Tables[0].Rows[0]["label3"].ToString().Trim();
            total3 = oDs.Tables[0].Rows[0]["total3"].ToString().Trim();
            rodape3 = oDs.Tables[0].Rows[0]["rodape3"].ToString().Trim();
        }


        html = label1 + "@" + total1 + "@" + rodape1 + "@" + label2 + "@" + total2 + "@" + rodape2 + "@" + label3 + "@" + total3 + "@" + rodape3;

        return html;
    }

    [WebMethod]
    public static string getRetornoURL(string url)
    {
        try
        {
            WebClient client = new WebClient();

            client.Headers.Add("User-Agent: BrowseAndDownload");
            ServicePointManager.Expect100Continue = true;
            ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12;
            ServicePointManager.ServerCertificateValidationCallback = delegate { return true; };

            string ret = client.DownloadString(url);

            //TRIMA a string        
            ret = ret.Trim();

            return ret;
        }
        catch (Exception)
        {
            return "";
        }
    }

    [WebMethod]
    public static string getAboutId()
    {
        string sql = "", codigo = "ABOUT", id = "";

        DataSqlServer oDB = new DataSqlServer();


        sql = string.Format(@"  DECLARE @id int;
                                DECLARE @codigo varchar(100) = '{0}';
                                select
                                    id
                                from REPORT_TEXTOS(@id, @codigo)", codigo);
        DataSet oDs = oDB.GetDataSet(sql, "").oData;

        if (oDB.validaDataSet(oDs))
        {
            id = oDs.Tables[0].Rows[0]["id"].ToString().Trim();
        }

        // Prepara o retorno dos dados
        return id;
    }
}