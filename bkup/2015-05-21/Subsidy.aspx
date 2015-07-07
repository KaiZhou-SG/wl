<%--//===============
// Modified by feipern - 190315
// Phase 2 - Subsidy - Remove %, and level to show $ only
//===============--%>

<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true"
    CodeFile="Subsidy.aspx.cs" Inherits="Setup_Subsidy" Theme="Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript" src="../Script/datepicker.js"></script>
    <script src="Subsidy.js" type="text/javascript"></script>
        <script src="../Script/jquery.metadata.js" type="text/javascript"></script>
        <script src="../Script/Utility.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="masthead">
      <h1>Subsidy</h1>
        <div class="contentContainer_new">      
            <div class="leftContentContainer190">
                <div class="Right_Favourite_Header" style="width:167px">Subsidy</div>
                  <div class="blueBarNew">
                    <a href="JavaScript:CreateEmptySubsidy();">
                        <img src="../App_Themes/Default/images/add.png" width="16" height="16" alt="Add new Subsidy." />
                        Add</a> | 
                    <a href="JavaScript:DeleteSubsidy()">
                        <img src="../App_Themes/Default/images/delete.png" width="16" height="16" alt="Delete Subsidy" />
                        Delete</a>
                  </div>
                <div id="divSubsidyList" class="listLinks">
                </div>
            </div>
            <!-- left container end -->
            <div class="rightContentContainer760" style="width:780px">
                <div class="Right_Favourite_Header" style="width:757px">Details</div>
                <div class="blueBarNew" style="text-align: right; top: 0px; left: 0px; width: 730px;">
                    <a href="JavaScript:UpdateSubsidy();">
                      <span id="spanAddUpdate" class="button_grey" style="padding-left:25px;padding-right: 25px">Add</span>
                    </a>
                </div>
                <div id="divFeeDetail" class="whiteContainer">
                    <table cellpadding="0" style="width:100%">
                    <tr>
                        <td valign="top" style="width:68%">
                            <table border="0" cellpadding="6" class="textField50px" style="width:100%">
                                <%--Start - Phase 2 - Remove--%>
                                <%--<tr>
                                    <td>Service Group:</td>
                                    <td><div id="divServiceGroup" class="divServiceGroup"></div></td>            
                                </tr>--%>
                                <%--End - Phase 2 - Remove--%>
                                <tr>
                                    <td>Status:</td>
                                    <td><div id="divSubsidyStatus"  class="divSubsidyStatus"></div></td>            
                                </tr>
                                
                                <tr>
                                    <td>Subsidy Name:</td>
                                    <td colspan="2"><input name="txtName" id="txtName" class="required textField250px" type="text" /></td>
                                </tr>
                                <tr>
                                    <td>Description:</td>
                                    <td colspan="2" ><textarea name="txtDesc"  rows="5" id="txtDesc" class="textArea200px"></textarea></td>
                                </tr>
                                <tr>
                                    <td colspan="3"><hr /></td>
                                </tr>
                                
                                <tr>
                                    <td valign="top">
                                        <table style="width:100%">
                                            <tr>
                                                <td>
                                                    <div>
                                                        <div class="blueBarNew">Used From List</div>                                                                        
                                                        <div id="divUsedFrom" class="listLinks"></div>
                                                    </div>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td colspan="3" valign="top">
                                        <table style="width:100%">
                                              <tr>
                                    <td></td>
                                    <td>Used From:</td>
                                    <td><input id="txtUsedFrom" name="txtUsedFrom" size="8" style="width:100px" class="required FullDate txtUsedFrom" type="text" /></td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td>Level:</td>
                                    <td>
                                        <select onChange="selectlevel();" id="ddllevel" class="ddllevel" style="width:100px">
                                            <option value="0">-</option>
                                            <option value="1">1st Level</option>
                                            <option value="2">2nd Level</option>
                                            <option value="3" selected>Regular</option>
                                        </select>
                                    </td>
                                </tr>
                                
                                 <tr>
                                  <td></td>
                                    <td>Type:</td>
                                    <td>
                                        <select disabled="disabled" id="ddlServiceOrTransport" class="ddlServiceOrTransport" 
                                                style="width:100px" name="ddlServiceOrTransport">
                                            <option value="S">Service</option>
                                            <option value="T">Transport</option>
                                        </select>
                                    </td>
                                </tr>
                                
                                
                                
                                 <tr>
                                 <td></td>
                                    <td>Cap:</td>
                                    <td>
                                         <input disabled="disabled" id="txtCap" name="txtCap" 
                                         class="number textField50px" style="width:100px" type="text" /> 
                                    </td>
                                </tr>
                                
                                 <tr>
                                    <td></td>
                                    <td>Subsidy: </td>
                                    <td valign="top">
                                      <input  id="txtSubsidy" name="txtSubsidy" style="width:100px" 
                                        class="required  number textField50px" type="text" /> 
                                      <select id="ddltype" class="ddltype" name="ddltype">
                                        <option value='A'>$</option>
                                        <option value='P'>%</option>
                                      </select>
                                    </td>
                                </tr>
                                
                                   <tr>
                                     <td></td>
                                    <td colspan="2"><input type="hidden" id="txtSubsidyId" /><input type="hidden" id="txtSubsidyRateId" />
                                    <input type="hidden" id="txtCreatedDate" /> <input type="hidden" id="txtCreatedBy" />
                                     <input type="hidden" id="txtRateCreatedDate" /> <input type="hidden" id="txtRateCreatedBy" />
                                    </td>
                                 </tr>
                                
                               <tr>
                                 <td></td>
                                    <td></td>
                                    <td>
                                        <div style="visibility:hidden" id="divParentSubsidy" name="divParentSubsidy" class="divParentSubsidy"></div>
                                    </td>
                                </tr>
                                
                                        </table>
                                    </td>
                                </tr>
                              
                             </table>
                        </td>
                    </tr>
                   </table>
                    
                </div>
            </div>
            
        </div>
    </div>
</asp:Content>
