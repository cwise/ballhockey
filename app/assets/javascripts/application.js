//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require twitter/bootstrap
//= require_self
//= require_tree .

function load_date_pickers() {
    $('.datepicker').each(function() {
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
	
	$('.icon-clickable').tooltip();
  $('.icon-clickable').click( function() {
    var newValue = $(this).attr('data-original-title');
    
    $(this).addClass('selected');
    $(this).siblings().removeClass('selected');
    $(this).parent().children('input').val(newValue);
  });	
});

