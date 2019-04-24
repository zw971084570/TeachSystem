//学生搜索功能
$(function () {
    $("#search").click(function () {
        var num = $("#searchNum").val();
        var name = $("#searchName").val();
        var cid = $("#cid").val();
        var cl = $("#cl").val();
        $.ajax({
            type: "POST",
            url: "SearchInfo",
            data: {
                num: num,
                name: name,
                cid: cid,
                cl: cl
            },
            success: function (result) {
                $("#cts").html(result);
            }
        })
    })
})