<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<EducationManager.Models.ChangePwdModel>" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html lang="zh-CN" xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <% if (ViewData["list"] != null)
       {%>
    <meta name="description" content='<%:ViewData["desc"] %>'>
    <meta name="keyword" content='<%:ViewData["key"] %>'>
    <%} %>
    <title>教务管理系统--修改密码</title>
    <link type="text/css" href="../../Content/bootstrap-3.3.7-dist/css/bootstrap.min.css"
        rel="stylesheet" />
    <link href="../../Content/style/web.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="../../Content/bootstrap-3.3.7-dist/js/jquery-3.0.0.js"></script>
    <script type="text/javascript" src="../../Content/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    <script type="text/javascript">
        $(function () {
            $("form").submit(function () { 
            var pwd = $("#password").val();
                var repwd = $("#repwd").val();
                if (repwd != null && repwd != "") {
                    if (repwd != pwd) {
                        alert("重复密码和密码不一致！");
                        return false;
                    }
                }
            })
           
        })
    </script>
</head>
<body>
 <div class="modal-header">
         
            <h4 class="modal-title" id="exampleModalLabel">
                修改密码</h4>
        </div>
        <div class="modal-body">
    <% using (Html.BeginForm()) {%>
        <%: Html.ValidationSummary(true) %>       
         <div class="form-group">
                <label for="recipient-name" class="control-label">
                    编号：</label>
                    <%:Model.id %>
            </div>

             <div class="form-group">
                <label for="recipient-name" class="control-label">
                    姓名：</label>
                <%: Html.TextBoxFor(model => model.name, new { @class = "form-control",@ReadOnly=true })%>
                <%: Html.ValidationMessageFor(model => model.name)%>
            </div>
             <div class="form-group">
                <label for="recipient-name" class="control-label">
                    新密码：</label>
                <input type="password" name="password" id="password" class="form-control"/>
            </div>
                <div class="form-group">
                <label for="recipient-name" class="control-label">
                    重复密码：</label>
             <input type="password" name="repwd" class="form-control" id="repwd" />
            </div>
            
           <div class="modal-footer">
                <input type="submit" class="btn btn-primary" id="save" value="保存" />
            </div>
            <% } %>
     </div>
</body>
</html>

