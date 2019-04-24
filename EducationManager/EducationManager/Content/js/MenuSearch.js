//搜索功能
//$(function () {
//    $("#search").click(function () {
//        var name = $("#searchName").val(); //功能名称                 
//        $.ajax({
//            type: "POST",
//            url: "SearchInfo",
//            data: {
//                name: name
//            },
//            success: function (result) {
//                $("#cts").html(result);
//            }
//        })
//    })
//})
$(function () {
    $("#search").click(function () {
        var name = $("#searchName").val(); //功能名称                 
        $.ajax({
            type: "POST",
            url: "SearchInfo1",
            data: {
                name: name
            },
            success: function (result) {
                var data = eval(result);
                var len = data.length;
                var cm = "";
                cm = "<caption>菜单信息</caption>  <tr><th>编号</th><th>菜单名称</th><th>菜单级别</th><th class='hidden-xs'>链接地址</th><th class='hidden-xs'>备注</th><th class='hidden-xs'>操作</th></tr>";
                if (len > 0) {
                    for (var i = 0; i < len; i++) {

                        cm += '<tr><td>' + data[i]["mn_id"] + '</td>';
                        cm += '<td>' + data[i]["mn_name"] + '</td>';
                        var menu = "一级菜单";
                        if (data[i]["mn_pId"] != null) {
                            menu = "二级菜单";
                        }
                        cm += '<td>' + menu + '</td>';
                        var murl = "";
                        if (data[i]["mn_url"] != null) {
                            murl = data[i]["mn_url"];
                        }
                        cm += '<td>' + murl + '</td>';
                        var mremark = "";
                        if (data[i]["mn_remark"] != null) {
                            mremark = data[i]["mn_remark"];
                        }
                        cm += '<td>' + mremark + '</td>';
                        cm += '<td class="hidden-xs"><a data-toggle="modal" class="btn btn-primary" style=" height:30px; padding:2px 12px;" href="MenuInfo/' + data[i]["mn_id"] + '" data-target="#editmodal">'
                        + '查看详情</a> <a data-toggle="modal" class="btn btn-primary" style=" height:30px; padding:2px 12px;background-color:#666666; border-color:#666666;" href="Delete/' + data[i]["mn_id"] + '" '
                        + 'data-target="#delmodal"> 删除</a></td></tr>';
                        console.log(cm);
                        $(".tb").html(cm);
                    }
                }
                else {
                    cm += "<tr><td colspan='6' style='color:red;font-size:24px;'>没有符合条件的内容！</td></td>";
                    console.log(cm);
                    $(".tb").html(cm);
                }
            }
        })
    })
})
//添加功能：父菜单如果没有选择，设置链接文本框不可用
  $(function () {
            var fc = $("#fc").val();
            if (fc == "") {
                $('#fc_url').attr("disabled", "disabled");
            }
            $("#fc").change(function () {
                fc = $("#fc").val();
                if (fc != "") {

                    $('#fc_url').removeAttr("disabled");
                }
                else {
                    $('#fc_url').attr("disabled", "disabled");
                }
            })
        })