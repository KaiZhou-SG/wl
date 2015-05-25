<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="DayCareFinancialReport.aspx.cs" Inherits="Reports_DayCareFinancialReport" Theme="Default" %>
<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=9.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript" src="../Script/datepicker.js"></script>    
    <script src="../Script/Utility.js" type="text/javascript"></script>
    <script src="DayCareFinancialReport.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
 <div class="container">
 <h1>Day Care Financial Report</h1>
        <div class="contentContainer_new" style="width:989px">
            <div class="leftContentContainer190">
                 <div class="Right_Favourite_Header" style="width:167px;">Financial Reports</div>
                 <div id="divReport" class="listLinks">
                <ul>
                   <li id='Item_1'><a href='#'>Day Care Financial</a></li>
                    <li id='Item_2'><a href='HomeCareFinancialReport.aspx'>Home Care Financial</a></li>
                    <li id='Item_3'><a href='EquipmentFinancialReport.aspx'>Equipment Financial</a></li>
                    <li id='Item_4'><a href='CourseFinancialReport.aspx'>Course Financial</a></li>                    
                    <li id='Item_5'><a href='OutStandingPaymentReport.aspx'>Outstanding Payment Financial</a></li>                                        
                </ul>
                </div>
            </div>
            
            <!-- left container end -->
            <div class="rightContentContainer760" style="width:770px">
                <div class="blueBarNew" id="divWithStartAndEndDate"> 
                    <table>
                        <tr>
                            <td>Start</td>
                            <td>
                                <asp:TextBox ID="txtStart" runat="server"></asp:TextBox>
                            </td>
                            <td>End</td>
                            <td>
                                <asp:TextBox ID="txtEnd" runat="server"></asp:TextBox>
                            </td>
                            <td>
                                <div class="blueBarNew">
                                  <a>
                                    <span id="btnSearch" class="button_grey"  
                                          style="padding-left:10px;padding-right:10px"
                                      onclick="Event_DisplayClick">Display
                                    </span>
                                  </a>
                                </div>
                            </td>
                            <td>
                                <asp:Label ID="lblMsg" runat="server" Text="Label"></asp:Label>
                            </td>
                        </tr>                        
                    </table>                                       
                    </div>  
                    <rsweb:ReportViewer ID="rptViewer" runat="server" Width="770px">
                </rsweb:ReportViewer>
                    <br />
            </div>                          
    </div>
    </div>
</asp:Content>
