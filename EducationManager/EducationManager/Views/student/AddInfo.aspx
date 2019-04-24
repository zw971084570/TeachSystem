<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<EducationManager.Models.student>" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>添加学生信息</title>
</head>
<body>
   <%--顶部的添加按钮部分--%>
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="exampleModalLabel">
            添加学生信息</h4>
    </div>
    <%--添加内容部分--%>
    <div class="modal-body">
        <% using (Html.BeginForm())
           {%>
        <%: Html.ValidationSummary(true) %>
    <div class="form-group">
        <label for="recipient-name" class="control-label">
            姓名：</label>
        <%: Html.TextBoxFor(model => model.stu_name, new { @class = "form-control" })%>
        <%: Html.ValidationMessageFor(model => model.stu_name)%>
    </div>
    <div class="form-group">
        <label for="recipient-name" class="control-label">
            性别：</label>
        <%: Html.DropDownListFor(model => model.stu_sex,ViewData["sex"] as IEnumerable<SelectListItem>,"--请选择--" ,new { @class = "form-control" })%>
        <%: Html.ValidationMessageFor(model => model.stu_sex)%>
    </div>
    <div class="form-group">
        <label for="recipient-name" class="control-label">
            出生日期：</label>
        <%: Html.TextBoxFor(model => model.stu_birth, new { @class = "form-control" })%>
        <%: Html.ValidationMessageFor(model => model.stu_birth)%>
    </div>
    <div class="form-group">
        <label for="recipient-name" class="control-label">
            民族：</label>
        <%: Html.DropDownListFor(model => model.stu_nation, ViewData["nation"] as IEnumerable<SelectListItem>, "--请选择--", new { @class = "form-control" })%>
        <%: Html.ValidationMessageFor(model => model.stu_nation)%>
    </div>
    <div class="form-group">
        <label for="recipient-name" class="control-label">
            身份证号：</label>
        <%: Html.TextBoxFor(model => model.stu_cid, new { @class = "form-control" })%>
        <%: Html.ValidationMessageFor(model => model.stu_cid)%>
    </div>
    <div class="form-group">
        <label for="recipient-name" class="control-label">
            联系电话：</label>
        <%: Html.TextBoxFor(model => model.stu_tel, new { @class = "form-control" })%>
        <%: Html.ValidationMessageFor(model => model.stu_tel)%>
    </div>
    <div class="form-group">
        <label for="recipient-name" class="control-label">
            户籍：</label>
        <%: Html.TextBoxFor(model => model.stu_address, new { @class = "form-control" })%>
        <%: Html.ValidationMessageFor(model => model.stu_address)%>
    </div>
    <div class="form-group">
        <label for="recipient-name" class="control-label">
            所在班级：</label>
        <%: Html.DropDownListFor(model => model.stu_clid, ViewData["class"] as IEnumerable<SelectListItem>, "--请选择--", new { @class = "form-control" })%>
        <%: Html.ValidationMessageFor(model => model.stu_clid)%>
    </div>
    <div class="form-group">
        <label for="recipient-name" class="control-label">
            政治面貌：</label>
        <%: Html.DropDownListFor(model => model.stu_politicalOutlook, ViewData["politicalOutlook"] as IEnumerable<SelectListItem>, "--请选择--", new { @class = "form-control" })%>
        <%: Html.ValidationMessageFor(model => model.stu_politicalOutlook)%>
    </div>
    <div class="form-group">
        <label for="recipient-name" class="control-label">
            入学时间：</label>
        <%: Html.TextBoxFor(model => model.stu_joinTime, new { @class = "form-control" })%>
        <%: Html.ValidationMessageFor(model => model.stu_joinTime)%>
    </div>
    <div class="form-group">
        <label for="recipient-name" class="control-label">
            毕业高中：</label>
        <%: Html.TextBoxFor(model => model.stu_highSchool, new { @class = "form-control" })%>
        <%: Html.ValidationMessageFor(model => model.stu_highSchool)%>
    </div>
    <div class="form-group">
        <label for="recipient-name" class="control-label">
            备注：</label>
        <%: Html.TextAreaFor(model => model.stu_remark, new { @class = "form-control" })%>
        <%: Html.ValidationMessageFor(model => model.stu_remark)%>
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
