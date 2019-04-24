﻿<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<EducationManager.Models.classes>" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>添加班级</title>
</head>
<body>
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="exampleModalLabel">
            添加班级</h4>
    </div>
    <div class="modal-body">
        <% using (Html.BeginForm())
           {%>
        <%: Html.ValidationSummary(true) %>
        <div class="form-group">
            <label for="recipient-name" class="control-label">
                班级名称：</label>
            <%: Html.TextBoxFor(model => model.cl_name, new { @class = "form-control" })%>
            <%: Html.ValidationMessageFor(model => model.cl_name) %>
        </div>
        <div class="form-group">
            <label for="recipient-name" class="control-label">
                所属专业：</label>
            <%: Html.DropDownListFor(model => model.cl_spid, ViewData["sp"] as IEnumerable<SelectListItem>, "--请选择--", new { @class = "form-control" })%>
            <%: Html.ValidationMessageFor(model => model.cl_spid)%>
        </div>
        <div class="form-group">
            <label for="recipient-name" class="control-label">
                班级教室：</label>
            <%: Html.TextBoxFor(model => model.cl_room, new { @class = "form-control" })%>
            <%: Html.ValidationMessageFor(model => model.cl_room)%>
        </div>
        <div class="form-group">
            <label for="recipient-name" class="control-label">
                备注：</label>
            <%: Html.TextAreaFor(model => model.cl_remark, new { @class = "form-control" })%>
            <%: Html.ValidationMessageFor(model => model.cl_remark)%>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">
                取消</button>
            <input type="submit" class="btn btn-primary" value="添加" />
        </div>
        <% } %>
    </div>
</body>
</html>
