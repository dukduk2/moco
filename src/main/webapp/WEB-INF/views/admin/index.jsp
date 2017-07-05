<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript">
	$(function() {
		
	});
</script>
<style type="text/css">
	
</style>
</head>
<body>
	<h2>Admin Index</h2>
	<br>
	<p><a href="./movieUpload">Movie Upload</a></p>
	<p><a href="./movieScheduleList">movieScheduleList</a></p>
	<p>
		<a href="./userBoardCommit">userBoard Commit</a>&nbsp;
		<c:if test="${userBoardCommitCount != null}">
			<span class="badge">${userBoardCommitCount}</span>			
		</c:if>
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
	
</body>
</html>