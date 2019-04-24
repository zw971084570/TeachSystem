<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<IEnumerable<EducationManager.Models.student>>" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="zh-CN" xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <title>学生列表</title>
    <link type="text/css" href="../../Content/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="../../Content/style/web.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../../Content/bootstrap-3.3.7-dist/js/jquery-3.0.0.js"></script>
    <script type="text/javascript" src="../../Content/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    <%--ajax实现局部刷新，前后台交互实现搜索查询功能--%>
    <script type="text/javascript" src="../../Content/js/StudentSearch.js"></script>
    <style type="text/css">
        #cl
        {
            width: auto;
            margin-left: 10px;
        }
    </style>
</head>
<body>
<div style=" margin-bottom:20px; padding-top:20px;">
   <div class="container-fluid hidden-xs" style="line-height:40px; text-align:right; float:right;">
        <%--添加--%>
        <a data-toggle="modal" href="AddInfo" class="btn btn-primary" data-target="#modal" >增加学生</a>      
        <a data-toggle="modal" href="AddInfos" class="btn btn-primary" data-target="#modal" >批量导入</a>
   </div>
     <div class="modal fade" id="modal" tabindex="-1" role="dialog" aria-labelledby="modal" style="max-height:780px;">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <%--此处用来显示添加页面的内容--%>
                </div>
            </div>
        </div>
 <div class="input-group">
        <input type="text" class="form-control txt" id="searchNum" style="width: auto" placeholder="请输入学号">&nbsp;&nbsp;
        <input type="text" class="form-control txt hidden-xs" id="searchName" style="width: auto" placeholder="请输入学生姓名">
        <input type="text" class="form-control txt hidden-xs" id="cid" style="width: auto" placeholder="请输入身份证号">
        <%:Html.DropDownList("cl", ViewData["cl"] as IEnumerable<SelectListItem>, "--请选择班级--", new { @class = "form-control hidden-xs" })%>
        <span class="input-group-addon" style="width: auto; border: 1px solid rgb(204, 204, 204);
            border-radius: 4px;" id="search"><span class="glyphicon glyphicon-search"></span>
        </span>
    </div>
     </div>
    <div id="cts">
            <%if (Model != null)
              { %>
                <table class="table table-hover">
    <caption>学生信息</caption> 
            <tr>
                <th>
                    学号
                </th>
                <th>
                    姓名
                </th>               
                <th class="hidden-xs">
                    身份证号
                </th>
                <th>
                    电话
                </th>
                <th>
                    班级
                </th>
                <th class="hidden-xs">
                    入学日期
                </th>
                <th class="hidden-xs">
                    所在高中
                </th>
                <th class="hidden-xs">
                    操作
                </th>
            </tr>
            <% foreach (var item in Model)
               { %>
            <tr>
                <td>
                    <%: item.stu_num %>
                </td>
                <td>
                    <%: item.stu_name %>
                </td>               
                <td class="hidden-xs">
                    <%: item.stu_cid %>
                </td>
                <td>
                    <%: item.stu_tel %>
                </td>
                <td>
                    <%: item.classes.cl_name %>
                </td>
                <td class="hidden-xs">
                    <%: String.Format("{0:g}", item.stu_joinTime) %>
                </td>
                <td class="hidden-xs">
                    <%: item.stu_highSchool %>
                </td>
                <td class="hidden-xs">
                    <a data-toggle="modal" class="btn btn-primary" style="height: 30px; padding: 2px 12px;" href="StudentInfo/<%: item.stu_num %>" data-target="#editmodal">
                        查看详情</a> <a data-toggle="modal" class="btn btn-primary" style="height: 30px; padding: 2px 12px; background-color: #666666;border-color: #666666;" href="Delete/<%: item.stu_num %>" data-target="#delmodal">
                            删除</a>
                </td>
            </tr>
            <% } %>
        </table>
        <% }  %>
    
    </div>
    <%--信息详情--%>
    <div class="modal fade" id="editmodal" tabindex="-1" role="dialog" aria-labelledby="editmodal" style=" max-height:780px;">
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
