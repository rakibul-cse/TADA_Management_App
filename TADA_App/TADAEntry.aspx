<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TADAEntry.aspx.cs" Inherits="TADA_App.TADAEntry" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=15.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <link rel='stylesheet' href='https://fonts.googleapis.com/css?family=Raleway' />
    <link rel='stylesheet' href='https://fonts.googleapis.com/icon?family=Material+Icons' />
    <link href="Content/toastr.min.css" rel="stylesheet" />

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="Scripts/bootstrap.min.js"></script>
    <script src="Scripts/toastr.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.15.1/moment.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.7.14/js/bootstrap-datetimepicker.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.7.14/css/bootstrap-datetimepicker.min.css">



    <script type="text/javascript">
        $(function () {
            //$('#datetimepicker1').datetimepicker();

            $('#datetimepicker1').datetimepicker({
                format: 'DD-MMM-YYYY',
                defaultDate: moment()
            });
        });

        function isNumber(evt) {
            evt = (evt) ? evt : window.event;
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            if (charCode != 46 && charCode > 31
                && (charCode < 48 || charCode > 57)) {
                return false;
            }
            return true;
        }

    </script>
    <style type="text/css">
        .text-align-right {
            text-align: right;
        }

        .text-align-left {
            text-align: left;
        }

        .text-align-center {
            text-align: center;
        }

        .auto-style1 {
            width: 100%;
        }
    </style>
    <div class="row">
        <div class="col-md-12">
            <div class="col-md-3"></div>
            <div class="col-md-6" style="margin-top: 57px;">                
                <fieldset>
                    <legend><b>TADA ENTRY </b></legend>
                    <div class="col-md-12 form-group">
                        <div class="col-md-4">Date</div>
                        <div class="col-md-1">:</div>
                        <div class="col-md-6">
                            <div class='input-group date' id='datetimepicker1'>
                                <input type='text' id="txtDate" class="form-control" />
                                <span class="input-group-addon">
                                    <span class="glyphicon glyphicon-calendar"></span>
                                </span>
                            </div>
                        </div>
                        <div class="col-md-1"></div>
                    </div>
                    <div class="col-md-12 form-group">
                        <div class="col-md-4">Employee Name</div>
                        <div class="col-md-1">:</div>
                        <div class="col-md-6">
                            <asp:DropDownList ID="ddlEmployeeName" CssClass="form-control" runat="server"></asp:DropDownList>
                        </div>
                        <div class="col-md-1"></div>
                    </div>
                    <div class="col-md-12 form-group">
                        <div class="col-md-4">Travel cost</div>
                        <div class="col-md-1">:</div>
                        <div class="col-md-6">
                            <asp:TextBox ID="txtTravelCost" placeHolder="0.00" onkeypress="return isNumber(event)" runat="server" CssClass="form-control text-align-right"></asp:TextBox>
                        </div>
                        <div class="col-md-1"></div>
                    </div>
                    <div class="col-md-12 form-group">
                        <div class="col-md-4">Lunch cost</div>
                        <div class="col-md-1">:</div>
                        <div class="col-md-6">
                            <asp:TextBox ID="txtLunchCost" placeHolder="0.00" onkeypress="return isNumber(event)" runat="server" CssClass="form-control text-align-right"></asp:TextBox>
                        </div>
                        <div class="col-md-1"></div>
                    </div>
                    <div class="col-md-12 form-group">
                        <div class="col-md-4">Instruments cost</div>
                        <div class="col-md-1">:</div>
                        <div class="col-md-6">
                            <asp:TextBox ID="txtInstrumentsCost" placeHolder="0.00" onkeypress="return isNumber(event)" runat="server" CssClass="form-control text-align-right"></asp:TextBox>
                        </div>
                        <div class="col-md-1"></div>
                    </div>
                    <div class="col-md-12 form-group">
                        <div class="col-md-4">Paid</div>
                        <div class="col-md-1">:</div>
                        <div class="col-md-6">
                            <asp:DropDownList ID="ddlPaidStatus" CssClass="form-control" runat="server"></asp:DropDownList>
                        </div>
                        <div class="col-md-1"></div>
                    </div>
                </fieldset>
                <div class="col-md-12 form-group">

                    <div class="col-md-12 text-align-right">
                        <br />
                        <asp:Button ID="btnExport" class="btn btn-info" runat="server" OnClick="btnExport_Click" Style="margin-bottom: 3px; margin-left: 4px; margin-right: 40px; font-weight: bold;" Text="Export" />
                        <button type="button" class="btn btn-primary" id="btnClear" name="btnClear" style="margin-bottom: 3px; margin-left: 4px; font-weight: bold;"><i class="fa fa-stop-circle"></i>&nbsp;Clear</button>
                        <button type="button" class="btn btn-success" id="btnSubmit" name="btnSubmit" style="margin-bottom: 3px; margin-left: 4px; margin-right: 40px; font-weight: bold;"><i class="fa fa-stop-circle"></i>&nbsp;Submit</button>
                        <br />
                        <asp:RadioButtonList ID="rbFormat" runat="server" RepeatDirection="Horizontal" BorderStyle="Solid">
                            <asp:ListItem Text="Word" Value="WORD" Selected="True" />
                            <asp:ListItem Text="Excel" Value="EXCEL" />
                            <asp:ListItem Text="PDF" Value="PDF" Selected="True" />
                            <asp:ListItem Text="Image" Value="IMAGE" />
                        </asp:RadioButtonList>
                    </div>

                </div>

            </div>
            <div class="col-md-3"></div>

            <div class="col-md-12 form-group">
                <div><b>TADA HISTORY</b></div>
                <div id="TADAContainer">
                </div>
            </div>
            <div class="col-md-12 form-group">
                <rsweb:ReportViewer ID="ReportViewer1" runat="server"></rsweb:ReportViewer>
            </div>
            <asp:HiddenField ID="hfId" runat="server" />
        </div>
    </div>

    <script type="text/javascript">

        $(document).ready(function () {
            fnLoadTADAList(0, 0);
        });


        $("#btnClear").click(function () {
            fnClearAll();
            fnLoadTADAList(0, 0);
        });

        //--- Submit Button Click --//

        $("#btnSubmit").click(function () {

            debugger;

            if ($("#MainContent_ddlEmployeeName option:selected").val() == 0) {
                toastr["warning"]("Select Employee.!");
                return;
            }
            if (document.getElementById("MainContent_txtTravelCost").value == "") {
                toastr["warning"]("Input Travel Cost.!");
                return;
            }
            if (document.getElementById("MainContent_txtLunchCost").value == "") {
                toastr["warning"]("Input Lunch Cost.!");
                return;
            }
            if (document.getElementById("MainContent_txtInstrumentsCost").value == "") {
                toastr["warning"]("Input Instruments Cost.!");
                return;
            }
            if ($("#MainContent_ddlPaidStatus option:selected").val() == 0) {
                toastr["warning"]("Select Status.!");
                return;
            }

            var obj =
            {

                "IDS": document.getElementById("MainContent_hfId").value,
                "Date": document.getElementById("txtDate").value,
                "EmpName": $("#MainContent_ddlEmployeeName option:selected").val(),
                "TravelCost": document.getElementById("MainContent_txtTravelCost").value,
                "LunchCost": document.getElementById("MainContent_txtLunchCost").value,
                "InstrumentsCost": document.getElementById("MainContent_txtInstrumentsCost").value,
                "StatusId": $("#MainContent_ddlPaidStatus option:selected").val()

            };
            debugger
            $.ajax({
                async: false,
                type: "POST",
                url: "WebService/TADAService.asmx/SaveTADAEntry",
                data: JSON.stringify(obj),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (CData) {
                    debugger
                    var dt = JSON.parse(CData.d);
                    if (dt[0].Id > 0) {
                        toastr["success"](dt[0].Message);
                        fnClearAll();
                        fnLoadTADAList(0, 0);
                    }

                },
                failure: function (response) {
                    alert(response.d);
                },
                error: function (response) {
                    alert(response.d);
                }
            });

        });

        //-- Clear all 
        function fnClearAll() {

            debugger;
            document.getElementById("MainContent_hfId").value = "";
            document.getElementById("MainContent_txtTravelCost").value = "";
            document.getElementById("MainContent_txtLunchCost").value = "";
            document.getElementById("MainContent_txtInstrumentsCost").value = "";
            $('#datetimepicker1').datetimepicker({
                format: 'DD-MMM-YYYY',
                defaultDate: moment()
            });

            var emp = document.getElementById("MainContent_ddlEmployeeName");
            emp.value = "0";
            emp.text = "---Select Employee---";

            var status = document.getElementById("MainContent_ddlPaidStatus");
            status.value = "0";
            status.text = "---Select Status---";


            document.getElementById("txtDate").focus();

        }

        //-- Load TADA List
        function fnLoadTADAList(id, empId) {

            debugger;
            $("#TADAContainer").empty();
            var html = '';
            html += '<table class="table table-bordered" style ="width:100%" > ';
            html += '<thead>';
            html += '<tr style="font-weight:bold">';
            html += '<th></th>';
            html += '<th>Date</th>';
            html += '<th>Name</th>';
            html += '<th>Travel cost</th>';
            html += '<th>Lunch cost</th>';
            html += '<th>Instruments cost</th>';
            html += '<th>Total cost</th>';
            html += '<th>Status</th>';
            html += '</tr>';
            html += '</thead>';

            var obj =
            {
                "id": id,
                "empId": empId
            };
            debugger
            $.ajax({
                async: false,
                type: "POST",
                url: "WebService/TADAService.asmx/LoadTADAList",
                data: JSON.stringify(obj),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (CData) {
                    debugger
                    var dt = JSON.parse(CData.d);
                    html += '<tbody>';
                    if (dt.length > 0) {
                        for (var i = 0; i < dt.length; i++) {
                            html += '<tr>';
                            html += '<td style="text-align:center;cursor: pointer;"><label onclick="fnTADASpecificDataList(' + dt[i].Id + ')">Select</label></td>'; //
                            html += '<td>' + dt[i].Date + '</td>';
                            html += '<td>' + dt[i].Name + '</td>';
                            html += '<td style="text-align:right">' + dt[i].TravelCost + '</td>';
                            html += '<td style="text-align:right">' + dt[i].LunchCost + '</td>';
                            html += '<td style="text-align:right">' + dt[i].InstrumentCost + '</td>';
                            html += '<td style="text-align:right">' + dt[i].TotalCost + '</td>';
                            if (dt[i].PaidStatusId == 1) {
                                html += '<td style="text-align:center;background-color: green;color: white;">' + dt[i].PaidStatus + '</td>';
                            }
                            else {
                                html += '<td style="text-align:center;background-color: red;color: white;">' + dt[i].PaidStatus + '</td>';
                            }
                            html += '</tr>';
                        }
                        html += '</tbody>';
                        html += '</table>';
                        $("#TADAContainer").append(html);
                    }

                },
                failure: function (response) {
                    alert(response.d);
                },
                error: function (response) {
                    alert(response.d);
                }
            });


        }


        //-- Find Specfic TADA Data & Assing textBox.
        function fnTADASpecificDataList(id) {

            debugger
            var obj =
            {
                "id": id,
                "empId": 0
            };

            $.ajax({
                async: false,
                type: "POST",
                url: "WebService/TADAService.asmx/LoadTADAList",
                data: JSON.stringify(obj),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (CData) {
                    debugger
                    var dt = JSON.parse(CData.d);
                    if (dt.length > 0) {

                        document.getElementById("MainContent_hfId").value = dt[0].Id;
                        document.getElementById("txtDate").value = dt[0].Date;
                        document.getElementById("MainContent_txtTravelCost").value = dt[0].TravelCost;
                        document.getElementById("MainContent_txtLunchCost").value = dt[0].LunchCost;
                        document.getElementById("MainContent_txtInstrumentsCost").value = dt[0].InstrumentCost;

                        var emp = document.getElementById("MainContent_ddlEmployeeName");
                        emp.value = dt[0].EmployeeId;
                        emp.text = dt[0].Name;

                        var status = document.getElementById("MainContent_ddlPaidStatus");
                        status.value = dt[0].PaidStatusId;
                        status.text = dt[0].PaidStatus;
                    }

                },
                failure: function (response) {
                    alert(response.d);
                },
                error: function (response) {
                    alert(response.d);
                }
            });
        }
    </script>
</asp:Content>
