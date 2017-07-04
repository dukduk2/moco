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
<style type="text/css">
.rank {
	width: 70%;
	height: 600px;
	border: solid blue 2px;
	margin: 0 auto;
	margin-top: -50px;
	font-size: 30px;
	font-weight: bold;
}

.sub {
	width: 45%;
	height: 400px;
	margin: 20px 0;
	font-size: 30px;
	font-weight: bold;
}

.left{
	margin-left: 4%;
	border: solid red 2px;
	float: left;
}

.right {
	margin-right: 4%;
	border: solid green 2px;
	float: right;
}
</style>
</head>
<body>
	<%@ include file="/resources/part/header2.jspf" %>
	<section>
		<div class="rank">랭크</div>
		
		<div class="sub left">sub1</div>
		<div class="sub right">sub2</div>
	</section>
</body>
</html>