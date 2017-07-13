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
</script>

<style type="text/css">
.button {
	width: 100px;
	margin: 0 auto;
}
</style>

</head>
<body>
	<div class="container">
		<h2 class="title">${message}</h2>
		<div class="button"><input type="button" id="bye" class="btn btn-primary" value="확인"></div>
	</div>
</body>
</html>