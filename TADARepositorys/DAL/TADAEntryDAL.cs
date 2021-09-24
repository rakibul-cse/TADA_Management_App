using ConnectionStrings;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Text;


namespace TADARepository.DAL
{
    public class TADAEntryDAL
    {
        internal DataTable GetLoadStatus()
        {
            try
            {
                List<SqlParameter> paramList = new List<SqlParameter>();
                paramList.Add(new SqlParameter("@executeId", 2));               
                return new SqlManager().FillDataTable("TADAEmployee_StatusLoad", paramList);
            }

            catch (Exception ex)
            {
                throw;
            }
        }        

        internal DataTable GetLoadEmployeeList()
        {
            try
            {
                List<SqlParameter> paramList = new List<SqlParameter>();
                paramList.Add(new SqlParameter("@executeId", 1));
                return new SqlManager().FillDataTable("TADAEmployee_StatusLoad", paramList);
            }

            catch (Exception ex)
            {
                throw;
            }
        }       

        internal void SaveAndUpdateTADA(int iDS, string date, int empName, decimal travelCost, decimal lunchCost, decimal instrumentsCost, int statusId)
        {
            try
            {
                var paramList = new List<SqlParameter>
                {
                    new SqlParameter("@id", iDS),
                    new SqlParameter("@date", date),
                    new SqlParameter("@empId", empName),
                    new SqlParameter("@travelCost", travelCost),
                    new SqlParameter("@LunchCost", lunchCost),
                    new SqlParameter("@InstrumentsCost", instrumentsCost),
                    new SqlParameter("@statusId", statusId)
                };
                new SqlManager().ExecuteNonQuery("TADAInsert_Update", paramList);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        internal DataTable LoadTADAList(int id, int empId)
        {
            try
            {
                List<SqlParameter> paramList = new List<SqlParameter>();
                paramList.Add(new SqlParameter("@id", id));
                paramList.Add(new SqlParameter("@empId", empId));
                return new SqlManager().FillDataTable("TADAEntryList", paramList);
            }

            catch (Exception ex)
            {
                throw;
            }
        }

    }
}
