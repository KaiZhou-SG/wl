
<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true"
    CodeFile="UserListing.aspx.cs" Inherits="System_UserListing" Theme="Default" %>

<%@ Register Assembly="WebCon.WebGrid" Namespace="Webcon.WebGrid" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript" src="../Script/datepicker.js"></script>
    <script src="UserListing.js" type="text/javascript"></script>
    <script src="../Script/Utility.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="container">
        <div class="contentContainer_new">
            <div class="Right_Favourite_Header" style="width: 967px;">User List</div>
            <div class="contentContainer960" style="width: 989px">
                <div class="blueBarNew">
                    <table>
                        <tr>
                            <td>User Name</td>
                            <td><input type="text" id="txtUserName" class="txtUserName" size="15" /></td>
                            <td>Role</td>
                            <td><div id="divRole" class="divRole">
                            </div></td>
                            <td>Status</td>
                            <td><div id="divStatus" class="divStatus"></div></td>
                            <td> 
                              <div class="greyBarNew" style="text-align: right; top: 0px; left: 0px; width:auto;">
                                <a onclick="Search();">
                                  <span id="btnSearch" class="button_grey" style="padding-left:10px;padding-right:10px">
                                    Search
                                  </span>
                                </a>
                              </div>
                              <%--<input type="button" name="btnSearch" id="btnSearch_old" value="Search" 
                                class="button_grey" onclick="Search();" />--%>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="greyBarNew">
                    <div class="floatLeft" style="margin-top: 5px;">
                    <table>
                      <tbody>
                        <tr>
                          <td>
                            <a href="UserDetail.aspx">
                            <span id="spanAddUpdate" class="button_grey" style="padding-left:10px;padding-right:10px">
                              Add
                            </span>
                            </a>
                          </td>
                          <td>
                            <a href="javascript:ExportToExcel();">
                              <span id="span1" class="button_grey" style="padding-left:10px;padding-right:10px">
                                Export 
                              </span>
                            </a>
                          </td>
                          <td>
                            <a href="javascript:ExportAllToExcel();">
                              <span id="span2" class="button_grey" style="padding-left:10px;padding-right:10px">
                                Export All
                              </span>
                            </a>
                          </td>
                        </tr>
                      </tbody>
                    </table>
                    </div>
                </div>
                <div style="float: left;">
                    <div id="GridArea">
                        <cc1:WebGrid ID="UserList" runat="server">
                        </cc1:WebGrid>
                    </div>
                </div>               
            </div>
            <!-- left container end -->
        </div>
    </div>
</asp:Content>
