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
	$("#bye").click(function(){
		window.close();
	});
});
</script>

<style type="text/css">
body {
	padding-top: 30%;
}
</style>

<style type="text/css">
.button {
	width: 100px;
	margin: 0 auto;
}
</style>

</head>
<body>
	<div class="container">
		<h2 class="title">작업을 성공하였습니다.</h2>
		<div class="button"><input type="button" id="bye" class="btn btn-default" value="확인"></div>
	</div>
</body>
</html>