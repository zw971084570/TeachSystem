//教师搜索功能
$(function () {

    $("#search").click(function () {
        var id = $("#searchID").val();
        var name = $("#searchName").val();
        var cid = $("#cid").val();
        var title = $("#searchTitle").val();
        $.ajax({
            type: "POST",
            url: "SearchInfo",
            data: {
                id: id,
                name: name,
                cid: cid,
                title: title
            },
            success: function (result) {
                $("#cts").html(result);
            }
        })
    })
})