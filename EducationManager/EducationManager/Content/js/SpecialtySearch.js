//专业搜索功能
$(function () {

    $("#search").click(function () {
        var name = $("#searchName").val();
        var dp = $("#dp").val();
        var gd = $("#gd").val();
        $.ajax({
            type: "POST",
            url: "SearchInfo",
            data: {
                name: name,
                dp: dp,
                gd: gd
            },
            success: function (result) {
                $("#cts").html(result);
            }
        })
    })
})