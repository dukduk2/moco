<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"><%@ include file="/resources/part/bootStrap.jspf" %>
<link rel="styleSheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/header.css">
<link rel="styleSheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/section.css">
<link rel="styleSheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/member.css">
<title>Insert title here</title>
<script type="text/javascript">
$(function(){
	var message = '${message}';

	if(message != ""){
		alert(message);
	}
	
	$("#bye").click(function(){
		window.close();
		/* session.invalidate(); */
	});

	/* $(window).resize(function (){
		var height_size = window.outerHeight;
		if (height_size >= 800) {
			alert('Curren width = 800px');
		}
	}).resize(); */
});

function resizeWin() {
    resizeTo('500', '200');
    focus();
}
</script>

<style type="text/css">
.button {
	width: 100%;
	height: 42px;
	float: right;
	margin-top: 10px;
	background-color: black;
	color: white;
	border-radius: 5px;
}
</style>

</head>
<body onload="resizeWin()">
	<div class="container">
		<p class="title">${message}</p>
		<input type="button" id="bye" class="button btn btn-primary" value="확인">
	</div>
</body>
</html>