<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" 
CodeFile="UserRole.aspx.cs" Inherits="Setup_UserRole" Theme="Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript" src="../Script/datepicker.js"></script>
    <script src="UserRole.js" type="text/javascript"></script>
    <script src="../Script/Utility.js" type="text/javascript"></script>
    <script src="../Script/jquery.metadata.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
        <div class="container">
        <div class="contentContainer_new">
            <h1>Roles</h1>
            <div class="leftContentContainer190">
                <div class="Right_Favourite_Header" style="width:166px;">Role List</div>
                <div class="greyBarNew">
                    <a href="JavaScript:CreateEmptyRole();">
                    <img src="../App_Themes/Default/images/add.png" width="16" height="16" alt="Add new Service Rate" />
                        Add
                    </a> | 
                    <a href="JavaScript:DeleteRole()">
                    <img src="../App_Themes/Default/images/delete.png" width="16" height="16" alt="Delete Service Rate" />
                      Delete
                    </a>
                </div>
                <div id="divRoleList" class="listLinks">
                </div>
            </div>
            <!-- left container end -->
            <div class="rightContentContainer760">
                <div class="Right_Favourite_Header" style="width:737px">Details</div>
                <div class="greyBarNew" style="text-align: right;">
                <table>
                <tbody>
                <tr>
                <td style="width:100%"></td>
                <td>
                <a href="JavaScript:SelectAll();">
                       <div class="button_grey" style="float:right">Select All</div> 
                    </a>
                </td>
                <td>
                <a href="JavaScript:UpdateRole();">
                        <span id="spanAddUpdate" class="button_grey" style="padding-left:10px;padding-right:10px">
                          Update
                        </span>
                    </a>
                </td>
                </tr>
                </tbody>
                </table>
                                            
                    
                </div>
                <div id="divPermissionDetail" class="whiteContainer">
                   <table border="0" cellpadding="5" style="width:100%">
                        <tr>
                            <td>
                                Role:
                            </td>
                            <td>
                                <input type="text" id="txtRole" name="txtRole"  class="required txtRole textField300px" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" align="left">
                                <div id="divPermissions" class="divCourseStatus">
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <input type="hidden" id="txtRoleID" />
                            </td>
                        </tr>
                   </table>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

