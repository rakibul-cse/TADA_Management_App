using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using TADARepository.BLL;

namespace TADA_App.WebService
{
    /// <summary>
    /// Summary description for TADAService
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    // [System.Web.Script.Services.ScriptService]    
    [ScriptService]
    public class TADAService : System.Web.Services.WebService
    {



                #region TADA Information Save & Update . If IDS variable Values are 0 then save and other wise update . this condition checking by SQL server SP : TADAInsert_Update . 

        [WebMethod(EnableSession = true)]
        [ScriptMethodAttribute(ResponseFormat = ResponseFormat.Json)]
        //********** 
        public string SaveTADAEntry(string IDS, string Date, int EmpName, decimal TravelCost, decimal LunchCost, decimal InstrumentsCost, int StatusId)
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("Id", typeof(int));
            dt.Columns.Add("Message", typeof(string));

            try
            {
                if (string.IsNullOrWhiteSpace(IDS))
                {
                    IDS = "0";
                }
                new TADAEntryBLL().SaveAndUpdateTADA(Convert.ToInt32(IDS), Date, EmpName, TravelCost, LunchCost, InstrumentsCost, StatusId);                
                dt.Rows.Add("1", "Recore are saved successfully.!");
                string a = DataTableToJSONWithString(dt);
                return a;
            }
            catch(Exception ex)
            {                
                dt.Rows.Add("2", ex);
                string a = DataTableToJSONWithString(dt);
                return a;
            }
        }
        #endregion

        #region --This function used on Load & find TADA Information, managed sql SP : TADAEntryList
      
        [WebMethod(EnableSession = true)]
        [ScriptMethodAttribute(ResponseFormat = ResponseFormat.Json)]
        public string LoadTADAList(int id, int empId)
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("Id", typeof(int));
            dt.Columns.Add("Message", typeof(string));

            try
            {
               DataTable dtList= new TADAEntryBLL().LoadTADAList(id,empId);               
                string a = DataTableToJSONWithString(dtList);
                return a;
            }
            catch (Exception ex)
            {                
                dt.Rows.Add("2", ex);
                string a = DataTableToJSONWithString(dt);
                return a;
            }
        }
        #endregion

        #region -- Convert Datatable to JSONWithString

        
        public string DataTableToJSONWithString(DataTable table)
        {
            string JSONString = string.Empty;
            JSONString = JsonConvert.SerializeObject(table);
            return JSONString;
        }

        #endregion
    }
}
