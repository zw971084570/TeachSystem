$(function () {
    $("table tr").focusout(function () {
        var a = $(this).children().eq(2).find('input').val();
        var b = $(this).children().eq(3).find('input').val();
        var c = $(this).children().eq(4).find('input').val();
        if (a != "" && a != undefined && b != null && b != "" && b != null && b != undefined) {
            var d = $("#sc_poportion").val();
            var e = Math.round(a * (1 - (d / 100)) + b * (d / 100));
            var f = $(this).children().eq(4).find('input').val(e);
        }
    })
})