<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<IEnumerable<EducationManager.Models.teacher>>" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html lang="zh-CN" xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <title>成绩信息</title>
    <link type="text/css" href="../../Content/bootstrap-3.3.7-dist/css/bootstrap.min.css"
        rel="stylesheet" />
    <link href="../../Content/style/web.css" rel="stylesheet" type="text/css" />
        <%--ajax实现局部刷新，前后台交互实现搜索查询功能--%>
  <script type="text/javascript" src="../../Content/js/GradeSearch.js"></script>
</head>
<body>
<br />
  <%if (Model != null)
      { %>
    <table class="table table-hover">
    <caption>录入成绩</caption>
        <tr>
            
            <th>
                院系
            </th>
            <th class="hidden-xs">
                专业
            </th>
              <th>
                班级
            </th>
            <th>
                课程
            </th>
            <th class="hidden-xs">
                教师
            </th>
            <th class="hidden-xs">
            录入状态
            </th>
            <th>
                操作
            </th>           
        </tr>

    <% foreach (var item in Model) { 
           if(ViewData["sc"] !=null)
           {
               List<EducationManager.Models.ScoreModel> lists=ViewData["sc"] as List<EducationManager.Models.ScoreModel>;
               foreach (EducationManager.Models.ScoreModel sc in lists)
	            {%>
		          <tr>
          
                    <td>
                        <%: item.department.dp_name %>
                    </td>
                    <td class="hidden-xs">
                        <%: sc.sp_name %>
                    </td>
                    <td>
                        <%: sc.cl_name%>
                    </td>
                    <td>
                    <%:sc.cs_name %>
                    </td>
                    <td class="hidden-xs">
                        <%: item.th_name %>
                    </td>    
                    <td class="hidden-xs">
                      <%if (sc.IsInput == "录入完毕")
                        { %>
                        <font color='red'><%:sc.IsInput %></font>
                        <%}
                        else
                        {%> 
                        <%:sc.IsInput %>
                        <%}%>                    
                    </td>    
                      <td>
                      <%if (sc.IsInput == "录入完毕")
                        { %>
                        <a class="btn btn-primary" style=" height:30px; padding:2px 12px; background-color:#666666; border-color:#666666;" href="TeacherScoreInfo/<%:sc.cl_id %>/<%:sc.cs_id %>">查看成绩</a>
                        <%}
                        else
                        {%> 
                        <a class="btn btn-primary" style=" height:30px; padding:2px 12px;" href="InputInfo/<%:sc.cl_id %>/<%:sc.cs_id %>">录入成绩</a>
                        <%}%>
                         
                    </td>
                  </tr>  
	            <%}
           }
           %>
   <% } %>
    </table>
    <% }  %>

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


