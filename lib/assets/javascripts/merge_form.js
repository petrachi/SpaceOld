function jsMergeForm(form, action, url_redirect){
	var mergeZone = $("#js-merge-form", form)
	
	function showId(id){
		mergeZone.children().hide(0);
		$(id, mergeZone).show(0);
	};
	
	function addLoading(){
		mergeZone.addClass("disabled");		
	};
	
	function removeLoading(){
		$(".errors", form).hide(0);
		mergeZone.removeClass("disabled");
	};
	
	function fillErrors(errors){		
		$.each(errors, function(index, field_name){
		    $("." + field_name + " .errors", form).show(0)
		});
	};
	
	function restartInterval(delay){
		if(!delay){
			timeInerval = baseTimeinterval;
		}else if(delay < 101){
			timeInerval *= delay;
		}else{
			timeInerval += delay;
		};
		
		clearTimeout(interval);
		interval = setTimeout(checkErrors, timeInerval);
	};
	
	function checkErrors(){
		addLoading();
		
		$.get(action, $(form).serialize() + "&wish=errors", function(data){
			removeLoading();
			
			if( !$.isEmptyObject(data) ){
				fillErrors(data);
				showId("#merge-errors");
				
				restartInterval(1.7);
			}else{
				showId("#merge-validate");
			};
		});
	};
	
	var timeInerval = 5000;
	var baseTimeinterval = timeInerval;
	var interval = setTimeout(checkErrors, timeInerval);
	
	checkErrors();
	
	$("input", form).bind("input", function(){
		restartInterval();
	});
	
	$(".merge-button", "#merge-init, #merge-errors, #merge-bug", mergeZone).click(function(){
		timeInerval = baseTimeinterval
		checkErrors();
	});
	
	$("#merge-validate .merge-button", mergeZone).click(function(){
		clearTimeout(interval);
		showId("#merge-save");
	});
	
	$("#merge-save .merge-button", mergeZone).click(function(){
		addLoading();
		clearTimeout(interval);
		
		
		$.ajax({
		    url: action,
			data: $(form).serialize() + "&wish=validate",
		    type: 'GET',
		    error: function(data) {
				removeLoading();
		        showId("#merge-bug");
		    }
		});
		
		
	});
}
