<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<EducationManager.Models.menuInfo>" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html lang="zh-CN" xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>AddInfo</title>
    <script type="text/javascript" src="../../Content/bootstrap-3.3.7-dist/js/jquery-3.0.0.js"></script>
    <script type="text/javascript" src="../../Content/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    <script type="text/javascript">
        $(function () {
            var mn = $("#mn").val();
            if (mn == "") {
                $('#mn_url').attr("disabled", "disabled");
            }
            $("#mn").change(function () {
                mn = $("#mn").val();
                if (mn != "") {

                    $('#mn_url').removeAttr("disabled");
                }
                else {
                    $('#mn_url').attr("disabled", "disabled");
                }
            })
        })
    </script>
</head>
<body>
<%--顶部的添加按钮部分--%>
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="exampleModalLabel">
            添加菜单信息</h4>
    </div>
    <%--添加内容部分--%>
    <div class="modal-body">
        <% using (Html.BeginForm())
           {%>
        <%: Html.ValidationSummary(true) %>
   
             <div class="form-group">
            <label for="recipient-name" class="control-label">
                菜单名称：</label>
            <%: Html.TextBoxFor(model => model.mn_name, new { @class = "form-control" })%>
            <%: Html.ValidationMessageFor(model => model.mn_name)%>
        </div>
        <div class="form-group">
            <label for="recipient-name" class="control-label">
               父节点菜单：</label>
            <%: Html.DropDownList("mn",ViewData["mn"] as IEnumerable<SelectListItem>,"--请选择--",new { @class = "form-control" })%>
            <span style="color:Red">一级菜单不用选择父节点菜单</span>
        </div>
             <div class="form-group">
            <label for="recipient-name" class="control-label">
                链接地址：</label>                
            <%: Html.TextBoxFor(model => model.mn_url, new { @class = "form-control"})%>
            <%: Html.ValidationMessageFor(model => model.mn_url)%>
            <span style="color:Red">一级菜单不用选择父节点菜单</span>
        </div>

        <div class="form-group">
            <label for="recipient-name" class="control-label">
                备注：</label>
            <%: Html.TextBoxFor(model => model.mn_remark, new { @class = "form-control" })%>
            <%: Html.ValidationMessageFor(model => model.mn_remark)%>
        </div>
           
            
             <%--底部按钮部分--%>
        <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">
                取消</button>
            <input type="submit" class="btn btn-primary" value="添加" />
        </div>
    <% } %>
    </div>
</body>
</html>