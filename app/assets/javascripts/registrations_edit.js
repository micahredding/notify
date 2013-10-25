$(function () {
    refresh();

    $("#new_gmail_account_form").submit(function () {
        $("#create_gmail_account_loading").show();
    });
});

function refresh_gmail_accounts() {
    $("#gmail_accounts_loading").show();
    $.ajax_eval($("#gmail_accounts_table").attr("data-url"), "GET");
}

function refresh_email_filters() {
    $("#email_filters_loading").show();
    $.ajax_eval($("#email_filters_table").attr("data-url"), "GET");
}

function refresh() {
    refresh_gmail_accounts();
    refresh_email_filters();
}