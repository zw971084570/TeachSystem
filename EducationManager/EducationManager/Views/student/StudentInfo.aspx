<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<EducationManager.Models.student>" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>学生详细信息</title>
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
    <h4 class="modal-title" id="exampleModalLabel">学生详细信息</h4>
</div>
    <div class="modal-body">
    <% using (Html.BeginForm()) {%>
        <%: Html.ValidationSummary(true) %>
            <div class="form-group">
            <label for="recipient-name" class="control-label">
                学号：</label>
            <%: Html.TextBoxFor(model => model.stu_num, new { @class = "form-control", @ReadOnly = true })%>
            <%: Html.ValidationMessageFor(model => model.stu_num)%>
        </div>
    <div class="form-group">
        <label for="recipient-name" class="control-label">
            姓名：</label>
        <%: Html.TextBoxFor(model => model.stu_name, new { @class = "form-control" })%>
        <%: Html.ValidationMessageFor(model => model.stu_name)%>
    </div>
    <div class="form-group">
        <label for="recipient-name" class="control-label">
            性别：</label>
        <%: Html.DropDownList("stu_sex",ViewData["sex"] as IEnumerable<SelectListItem>, new { @class = "form-control" })%>
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
        <%: Html.DropDownList("stu_nation", ViewData["nation"] as IEnumerable<SelectListItem>, new { @class = "form-control" })%>
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
        <%: Html.DropDownList("stu_clid", ViewData["class"] as IEnumerable<SelectListItem>, new { @class = "form-control" })%>
        <%: Html.ValidationMessageFor(model => model.stu_clid)%>
    </div>
    <div class="form-group">
        <label for="recipient-name" class="control-label">
            政治面貌：</label>
        <%: Html.DropDownList("stu_politicalOutlook", ViewData["politicalOutlook"] as IEnumerable<SelectListItem>, new { @class = "form-control" })%>
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

