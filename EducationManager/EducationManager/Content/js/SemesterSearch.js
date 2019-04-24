//学期搜索功能
$(function () {
    $("#search").click(function () {
        var st = $("#st").val();
        $.ajax({
            type: "POST",
            url: "SearchInfo",
            data: {
                st: st
            },
            success: function (result) {
                $("#cts").html(result);
            }
        })
    })
})