$(document).ready ->
	$(".user_info a[data-remote]")
		.bind "ajax:beforeSend", (evt, xhr, settings) ->
			$(this).addClass("disabled").text("loading");
		.bind "ajax:success", (evt, data, status, xhr) ->
			$(this).text("done");
		.bind "ajax:failure", (evt, xhr, status, error) ->
			$(this).text("something went wrong");
		.bind "ajax:complete", (evt, xhr, status, error) ->
			$(this).removeClass("disabled");
			
			
			