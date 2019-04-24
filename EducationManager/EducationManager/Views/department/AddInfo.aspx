<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<EducationManager.Models.department>" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>添加院系</title>
    <style type="text/css">
    .dpdl{ width:150px; height:30px; text-align:center;}
    </style>
</head>
<body>
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="exampleModalLabel">
            添加院系</h4>
    </div>
    <div class="modal-body">
    <% using (Html.BeginForm())
       {%>
    <%: Html.ValidationSummary(true) %>
     <div class="form-group">
            <label for="recipient-name" class="control-label">院系名称：</label>
             <%: Html.TextBoxFor(model => model.dp_name, new { @class = "form-control" })%>
        <%: Html.ValidationMessageFor(model => model.dp_name) %>
        </div>
    <div class="form-group dropdown">
            <label for="recipient-name" class="control-label"> 院系类别：</label>
            <br />
           <%: Html.DropDownListFor(model => model.dp_type, ViewData["type"] as List<SelectListItem>,"--请选择--",new { @class = "form-control" })%>
        <%: Html.ValidationMessageFor(model => model.dp_type)%>
        </div>
          <div class="form-group">
            <label for="recipient-name" class="control-label">院系创办时间：</label>
             <%: Html.TextBoxFor(model => model.dp_cretateTime, new { @class = "form-control" })%>
        <%: Html.ValidationMessageFor(model => model.dp_cretateTime)%>
        </div>
          <div class="form-group">
            <label for="recipient-name" class="control-label">院系负责人：</label>
             <%: Html.TextBoxFor(model => model.dp_leader, new { @class = "form-control" })%>
        <%: Html.ValidationMessageFor(model => model.dp_leader)%>
        </div>
          <div class="form-group">
            <label for="recipient-name" class="control-label">院系所属校区：</label>
             <%: Html.TextBoxFor(model => model.dp_campus, new { @class = "form-control" })%>
        <%: Html.ValidationMessageFor(model => model.dp_campus)%>
        <font color="red">注意：该内容指的是新校区/老校区/南校区/北校区等等</font>
        </div>
          <div class="form-group">
            <label for="recipient-name" class="control-label">备注：</label>
             <%: Html.TextAreaFor(model => model.dp_remark, new { @class = "form-control" })%>
        <%: Html.ValidationMessageFor(model => model.dp_remark)%>
        </div>
  
    <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
        <input class="btn btn-primary" type="submit" value="添加" />
    </div>
    <% } %>

    </div>
</body>
</html>
