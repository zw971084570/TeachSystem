<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<EducationManager.Models.webInfo>" %>

<%@ Import Namespace="EducationManager.Models" %>
<%@ Import Namespace="EducationManager.Controllers" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="zh-CN" xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <% if (ViewData["list"] != null)
       {%>
    <meta name="description" content='<%:ViewData["desc"] %>'/>
    <meta name="keyword" content='<%:ViewData["key"] %>'/>
    <%} %>
    <title>教务管理系统</title>
    <link type="text/css" href="../../Content/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="../../Content/style/web.css" rel="stylesheet" type="text/css" /> 
</head>
<body>
    <!--手机导航栏-->
    <nav class="navbar navbar-inverse navbar-fixed-top" id="navtop">
    <div class=" container-fluid">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <%--<a class="navbar-brand" href="#">Project name</a>--%>
            <a class="navbar-brand" href="#"><img src="../../Content/images/logo.png" id="logo"  style="margin-top: -12px;"></a>
        </div>
        <div id="navbar" class="collapse navbar-collapse">
            <ul class="nav navbar-nav visible-sm visible-lg visible-md">
                <li ><a href="../EducationManager/Index">系统首页</a></li>
                <li><a href="../UserInfo/UserCenters" target="right">个人信息</a></li>
                <li><a href="../UserInfo/ChangePwd" target="right">修改密码</a></li>
            </ul>
            <ul class="nav navbar-nav pull-right visible-sm visible-lg visible-md">
             <li><a href="#" class="exit" >退出系统</a></li>
            </ul>
               <ul class="nav navbar-nav visible-xs">
               <%foreach (powers item in ViewData["pinfo"] as List<powers>)
                 {%>
                     <li ><a href="<%:item.menuInfo.mn_url %>" target="right"><%:item.menuInfo.mn_name %></a></li>
                 <%} %>
                 <li><a href="#" class="exit" >退出系统</a></li>
            </ul>
        </div>

    </div>
</nav>
    <div class="contents">
        <div id="left-menu" class="visible-sm visible-lg visible-md">
            <!--左侧导航栏-->
            <div class="mobile-nav visible-xs visible-lg visible-sm visible-md">
                <ul>
                    <%  foreach (menuInfo mi in (ViewData["minfo"] as List<menuInfo>))
                        {
                            List<int> pids=ViewData["pids"] as List<int>;
                            if (pids.Contains(mi.mn_id))
                            {%>
                               <li><a href="#collapse<%:mi.mn_id %>" data-toggle="collapse" class="menus">
                             <img src="../../Content/images/icon2.gif" width="23px" height="18px;"/>
                               <%:mi.mn_name%></a>
 
                            <%}
                            %>
                            <ul class="collapse cl" id="collapse<%:mi.mn_id %>">   
                       
                            <%foreach (powers i in ViewData["pinfo"] as List<powers>)
                            {
                                if (i.menuInfo.mn_pId == mi.mn_id)
                                {%>
                   
                        <li><a href="<%:i.menuInfo.mn_url %>" target="right" style="color: #ffffff; padding-left:15%;">
                            <%:i.menuInfo.mn_name%></a></li>
                   
                    <% } 
                   
               }%> </ul>
                    </li>
            <%}%>
                </ul>
            </div>
        </div>
        <div id="right-content" class="container-fluid">
        <br />
            <iframe name="right" width="100%" height="99.2%" frameborder="0"></iframe>
            <%if (ViewData["list"] != null)
              { %>
            <div style="width: 100%; text-align: center; height: 70px; line-height: 30px;" class="nav navbar-fixed-bottom">
                <span>版权所有&copy;
                    <%:ViewData["copy"]%></span> <span style="display: block;">地址：<%:ViewData["address"]%>&nbsp;&nbsp;&nbsp;&nbsp;
                        邮编：<%:ViewData["post"]%>&nbsp;&nbsp;&nbsp;&nbsp; 电话：<%:ViewData["tel"]%>&nbsp;&nbsp;&nbsp;&nbsp;</span>
            </div>
            <%} %>
        </div>
    </div>
    <script type="text/javascript" src="../../Content/bootstrap-3.3.7-dist/js/jquery-3.0.0.js"></script>
    <script type="text/javascript" src="../../Content/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
      <script type="text/javascript">
          $(function () {
              $(".exit").click(function () {
                  $.ajax({
                      type: "POST",
                      url: "../UserInfo/LoginOut",
                      success: function (result) {
                          window.location = "../UserInfo/LoginOn";
                      }
                  })
              })
          })
    </script>
</body>
</html>
