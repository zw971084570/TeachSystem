<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<EducationManager.Models.teacher>" %>
<%@ Import Namespace="EducationManager.Models" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>教师详细信息</title>
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
    <h4 class="modal-title" id="exampleModalLabel">教师详细信息</h4>
</div>
    <div class="modal-body">
    <% using (Html.BeginForm()) {%>
        <%: Html.ValidationSummary(true) %>
        <div class="form-group">
            <label for="recipient-name" class="control-label">
                教师编号：</label>
            <%: Html.TextBoxFor(model => model.th_id, new { @class = "form-control", @ReadOnly=true })%>
            <%: Html.ValidationMessageFor(model => model.th_id)%>
        </div>
        <div class="form-group">
            <label for="recipient-name" class="control-label">
                姓名：</label>
                
            <%: Html.TextBoxFor(model => model.th_name, new { @class = "form-control" })%>
            <%: Html.ValidationMessageFor(model => model.th_name)%>
        </div>
        <div class="form-group">
            <label for="recipient-name" class="control-label">
                角色：</label>
            <%: Html.DropDownList("th_role", ViewData["role"] as IEnumerable<SelectListItem>, new { @class = "form-control" })%>
            <%: Html.ValidationMessageFor(model => model.th_role)%>
        </div>
        <div class="form-group">
            <label for="recipient-name" class="control-label">
                性别：</label>
            <%: Html.DropDownList("th_sex",ViewData["sex"] as IEnumerable<SelectListItem>, new { @class = "form-control" })%>
            <%: Html.ValidationMessageFor(model => model.th_sex)%>
        </div>
        <div class="form-group">
            <label for="recipient-name" class="control-label">
                学历：</label>
            <%: Html.DropDownList("th_education", ViewData["education"] as IEnumerable<SelectListItem>, new { @class = "form-control" })%>
            <%: Html.ValidationMessageFor(model => model.th_education)%>
        </div>
        <div class="form-group">
            <label for="recipient-name" class="control-label">
                职称：</label>
            <%: Html.DropDownList("th_title", ViewData["title"] as IEnumerable<SelectListItem>, new { @class = "form-control" })%>
            <%: Html.ValidationMessageFor(model => model.th_title)%>
        </div>
        <div class="form-group">
            <label for="recipient-name" class="control-label">
                所学专业：</label>
            <%: Html.TextBoxFor(model => model.th_sSpecialty, new { @class = "form-control" })%>
            <%: Html.ValidationMessageFor(model => model.th_sSpecialty)%>
        </div>
        <div class="form-group">
            <label for="recipient-name" class="control-label">
                民族：</label>
            <%: Html.DropDownList("th_nation", ViewData["nation"] as IEnumerable<SelectListItem>, new { @class = "form-control" })%>
            <%: Html.ValidationMessageFor(model => model.th_nation)%>
        </div>
        <div class="form-group">
            <label for="recipient-name" class="control-label">
                户籍：</label>
            <%: Html.TextBoxFor(model => model.th_address, new { @class = "form-control" })%>
            <%: Html.ValidationMessageFor(model => model.th_address)%>
        </div>
        <div class="form-group">
            <label for="recipient-name" class="control-label">
                联系电话：</label>
            <%: Html.TextBoxFor(model => model.th_tel, new { @class = "form-control" })%>
            <%: Html.ValidationMessageFor(model => model.th_tel)%>
        </div>
        <div class="form-group">
            <label for="recipient-name" class="control-label">
                政治面貌：</label>
            <%: Html.DropDownList("th_politicalOutlook",ViewData["politicalOutlook"] as IEnumerable<SelectListItem>, new { @class = "form-control" })%>
            <%: Html.ValidationMessageFor(model => model.th_politicalOutlook)%>
        </div>
        <div class="form-group">
            <label for="recipient-name" class="control-label">
                身份证号：</label>
            <%: Html.TextBoxFor(model => model.th_cid, new { @class = "form-control" })%>
            <%: Html.ValidationMessageFor(model => model.th_cid)%>
        </div>
        <div class="form-group">
            <label for="recipient-name" class="control-label">
                所在院校：</label>
            <%: Html.TextBoxFor(model => model.th_school, new { @class = "form-control" })%>
            <%: Html.ValidationMessageFor(model => model.th_school)%>
        </div>
        <div class="form-group">
            <label for="recipient-name" class="control-label">
                所属院系：</label>
            <%: Html.DropDownList("th_dpid", ViewData["dp"] as IEnumerable<SelectListItem>, new { @class = "form-control" })%>
            <%: Html.ValidationMessageFor(model => model.th_dpid)%>
        </div>
        <div class="form-group">
            <label for="recipient-name" class="control-label">
                现居住地址：</label>
            <%: Html.TextBoxFor(model => model.th_nowAddress, new { @class = "form-control" })%>
            <%: Html.ValidationMessageFor(model => model.th_nowAddress)%>
        </div>
        <div class="form-group">
            <label for="recipient-name" class="control-label">
                出生日期：</label>
            <%: Html.TextBoxFor(model => model.th_birth, new { @class = "form-control" })%>
            <%: Html.ValidationMessageFor(model => model.th_birth)%>
        </div>
        <div class="form-group">
            <label for="recipient-name" class="control-label">
                入职日期：</label>
            <%: Html.TextBoxFor(model => model.th_joinTime, new { @class = "form-control" })%>
            <%: Html.ValidationMessageFor(model => model.th_joinTime)%>
        </div>
        <div class="form-group">
            <label for="recipient-name" class="control-label">
                所带课程：</label>
            <%--<%: Html.TextBoxFor(model => model.th_classes, new { @class = "form-control" })%>
            <%: Html.ValidationMessageFor(model => model.th_classes)%>--%>
            
             <%
               List<classes> list=ViewData["clist"] as List<classes>;
               if (list.Count()>0){
                   foreach (classes item in list)
                   {
                       string[] strs = ViewData["str"] as string[];
                       if (Array.IndexOf(strs, item.cl_id.ToString()) == -1)
                       {%>
                            <input type="checkbox" name="th_classes" value="<%:item.cl_id %>" /> <%:item.cl_name%>  
                       <%}
                       else { %>
                       <input type="checkbox" name="th_classes" value="<%:item.cl_id %>" checked=checked /> <%:item.cl_name%>  
                       <%}%>

                    
                   <%}} %>
        </div>
        <div class="form-group">
            <label for="recipient-name" class="control-label">
                备注：</label>
            <%: Html.TextAreaFor(model => model.th_remark, new { @class = "form-control" })%>
            <%: Html.ValidationMessageFor(model => model.th_remark)%>
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

