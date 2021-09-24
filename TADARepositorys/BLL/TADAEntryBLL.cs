using System;
using System.Collections.Generic;
using System.Data;
using System.Text;
using TADARepository.DAL;

namespace TADARepository.BLL
{
    public class TADAEntryBLL
    {
        public DataTable GetLoadStatus()
        {
            return new TADAEntryDAL().GetLoadStatus();
        }

        public DataTable GetLoadEmployeeList()
        {
            return new TADAEntryDAL().GetLoadEmployeeList();
        }

        public void SaveAndUpdateTADA(int iDS, string date, int empName, decimal travelCost, decimal lunchCost, decimal instrumentsCost, int statusId)
        {
            new TADAEntryDAL().SaveAndUpdateTADA(iDS, date, empName,  travelCost,  lunchCost,  instrumentsCost,  statusId);
        }

        public DataTable LoadTADAList(int id, int empId)
        {
           return new TADAEntryDAL().LoadTADAList(id, empId);
        }
    }
}
