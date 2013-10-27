$(function () {
    refresh();
});

function refresh() {
    refresh_notifications();
}

function refresh_notifications() {
    $("#notifications_loading").show();
    $.ajax_eval($("#notifications_table").attr("data-url"), "GET");
}