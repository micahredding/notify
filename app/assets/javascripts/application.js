// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap


// allows to load modal multiple times
$(function () {
    $("body").on("click", ".modal-link", function (event) {
        event.preventDefault();
        $targetModal = $($(this).attr('data-target'));
        $targetModal.removeData("modal");
        $targetModal.modal({remote: $(this).attr("href")});
    });
});

// add loaded event to modal https://github.com/twbs/bootstrap/pull/6846
(function () {
    $.fn.jqueryLoad = $.fn.load;

    $.fn.load = function (url, params, callback) {
        var $this = $(this);
        var cb = $.isFunction(params) ? params : callback || $.noop;
        var wrapped = function (responseText, textStatus, XMLHttpRequest) {
            cb(responseText, textStatus, XMLHttpRequest);
            $this.trigger('loaded');
        };

        if ($.isFunction(params)) {
            params = wrapped;
        } else {
            callback = wrapped;
        }

        $this.jqueryLoad(url, params, callback);

        return this;
    };
})();

$.fn.exists = function () {
    return this.length !== 0;
};

// Regex escape
RegExp.escape = function (text) {
    return text.replace(/[-[\]{}()*+?.,\\^$|#\s]/g, "\\$&");
};

$.ajax_eval = function (url, method, data) {
    $.ajax({
        type: method,
        url: url,
        data: data,
        dataType: "script"
    });
};