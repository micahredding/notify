$(function () {
    refresh();

    $("#notifications_table").on("click", ".email_link", function () {
        window.open($(this).parent().attr("data-url"), '_blank');
    });
});

function refresh() {
    refresh_notifications();
}

function refresh_notifications() {
    $("#notifications_loading").show();
    $.ajax_eval($("#notifications_table").attr("data-url"), "GET");
}