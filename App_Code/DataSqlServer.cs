using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using Microsoft.VisualBasic.FileIO;
using System;
using System.Collections.Generic;
using System.IO;
using ExcelDataReader;
using System.Web.Services.Description;
using System.Web.UI.WebControls;
using System.Activities.Expressions;

/// <summary>
/// Summary description for DataSqlServer
/// </summary>
public class DataSqlServer
{
    SqlConnection oConn = null;

    public DataSqlServer()
    {

    }

    public struct getDataResult
    {
        public int Code;
        public string Message;
        public DataSet oData;
    }

    public struct CommandResult
    {
        public string Code;
        public string Message;
    }

    private string getConnectionString()
    {
        string ret = ConfigurationManager.ConnectionStrings["CS_CDB"].ConnectionString.ToString();

        return ret;
    }

    private void openDataBase()
    {
        if (oConn.State == ConnectionState.Closed) oConn.Open();
    }

    private void closeDataBase()
    {
        if (oConn.State == ConnectionState.Open) oConn.Close();
    }

    public bool validaDataSet(DataSet oDs)
    {
        if (oDs != null && oDs.Tables.Count > 0 && oDs.Tables[0].Rows.Count > 0)
            return true;
        else
            return false;
    }

    public getDataResult GetDataSet(string query, string session)
    {
        getDataResult oResult = new getDataResult();
        DataSet oData = new DataSet();


        if (session.Trim() != "")
        {
            query += " UPDATE SESSAO SET ultimaiteracao=getdate() WHERE session='" + session + "'";
        }

        // Verifica se temos objeto conexao à bd, se nao tivermos criamos
        if (oConn == null)
        {
            oConn = new SqlConnection(getConnectionString());
        }

        // Executamos o sql para retornar os dados pretendidos
        SqlCommand cmd = new SqlCommand(query, oConn);

        // Abre a conexao à base de dados, caso esta esteja fechada
        openDataBase();


        // create data adapter
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        // this will query your database and return the result to your datatable
        da.Fill(oData);

        // Fecha a conexao à base de dados, caso esta esteja aberta
        closeDataBase();

        // Destroimos o objet DataAdapter
        da.Dispose();


        // Verificamos a consitencia e preparamos o retorno
        if (validaDataSet(oData))
        {
            oResult.Code = 1;
            oResult.Message = "Foram retornados " + oData.Tables[0].Rows.Count.ToString() + " registos.";
            oResult.oData = oData;
        }

        return oResult;
    }

    public CommandResult RunDataCommand(string query, string session)
    {
        CommandResult oRes = new CommandResult();
        oRes.Code = "";
        oRes.Message = "";


        if (session.Trim() != "")
        {
            query += " UPDATE SESSAO SET ultimaiteracao=getdate() WHERE session='" + session + "'";
        }

        try
        {
            // Verifica se temos objeto conexao à bd, se nao tivermos criamos
            if (oConn == null)
            {
                oConn = new SqlConnection(getConnectionString());
            }

            // Abre a conexao à base de dados, caso esta esteja fechada
            openDataBase();

            SqlCommand cmdExecute = new SqlCommand(query, oConn);
            cmdExecute.ExecuteNonQuery();

            // Fecha a conexao à base de dados, caso esta esteja aberta
            closeDataBase();

            cmdExecute.Dispose();

            oRes.Code = "<OK>";
            oRes.Message = "Comando executado com sucesso.";
        }
        catch (SqlException ex)
        {
            oRes.Code = "<ERROR>";
            oRes.Message = ex.Message.ToString();
        }

        return oRes;
    }

    private DataTable GetDataTableFromCSVFile(string csv_file_path)
    {
        DataTable csvData = new DataTable();
        try
        {
            using (TextFieldParser csvReader = new TextFieldParser(csv_file_path))
            {
                csvReader.SetDelimiters(new string[] { ";" });
                csvReader.HasFieldsEnclosedInQuotes = true;
                string[] colFields = csvReader.ReadFields();
                foreach (string column in colFields)
                {
                    DataColumn datecolumn = new DataColumn(column);
                    datecolumn.AllowDBNull = true;
                    csvData.Columns.Add(datecolumn);
                }
                while (!csvReader.EndOfData)
                {
                    string[] fieldData = csvReader.ReadFields();
                    //Making empty value as null
                    for (int i = 0; i < fieldData.Length; i++)
                    {
                        if (fieldData[i] == "")
                        {
                            fieldData[i] = null;
                        }
                    }
                    csvData.Rows.Add(fieldData);
                }
            }
        }
        catch (Exception ex)
        {
            return null;
        }
        return csvData;
    }

