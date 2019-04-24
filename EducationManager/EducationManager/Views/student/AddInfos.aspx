<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<EducationManager.Models.student>" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>批量导入学生信息</title>
</head>
<body>
<%--顶部的添加按钮部分--%>
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="exampleModalLabel">
            批量导入学生信息</h4>
    </div>
    <%--添加内容部分--%>
    <div class="modal-body">
    <% using (Html.BeginForm("AddInfos", "student", FormMethod.Post, new { enctype = "multipart/form-data" }))
       {%>
    <%: Html.ValidationSummary(true)%>
      <div class="form-group">       
    <input id="FileUpload" type="file" name="files" style="width: 250px; height: 24px;background: White" class="easyui-validatebox" />
    <br />
    <br />
    <input type="submit" value="导入"  class="btn btn-primary"/>
    <br />
    <font color="red">注意：批量导入数据必须完全按照<a href="#">附件</a>格式填写，班级名称必须使用系统中已有的班级，名称也必须与系统中名称一致,否则上传不成功!
    </font>   
    </div>
    <% } %>
     <form id="form2" action="DownloadFile" method="post">
     <input type="submit" value="下载附件" />     
     </form>
    </div>
</body>
</html>
