$(document).ready ->
	$('a:not([data-remote]):not([data-behavior]):not([data-skip-pjax])').pjax '[data-pjax-container]'
	
	$('[data-pjax-container]')
		.on "pjax:start", ->
			$('#loading').show()
		.on "pjax:end", ->
			$('#loading').hide()
			$(".notice").text $("#notice").text()
			$(".alert").text $("#alert").text()
			$(".sign_up, .sign_in").hide()