    private bool insertDataIntoDB(DataTable csvFileData, string tableName, string userID)
    {
        try
        {
            // Verifica se temos objeto conexao à bd, se nao tivermos criamos
            if (oConn == null)
            {
                oConn = new SqlConnection(getConnectionString());
            }

            // Abre a conexao à base de dados, caso esta esteja fechada
            openDataBase();

            using (SqlBulkCopy s = new SqlBulkCopy(oConn))
            {
                DataTable dt = null;
                s.DestinationTableName = tableName;
                
                foreach (var column in csvFileData.Columns)
                {
                    s.ColumnMappings.Add(column.ToString(), column.ToString());
                }

                switch(tableName)
                {
                    case "TEXTOS":
                        dt = getTextsDataTable(csvFileData, userID);
                        break;
                    case "TIPOS_ESPECIALIDADES":
                        dt = getSpecTypeDataTable(csvFileData, userID);
                        break;
                    case "IMAGES_TYPE":
                        dt = getImagesTypesDataTable(csvFileData, userID);
                        break;
                    case "PORTFOLIO":
                        dt = getPortfolioDataTable(csvFileData, userID);
                        break;
                    case "ESPECIALIDADES":
                        dt = getSpecDataTable(csvFileData, userID);
                        break;
                    default:
                        break;
                }

                openDataBase();
                s.WriteToServer(dt);
            }

            // Fecha a conexao à base de dados, caso esta esteja aberta
            closeDataBase();
        }
        catch (Exception ex)
        {
            return false;
        }

        return true;
    }

    private DataTable getTextsDataTable(DataTable csvFileData, string userID)
    {
        DataTable dt = csvFileData.Clone();
        string[] rowNames = { "codigo", "nome", "texto", "ordem" };

        foreach (DataRow row in csvFileData.Rows)
        {
            if (!updateTextIfExists(userID, row))
            {
                if(validateMandatoryRows(row, rowNames))
                {
                    dt.ImportRow(row);
                }
            }
        }

        return dt;
    }

    private DataTable getSpecTypeDataTable(DataTable csvFileData, string userID)
    {
        DataTable dt = csvFileData.Clone();
        string[] rowNames = { "nome", "ordem" };

        foreach (DataRow row in csvFileData.Rows)
        {
            if (!updateSpecTypesIfExists(userID, row))
            {
                if (validateMandatoryRows(row, rowNames))
                {
                    dt.ImportRow(row);
                }
            }
        }

        return dt;
    }

    private DataTable getImagesTypesDataTable(DataTable csvFileData, string userID)
    {
        DataTable dt = csvFileData.Clone();
        string[] rowNames = { "nome" };

        foreach (DataRow row in csvFileData.Rows)
        {
            if (!updateImagesTypesIfExists(userID, row))
            {
                if (validateMandatoryRows(row, rowNames))
                {
                    dt.ImportRow(row);
                }
            }
        }

        return dt;
    }

    private DataTable getSpecDataTable(DataTable csvFileData, string userID)
    {
        DataTable dt = csvFileData.Clone();
        string[] rowNames = { "nome", "tipo" };

        foreach (DataRow row in csvFileData.Rows)
        {
            if (!updateSpecIfExists(userID, row))
            {
                if (validateMandatoryRows(row, rowNames))
                {
                    dt.ImportRow(row);
                }
            }
        }

        return dt;
    }

    private DataTable getPortfolioDataTable(DataTable csvFileData, string userID)
    {
        DataTable dt = csvFileData.Clone();
        string[] rowNames = { "texto", "ano", "localidade", "tipo" };

        foreach (DataRow row in csvFileData.Rows)
        {
            if (!updatePortfolioIfExists(userID, row))
            {
                if (validateMandatoryRows(row, rowNames))
                {
                    dt.ImportRow(row);
                }
            }
        }
        return dt;
    }

    private bool validateMandatoryRows(DataRow row, string[] rowNames)
    {
        foreach(string rowName in rowNames)
        {
            if(String.IsNullOrEmpty(row[rowName].ToString()))
            {
                return false;
            }
        }

        return true;
    }

