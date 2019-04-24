<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<EducationManager.Models.course>" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>添加课程</title>
</head>
<body>
    <%--顶部的添加按钮部分--%>
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="exampleModalLabel">
            添加课程</h4>
    </div>
    <%--添加内容部分--%>
    <div class="modal-body">
        <% using (Html.BeginForm())
           {%>
        <%: Html.ValidationSummary(true) %>
        <div class="form-group">
            <label for="recipient-name" class="control-label">
                课程名称：</label>
            <%: Html.TextBoxFor(model => model.cs_name, new { @class = "form-control" })%>
            <%: Html.ValidationMessageFor(model => model.cs_name)%>
        </div>
        <div class="form-group">
            <label for="recipient-name" class="control-label">
                所属学期：</label>
            <%: Html.DropDownListFor(model => model.cs_stid,ViewData["st"] as IEnumerable<SelectListItem>,"--请选择--",new { @class = "form-control" })%>
            <%: Html.ValidationMessageFor(model => model.cs_stid)%>
        </div>
        <div class="form-group">
            <label for="recipient-name" class="control-label">
                备注：</label>
            <%: Html.TextAreaFor(model => model.cs_remark, new { @class = "form-control" })%>
            <%: Html.ValidationMessageFor(model => model.cs_remark)%>
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
