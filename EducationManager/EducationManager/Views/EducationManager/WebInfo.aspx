<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<EducationManager.Models.webInfo>" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html lang="zh-cn" xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>WebInfo</title>
  <link type="text/css" href="../../Content/bootstrap-3.3.7-dist/css/bootstrap.min.css"
        rel="stylesheet" />
    <link href="../../Content/style/web.css" rel="stylesheet" type="text/css" />
    
</head>
<body>
<div class="modal-body">
    <% using (Html.BeginForm()) {%>
        <%: Html.ValidationSummary(true) %>
            <div class="form-group">
                  <label for="recipient-name" class="control-label">
                版权：</label>            
                <%: Html.TextBoxFor(model => model.web_copyright, new { @class = "form-control" })%>
                <%: Html.ValidationMessageFor(model => model.web_copyright) %>
            </div>
            

              <div class="form-group">
                  <label for="recipient-name" class="control-label">
                地址：</label>            
             <%: Html.TextBoxFor(model => model.web_address, new { @class = "form-control" })%>
                <%: Html.ValidationMessageFor(model => model.web_address) %>
            </div>
            
            <div class="form-group">
                  <label for="recipient-name" class="control-label">
                邮编：</label>            
             <%: Html.TextBoxFor(model => model.web_postcode, new { @class = "form-control" })%>
                <%: Html.ValidationMessageFor(model => model.web_postcode)%>
            </div>

            <div class="form-group">
                  <label for="recipient-name" class="control-label">
                电话：</label>            
             <%: Html.TextBoxFor(model => model.web_tel, new { @class = "form-control" })%>
                <%: Html.ValidationMessageFor(model => model.web_tel)%>
            </div>

            <div class="form-group">
                  <label for="recipient-name" class="control-label">
                描述：</label>            
             <%: Html.TextBoxFor(model => model.web_desc, new { @class = "form-control" })%>
                <%: Html.ValidationMessageFor(model => model.web_desc)%>
            </div>

            <div class="form-group">
                  <label for="recipient-name" class="control-label">
                关键字：</label>            
             <%: Html.TextBoxFor(model => model.web_keywords, new { @class = "form-control" })%>
                <%: Html.ValidationMessageFor(model => model.web_keywords)%>
            </div>         
            <p>
                <input type="submit" class="btn btn-primary" value="保存" />
            </p>    

    <% } %>
    </div>
    <script type="text/javascript" src="../../Content/bootstrap-3.3.7-dist/js/jquery-3.0.0.js"></script>
    <script type="text/javascript" src="../../Content/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>

</body>
</html>

