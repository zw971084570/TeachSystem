<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<EducationManager.Models.powers>" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="zh-cn" xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>WebInfo</title>
    <link type="text/css" href="../../Content/bootstrap-3.3.7-dist/css/bootstrap.min.css"
        rel="stylesheet" />
    <link href="../../Content/style/web.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../../Content/bootstrap-3.3.7-dist/js/jquery-3.0.0.js"></script>
    <script type="text/javas cript" src="../../Content/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    <script type="text/javascript">
        $(function () {

            $("#pr_roles").change(function () {
                var id = $("#pr_roles").val();
                window.location.href = " /powers/PowersManager/" + id;
            })
        })
    </script>
</head>
<body>
    <div class="container-fluid hidden-xs" style=" font-size:20px;padding-top:20px;">
       权限设置
         <hr />
    </div>
    <div class="modal-body" style="font-size: 20px;">
        <% using (Html.BeginForm())
           {%>
        <%: Html.ValidationSummary(true) %>
       
        <div class="form-group">
            角色：
            <%:Html.DropDownList("pr_roles")%>
        </div>
        <div class="form-group">
            请选择菜单：
            <div class="row">
                <% if (ViewData["mn"] != null)
                   {
                       foreach (var item in ViewData["mn"] as IEnumerable<EducationManager.Models.menuInfo>)
                       {%>
                <%if (item.mn_pId != null)
                  {
                      if ((ViewData["pw"] as List<string>).Contains(item.mn_id.ToString()))
                      {%>
                <div class="col-lg-2 col-md-3 col-sm-3 col-xs-4" >
                    <input type="checkbox" name="fc" value="<%:item.mn_id %>" checked="checked" /><%:item.mn_name%>
                </div>
                <%}
                  else
                  {%>
                <div class="col-lg-2 col-md-3 col-sm-3 col-xs-4" style="font-size: 20px;">
                    <input type="checkbox" name="fc" value="<%:item.mn_id %>" /><%:item.mn_name%>
                </div>
                <%}
              }%>
                <%}
               }%>
            </div>
        </div>
        <p>
            <input type="submit" class="btn btn-primary" value="保存" />
        </p>
        <% } %>
    </div>
    <script type="text/javascript" src="../../Content/bootstrap-3.3.7-dist/js/jquery-3.0.0.js"></script>
    <script type="text/javas cript" src="../../Content/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</body>
</html>
