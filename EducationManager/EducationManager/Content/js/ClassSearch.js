//班级搜索功能
$(function () {

    $("#search").click(function () {
        var name = $("#searchName").val(); //班级名称
        var dp = $("#dp").val(); //院系
        var gd = $("#gd").val(); //年级
        var sp = $("#sp").val(); //专业
        var searchRoomName = $("#searchRoomName").val(); //教室名称                
        $.ajax({
            type: "POST",
            url: "SearchInfo",
            data: {
                name: name,
                dp: dp,
                sp: sp,
                gd: gd,
                searchRoomName: searchRoomName

            },
            success: function (result) {
                $("#cts").html(result);
            }
        })
    })
})