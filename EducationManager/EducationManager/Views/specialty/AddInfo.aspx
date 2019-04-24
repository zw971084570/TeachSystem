<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<EducationManager.Models.specialty>" %>
<%@ Import Namespace="EducationManager.Models" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>AddInfo</title>
</head>
<body>
    <%--顶部的添加按钮部分--%>
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="exampleModalLabel">
            添加专业</h4>
    </div>
    <%--添加内容部分--%>
    <div class="modal-body">
        <% using (Html.BeginForm())
           {%>
        <%: Html.ValidationSummary(true) %>
        <div class="form-group">
            <label for="recipient-name" class="control-label">
                专业名称：</label>
            <%: Html.TextBoxFor(model => model.sp_name, new { @class = "form-control" })%>
            <%: Html.ValidationMessageFor(model => model.sp_name)%>
        </div>
        <div class="form-group">
            <label for="recipient-name" class="control-label">
                所属院系：</label>
            <%: Html.DropDownListFor(model => model.sp_dpid,ViewData["dpm"] as IEnumerable<SelectListItem>,"--请选择--", new { @class = "form-control" })%>
            <%: Html.ValidationMessageFor(model => model.sp_dpid)%>
        </div>
        <div class="form-group">
            <label for="recipient-name" class="control-label">
                所属年级：</label>
            <%: Html.DropDownListFor(model => model.sp_gdid, ViewData["gd"] as IEnumerable<SelectListItem>, "--请选择--", new { @class = "form-control" })%>
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
                    {%>
                        <input type="checkbox" name="sp_csids" value="<%:item.cs_id %>" /> <%:item.cs_name %>
                    <%} 
                }
                %>
        </div>
        <div class="form-group">
            <label for="recipient-name" class="control-label">
                备注：</label>
            <%: Html.TextAreaFor(model => model.sp_remark, new { @class = "form-control" })%>
            <%: Html.ValidationMessageFor(model => model.sp_remark)%>
        </div>
        <%--底部按钮部分--%>
        <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">
                取消</button>
            <input type="submit" class="btn btn-primary" value="添加" />
        </div>
        <% } %>
    </div>
</body>
</html>
