<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="FinancialReports.aspx.cs" Inherits="Reports_FinancialReports"  Theme="Default" %>

<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=9.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript" src="../Script/datepicker.js"></script>    
    <script src="../Script/Utility.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
 <div class="container">
        <div class="contentContainer_new">
        <h1>Financial Reports</h1>
          <div class="leftContentContainer190">
             <div id="divReport" class="listLinks">
                <ul>
                    <li id='Item_1'><a href='DayCareFinancialReport.aspx'>Day Care Financial</a></li>
                    <li id='Item_2'><a href='HomeCareFinancialReport.aspx'>Home Care Financial</a></li>
                    <li id='Item_3'><a href='EquipmentFinancialReport.aspx'>Equipment Financial</a></li>
                    <li id='Item_4'><a href='CourseFinancialReport.aspx'>Course Financial</a></li>                    
                    <li id='Item_5'><a href='OutStandingPaymentReport.aspx'>Outstanding Payment Financial</a></li>                    
                </ul>
             </div>
          </div>                                      
    </div>
    </div>
</asp:Content>

