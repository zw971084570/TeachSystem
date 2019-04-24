<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<EducationManager.Models.student>" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>StuCenter</title>
    <style type="text/css">
        .form-group
        {
            font-size: 22px;
        }
        .control-label{ width:120px; display:inline-block; height:40px;}
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
                学号：</label><%: Model.stu_num %>
        </div>
        <div class="form-group">
            <label for="recipient-name" class="control-label">
                姓名：</label><%: Model.stu_name%>
        </div>
        <div class="form-group">
            <label for="recipient-name" class="control-label">
                性别：</label><%: Model.stu_sex%>
        </div>
        <div class="form-group">
            <label for="recipient-name" class="control-label">
                出生日期：</label><%: String.Format("{0:yyyy-MM-dd}", Model.stu_birth) %>
        </div>
        <div class="form-group">
            <label for="recipient-name" class="control-label">
                民族：</label><%: Model.stu_nation %>
        </div>
        <div class="form-group">
            <label for="recipient-name" class="control-label">
                身份证号：</label><%: Model.stu_cid%>
        </div>
        <div class="form-group">
            <label for="recipient-name" class="control-label">
                联系电话：</label><%: Model.stu_tel%>
        </div>
        <div class="form-group">
            <label for="recipient-name" class="control-label">
                户籍：</label><%: Model.stu_address%>
        </div>
        <div class="form-group">
            <label for="recipient-name" class="control-label">
                班级：</label><%: Model.classes.cl_name%>
        </div>
        <div class="form-group">
            <label for="recipient-name" class="control-label">
                政治面貌：</label><%: Model.stu_politicalOutlook%>
        </div>
        <div class="form-group">
            <label for="recipient-name" class="control-label">
                入学日期：</label><%: String.Format("{0:yyyy-MM-dd}", Model.stu_joinTime)%>
        </div>
        <div class="form-group">
            <label for="recipient-name" class="control-label">
                毕业高中：</label><%:Model.stu_highSchool%>
        </div>
        <div class="form-group">
            <label for="recipient-name" class="control-label">
                备注：</label><%:Model.stu_remark%>
        </div>
    </div>
</body>
</html>
