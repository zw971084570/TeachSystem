//班级搜索功能
$(function () {
    $("#search").click(function () {
        var name = $("#searchName").val();
        $.ajax({
            type: "POST",
            url: "SearchInfo",
            data: {
                name: name
            },
            success: function (result) {
                $("#cts").html(result);
            }
        })
    })
})