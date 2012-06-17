//= require jquery
//= require jquery_ujs
//= require_self
//= require_tree .

function load_date_pickers() {
    $('.date_picker').each(function() {
       if($(this).is(":visible"))
            $(this).datepicker({ dateFormat: 'yy-mm-dd', showOn : 'focus', constrainInput : true });
    });
	$('#ui-datepicker-div').css('clip', 'auto');
}

function CSRFProtection(xhr) {
    var token = $('meta[name="csrf-token"]').attr('content');
    if (token) xhr.setRequestHeader('X-CSRF-Token', token);
};

function ajax_headers() {
	if ('ajaxPrefilter' in $) $.ajaxPrefilter(function(options, originalOptions, xhr){ CSRFProtection(xhr) });
	else $(document).ajaxSend(function(e, xhr){ CSRFProtection(xhr) });
};

$(function () {
	ajax_headers();
	load_date_pickers();
});