    public static bool SaveAsCsv(string excelFilePath, string destinationCsvFilePath)
    {
        try
        {
            using (var stream = new FileStream(excelFilePath, FileMode.Open, FileAccess.Read, FileShare.ReadWrite))
            {
                IExcelDataReader reader = null;
                if (excelFilePath.EndsWith(".xls"))
                {
                    reader = ExcelReaderFactory.CreateBinaryReader(stream);
                }
                else if (excelFilePath.EndsWith(".xlsx"))
                {
                    reader = ExcelReaderFactory.CreateOpenXmlReader(stream);
                }

                if (reader == null)
                    return false;

                DataSet ds = reader.AsDataSet(new ExcelDataSetConfiguration()
                {
                    ConfigureDataTable = (tableReader) => new ExcelDataTableConfiguration()
                    {
                        UseHeaderRow = false
                    }
                });

                var csvContent = string.Empty;
                int row_no = 0;
                while (row_no < ds.Tables[0].Rows.Count)
                {
                    var arr = new List<string>();
                    for (int i = 0; i < ds.Tables[0].Columns.Count; i++)
                    {
                        arr.Add(ds.Tables[0].Rows[row_no][i].ToString());
                    }
                    row_no++;
                    csvContent += string.Join(";", arr) + "\n";
                }

                StreamWriter csv = new StreamWriter(destinationCsvFilePath, false);
                csv.Write(csvContent);
                csv.Close();
                return true;
            }
        }
        catch (Exception ex)
        {
            return false;
        }
    }

    public bool updateTextIfExists(string userID, DataRow row)
    {
        string codigo = getRowValue(row, "codigo"), nome = getRowValue(row, "nome"), nome_en = getRowValue(row, "nome_en"), nome_fr = getRowValue(row, "nome_fr"), nome_es = getRowValue(row, "nome_es"),
            texto = getRowValue(row, "texto"), texto_en = getRowValue(row, "texto_en"), texto_fr = getRowValue(row, "texto_fr"), texto_es = getRowValue(row, "texto_es"),
            ordem = getRowValue(row, "ordem");

        string sql = string.Format(@"   DECLARE @idUser int = {0};
	                                    DECLARE @id INT;
	                                    DECLARE @codigo varchar(100) = '{1}';
	                                    DECLARE @nome varchar(500) = '{2}';
	                                    DECLARE @nome_en varchar(500) = '{3}';
	                                    DECLARE @nome_fr varchar(500) = '{4}';
	                                    DECLARE @nome_es varchar(500) = '{5}';
	                                    DECLARE @texto varchar(max) = '{6}';
	                                    DECLARE @texto_en varchar(max) = '{7}';
                                        DECLARE @texto_fr varchar(max) = '{8}';
                                        DECLARE @texto_es varchar(max) = '{9}';
	                                    DECLARE @ordem int = {10};
	                                    DECLARE @ret int;
                                        DECLARE @retMsg VARCHAR(max);

                                        EXECUTE CRIA_EDITA_TEXTOS @idUser, @id, @codigo, @nome, @nome_en, @nome_fr, @nome_es, @texto, @texto_en, @texto_fr, @texto_es, @ordem, @ret OUTPUT, @retMsg OUTPUT
                                        SELECT @ret ret, @retMsg retMsg ", userID, codigo, nome, nome_en, nome_fr, nome_es, texto, texto_en,
                                            texto_fr, texto_es, ordem);

        DataSet oDs = GetDataSet(sql, "").oData;

        if (validaDataSet(oDs))
        {
            if(Convert.ToInt32(oDs.Tables[0].Rows[0]["ret"].ToString().Trim()) > 0)
            {
                return true;
            }

            return false;
        }

        return false;
    }

