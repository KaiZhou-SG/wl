<%--//===============
// Modified by feipern - 090315
// Phase 2 - Service Rate
//===============--%>

<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true"
    CodeFile="ServiceRate.aspx.cs" Inherits="Setup_ServiceRate" Theme="Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript" src="../Script/datepicker.js"></script>
    <script src="ServiceRate.js" type="text/javascript"></script>
    <script src="../Script/jquery.metadata.js" type="text/javascript"></script>
    <script src="../Script/Utility.js" type="text/javascript"></script>
    

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="container">
        <div class="contentContainer_new">
            <h1>Payment Rate</h1>
            <div class="leftContentContainer190" style="width:190px">
            <div class="Right_Favourite_Header" style="width:167px">Services</div>
                <div class="greyBarNew">
                    <a href="JavaScript:CreateEmptyService();">
                        <img src="../App_Themes/Default/images/add.png" width="16" height="16" alt="Add new Service Rate" />
                        Add</a> | 
                    <a href="JavaScript:DeleteService()">
                        <img src="../App_Themes/Default/images/delete.png" width="16" height="16" alt="Delete Service Rate" />
                        Delete</a>
                </div>
                <div id="divServiceList"  class="listLinks">
                </div>
            </div>
            <!-- left container end -->
             <div class="rightContentContainer760" style="width:780px">
               <div class="Right_Favourite_Header" style="width:757px">Details</div>
               <div class="greyBarNew" style="text-align: right; top: 0px; left: 0px; width: 757px;">
                   <a href="JavaScript:UpdateService();">
                            <span id="spanAddUpdate" class="button_grey" style="padding-left:10px;padding-right:10px">
                            Add</span>
                   </a>
                </div>
                <div id="divServiceDetail" class="whiteContainer">
                     <table cellpadding="0" style="width:100%">
                    <tr>
                        <td valign="top" style="width:68%">
                            <table border="0" cellpadding="6" class="textField50px" style="width:100%">
                    <tr><td colspan="3">The Rate below is used to pay service rendered by contract or relief staff performing the service</td></tr>
                    <%--Start - Phase 2--%>
                    <%--<tr><td>ServiceGroup:</td>--%>
                    <tr><td>Status:</td>
                        <%--<td><div id="divServiceGroup"></div></td>--%>
                       
                            <td><div id="divServiceStatus"></div></td>
                    <%--End - Phase 2--%>
                            </tr>
                           <tr>
                                    <td>Service Name:</td>
                                    <td><input id="txtName" name="txtName" class="required textField250px" type="text" /></td>
                                </tr>
                                <tr>
                                    <td>Description:</td>
                                    <td ><textarea  rows="5" id="txtDesc" name="txtDesc" class="required textArea200px"></textarea></td>
                                </tr>
                                <%--<tr>
                                    <td>Apply Subsidy:</td>
                                    <td >
                                        <input id="chkApplySubsidy" name="chkApplySubsidy" type="checkbox" /></td>
                                </tr>--%>
                                 <tr>
                                    <td>Basic Care Service:</td>
                                    <td >
                                        <input id="chkBasicCareService" name="chkBasicCareService" type="checkbox" onclick="chkBasicCareService_onchange();"/></td>
                                </tr>
                               <tr>
                                    <td>Bill Item:</td>
                                    <td >
                                        <select name="sltBillItem" id="sltBillItem" class="list200px">
                    </select></td>
                                </tr>
                                <tr>
                                    <td colspan="2"><hr /></td>
                                </tr>
                           <tr valign="top">
                                    <td><div class="greyBar">
                                                                Used From List</div>
                                    <div id="divUsedFrom" class="listLinks"></div>
                                    </td>
                                    <td valign="top">
                                        <table cellpadding="5" cellspacing="0" width="100%">
                                            <tr>
                                                <td>
                                                    Used From:</td>
                                                <td>
                                                    <input id="txtUsedFrom" name="txtUsedFrom" size="8" class="required FullDate txtUsedFrom" type="text" /></td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <input checked="checked" name="rdo" id="rdofree" value="" type="radio" onclick="rdobasic_onclick();"/> Free</td>
                                                <td>
                                                    &nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <input  name="rdo" id="rdoonetime" type="radio" onclick="rdobasic_onclick();"/> One Time Rate: $</td>
                                                <td><input id="txtOneTimeRate" class="number textField50px"  type="text" /></td></td>
                                            </tr>
                                             <tr>
                                                <td>
                                                    <input  name="rdo" id="rdoHourRate" type="radio" onclick="rdobasic_onclick();"/> Hourly Rate</td>
                                                <td>
                                                    &nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    Weekday: $</td>
                                                <td>
                                                    <input id="txtWeekdayOneHourRate" class="number textField50px"  type="text" /></td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    Weekend: $</td>
                                                <td>
                                                    <input id="txtWeekendOneHourRate" class="number textField50px" type="text" /></td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <input  name="rdo" id="rdobasic" type="radio" onclick="rdobasic_onclick();"/> Basic Care Rate</td>
                                                <td>
                                                    &nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <a href='#' onclick="javascript:ShowPopup();">Change</a></td>
                                                            <td>
                                                                &nbsp;</td>
                                                        </tr>
                                                    </table>
 
                                        </td>
                            
                            </tr>
                                    </table>
                                    </td>
                            </tr>
                               
                           <tr valign="top">
                                    <td>&nbsp;</td>
                                    <td valign="top">&nbsp;</td>
                            </tr>
                             <tr>
                                    <td><div id="divUsedFromList" class="listLinks"></div></td>
                                    <td>&nbsp;</td>
                             </tr>
                               
                             <tr>
                                    <td colspan="2"><input type="hidden" id="txtServiceId" />
                                    <input type="hidden" id="txtServiceRateId" />
                                    <input type="hidden" id="txtCreatedDate" /> <input type="hidden" id="txtCreatedBy" />
                                    <input type="hidden" id="txtRateCreatedDate" /> <input type="hidden" id="txtRateCreatedBy" />
                                    </td>
                             </tr>
                               </table>
                      
                    
                </div>
            </div>
            
        </div>
        

    </div>
    
        <div id="popUpDiv" name="popUpDiv" class="popUpDivServiceRate" style="display: none;">
            <table cellpadding="5" cellspacing="0" class="textField50px" style="width:100%;border-left:1px solid #d3d2d4;border-right:1px solid #d3d2d4;border-bottom:1px solid #d3d2d4;">
                                <%--<tr>    
                                    <td colspan="3">
                                        Charge in 
                                        <select id="ddlBaseRateChargeBlock" name="ddlBaseRateChargeBlock">
                                            <option value="15">15 Mins</option>
                                            <option value="30">30 Mins</option>
                                        </select>
                                        block (round up to nearest)
                                    </td>
                                </tr>--%>
                                <tr style="background-color: #99CDFF">
                                    <td><b>24 Hrs</b></td>
                                    <td><b>Weekday</b></td>
                                    <td><b>Weekend/Holiday</b></td>                           
                                </tr>
                                <tr>
                                    <td>00:00</td>
                                    <td>$&nbsp;<input id="txtW0" class="textField50px " type="text" value="0" /></td>
                                    <td><input id="txtH0" class="textField50px " type="text" value="0" /></td>
                                </tr>
                                <tr>
                                    <td>01:00</td>
                                    <td>$&nbsp;<input id="txtW1" class="textField50px " type="text" value="0"  /></td>
                                    <td><input id="txtH1" class="textField50px " type="text" value="0"  /></td>
                                </tr>
                                <tr>
                                    <td>02:00</td>
                                    <td>$&nbsp;<input id="txtW2" class="textField50px " type="text" value="0"  /></td>
                                    <td><input id="txtH2" class="textField50px " type="text"  value="0" /></td>
                                </tr>
                                <tr>
                                    <td>03:00</td>
                                    <td>$&nbsp;<input id="txtW3" class="textField50px " type="text"  value="0" /></td>
                                    <td><input id="txtH3" class="textField50px " type="text"  value="0" /></td>
                                </tr>
                                <tr>
                                    <td>04:00</td>
                                    <td>$&nbsp;<input id="txtW4" class="textField50px " type="text"  value="0" /></td>
                                    <td><input id="txtH4" class="textField50px " type="text"  value="0" /></td>
                                </tr>
                                <tr>
                                    <td>05:00</td>
                                    <td>$&nbsp;<input id="txtW5" class="textField50px " type="text"  value="0" /></td>
                                    <td><input id="txtH5" class="textField50px " type="text"  value="0" /></td>
                                </tr>
                                <tr>
                                    <td>06:00</td>
                                    <td>$&nbsp;<input id="txtW6" class="textField50px " type="text"  value="0" /></td>
                                    <td><input id="txtH6" class="textField50px " type="text"  value="0" /></td>
                                </tr>
                                <tr>
                                    <td>07:00</td>
                                    <td>$&nbsp;<input id="txtW7" class="textField50px " type="text"  value="0" /></td>
                                    <td><input id="txtH7" class="textField50px " type="text"  value="0" /></td>
                                </tr>
                                <tr>
                                    <td>08:00</td>
                                    <td>$&nbsp;<input id="txtW8" class="textField50px " type="text"  value="0" /></td>
                                    <td><input id="txtH8" class="textField50px " type="text"  value="0" /></td>
                                </tr>
                                <tr>
                                    <td>09:00</td>
                                    <td>$&nbsp;<input id="txtW9" class="textField50px " type="text"  value="0" /></td>
                                    <td><input id="txtH9" class="textField50px " type="text"  value="0" /></td>
                                </tr>
                                <tr>
                                    <td>10:00</td>
                                    <td>$&nbsp;<input id="txtW10" class="textField50px" type="text"  value="0" /></td>
                                    <td><input id="txtH10" class="textField50px " type="text"  value="0" /></td>
                                </tr>
                                <tr>
                                    <td>11:00</td>
                                    <td>$&nbsp;<input id="txtW11" class="textField50px " type="text"  value="0" /></td>
                                    <td><input id="txtH11" class="textField50px " type="text"  value="0" /></td>
                                </tr>
                                <tr>
                                    <td>12:00</td>
                                    <td>$&nbsp;<input id="txtW12" class="textField50px " type="text"  value="0" /></td>
                                    <td><input id="txtH12" class="textField50px " type="text"  value="0" /></td>
                                </tr>
                                <tr>
                                    <td>13:00</td>
                                    <td>$&nbsp;<input id="txtW13" class="textField50px " type="text"  value="0" /></td>
                                    <td><input id="txtH13" class="textField50px " type="text"  value="0" /></td>
                                </tr>
                                <tr>
                                    <td>14:00</td>
                                    <td>$&nbsp;<input id="txtW14" class="textField50px " type="text" value="0"  /></td>
                                    <td><input id="txtH14" class="textField50px " type="text"  value="0" /></td>
                                </tr>
                                <tr>
                                    <td>15:00</td>
                                    <td>$&nbsp;<input id="txtW15" class="textField50px " type="text"  value="0" /></td>
                                    <td><input id="txtH15" class="textField50px " type="text"  value="0" /></td>
                                </tr>
                                <tr>
                                    <td>16:00</td>
                                    <td>$&nbsp;<input id="txtW16" class="textField50px " type="text"  value="0" /></td>
                                    <td><input id="txtH16" class="textField50px " type="text"  value="0" /></td>
                                </tr>
                                <tr>
                                    <td>17:00</td>
                                    <td>$&nbsp;<input id="txtW17" class="textField50px " type="text"  value="0" /></td>
                                    <td><input id="txtH17" class="textField50px " type="text"  value="0" /></td>
                                </tr>
                                <tr>
                                    <td>18:00</td>
                                    <td>$&nbsp;<input id="txtW18" class="textField50px " type="text"  value="0" /></td>
                                    <td><input id="txtH18" class="textField50px " type="text"  value="0" /></td>
                                </tr>
                                <tr>
                                    <td>19:00</td>
                                    <td>$&nbsp;<input id="txtW19" class="textField50px " type="text"  value="0" /></td>
                                    <td><input id="txtH19" class="textField50px " type="text"  value="0" /></td>
                                </tr>
                                <tr>
                                    <td>20:00</td>
                                    <td>$&nbsp;<input id="txtW20" class="textField50px " type="text"  value="0" /></td>
                                    <td><input id="txtH20" class="textField50px " type="text"  value="0" /></td>
                                </tr>
                                <tr>
                                    <td>21:00</td>
                                    <td>$&nbsp;<input id="txtW21" class="textField50px " type="text"  value="0" /></td>
                                    <td><input id="txtH21" class="textField50px " type="text" value="0"  /></td>
                                </tr>
                                <tr>
                                    <td>22:00</td>
                                    <td>$&nbsp;<input id="txtW22" class="textField50px " type="text"  value="0" /></td>
                                    <td><input id="txtH22" class="textField50px " type="text"  value="0" /></td>
                                </tr>
                                <tr>
                                    <td>23:00</td>
                                    <td>$&nbsp;<input id="txtW23" class="textField50px " type="text"  value="0" /></td>
                                    <td><input id="txtH23" class="textField50px " type="text"  value="0" /></td>
                                </tr>
                                <tr>
                                    <td>1hr Adjustment</td>
                                    <td>%&nbsp;<input id="txtW24" class="textField50px " type="text"  value="0" /></td>
                                    <td><input id="txtH24" class="textField50px " type="text"  value="0" /></td>
                                </tr>
                                <tr>
                                    <td colspan="3" align="center">
                                        <input type="button" id="btnupdate" onclick="SaveBaseRate();" value="Update" />
                                        <input type="button" id="btnupdate" onclick="Cancel();" value="Cancel" />
                                    </td>
                                </tr>
                             </table>
        </div>
        
</asp:Content>
