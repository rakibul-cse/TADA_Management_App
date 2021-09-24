using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TADARepository.BLL;

namespace TADA_App
{
    public partial class TADAEntry : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            #region -- Load Employee & Status on dropdownlist

            
            if (!IsPostBack)
            {
                DataTable dtLoadEmployeeList = new TADAEntryBLL().GetLoadEmployeeList();
                ddlEmployeeName.DataSource = dtLoadEmployeeList;
                ddlEmployeeName.DataTextField = "Name";
                ddlEmployeeName.DataValueField = "Id";
                ddlEmployeeName.DataBind();
                ddlEmployeeName.Items.Insert(0, new ListItem("---Select Employee---", "0"));

                DataTable dtLoadStatusList = new TADAEntryBLL().GetLoadStatus();
                ddlPaidStatus.DataSource = dtLoadStatusList;
                ddlPaidStatus.DataTextField = "Name";
                ddlPaidStatus.DataValueField = "Id";
                ddlPaidStatus.DataBind();
                ddlPaidStatus.Items.Insert(0, new ListItem("---Select Status---", "0"));

                hfId.Value = "";
            }

            #endregion
        }

        #region -- Button Click

        #region -- Export PDF,Excel,Word & Image

        
        protected void btnExport_Click(object sender, EventArgs e)
        {
            DataTable dtList = new TADAEntryBLL().LoadTADAList(0, 0);
            ReportViewer1.ProcessingMode = ProcessingMode.Local;
            ReportViewer1.LocalReport.ReportPath = Server.MapPath("Report/rptTADAList.rdlc");
            ReportViewer1.LocalReport.DataSources.Clear();
            ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("TADAReport", dtList));
            ReportViewer1.LocalReport.Refresh();
            Export(sender, e);

        }

        #endregion
        protected void Export(object sender, EventArgs e)
        {
            Microsoft.Reporting.WebForms.Warning[] warnings;
            string[] streamIds;
            string contentType;
            string encoding;
            string extension;

            //Export the RDLC Report to Byte Array.
            byte[] bytes = ReportViewer1.LocalReport.Render(rbFormat.SelectedItem.Value, null, out contentType, out encoding, out extension, out streamIds, out warnings);

            //Download the RDLC Report in Word, Excel, PDF and Image formats.
            Response.Clear();
            Response.Buffer = true;
            Response.Charset = "";
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.ContentType = contentType;
            Response.AppendHeader("Content-Disposition", "attachment; filename=RDLC." + extension);
            Response.BinaryWrite(bytes);
            Response.Flush();
            Response.End();
        }

        #endregion
    }
}