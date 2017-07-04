<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/resources/part/bootStrap.jspf" %>
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.js"></script>
<link rel="styleSheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/header.css">
<link rel="styleSheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/section.css">
<title>Insert title here</title>

<script type="text/javascript">
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
</script>

</head>
<body>
	<%@ include file="/resources/part/header1.jspf" %>
	
	<section>
	<h2>Movie Add</h2>
	<form action="movieScheduleAdd" name="frm" id="frm" method="POST">
		<table class="table table-hover" style="width: 300px">
			<tr>
				<td>MOVIE NUM SEARCH:<input type="number" min="1" class="form-control" name="pnum" id="pnum" required="required">
			</tr>

			<tr>
				<td>MOVIE TITLE:<input type="text" class="form-control" name="title" id="title" required="required" readonly="readonly">
			</tr>

			<tr>
				<td>MOVIE DATE:<input type="date" class="form-control" name="moviedate" id="moviedate" required="required">
			</tr>
		</table>
		<input type="button" id="btn" class="btn btn-success" value="등록">
		<input type="button" class="btn btn-success" id="back" value="BACK">
	</form>
	</section>
	
	<%@ include file="/resources/part/footer.jspf" %>
</body>
</html>