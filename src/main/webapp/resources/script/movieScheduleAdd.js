$(function() {
	var titleCheck = false;
	var dateCheck = false;
	
	$("#pnum").keyup(function(){
		var pnum = document.frm.pnum.value;

		$.post("paidMovieCheck1", {
			pnum: $("#pnum").val()
		}, function(data) {
			$("#title").val(data);

			if($("#title").val() == ""){
				titleCheck = false;
			} else {
				titleCheck = true;
			}
		})
	});

	$("#pnum").click(function(){
		var pnum = document.frm.pnum.value;

		$.post("paidMovieCheck1", {
			pnum: $("#pnum").val()
		}, function(data) {
			$("#title").val(data);

			if($("#title").val() == ""){
				titleCheck = false;
			} else {
				titleCheck = true;
			}
		})
	});

	$("#moviedate").focusout(function(){
		var moviedate = document.frm.moviedate.value;

		$.post("paidMovieCheck2", {
			moviedate: $("#moviedate").val()
		}, function(data) {
			data = data.trim();

		 	if(data != moviedate) {
				dateCheck = true;
			} else {
				dateCheck = false;
			} 
		})
	});

	$("#moviedate").mouseout(function(){
		var moviedate = document.frm.moviedate.value;

		$.post("paidMovieCheck2", {
			moviedate: $("#moviedate").val()
		}, function(data) {
			data = data.trim();

		 	if(data != moviedate) {
				dateCheck = true;
			} else {
				dateCheck = false;
			} 
		})
	});

	$("#frm").on("click", "#btn", function() {
		if(titleCheck == false){
			alert("번호를 다시 확인해주세요.");
		} else if(dateCheck == false){
			alert("날짜를 확인해 주세요.");
		} else {
			document.frm.submit("movieScheduleAdd");
		}
	});

	$("#back").click(function(){
		location.href="javascript:history.back()";
	});
});