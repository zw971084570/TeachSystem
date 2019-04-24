//课程搜索功能
$(function () {
    $("#search").click(function () {
        var name = $("#searchName").val();
        var st = $("#st").val();
        $.ajax({
            type: "POST",
            url: "SearchInfo",
            data: {
                name: name,
                st: st
            },
            success: function (result) {
                $("#cts").html(result);
            }
        })
    })
})