    public bool updateSpecTypesIfExists(string userID, DataRow row)
    {
        string nome = getRowValue(row, "nome"), nome_en = getRowValue(row, "nome_en"), nome_fr = getRowValue(row, "nome_fr"), nome_es = getRowValue(row, "nome_es"), ordem = getRowValue(row, "ordem");

        string sql = string.Format(@"   DECLARE @idUser int = {0};
	                                    DECLARE @id INT;
	                                    DECLARE @nome varchar(500) = '{1}';
	                                    DECLARE @nome_en varchar(500) = '{2}';
	                                    DECLARE @nome_fr varchar(500) = '{3}';
	                                    DECLARE @nome_es varchar(500) = '{4}';
	                                    DECLARE @ordem int = {5};
                                        DECLARE @fromCsv bit = 1;
	                                    DECLARE @ret int;
                                        DECLARE @retMsg VARCHAR(max);

                                        EXECUTE CRIA_EDITA_TIPOS_ESPECIALIDADE @idUser, @id, @nome, @nome_en, @nome_fr, @nome_es, @ordem, @fromCsv, @ret OUTPUT, @retMsg OUTPUT
                                        SELECT @ret ret, @retMsg retMsg ", userID, nome, nome_en, nome_fr, nome_es, ordem);

        DataSet oDs = GetDataSet(sql, "").oData;

        if (validaDataSet(oDs))
        {
            if (Convert.ToInt32(oDs.Tables[0].Rows[0]["ret"].ToString().Trim()) > 0)
            {
                return true;
            }

            return false;
        }

        return false;
    }

    public bool updateImagesTypesIfExists(string userID, DataRow row)
    {
        string nome = getRowValue(row, "nome"), nome_en = getRowValue(row, "nome_en"), nome_fr = getRowValue(row, "nome_fr"), nome_es = getRowValue(row, "nome_es"),
            ordem = getRowValue(row, "ordem");

        string sql = string.Format(@"   DECLARE @idUser int = {0};
	                                    DECLARE @id INT;
	                                    DECLARE @nome varchar(500) = '{1}';
	                                    DECLARE @nome_en varchar(500) = '{2}';
	                                    DECLARE @nome_fr varchar(500) = '{3}';
	                                    DECLARE @nome_es varchar(500) = '{4}';
                                        DECLARE @ordem int = {5};
	                                    DECLARE @ret int;
                                        DECLARE @retMsg VARCHAR(max);

                                        EXECUTE CRIA_EDITA_IMAGEM_TIPO @idUser, @id, @nome, @nome_en, @nome_fr, @nome_es, @ordem, @ret OUTPUT, @retMsg OUTPUT
                                        SELECT @ret ret, @retMsg retMsg ", userID, nome, nome_en, nome_fr, nome_es, ordem);

        DataSet oDs = GetDataSet(sql, "").oData;

        if (validaDataSet(oDs))
        {
            if (Convert.ToInt32(oDs.Tables[0].Rows[0]["ret"].ToString().Trim()) > 0)
            {
                return true;
            }

            return false;
        }

        return false;
    }

    public bool updateSpecIfExists(string userID, DataRow row)
    {
        string id = getRowValue(row, "id"), nome = getRowValue(row, "nome"), nome_en = getRowValue(row, "nome_en"), nome_fr = getRowValue(row, "nome_fr"), nome_es = getRowValue(row, "nome_es"), ordem = getRowValue(row, "ordem");
        string tipo = getRowValue(row, "tipo"), tipo_en = getRowValue(row, "tipo_en"), tipo_fr = getRowValue(row, "tipo_fr"), tipo_es = getRowValue(row, "tipo_es"), ordem_tipo = getRowValue(row, "ordem_tipo");
        string xml = string.Empty;

        xml = string.Format(@"  <ESPECIALIDADE>
                                    <ID>{0}</ID>
                                    <ESPECIALIDADE>{1}</ESPECIALIDADE>
                                    <ESPECIALIDADE_EN>{2}</ESPECIALIDADE_EN>
                                    <ESPECIALIDADE_FR>{3}</ESPECIALIDADE_FR>
                                    <ESPECIALIDADE_ES>{4}</ESPECIALIDADE_ES>
                                    <ORDEM>{5}</ORDEM>
                                    <TIPO_ESPECIALIDADE>
                                        <TIPO>{6}</TIPO>
                                        <TIPO_EN>{7}</TIPO_EN>
                                        <TIPO_FR>{8}</TIPO_FR>
                                        <TIPO_ES>{9}</TIPO_ES>
                                        <ORDEM>{10}</ORDEM>
                                    </TIPO_ESPECIALIDADE>
                                </ESPECIALIDADE>", id, nome, nome_en, nome_fr, nome_es, string.IsNullOrEmpty(ordem) || string.IsNullOrWhiteSpace(ordem) ? "0" : ordem, 
                                tipo, tipo_en, tipo_fr, tipo_es, string.IsNullOrEmpty(ordem_tipo) || string.IsNullOrWhiteSpace(ordem_tipo) ? "0" : ordem_tipo);

        string sql = string.Format(@"   DECLARE @idUser int = {0};
	                                    DECLARE @DocXml nvarchar(max) = N'{1}';
	                                    DECLARE @ret int;
                                        DECLARE @retMsg VARCHAR(max);

                                        EXECUTE CRIA_EDITA_ESPECIALIDADE @idUser, @DocXml, @ret OUTPUT, @retMsg OUTPUT
                                        SELECT @ret ret, @retMsg retMsg ", userID, xml);

        DataSet oDs = GetDataSet(sql, "").oData;

        if (validaDataSet(oDs))
        {
            if (Convert.ToInt32(oDs.Tables[0].Rows[0]["ret"].ToString().Trim()) > 0)
            {
                return true;
            }

            return false;
        }

        return false;
    }

    public bool updatePortfolioIfExists(string userID, DataRow row)
    {
        string id = getRowValue(row, "id"), texto = getRowValue(row, "texto"), texto_en = getRowValue(row, "texto_en"), texto_fr = getRowValue(row, "texto_fr"), texto_es = getRowValue(row, "texto_es");
        string ordem = getRowValue(row, "ordem"), img = getRowValue(row, "img"), ano = getRowValue(row, "ano"), localidade = getRowValue(row, "localidade"), empresa = getRowValue(row, "empresa");
        string tipo = getRowValue(row, "tipo"), tipo_en = getRowValue(row, "tipo_en"), tipo_fr = getRowValue(row, "tipo_fr"), tipo_es = getRowValue(row, "tipo_es");
        string xml = string.Empty;

        xml = string.Format(@"  <PORTFOLIO>
                                    <ID>{0}</ID>
                                    <TEXTO>{1}</TEXTO>
                                    <TEXTO_EN>{2}</TEXTO_EN>
                                    <TEXTO_FR>{3}</TEXTO_FR>
                                    <TEXTO_ES>{4}</TEXTO_ES>
                                    <ORDEM>{5}</ORDEM>
                                    <IMG>{6}</IMG>
                                    <ANO>{7}</ANO>
                                    <LOCALIDADE>{8}</LOCALIDADE>
                                    <EMPRESA>{9}</EMPRESA>
                                    <TIPO_PORTFOLIO>
                                        <TIPO>{10}</TIPO>
                                        <TIPO_EN>{11}</TIPO_EN>
                                        <TIPO_FR>{12}</TIPO_FR>
                                        <TIPO_ES>{13}</TIPO_ES>
                                    </TIPO_PORTFOLIO>
                                </PORTFOLIO>", id, texto, texto_en, texto_fr, texto_es, string.IsNullOrEmpty(ordem) || string.IsNullOrWhiteSpace(ordem) ? "0" : ordem, img,
                                string.IsNullOrEmpty(ano) || string.IsNullOrWhiteSpace(ano) ? DateTime.Now.Year.ToString() : ano, localidade, empresa, tipo, tipo_en, tipo_fr, tipo_es);

        string sql = string.Format(@"   DECLARE @idUser int = {0};
	                                    DECLARE @DocXml nvarchar(max) = N'{1}';
	                                    DECLARE @ret int;
                                        DECLARE @retMsg VARCHAR(max);

                                        EXECUTE CRIA_EDITA_PORTFOLIO @idUser, @DocXml, @ret OUTPUT, @retMsg OUTPUT
                                        SELECT @ret ret, @retMsg retMsg ", userID, xml);

        DataSet oDs = GetDataSet(sql, "").oData;

        if (validaDataSet(oDs))
        {
            if (Convert.ToInt32(oDs.Tables[0].Rows[0]["ret"].ToString().Trim()) > 0)
            {
                return true;
            }

            return false;
        }

        return false;
    }

    public string getRowValue(DataRow row, string rowName)
    {
        try
        {
            return row[rowName].ToString();
        }
        catch
        {
            return "";
        }
    }

    public bool insertCSVFileIntoDB(string path, string tableName, string userID)
    {
        if(path.EndsWith(".xls") || path.EndsWith(".xlsx"))
        {
            string newPath = path.EndsWith(".xlsx") ? path.Replace(".xlsx", ".csv") : path.Replace(".xls", ".csv");
            if(!SaveAsCsv(path, newPath))
            {
                return false;
            }
            path = newPath;
        }

        DataTable csvData = GetDataTableFromCSVFile(path);

        if(csvData == null)
        {
            return false;
        }

        return insertDataIntoDB(csvData, tableName, userID);
    }
}