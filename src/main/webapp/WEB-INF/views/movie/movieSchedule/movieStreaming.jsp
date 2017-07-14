<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ROOT" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/resources/part/bootStrap.jspf" %>
<link rel="styleSheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/header.css">
<link rel="styleSheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/section.css">
<link rel="styleSheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/list.css">
<title>Insert title here</title>
<script type="text/javascript">
	$(function() {
		
	});
</script>
<style type="text/css">
	.video{
		width: 100%;
		height: 600px;
	}
</style>
</head>
<body>
	<div class="container">
		<h2 style="text-align: center;">${title}</h2>
			<div>
				<video autoplay="autoplay"  class="video" preload="metadata">
					<source src="${ROOT}/resources/upload/adminMovieUpload/${fname}" type="video/mp4">
				</video>
			</div>	
	</div>
	
</body>
</html>