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
	});
});
</script>

</head>
<body>
	<div class="container">
		<h2 class="title">${message}</h2>
		<input type="button" id="bye" value="확인">
	</div>
</body>
</html>