using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConnectionStrings
{
    public class SqlManager
    {
        #region Variable(s)
        private int _connectionTimeOut = 120;       
        private SqlManager _manager;
        private SqlConnection _connection;

        private bool? HasTransaction { get; set; }
        private SqlTransaction Transaction { get; set; }

        #endregion

        public int ConnectionTimeOut
        {
            set
            {
                _connectionTimeOut = value;

            }
        }

        #region Sql Connection and Transaction
        public SqlConnection Connection
        {
            get
            {
                if (_connection == null || _connection.State != ConnectionState.Open)
                {
                    _connection = new SqlConnection(ConfigurationManager.ConnectionStrings["tempConnection"].ConnectionString);
                }

                return _connection;
            }
        }

        private void OpenConnection()
        {
            if (this.Connection != null && this.Connection.State == ConnectionState.Open)
            {
                throw new Exception("SqlManager is not handled properly.");
            }

            // string connString = ConfigurationManager.ConnectionStrings["tempConnection"].ConnectionString;
            //this.Connection = new SqlConnection(connString);
            this.Connection.Open();
        }
        private void CloseConnection()
        {
            if (this.Connection.State == ConnectionState.Open)
            {
                this.Connection.Close();
                this.Connection.Dispose();
            }
        }
        #endregion

        public int ExecuteNonQuery(string procedureName, List<SqlParameter> paramList = null)
        {
            int records = 0;
            using (SqlCommand sqlCommand = new SqlCommand())
            {
                try
                {
                    if (this.Connection == null || this.Connection.State != ConnectionState.Open) this.OpenConnection();

                    sqlCommand.Connection = this.Connection;
                    sqlCommand.CommandText = procedureName;
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.CommandTimeout = _connectionTimeOut;
                    if (this.HasTransaction.HasValue && this.HasTransaction.Value) sqlCommand.Transaction = this.Transaction;

                    foreach (SqlParameter item in paramList)
                    {
                        sqlCommand.Parameters.Add(item);
                    }

                    records = sqlCommand.ExecuteNonQuery();
                }
                catch (Exception exception)
                {
                    throw exception;
                }
                finally
                {
                    if (!this.HasTransaction.HasValue || (this.HasTransaction.HasValue && !this.HasTransaction.Value))
                        if (this.Connection != null && this.Connection.State == ConnectionState.Open) this.CloseConnection();
                }
            }
            return records;
        }

        public DataTable FillDataTable(string procedureName, List<SqlParameter> paramList = null)
        {
            DataTable dtResult = null;
            SqlDataAdapter dbAdapter = null;

            using (SqlCommand sqlCommand = new SqlCommand())
            {
                try
                {
                    if (this.Connection == null || this.Connection.State != ConnectionState.Open) this.OpenConnection();

                    sqlCommand.Connection = this.Connection;
                    sqlCommand.CommandText = procedureName;
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.CommandTimeout = _connectionTimeOut;

                    if (this.HasTransaction.HasValue && this.HasTransaction.Value) sqlCommand.Transaction = this.Transaction;


                    foreach (SqlParameter item in paramList)
                    {
                        sqlCommand.Parameters.Add(item);
                    }
                    dbAdapter = new SqlDataAdapter(sqlCommand);
                    dtResult = new DataTable(procedureName);

                    dbAdapter.Fill(dtResult);
                }
                catch (Exception exception)
                {
                    throw exception;
                }
                finally
                {
                    if (!this.HasTransaction.HasValue || (this.HasTransaction.HasValue && !this.HasTransaction.Value))
                        if (this.Connection != null && this.Connection.State == ConnectionState.Open) this.CloseConnection();

                    dbAdapter.Dispose();
                }
            }
            return dtResult;
        }
    }
}
