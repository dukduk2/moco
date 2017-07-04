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
<style type="text/css">
.contents-wrap {
	width: 1000px;
	margin: 0 auto;
}
</style>
</head>
<body>
	<%@ include file="/resources/part/header2.jspf" %>
	<section>
	<div class="contents-wrap">
		<h2>MY AGENCY REQUEST</h2>
		<h2>TITLE : ${dto.title }</h2>
		<h2>DIRECTOR : ${dto.director }</h2>
		<h2>PUBDATE : ${dto.pubdate }</h2>
		<h2>AGENCY CERTIFICATE : 
			<img alt="" src="../../resources/upload/agency/${dto.fname }">
		</h2>

		<a href="./agencyList" class="btn btn-info">LIST</a>
		<a href="./agencyUpdate?num=${dto.num }" class="btn btn-info">수정</a>
		<a href="./agencyDelete?num=${dto.num }" class="btn btn-info">삭제</a>
	</div>
	</section>
</body>
</html>