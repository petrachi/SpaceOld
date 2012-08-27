function jsMergeForm(form, action){
	var mergeZone = $("#js-merge-form", form)
	
	function showId(id){
		mergeZone.children().hide(0);
		$(id, mergeZone).show(0);
	};
	
	function addLoading(){
		mergeZone.addClass("disabled");
	};
	
	function removeLoading(){
		mergeZone.removeClass("disabled");
	};
	
	function fillErrors(errors){
		$("#merge-errors-list", mergeZone).html(errors);
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
		// showId("#merge-loading");
		
		addLoading();
		
		$.get(action + "_errors", $(form).serialize(), function(data){
			removeLoading();
			
			if( data.length ){
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
		
		$.get(action, $(form).serialize(), function(data){
			removeLoading();
			
			
			if( data == "valid-merge" ){
				clearTimeout(interval);
				alert("youpi");
				
				//window.location="<%= action_redirect %>";
				
			}else if( data == "bug-merge"){
				showId("#merge-bug");
				restartInterval();
			}else{
				fillErrors(data);
				showId("#merge-errors");
				
				restartInterval();
			};
		});
	});
}
