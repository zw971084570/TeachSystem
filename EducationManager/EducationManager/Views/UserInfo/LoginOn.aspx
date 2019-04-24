<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<EducationManager.Models.teacherLoginModel>" %>
<%@ Import Namespace="EducationManager.Models" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>教务管理系统--登录</title>
<link href="../../Content/style/style.css" rel="stylesheet" type="text/css" media="all" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
    <link type="text/css" href="../../Content/bootstrap-3.3.7-dist/css/bootstrap.min.css"
        rel="stylesheet" />
<script type="text/javascript" src="../../Content/js/jquery.min.js"></script>
<script type="text/javascript">
    $(function () {
        //用户名部分
        $("#th_id").val("请输入账号");
        $("#th_id").focus(function () {
            if ($(this).val() == "请输入账号") {
                $(this).val("");
            }
        })
        $("#th_id").blur(function () {
            if ($(this).val() == "") {
                this.value = '请输入账号';
            }
        })

        //密码部分
        $("#th_password").val("请输入密码");
        $("#th_password").focus(function () {
            if ($(this).val() == "请输入密码") {
                $(this).val("");
            }
        })
        $("#th_password").blur(function () {
            if ($(this).val() == "") {
                this.value = '请输入密码';
            }
        })
    })
</script>
<style type="text/css">
.sel
{
    font-family: 'Droid Sans', sans-serif;
    width: 94%;
    padding: 0.5em 2em 0.5em 1em;
    color: #B8B8B8;
    font-size: 20px;
    outline: none;
    background: none;
    border: none;
    appearance:none;
    -moz-appearance:none;/*??Firefox?*/
    -webkit-appearance:none;/*??Safari?和?Chrome?*/
}
</style>
</head>
<body>

<!-- contact-form -->	
<div class="message warning">
<div class="inset">
	<div class="login-head">
		<h1>教务管理系统登录</h1>		
	</div>

          <% using (Html.BeginForm())
             {%>
        <%: Html.ValidationSummary(true)%>
        <ul>
          <li style=" background-color:White;">
          
             <select name="th_role" class="sel" style="-ms-expand { display: none; }  ">
             <option value="1">系统管理员</option>
             <option value="2">教师</option>
             <option value="3">学生</option>
             </select><a href="#" class="glyphicon glyphicon glyphicon-triangle-bottom"></a>                
			</li>
            
			<li>            
            <%:Html.TextBoxFor(model=>model.th_id) %>
            <%: Html.ValidationMessageFor(model => model.th_id)%><a href="#" class=" icon user"></a>
			</li>
			<li>
            <%:Html.PasswordFor(model=>model.th_password) %>              
                <%: Html.ValidationMessageFor(model => model.th_password)%><a href="#" class="icon lock"></a>
			</li>
            </ul>
			<div class="clear"> </div>
			<div class="submit">
                  <input type="submit" value="登录" />
						  <div class="clear">  </div>	
			</div>
				<% }%>
		</div>					
	</div>
	<div class="clear"> </div>
<!--- footer --->
<div style="width: 100%; text-align: center; height: 100px; line-height: 40px; position:absolute; bottom:76px; color:White;" class="nav navbar-fixed-bottom">
<%if (ViewData["copys"] != null)
  {
      List<webInfo> wi = ViewData["copys"] as List<webInfo>;
      if (wi.Count() > 0)
      {
      %>
    版权所有：<%:wi.First().web_copyright%> <br />
    地址：<%:wi.First().web_address%>
    邮编：<%:wi.First().web_postcode%>
    电话：<%:wi.First().web_tel%>
<%}
  }%>
</div>
</body>
</html>



