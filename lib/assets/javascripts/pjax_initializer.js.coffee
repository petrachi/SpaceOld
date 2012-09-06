$(document).ready ->
	$('a:not([data-remote]):not([data-behavior]):not([data-skip-pjax])').pjax '[data-pjax-container]', {timeout: 2000}
	
	$('[data-pjax-container]')
		.on "pjax:start", ->
			$('#loading').show()
		.on "pjax:end", ->
			$('#loading').hide()
			$(".sign_up, .sign_in").hide()
			$("body").css "margin-top", $("#header").height() + 30
			$("[data-pjax-container]").addClass "pjax"