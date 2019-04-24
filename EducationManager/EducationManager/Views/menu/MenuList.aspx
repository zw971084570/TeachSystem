<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<IEnumerable<EducationManager.Models.menuInfo>>" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html lang="zh-CN" xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <title>功能管理</title>
    <meta name="description" content="你的描述内容">
    <meta name="keyword" content="关键字1，关键字2">
    <link type="text/css" href="../../Content/bootstrap-3.3.7-dist/css/bootstrap.min.css"
        rel="stylesheet" />
    <link href="../../Content/style/web.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../../Content/bootstrap-3.3.7-dist/js/jquery-3.0.0.js"></script>
    <script type="text/javascript" src="../../Content/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    <%--ajax实现局部刷新，前后台交互实现搜索查询功能--%>
    <script type="text/javascript" src="../../Content/js/MenuSearch.js"></script>
</head>
<body>
<div style="padding-top:20px;">
    <div class="container-fluid hidden-xs" style="line-height:40px; text-align:right; float:right;">
        <%--添加--%>
        <a data-toggle="modal" href="AddInfo" class="btn btn-primary" data-target="#modal" >增加菜单</a>        
   </div>
   <div class="modal fade" id="modal" tabindex="-1" role="dialog" aria-labelledby="modal">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <%--此处用来显示添加页面的内容--%>
                </div>
            </div>
        </div>
     <div class="input-group" style=" float:left;">    
        <input type="text" class="form-control txt" id="searchName" style="width: auto" placeholder="请输入菜单名称">&nbsp;&nbsp;
        <span class="input-group-addon" style="width: auto; border: 1px solid rgb(204, 204, 204);
            border-radius: 4px;" id="search"><span class="glyphicon glyphicon-search"></span>
        </span>
    </div> 
     </div>
     <br />
     <br />
    <div id="cts">
    <%--查询--%>
    <table class="table table-hover tb">
    <caption>菜单信息</caption>
            <tr>
                <th>
                    编号
                </th>
                <th>
                    菜单名称
                </th>
                <th>
                    菜单级别
                </th>
                <th class="hidden-xs">
                    链接地址
                </th>
                <th class="hidden-xs">
                    备注
                </th>
                <th class="hidden-xs">
                    操作
                </th>
            </tr>
        <%if (Model != null)
          { %>
        
            <% foreach (var item in Model)
               { %>
            <tr>
                <td>
                    <%: item.mn_id%>
                </td>
                <td>
                    <%: item.mn_name%>
                </td>
               <td>
               <%if (item.mn_pId == null)
                 { %>
               一级菜单
               <%}
                 else
                 { %>
                 二级菜单
               <%} %>
                </td>
                <td class="hidden-xs">
                    <%: item.mn_url%>
                </td>
                <td class="hidden-xs">
                    <%: item.mn_remark%>
                </td>
                <td class="hidden-xs">
                    <a data-toggle="modal" class="btn btn-primary" style=" height:30px; padding:2px 12px;" href="MenuInfo/<%: item.mn_id %>" data-target="#editmodal">
                        查看详情</a> <a data-toggle="modal" class="btn btn-primary" style=" height:30px; padding:2px 12px;background-color:#666666; border-color:#666666;" href="Delete/<%: item.mn_id %>" data-target="#delmodal">
                            删除</a>
                </td>
            </tr>
            <% } %>
        
        <% }
          else { %>
          <td colspan="6" style="text-align:center;color:Red;font-size:22px;">空空如也~~~~</td>
          <%} %>
        </table>
      <div style=" height:100px;"></div>
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
