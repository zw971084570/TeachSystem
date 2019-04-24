<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<IEnumerable<EducationManager.Models.score>>" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html lang="zh-CN" xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <title>查看成绩</title>
    <link type="text/css" href="../../Content/bootstrap-3.3.7-dist/css/bootstrap.min.css"
        rel="stylesheet" />
    <link href="../../Content/style/web.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../../Content/bootstrap-3.3.7-dist/js/jquery-3.0.0.js"></script>
    <script type="text/javascript" src="../../Content/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    <%--ajax实现局部刷新，前后台交互实现搜索查询功能--%>
    <script type="text/javascript">
        $(function () {
            $("#search").click(function () {
                var name = $("#searchName").val();
                $.ajax({
                    type: "POST",
                    url: "SearchInfo",
                    data: {
                        csname: name
                    },
                    success: function (result) {
                        $("#cts").html(result);
                    }
                })
            })
        })
    </script>
</head>
<body>
<div style=" margin-bottom:20px; padding-top:30px;">
  <div class="input-group">
        <input type="text" class="form-control txt" id="searchName" style="width: auto" placeholder="请输入专业课名称">&nbsp;&nbsp;
        <span class="input-group-addon" style="width: auto; border: 1px solid rgb(204, 204, 204);
            border-radius: 4px;" id="search"><span class="glyphicon glyphicon-search"></span>
        </span>
    </div>
     </div>
    <div id="cts">
            <%if (Model != null)
              { %>
                <table class="table table-hover">
    <caption>查看成绩</caption>
        <tr>            
            <th>
                成绩编号
            </th>
            <th>
                学号
            </th>
            <th>
                姓名
            </th>
            <th>
                专业
            </th>            
            <th>
                总成绩
            </th>
            <th>
            是否挂科
            </th>
        </tr>

    <% foreach (var item in Model) { %>
    
        <tr>
            <td>
                <%: item.sc_id %>
            </td>
            <td>
                <%: item.sc_stuNum %>
            </td>
             <td>
                <%: item.student.stu_name %>
            </td>
            <td>
                <%: item.course.cs_name %>
            </td>            
            <td>
                <%: item.sc_sumScore %>
            </td>
            <td>
                <% if (item.sc_sumScore < 60)
                   { %>
                   是
                   <%}
                   else { %>
                   否
                   <%} %>
            </td>
        </tr>
    
    <% } %>

    </table>
    <%} %>
    </div>
</body>
</html>

