$(function () {
    refresh();

    $("#new_gmail_account_form").submit(function () {
        $("#create_gmail_account_loading").show();
    });
});

function refresh() {
    $("#gmail_accounts_loading").show();
    $.ajax_eval($("#gmail_accounts_table").attr("data-url"), "GET");
}