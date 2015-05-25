using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using NTUCEldercare.Services;
using NTUCEldercare.DataAccess;
using System.Web;
using NTUCEldercare.Utility;

namespace NTUCEldercare.UiServices
{
    public class RolePermissionUiService
    {
        public static string LoadRoleList()
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("<ul>");
            List<Role> list = RoleService.GetRoleList("it.IsDeleted=false"); //load only undeleted records
            foreach (Role r in list)
            {
                sb.AppendFormat("<li id='RoleListItem_{0}'><a href='JavaScript:SelectRole({0});'><input id='RoleListItem_Checkbox_{0}' type='checkbox' value='{0}' /> {1}</a></li>", r.ID, r.Name);
            }
            sb.Append("</ul>");
            return sb.ToString();

        }


        public static string LoadRolePermission(Int64 RoleID)
        {
            StringBuilder sb = new StringBuilder();
            StringBuilder sbPId = new StringBuilder();
            StringBuilder sbPCatId = new StringBuilder();
            sb.Append("<table id='user_role' cellpadding='5' cellspacing='0' style='width:100%;border=1px solid #d3d2d4'>");
            // sb.Append("<tr style='background-color: #4075B0'>");
            sb.Append("<tr class='blueRowNew'>");
            sb.Append("<td style='width:250px' class='fontWhite12px'>Permission</td>");
            sb.Append("<td style='width:80px' class='fontWhite12px' align='center'>Create</td>");
            sb.Append("<td style='width:80px' class='fontWhite12px' align='center'>Read</td>");
            sb.Append("<td style='width:80px' class='fontWhite12px' align='center'>Update</td>");
            sb.Append("<td style='width:80px' class='fontWhite12px' align='center'>Delete</td>");
            sb.Append("<td style='width:80px' class='fontWhite12px' align='center'>Verification</td>");
            sb.Append("<td style='width:80px' class='fontWhite12px' align='center'>Approval</td>");
            sb.Append("</tr>");

            //Retrieve the Permission category
            List<PermissionCategory> lstPerCat = RolePermissionService.GetPermissionCategory();
            List<Role_Permission> lstRolePerCat = new List<Role_Permission>();
            foreach (PermissionCategory pc in lstPerCat)
            {
                // sb.Append("<tr style='background-color: #E6DFEC'>");
                sb.Append("<tr class='blueRowNew'>");
                sb.Append("<td colspan='5' class='fontBlack12px'>" + pc.Name + "</td>");

                string disbale = pc.Approval.Value ? "" : "disabled='disabled'";
                lstRolePerCat = RolePermissionService.IsPermissionCatChecked(RoleID, pc.ID);
                if (lstRolePerCat != null)
                {
                    if (lstRolePerCat.Count > 0)
                    {
                        if (lstRolePerCat.FirstOrDefault().Verification)
                            sb.Append("<td align='center'><input type='checkbox' " + disbale + " checked id='cV" + pc.ID + "' value='rPCatV" + pc.ID + "'></input>");
                        else
                            sb.Append("<td align='center'><input type='checkbox' " + disbale + " id='cV" + pc.ID + "' value='rPCatV" + pc.ID + "'></input>");

                        if (lstRolePerCat.FirstOrDefault().Approval)
                            sb.Append("<td align='center'><input type='checkbox' " + disbale + " checked id='cA" + pc.ID + "' value='rPCatA" + pc.ID + "'></input>");
                        else
                            sb.Append("<td align='center'><input type='checkbox' " + disbale + " id='cA" + pc.ID + "' value='rPCatA" + pc.ID + "'></input>");
                    }
                    else
                    {
                        sb.Append("<td align='center'><input type='checkbox' " + disbale + " id='cV" + pc.ID + "' value='rPCatV" + pc.ID + "'></input>");
                        sb.Append("<td align='center'><input type='checkbox' " + disbale + " id='cA" + pc.ID + "' value='rPCatA" + pc.ID + "'></input>");
                    }
                }
                else
                {
                    sb.Append("<td align='center'><input type='checkbox' " + disbale + " id='cV" + pc.ID + "' value='rPCatV" + pc.ID + "'></input>");
                    sb.Append("<td align='center'><input type='checkbox' " + disbale + " id='cA" + pc.ID + "' value='rPCatA" + pc.ID + "'></input>");
                }

                sb.Append("</tr>");
                //Retrieve the Permissions Based on category
                List<Permission> list = RolePermissionService.GetPermissionByCategory("it.ParentId=" + pc.ID.ToString()); //load only undeleted records
                List<Role_Permission> lstRolePer = new List<Role_Permission>();
                foreach (Permission c in list)
                {
                    lstRolePer = RolePermissionService.IsPermissionChecked(RoleID, c.ID);
                    sb.Append("<tr>");
                    sb.Append("<td>" + c.Name + "</td>");
                    if (lstRolePer.Count > 0)
                    {
                        if (lstRolePer.FirstOrDefault().AllowCreate)
                            sb.Append("<td align='center'><input type='checkbox' checked id='cC" + c.ID + "' value='rPerC" + c.ID + "'></input>");
                        else
                            sb.Append("<td align='center'><input type='checkbox' id='cC" + c.ID + "' value='rPerC" + c.ID + "'></input>");

                        if (lstRolePer.FirstOrDefault().AllowRead)
                            sb.Append("<td align='center'><input type='checkbox' checked id='cR" + c.ID + "' value='rPerR" + c.ID + "'></input>");
                        else
                            sb.Append("<td align='center'><input type='checkbox' id='cR" + c.ID + "' value='rPerR" + c.ID + "'></input>");

                        if (lstRolePer.FirstOrDefault().AllowUpdate)
                            sb.Append("<td align='center'><input type='checkbox' checked id='cU" + c.ID + "' value='rPerU" + c.ID + "'></input>");
                        else
                            sb.Append("<td align='center'><input type='checkbox' id='cU" + c.ID + "' value='rPerU" + c.ID + "'></input>");

                        if (lstRolePer.FirstOrDefault().AllowDelete)
                            sb.Append("<td align='center'><input type='checkbox' checked id='cD" + c.ID + "' value='rPerD" + c.ID + "'></input>");
                        else
                            sb.Append("<td align='center'><input type='checkbox' id='cD" + c.ID + "' value='rPerD" + c.ID + "'></input>");
                    }
                    else
                    {
                        sb.Append("<td align='center'><input type='checkbox' id='cC" + c.ID + "' value='rPerC" + c.ID + "'></input>");
                        sb.Append("<td align='center'><input type='checkbox' id='cR" + c.ID + "' value='rPerR" + c.ID + "'></input>");
                        sb.Append("<td align='center'><input type='checkbox' id='cU" + c.ID + "' value='rPerU" + c.ID + "'></input>");
                        sb.Append("<td align='center'><input type='checkbox' id='cD" + c.ID + "' value='rPerD" + c.ID + "'></input>");
                    }

                    sb.Append("<td><input type='hidden' id='txtPermCat" + c.ID + "' value='" + pc.ID.ToString() + "'></td>");
                    sb.Append("<td>&nbsp;</td>");
                    sb.Append("</tr>");

                    sbPId.Append(c.ID.ToString() + ",");
                }
                sbPCatId.Append(pc.ID.ToString() + ",");
            }
            string strPIds = sbPId.ToString();
            string strPCatIds = sbPCatId.ToString();
            strPIds = strPIds.Substring(0, strPIds.Length - 1);
            strPCatIds = strPCatIds.Substring(0, strPCatIds.Length - 1);
            sb.Append("<tr>");
            sb.Append("<td colspan='7'><input type='hidden' id='txtPermissionIds' value='" + strPIds + "'><input type='hidden' id='txtPermCatIds' value='" + strPCatIds + "'></td>");
            sb.Append("</tr>");
            sb.Append("</table>");

            return sb.ToString();

        }

