<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<EducationManager.Models.semester>" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Delete</title>
</head>
<body>
   <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
    <h4 class="modal-title" id="exampleModalLabel">删除确认</h4>
</div>
<div class="modal-body">
    <h3>删除该学期同时会删除与该学习相关的所有数据，您确定要删除吗?</h3>        
    <% using (Html.BeginForm()) { %>
        <div class="modal-footer">
    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
    <input type="submit" class="btn btn-primary"  value="删除" /> 
</div>
        
    <% } %>
    </div>
</body>
</html>

