﻿<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<EducationManager.Models.course>" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>课程详细信息</title>
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
    <h4 class="modal-title" id="exampleModalLabel">课程详细信息</h4>
</div>
    <div class="modal-body">
    <% using (Html.BeginForm()) {%>
        <%: Html.ValidationSummary(true) %>
         <div class="form-group">
            <label for="recipient-name" class="control-label">
                课程编号：</label>
            <%: Html.TextBoxFor(model => model.cs_id, new { @class = "form-control", @ReadOnly = true })%>
            <%: Html.ValidationMessageFor(model => model.cs_id)%>
        </div>
        <div class="form-group">
            <label for="recipient-name" class="control-label">
                课程名称：</label>
            <%: Html.TextBoxFor(model => model.cs_name, new { @class = "form-control" })%>
            <%: Html.ValidationMessageFor(model => model.cs_name)%>
        </div>
        <div class="form-group">
            <label for="recipient-name" class="control-label">
                所属学期：</label>
            <%: Html.DropDownList("cs_stid",ViewData["st"] as IEnumerable<SelectListItem>,new { @class = "form-control" })%>
            <%: Html.ValidationMessageFor(model => model.cs_stid)%>
        </div>
        <div class="form-group">
            <label for="recipient-name" class="control-label">
                备注：</label>
            <%: Html.TextAreaFor(model => model.cs_remark, new { @class = "form-control" })%>
            <%: Html.ValidationMessageFor(model => model.cs_remark)%>
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