        ////public static string LoadRolePermission(Int64 RoleID)
        ////{
        ////    try
        ////    {
        ////        StringBuilder sb = new StringBuilder();
        ////        StringBuilder sbPId = new StringBuilder();
        ////        StringBuilder sbPCatId = new StringBuilder();
        ////        sb.Append("<table id='user_role' cellpadding='5' cellspacing='0' style='width:100%;border=1px solid #d3d2d4'>");
        ////        sb.Append("<tr style='background-color: #4075B0'>");
        ////        sb.Append("<td style='width:250px' class='fontWhite12px'>Permission</td>");
        ////        sb.Append("<td style='width:80px' class='fontWhite12px'>Create</td>");
        ////        sb.Append("<td style='width:80px' class='fontWhite12px'>Read</td>");
        ////        sb.Append("<td style='width:80px' class='fontWhite12px'>Update</td>");
        ////        sb.Append("<td style='width:80px' class='fontWhite12px'>Delete</td>");
        ////        sb.Append("<td style='width:80px' class='fontWhite12px'>Verification</td>");
        ////        sb.Append("<td style='width:80px' class='fontWhite12px'>Approval</td>");
        ////        sb.Append("</tr>");

        ////        //Retrieve the Permission category
        ////        List<PermissionCategory> lstPerCat = RolePermissionService.GetPermissionCategory();
        ////        List<Role_Permission> lstRolePerCat = new List<Role_Permission>();
        ////        foreach (PermissionCategory pc in lstPerCat)
        ////        {
        ////            lstRolePerCat = RolePermissionService.IsPermissionCatChecked(RoleID, pc.ID);
        ////            sb.Append("<tr style='background-color: #E6DFEC'>");
        ////            sb.Append("<td colspan='5' class='fontBlack12px'>" + pc.Name + "</td>");
        ////            if (lstRolePerCat.Count > 0)
        ////            {
        ////                if (lstRolePerCat.FirstOrDefault().Verification)
        ////                    sb.Append("<td align='center'><input type='checkbox' checked id='cV" + pc.ID + "' value='rPCatV" + pc.ID + "'></input>");
        ////                else
        ////                    sb.Append("<td align='center'><input type='checkbox' id='cV" + pc.ID + "' value='rPCatV" + pc.ID + "'></input>");

