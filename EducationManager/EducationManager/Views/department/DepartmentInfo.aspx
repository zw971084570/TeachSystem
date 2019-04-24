<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<EducationManager.Models.department>" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>departmentInfo</title>
    <%--每次打开页面更新模态窗口中显示的数据--%>
    <script type="text/javascript">
        $(function () {
            $('body').on('hidden.bs.modal', '.modal', function () { $(this).removeData('bs.modal'); });
        })
        
    </script>
</head>
<body>
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="exampleModalLabel">
            院系详细信息</h4>
    </div>
    <div class="modal-body">
        <% using (Html.BeginForm())
           {%>
        <%: Html.ValidationSummary(true) %>
        <div class="form-group">
            <label for="recipient-name" class="control-label">
                院系编号：</label>
            <%: Html.TextBoxFor(model => model.dp_id, new {@class = "form-control",@ReadOnly=true })%>
            <%: Html.ValidationMessageFor(model => model.dp_id) %>
        </div>
        <div class="form-group">
            <label for="recipient-name" class="control-label">
                院系名称：</label>
            <%: Html.TextBoxFor(model => model.dp_name,new { @class = "form-control" })%>
            <%: Html.ValidationMessageFor(model => model.dp_name)%>
        </div>
        <div class="form-group">
            <label for="recipient-name" class="control-label">
                院系类别：</label>
            <%: Html.DropDownList("dp_type", ViewData["type"] as IEnumerable<SelectListItem>, new { @class = "form-control" })%>
            <%: Html.ValidationMessageFor(model => model.dp_type)%>
        </div>
        <div class="form-group">
            <label for="recipient-name" class="control-label">
                创办时间：</label>
            <%: Html.TextBoxFor(model => model.dp_cretateTime, new {@class = "form-control"})%>
            <%: Html.ValidationMessageFor(model => model.dp_cretateTime)%>
        </div>
        <div class="form-group">
            <label for="recipient-name" class="control-label">
                院系负责人：</label>
            <%: Html.TextBoxFor(model => model.dp_leader, new {@class = "form-control"})%>
            <%: Html.ValidationMessageFor(model => model.dp_leader)%>
        </div>
        <div class="form-group">
            <label for="recipient-name" class="control-label">
                所属校区：</label>
            <%: Html.TextBoxFor(model => model.dp_campus, new {@class = "form-control"})%><font color='red'> 该内容指的是新校区/老校区/南校区/北校区等等</font>
            <%: Html.ValidationMessageFor(model => model.dp_campus)%>
        </div>
        <div class="form-group">
            <label for="recipient-name" class="control-label">
                备注：</label>
            <%: Html.TextAreaFor(model => model.dp_remark, new {@class = "form-control"})%>
            <%: Html.ValidationMessageFor(model => model.dp_remark)%>
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
