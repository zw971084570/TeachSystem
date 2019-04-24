<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<EducationManager.Models.InputScoreModel>" %>

<%@ Import Namespace="EducationManager.Models" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="zh-CN" xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <title>专业信息</title>
    <link type="text/css" href="../../Content/bootstrap-3.3.7-dist/css/bootstrap.min.css"
        rel="stylesheet" />
        <link type="text/css" href="../../Content/style/web.css" />

    <%--ajax实现局部刷新，前后台交互实现搜索查询功能--%>
    <script type="text/javascript" src="../../Content/js/SpecialtySearch.js"></script>
    <style type="text/css">
        #gd
        {
            width: auto;
            margin-left: 10px;
        }
        #dp
        {
            width: auto;
            margin-left: 10px;
        }
        .txt
        {
            width: 80px;
        }
        th
        {
            text-align: center;
        }
        .hidtxt{ border:none; width:80px;}
        .t{ width:50px; display:inline-block;}
    </style>
        <script type="text/javascript" src="/Content/bootstrap-3.3.7-dist/js/jquery-3.0.0.js"></script>
    <script type="text/javascript" src="/Content/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="/Content/js/InputInfo.js"></script>
        <%--统计总分数--%>
    <%--<script type="text/javascript">
        $(function () {
            $("#sc_endScore").blur(function () {
                $("#sc_sumScore").val("81");
            })
        })
    </script>s--%>
</head>
<body>
<br />
<br />
    <% using (Html.BeginForm())
       {%>
    <%: Html.ValidationSummary(true)%>

     期末成绩所占百分比: <%:Html.TextBoxFor(model => model.sc_poportion, new { @Value = "70", @class = "form-control t" })%><span style="font-size:20px;">%</span>
         <br />
        <br />
    <div id="cts">
        <table class="table table-hover" style="text-align: center">
        <caption style="font-size:20px;">成绩录入</caption>
            <tr>
                <th>
                    学号
                </th>
                <th>
                    姓名
                </th>
                <th>
                    平时成绩
                </th>
                <th>
                    期末成绩
                </th>
                <th>
                    总成绩
                </th>
                <th>
                    备注
                </th>
            </tr>
            <% 
                List<InputScoreModel> list = ViewData["ism"] as List<InputScoreModel>;
                if (list.Count() > 0)
                {
                    foreach (InputScoreModel item in list)
                    {%>
            <tr>
                <td>                
                <%:Html.TextBox("stu_num", item.stu_num.ToString(), new { @class="hidtxt",@ReadOnly=true})%>
                <%:Html.TextBox("cs_id", item.cs_id.ToString(), new { @class = "hidtxt", @Hidden = true })%>
                </td>
                <td>                
                <%:Html.TextBox(item.stu_name.ToString(), item.stu_name.ToString(), new { @class = "hidtxt", @ReadOnly = true })%>
                </td>
                <td>
                    <%:Html.TextBoxFor(model => model.sc_usuallyScore, new { @class = "txt" })%>
                    
                </td>
                <td>
                    <%:Html.TextBoxFor(model => model.sc_endScore, new { @class = "txt" })%>
                </td>
                <td>
                    <%:Html.TextBoxFor(model => model.sc_sumScore, new { @class = "txt",@ReadOnly=true })%>
                </td>
                <td>
                    <%:Html.TextBoxFor(model=>model.sc_remark,new{@class="txt"})%>
                </td>
            </tr>
            <%}%>
        </table>
        <% } %>
        <p style="text-align: right; margin-right: 100px; margin-top: 50px;">
            <input type="submit" class="btn btn-primary" id="aa" value="提交成绩" />
        </p>
    </div>
    <%}%>
    
</body>
</html>