        ////                if (lstRolePerCat.FirstOrDefault().Approval)
        ////                    sb.Append("<td align='center'><input type='checkbox' checked id='cA" + pc.ID + "' value='rPCatA" + pc.ID + "'></input>");
        ////                else
        ////                    sb.Append("<td align='center'><input type='checkbox' id='cA" + pc.ID + "' value='rPCatA" + pc.ID + "'></input>");
        ////            }
        ////            else
        ////            {
        ////                sb.Append("<td align='center'><input type='checkbox' id='cV" + pc.ID + "' value='rPCatV" + pc.ID + "'></input>");
        ////                sb.Append("<td align='center'><input type='checkbox' id='cA" + pc.ID + "' value='rPCatA" + pc.ID + "'></input>");
        ////            }
        ////            sb.Append("</tr>");
        ////            //Retrieve the Permissions Based on category
        ////            List<Permission> list = RolePermissionService.GetPermissionByCategory("it.ParentId=" + pc.ID.ToString()); //load only undeleted records
        ////            List<Role_Permission> lstRolePer = new List<Role_Permission>();
        ////            foreach (Permission c in list)
        ////            {
        ////                lstRolePer = RolePermissionService.IsPermissionChecked(RoleID, c.ID);
        ////                sb.Append("<tr>");
        ////                sb.Append("<td>" + c.Name + "</td>");
        ////                if (lstRolePer.Count > 0)
        ////                {
        ////                    if (lstRolePer.FirstOrDefault().AllowCreate)
        ////                        sb.Append("<td align='center'><input type='checkbox' checked id='cC" + c.ID + "' value='rPerC" + c.ID + "'></input>");
        ////                    else
        ////                        sb.Append("<td align='center'><input type='checkbox' id='cC" + c.ID + "' value='rPerC" + c.ID + "'></input>");

        ////                    if (lstRolePer.FirstOrDefault().AllowRead)
        ////                        sb.Append("<td align='center'><input type='checkbox' checked id='cR" + c.ID + "' value='rPerR" + c.ID + "'></input>");
        ////                    else
        ////                        sb.Append("<td align='center'><input type='checkbox' id='cR" + c.ID + "' value='rPerR" + c.ID + "'></input>");

        ////                    if (lstRolePer.FirstOrDefault().AllowUpdate)
        ////                        sb.Append("<td align='center'><input type='checkbox' checked id='cU" + c.ID + "' value='rPerU" + c.ID + "'></input>");
        ////                    else
        ////                        sb.Append("<td align='center'><input type='checkbox' id='cU" + c.ID + "' value='rPerU" + c.ID + "'></input>");

        ////                    if (lstRolePer.FirstOrDefault().AllowDelete)
        ////                        sb.Append("<td align='center'><input type='checkbox' checked id='cD" + c.ID + "' value='rPerD" + c.ID + "'></input>");
        ////                    else
        ////                        sb.Append("<td align='center'><input type='checkbox' id='cD" + c.ID + "' value='rPerD" + c.ID + "'></input>");
        ////                }
        ////                else
        ////                {
        ////                    sb.Append("<td align='center'><input type='checkbox' id='cC" + c.ID + "' value='rPerC" + c.ID + "'></input>");
        ////                    sb.Append("<td align='center'><input type='checkbox' id='cR" + c.ID + "' value='rPerR" + c.ID + "'></input>");
        ////                    sb.Append("<td align='center'><input type='checkbox' id='cU" + c.ID + "' value='rPerU" + c.ID + "'></input>");
        ////                    sb.Append("<td align='center'><input type='checkbox' id='cD" + c.ID + "' value='rPerD" + c.ID + "'></input>");
        ////                }

        ////                sb.Append("<td><input type='hidden' id='txtPermCat" + c.ID + "' value='" + pc.ID.ToString() + "'></td>");
        ////                sb.Append("<td>&nbsp;</td>");
        ////                sb.Append("</tr>");

        ////                sbPId.Append(c.ID.ToString() + ",");
        ////            }
        ////            sbPCatId.Append(pc.ID.ToString() + ",");
        ////        }
        ////        string strPIds = sbPId.ToString();
        ////        string strPCatIds = sbPCatId.ToString();
        ////        strPIds = strPIds.Substring(0, strPIds.Length - 1);
        ////        strPCatIds = strPCatIds.Substring(0, strPCatIds.Length - 1);
        ////        sb.Append("<tr>");
        ////        sb.Append("<td colspan='7'><input type='hidden' id='txtPermissionIds' value='" + strPIds + "'><input type='hidden' id='txtPermCatIds' value='" + strPCatIds + "'></td>");
        ////        sb.Append("</tr>");
        ////        sb.Append("</table>");

        ////        return sb.ToString();

        ////    }
        ////    catch (Exception ex)
        ////    {
        ////        throw ex;
        ////    }
        ////}
    }
}
