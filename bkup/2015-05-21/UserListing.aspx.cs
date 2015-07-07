using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using NTUCEldercare.DataAccess;
using NTUCEldercare.Services;
using NTUCEldercare.Utility;
using NTUCEldercare.UiServices;
using NTUCEldercare;

public partial class System_UserListing : System.Web.UI.Page
{
    private const string DEF_FIELDNAME = "it.Username";
    private const   string  DEF_SORTORDER = "ASC";
    private const   int     DEF_CURRENTPAGE = 1;
    private const   int     DEF_ITEMSPERPAGE = 10;

    protected void Page_Load(object sender, EventArgs e)
    {
        AjaxPro.Utility.RegisterTypeForAjax(typeof(System_UserListing));
        //LoadWebGrid("UserList", "1=2", DEF_FIELDNAME, DEF_SORTORDER, DEF_CURRENTPAGE.ToString(), DEF_ITEMSPERPAGE.ToString());
    }

    [AjaxPro.AjaxMethod()]
    public string LoadUserStatus()
    {
        return LookupUiService.LoadUserStatus("");
    }

    [AjaxPro.AjaxMethod()]
    public string LoadUserRole()
    {
        return LookupUiService.LoadUserRole("", "IncludeAll");
    }

    [AjaxPro.AjaxMethod()]
    public HtmlTable UpdateGridAfterSearch(string username, Int64 Role, int Status, string fieldname, string sort, string pagenum, string recordperpage)
    {
        UserList = new Webcon.WebGrid.WebGrid();
        LoadWebGrid("UserList", username, Role, Status, fieldname, sort, pagenum, recordperpage);
        return UserList.Construct();
    }

    private string ConvertDDMMYYYYToYYYYMMDDHHMMSS(string strDate)
    {
        return strDate.Substring(6, 4).ToString() + "-" + strDate.Substring(3, 2).ToString() + "-" + strDate.Substring(0, 2).ToString() + " 00:00:00";
    }

    [AjaxPro.AjaxMethod()]
    public HtmlTable Search(string username, string role, string status)
    {       
        UpdateGridAfterSearch(username,Int64.Parse(role), int.Parse(status), DEF_FIELDNAME, DEF_SORTORDER.ToString(), DEF_CURRENTPAGE.ToString(), DEF_ITEMSPERPAGE.ToString());
        return UserList.Construct();
    }
     
    #region -- WebGrid
    private void LoadWebGrid(string gridId, string username, Int64 Role, int Status, string fieldname, string sort, string pagenum, string itemPerPage)
    {
        int _page = int.Parse(pagenum);
        int _itemPerPage = int.Parse(itemPerPage);

        List<UsersView> list = UserService.GetUserListView(username, Role, Status, fieldname, sort, _page, _itemPerPage);
        int totalItem = UserService.GetUserListViewCount(username, Role, Status, fieldname, sort, _page, _itemPerPage);
        
        try
        {
            UserList.ID = gridId;
            UserList.RecordsPerPage = _itemPerPage;
            UserList.CurrentPage = _page;
            UserList.SortingField = fieldname;
            UserList.TotalRecords = totalItem;
            UserList.SortingOrder = (sort == "ASC") ? Webcon.WebGrid.SortOrder.ASC : Webcon.WebGrid.SortOrder.DESC;
            UserList.RunAtServer = false;
            UserList.ClearHeader();
            UserList.ClearRow();
            GridProperties(UserList);
            GridHeader(UserList);
            GridRow(UserList, list);
        }
        catch (Exception ex)
        {
            throw new Exception("LoadWebGrid: " + ex.Message);
        }
    }

    private void GridProperties(Webcon.WebGrid.WebGrid grid)
    {
        grid.Width = "960px";
        grid.GridCss = "table673px";
        grid.HeaderCss = "blueRowNew";
        grid.ItemEvenRowCss = "whiteRow";
        grid.ItemOddRowCss = "whiteRow";
        grid.PagingCss = "pagination";
        grid.Paging = Webcon.WebGrid.Location.Bottom;
        grid.NoRecordText = "No Records Found";
        grid.UseSort = true;
        grid.TrancateText = false;
        grid.InActivePagingCss = "prevnext disablelink";
        grid.CurrentPagingCss = "currentpage";
        grid.OnPagingClickFunctionName = "OnPageClick";
        grid.OnHeaderClickFunctionName = "OnHeaderClick";
        grid.SortDownImagePath = "~/App_Themes/Default/images/down.gif";
        grid.SortUpImagePath = "~/App_Themes/Default/images/up.gif";
    }

    private void GridHeader(Webcon.WebGrid.WebGrid grid)
    {
        grid.AddHeader(new Webcon.WebGrid.wgHeaderLink(5, true, "GridHeaderLink", ""));
        grid.AddHeader(new Webcon.WebGrid.wgHeaderLink(80, false, "GridHeaderLink", "User Name", "it.UserName"));
        grid.AddHeader(new Webcon.WebGrid.wgHeaderLink(80, false, "GridHeaderLink", "First Name", "it.FirstName"));
        grid.AddHeader(new Webcon.WebGrid.wgHeaderLink(80, false, "GridHeaderLink", "Last Name", "it.LastName"));        
        grid.AddHeader(new Webcon.WebGrid.wgHeaderLink(90, false, "GridHeaderLink", "Role", "it.Role"));
        grid.AddHeader(new Webcon.WebGrid.wgHeaderLink(65, false, "GridHeaderLink", "Phone", "it.Phone"));
        grid.AddHeader(new Webcon.WebGrid.wgHeaderLink(110, false, "GridHeaderLink", "Email", "it.Email"));
        grid.AddHeader(new Webcon.WebGrid.wgHeaderLink(55, false, "GridHeaderLink", "Status", "it.Status"));
    }

    private void GridRow(Webcon.WebGrid.WebGrid grid, List<UsersView> list)
    {
        if (list != null && list.Count > 0)
        {
            foreach (UsersView obj in list)
            {
                Webcon.WebGrid.RowCellCollection collection = new Webcon.WebGrid.RowCellCollection(obj.ID.ToString());
                collection.Add(new Webcon.WebGrid.wgSelectionCheckBox(obj.ID.ToString()));
                collection.Add(new Webcon.WebGrid.wgHyperLink(obj.ID.ToString(), obj.Username.ToString(), string.Format("UserDetail.aspx?id={0}", obj.ID)));
                collection.Add(new Webcon.WebGrid.wgLabel(obj.FirstName.ToString()));
                collection.Add(new Webcon.WebGrid.wgLabel(obj.LastName.ToString()));                
                collection.Add(new Webcon.WebGrid.wgLabel(obj.Role.ToString()));
                collection.Add(new Webcon.WebGrid.wgLabel(obj.Phone.ToString()));
                collection.Add(new Webcon.WebGrid.wgLabel(obj.Email.ToString()));
                collection.Add(new Webcon.WebGrid.wgLabel(obj.Status.ToString()));
                grid.AddRow(collection);
            }
        }
    }
    #endregion
}
