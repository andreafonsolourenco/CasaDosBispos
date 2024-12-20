using System;
using System.Web.Services;
using System.Data;

public partial class dashboard : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }

    [WebMethod]
    public static string getGrafico()
    {
        string sql = "", ret = "", nr = "", mes = "";
        DataSqlServer oDB = new DataSqlServer();


        sql = @"set language Portuguese
                select
                    SUM(nr) as nr,
                    mes,
                    mes_nome
                from REPORT_GRAPHIC_DATA()
                where ano = year(getdate())
                group by mes, mes_nome
                order by mes desc";

        DataSet oDs = oDB.GetDataSet(sql, "").oData;

        if (oDB.validaDataSet(oDs))
        {
            for (int j = 0; j < oDs.Tables.Count; j++)
            {
                for (int i = 0; i < oDs.Tables[j].Rows.Count; i++)
                {
                    if(i > 0)
                    {
                        ret += "<#SEP#>";
                    }

                    nr = oDs.Tables[j].Rows[i]["nr"].ToString().Trim();
                    mes = oDs.Tables[j].Rows[i]["mes_nome"].ToString().Trim();

                    ret += nr + "@" + mes;
                }
            }
        }

        return ret;
    }

    [WebMethod]
    public static string getContactosSite()
    {
        string sql = "", html = "";
        string ano = "", mes = "", mes_nome = "", success = "", not_success = "";
        DataSqlServer oDB = new DataSqlServer();

        html += @"  <table class='table align-items-center table-flush'>
		                <thead class='thead-light'>
		                    <tr>
                                <th scope='col'>Ano</th>
                                <th scope='col'>Mês</th>
                                <th scope='col'>Nº Contactos com sucesso</th>
                                <th scope='col'>Nº Contactos com erro</th>
		                    </tr>
		                </thead>
                        <tbody>";


        sql = @"set language Portuguese
                select
		            ano, mes, success, not_success, mes_nome
	            from REPORT_DASHBOARD_TABLE_DATA()
                order by ano desc, mes desc";

        DataSet oDs = oDB.GetDataSet(sql, "").oData;
        if (oDB.validaDataSet(oDs))
        {
            for (int j = 0; j < oDs.Tables.Count; j++)
            {
                for (int i = 0; i < oDs.Tables[j].Rows.Count; i++)
                {
                    ano = oDs.Tables[j].Rows[i]["ano"].ToString().Trim();
                    mes = oDs.Tables[j].Rows[i]["mes"].ToString().Trim();
                    mes_nome = oDs.Tables[j].Rows[i]["mes_nome"].ToString().Trim();
                    success = oDs.Tables[j].Rows[i]["success"].ToString().Trim();
                    not_success = oDs.Tables[j].Rows[i]["not_success"].ToString().Trim();

                    html += String.Format(@"<tr>
		                                        <td>{0}</td>
                                                <td>{1}</td>
                                                <td>{2}</td>
                                                <td>{3}</td>
	                                        </tr>", ano, mes_nome, success, not_success);
                }
            }
        }

        html += "</tbody></table>";

        return html;
    }
}