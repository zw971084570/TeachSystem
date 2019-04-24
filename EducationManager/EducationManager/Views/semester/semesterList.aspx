<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<IEnumerable<EducationManager.Models.semester>>" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html lang="zh-CN" xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <title>学期信息</title>
    <link type="text/css" href="../../Content/bootstrap-3.3.7-dist/css/bootstrap.min.css"
        rel="stylesheet" />
    <link href="../../Content/style/web.css" rel="stylesheet" type="text/css" />
     <script type="text/javascript" src="../../Content/bootstrap-3.3.7-dist/js/jquery-3.0.0.js"></script>
    <script type="text/javascript" src="../../Content/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
        <%--ajax实现局部刷新，前后台交互实现搜索查询功能--%>
  <script type="text/javascript" src="../../Content/js/SemesterSearch.js"></script>
    <style type="text/css">
    #st{ width:auto; margin-right:10px;}
    </style>
</head>
<body>
    <div style="margin-bottom: 20px; padding-top:30px;">
        <div class="container-fluid hidden-xs" style="line-height: 40px; text-align: right;
            float: right;">
            <%--添加--%>
            <a data-toggle="modal" href="AddInfo" class="btn btn-primary" data-target="#modal">增加学期</a>
        </div>
        <div class="modal fade" id="modal" tabindex="-1" role="dialog" aria-labelledby="modal">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <%--此处用来显示添加页面的内容--%>
                </div>
            </div>
        </div>
        <div class="input-group">
        <%:Html.DropDownList("st", ViewData["st"] as IEnumerable<SelectListItem>, "--请选择学期--", new { @class = "form-control" })%>
         <span class="input-group-addon" style="width: auto; border: 1px solid rgb(204, 204, 204);
                border-radius: 4px;" id="search"><span class="glyphicon glyphicon-search"></span>
            </span>
        </div>
    </div>
    <div id="cts">
        <%if (Model != null)
          { %>
        <table class="table table-hover">
            <caption>学期信息</caption>
        <tr>
            
            <th>
                学期编号
            </th>
            <th>
                学期名称
            </th>
            <th class="hidden-xs">
                备注
            </th>
            <th class="hidden-xs">
            操作
            </th>
        </tr>

    <% foreach (var item in Model) { %>
    
        <tr>
            
            <td>
                <%: item.st_id %>
            </td>
            <td>
                <%: item.st_name %>
            </td>
            <td class="hidden-xs">
                <%: item.st_remark %>
            </td>
            <td class="hidden-xs">
                 <a data-toggle="modal" class="btn btn-primary" style="height: 30px; padding: 2px 12px;" href="semesterInfo/<%: item.st_id %>" data-target="#editmodal">查看详情</a>
                <a data-toggle="modal" class="btn btn-primary" style="height: 30px; padding: 2px 12px; background-color: #666666;border-color: #666666;" href="Delete/<%: item.st_id %>" data-target="#delmodal">删除</a>
            </td>
        </tr>
    
   <% } %>
    </table>
    <% }  %>
 </div>

    <%--信息详情--%>
    <div class="modal fade" id="editmodal" tabindex="-1" role="dialog" aria-labelledby="editmodal">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <%--此处用来显示详情页面的内容--%>
            </div>
        </div>
    </div>


    <%--删除消息--%>
    <div class="modal fade" id="delmodal" tabindex="-1" role="dialog" aria-labelledby="delmodal">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <%--删除内容--%>
            </div>
        </div>
    </div>
    <script type="text/javascript" src="../../Content/bootstrap-3.3.7-dist/js/jquery-3.0.0.js"></script>
    <script type="text/javascript" src="../../Content/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>

</body>
</html>

