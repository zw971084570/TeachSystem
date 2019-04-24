<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<IEnumerable<EducationManager.Models.teacher>>" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="zh-CN" xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <title>教师信息管理</title>
    <link type="text/css" href="../../Content/bootstrap-3.3.7-dist/css/bootstrap.min.css"
        rel="stylesheet" />
    <link href="../../Content/style/web.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../../Content/bootstrap-3.3.7-dist/js/jquery-3.0.0.js"></script>
    <script type="text/javascript" src="../../Content/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    <%--搜索查询js--%>
    <script type="text/javascript" src="../../Content/js/TeacherSearch.js"></script>
</head>
<body>
<div style=" margin-bottom:20px;padding-top:20px;">
   <div class="container-fluid hidden-xs" style="line-height:40px; text-align:right; float:right;">
        <%--添加--%>
        <a data-toggle="modal" href="AddInfo" class="btn btn-primary" data-target="#modal" >增加教师</a>      
   </div>
     <div class="modal fade" id="modal" tabindex="-1" role="dialog" aria-labelledby="modal" style=" max-height:780px;">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <%--此处用来显示添加页面的内容--%>
                </div>
            </div>
        </div>
    <div class="input-group">
        <input type="text" class="form-control txt" id="searchID" style="width: auto" placeholder="请输入教师编号">
        <input type="text" class="form-control txt hidden-xs" id="searchName" style="width: auto" placeholder="请输入教师名称">
        <input type="text" class="form-control txt hidden-xs" id="cid" style="width: auto" placeholder="请输入身份证号">
        <select name="th_title" class="form-control txt hidden-xs" style="width: auto; margin-right: 10px;"
            id="searchTitle">
            <option value="0">--请选择职称--</option>
            <option value="教授">教授</option>
            <option value="副教授">副教授</option>
            <option value="讲师">讲师</option>
            <option value="助教">助教</option>
            <option value="辅导员">辅导员</option>
            <option value="班主任">班主任</option>
        </select>
        <span class="input-group-addon" style="width: auto; border: 1px solid rgb(204, 204, 204);
            border-radius: 4px;" id="search"><span class="glyphicon glyphicon-search"></span>
        </span>
    </div>
     </div>
    <div id="cts">
            <%if (Model != null)
              { %>
                <table class="table table-hover">
    <caption>教师信息</caption> 
            <tr>
                <th>
                    教职工号
                </th>
                <th>
                    名称
                </th>
                <th>
                    角色
                </th>
                <th class="hidden-xs">
                    职称
                </th>
                <th>
                    电话
                </th>
                <th>
                    身份证号
                </th>
                <th class="hidden-xs">
                    院校
                </th>
                <th class="hidden-xs">
                    院系
                </th>
                <th class="hidden-xs">
                    操作
                </th>
            </tr>
            <% foreach (var item in Model)
               { %>
            <tr>
                <td>
                    <%: item.th_id %>
                </td>
                <td>
                    <%: item.th_name %>
                </td>
                <td>
                    <%if (item.th_role == 1)
                      {%>
                    系统管理员
                    <%}%>
                    <%else
                        { %>
                    普通教师
                    <%}%>
                </td>
                <td class="hidden-xs">
                    <%: item.th_title %>
                </td>
                <td>
                    <%: item.th_tel %>
                </td>
                <td>
                    <%: item.th_cid %>
                </td>
                <td class="hidden-xs">
                    <%: item.th_school %>
                </td>
                <td class="hidden-xs">
                    <%: item.department.dp_name %>
                </td>
                <td class="hidden-xs">
                    <a data-toggle="modal" class="btn btn-primary" style="height: 30px; padding: 2px 12px;" href="TeacherInfo/<%: item.th_id %>" data-target="#editmodal">
                        查看详情</a> <a data-toggle="modal" class="btn btn-primary" style="height: 30px; padding: 2px 12px; background-color: #666666;border-color: #666666;" href="Delete/<%: item.th_id %>" data-target="#delmodal">
                            删除</a>
                </td>
            </tr>
            <% } %>
        </table>
        <% }  %>
    </div>
    <%--信息详情--%>
    <div class="modal fade" id="editmodal" style=" max-height:800px;" tabindex="-1" role="dialog" aria-labelledby="editmodal">
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
