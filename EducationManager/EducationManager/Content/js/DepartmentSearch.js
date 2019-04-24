//院系搜索功能
$(function () {

    $("#search").click(function () {
        var name = $("#searchName").val();
        var type = $("#searchType").val();
        $.ajax({
            type: "POST",
            url: "SearchInfo",
            data: {
                name: name,
                type: type
            },
            success: function (result) {
                $("#cts").html(result);
            }
        })
    })
})