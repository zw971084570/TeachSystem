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
</head>
<body>
<br />
          <div id="cts">
    <%if (Model != null)
      { %>
    <table class="table table-hover">
    <caption>成绩信息</caption>
        <tr>
            <th class=" hidden-xs">
                成绩编号
            </th>
            <th>
                学号
            </th>
              <th>
                姓名
            </th>
            <th>
                课程名称
            </th>
            <th class=" hidden-xs">
                平时成绩
            </th>
            <th class=" hidden-xs">
                期末成绩
            </th>
            <th class=" hidden-xs">
                期末所占百分比
            </th>
            <th>
                总成绩
            </th>
            <th class=" hidden-xs">
                备注
            </th>
        </tr>

    <% foreach (var item in Model) { %>
    
        <tr>           
            <td class=" hidden-xs">
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
            <td class=" hidden-xs">
                <%: item.sc_usuallyScore %>
            </td>
            <td class=" hidden-xs">
                <%: item.sc_endScore %>
            </td>
            <td class=" hidden-xs">
                <%: item.sc_poportion %>
            </td>
            <td>
                <%: item.sc_sumScore %>
            </td>
            <td class=" hidden-xs">
                <%: item.sc_remark %>
            </td>
        </tr>
    
    <% } %>

    </table>
 <% }  %>
     </div>
    <script type="text/javascript" src="../../Content/bootstrap-3.3.7-dist/js/jquery-3.0.0.js"></script>
    <script type="text/javascript" src="../../Content/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>

</body>
</html>

