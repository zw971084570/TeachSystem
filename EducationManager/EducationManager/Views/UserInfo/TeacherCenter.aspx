<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<EducationManager.Models.teacher>" %>
<%@ Import Namespace="EducationManager.Models" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>TeacherCenter</title>
    <style type="text/css">
        .form-group
        {
            font-size: 22px;
        }
        .control-label
        {
            width: 120px;
            display: inline-block;
            height: 35px;
        }
    </style>
</head>
<body>
    <div class="modal-header">
        <h4 class="modal-title" id="exampleModalLabel">
            个人信息</h4>
    </div>
    <hr />
    <div class="modal-body">
        <div class="form-group">
            <label for="recipient-name" class="control-label">
                工号：</label><%: Model.th_id%>
        </div>
        <div class="form-group">
            <label for="recipient-name" class="control-label">
                姓名：</label><%: Model.th_name%>
        </div>
        <div class="form-group">
            <label for="recipient-name" class="control-label">
                角色：</label><%if (Model.th_role == 1){ %>管理员<%}else{ %>普通教师<%}%>
        </div>
        <div class="form-group">
            <label for="recipient-name" class="control-label">
                性别：</label><%: Model.th_sex%>
        </div>
        <div class="form-group">
            <label for="recipient-name" class="control-label">
                学历：</label><%: Model.th_education%>
        </div>
        <div class="form-group">
            <label for="recipient-name" class="control-label">
                职称：</label><%: Model.th_title%>
        </div>
        <div class="form-group">
            <label for="recipient-name" class="control-label">
                所学专业：</label><%: Model.th_sSpecialty%>
        </div>
        <div class="form-group">
            <label for="recipient-name" class="control-label">
                民族：</label><%: Model.th_nation%>
        </div>
        <div class="form-group">
            <label for="recipient-name" class="control-label">
                户籍：</label><%: Model.th_address%>
        </div>
        <div class="form-group">
            <label for="recipient-name" class="control-label">
                联系电话：</label><%: Model.th_tel%>
        </div>
        <div class="form-group">
            <label for="recipient-name" class="control-label">
                政治面貌：</label><%: Model.th_politicalOutlook%>
        </div>
        <div class="form-group">
            <label for="recipient-name" class="control-label">
                身份证号：</label><%: Model.th_cid%>
        </div>
        <div class="form-group">
            <label for="recipient-name" class="control-label">
                所在院校：</label><%: Model.th_school%>
        </div>
        <div class="form-group">
            <label for="recipient-name" class="control-label">
                所在院系：</label><%: Model.department.dp_name%>
        </div>
        <div class="form-group">
            <label for="recipient-name" class="control-label">
                现居住址：</label><%: Model.th_nowAddress%>
        </div>
        <div class="form-group">
            <label for="recipient-name" class="control-label">
                出生日期：</label><%: String.Format("{0:yyyy-MM-dd}", Model.th_birth) %>
        </div>
        <div class="form-group">
            <label for="recipient-name" class="control-label">
                入职日期：</label><%: String.Format("{0:yyyy-MM-dd}", Model.th_joinTime)%>
        </div>
        <div class="form-group">
            <label for="recipient-name" class="control-label">
                所带班级：</label>
                    <%
               List<classes> list=ViewData["clist"] as List<classes>;
               if (list.Count()>0){
                   foreach (classes item in list)
                   {
                       string[] strs = ViewData["str"] as string[];
                       if (Array.IndexOf(strs, item.cl_id.ToString()) != -1)
                       {%>
                           <%:item.cl_name%>  
                       <%}%>

                    
                   <%}} %>
        </div>
        <div class="form-group">
            <label for="recipient-name" class="control-label">
                备注：</label><%: Model.th_remark%>
        </div>
    </div>
</body>
</html>
