$(document).ready(function(){

	$("a").click(function(){ alert("cikc") });

	$(".user_info a[data-remote]")
		.bind("ajax:beforeSend", function(evt, xhr, settings){
			$(this).addClass("disabled").text("loading");
		})
		.bind("ajax:success", function(evt, data, status, xhr){
			$(this).text("done");
		})
		.bind("ajax:failure", function(evt, xhr, status, error){
			$(this).text("something went wrong");
		})
		.bind("ajax:complete", function(evt, xhr, status, error){
			$(this).removeClass("disabled");
		});
});