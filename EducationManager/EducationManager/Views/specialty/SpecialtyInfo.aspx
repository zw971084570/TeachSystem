<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<EducationManager.Models.specialty>" %>
<%@ Import Namespace="EducationManager.Models" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>专业详细信息</title>
   <%--每次打开页面更新模态窗口中显示的数据--%>
    <script type="text/javascript">
        $(function () {
            $('body').on('hidden.bs.modal', '.modal', function () { $(this).removeData('bs.modal'); });
        })
        
    </script>
</head>
<body>
<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
    <h4 class="modal-title" id="exampleModalLabel">专业详细信息</h4>
</div>
    <div class="modal-body">
    <% using (Html.BeginForm()) {%>
        <%: Html.ValidationSummary(true) %>
            <div class="form-group">
            <label for="recipient-name" class="control-label">
                专业编号：</label>
            <%: Html.TextBoxFor(model => model.sp_id, new { @class = "form-control", @ReadOnly = true })%>
            <%: Html.ValidationMessageFor(model => model.sp_id)%>
        </div>
         <div class="form-group">
            <label for="recipient-name" class="control-label">
                专业名称：</label>
            <%: Html.TextBoxFor(model => model.sp_name, new { @class = "form-control" })%>
            <%: Html.ValidationMessageFor(model => model.sp_name)%>
        </div>
        <div class="form-group">
            <label for="recipient-name" class="control-label">
                所属院系：</label>
            <%: Html.DropDownListFor(model => model.sp_dpid, ViewData["dpm"] as IEnumerable<SelectListItem>, new { @class = "form-control" })%>
            <%: Html.ValidationMessageFor(model => model.sp_dpid)%>
        </div>
        <div class="form-group">
            <label for="recipient-name" class="control-label">
                所属年级：</label>
            <%: Html.DropDownListFor(model => model.sp_gdid, ViewData["gd"] as IEnumerable<SelectListItem>, new { @class = "form-control" })%>
            <%: Html.ValidationMessageFor(model => model.sp_gdid)%>
        </div>
         <div class="form-group">
            <label for="recipient-name" class="control-label">
                包含课程：</label>
               <%
                List<course> list = ViewData["clist"] as List<course>;
                if (list.Count() > 0)
                {
                    foreach (course item in list)
                    {
                        string[] strs = ViewData["strs"] as string[];
                        if (Array.IndexOf(strs, item.cs_id.ToString()) == -1)
                        {%>
                             <input type="checkbox" name="sp_csids" value="<%:item.cs_id %>" /> <%:item.cs_name%>  
                        <%}
                        else
                        {%>
                             <input type="checkbox" name="sp_csids" value="<%:item.cs_id %>" checked=checked /> <%:item.cs_name%>  
                        <%}
                    } 
                }
                %>
        </div>
        <div class="form-group">
            <label for="recipient-name" class="control-label">
                备注：</label>
            <%: Html.TextAreaFor(model => model.sp_remark, new { @class = "form-control" })%>
            <%: Html.ValidationMessageFor(model => model.sp_remark)%>
        </div>
        <div class="modal-footer">
           <a href="departmentList"> 
           <button type="button" class="btn btn-default" data-dismiss="modal">
                关闭</button></a>
            <input type="submit" class="btn btn-primary" value="保存" />
        </div>
        <% } %>
    </div>

</body>
</html>

