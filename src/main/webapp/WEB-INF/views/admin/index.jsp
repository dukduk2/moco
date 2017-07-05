<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
		
	});
</script>
<style type="text/css">
	
</style>
</head>
<body>
	<%@ include file="/resources/part/adminHeader.jspf" %>
	
	<section>
	<br>
	<p><a href="./movieUpload">Movie Upload</a></p>
	<p><a href="./movieScheduleList">movieScheduleList</a></p>
	<p>
		<a href="./userBoardCommit">userBoard Commit</a>&nbsp;
			<span class="badge">${userBoardCommitCount}</span>			
	</p>
	<p><a href="./adminSeason">SEASON</a></p>
	<p>
		<a href="./agencyList">Agency</a>
		<span class="badge">${agencyCommitCount}</span>
	</p>
	<p>
		<a href="./memberList">memberList</a>&nbsp;
		<span class="badge">${memberStateCount}</span>
	</p>
	<p>
		<a href="./movieRequestList">MovieRequest</a>
		<span class="badge">${movieRequest}</span>
	</p>
	<p><a href="../">HOME</a></p>
	</section>
</body>
</html>