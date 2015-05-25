<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true"
    CodeFile="DayCareReport.aspx.cs" Inherits="Report_DayCareReport" Theme="Default" %>

<%@ Register Assembly="WebCon.WebGrid" Namespace="Webcon.WebGrid" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript" src="../Script/datepicker.js"></script>
    <script src="DayCareReport.js" type="text/javascript"></script>
    <script src="../Script/Utility.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
        <div class="contentContainer_new">
            <h1>DayCare Report</h1>
            <div class="leftContentContainer190">
                 <div class="Right_Favourite_Header" style="width:167px">Details</div>
                 <div id="divReport" class="listLinks">
                <ul>
                    <li id='Item_1'><a href='JavaScript:SelectReport(1);'>Client Payment Profile</a></li>
                    <li id='Item_2'><a href='JavaScript:SelectReport(2);'>Registered Clients</a></li>
                    <li id='Item_3'><a href='JavaScript:SelectReport(3);'>Total Withdrawals</a></li>
                    <li id='Item_4'><a href='JavaScript:SelectReport(4);'>Total / Accumulated Clients</a></li>
                    <%--<li id='Item_5'><a href='JavaScript:SelectReport(5);'>Volunteers Report</a></li>--%>
                    <li id='Item_6'><a href='JavaScript:SelectReport(6);'>Relief Staff Report</a></li>
                    <li id='Item_7'><a href='JavaScript:SelectReport(7);'>Rental of Equipment</a></li>
                    <li id='Item_8'><a href='JavaScript:SelectReport(8);'>Equipment Status</a></li>
                </ul>
                </div>
            </div>
            <!-- left container end -->
            <div class="rightContentContainer760" style="width:780px">
                <div class="blueBarNew" id="divWithStartAndEndDate"> 
                    <table>
                        <tr>
                            <td>Start</td>
                            <td>
                              <input type="text" name="txtStart" id="txtStart" class="textField100px" />
                            </td>
                            <td>End</td>
                            <td>
                              <input type="text" name="txtEnd" id="txtEnd" class="textField100px"/>
                            </td>
                            <td>
                              <a>
                                <span id="btnSearch" onclick="Search();" class="button_grey" style="padding-left:10px;padding-right:10px">
                                  Retrieve
                                </span>
                              </a>
                            </td>
                            <td>
                              <a>
                                <span id="btnExport" onclick="Export();" class="button_grey" style="padding-left:10px;padding-right:10px">
                                  Export 
                                </span>
                              </a>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="blueBar" id="divWithDate"> 
                    <table>
                        <tr>
                            <td>Date</td>
                            <td><input type="text" name="txtStart" id="txtDate" class="textField100px" /></td>                           
                            <td><input type="button" name="btnSearch" id="btnDateSearch" value="Retrieve" class="btnSearch" onclick="Search();" /></td>
                            <td><input type="button" name="btnExport" id="btnDateExport" value="Export" class="btnExport" onclick="Export();" /></td>
                        </tr>
                    </table>
                </div>
                <div id="GridArea" name="GridArea" style="overflow-y:hidden;overflow-x:scroll;" class="rightContent740">
                </div>
            </div>
        </div>
    </div>
</asp:Content>
