<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

<!-- jQuery library -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<!-- Latest compiled JavaScript -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script type="text/javascript">
	$(function(){
		$("#commit").click(function(){
			$("#frm").attr("action","./agencyCommit");
			$("#frm").submit();
			alert("승인 완료");
		});
		
		$("#cancel").click(function(){
			$("#frm").attr("action","./agencyCommitCancel");
			$("#frm").submit();
			alert("승인 취소");
		});
		
		$("#refuse").click(function(){
			$("#frm").attr("action","./agencyDelete");
			$("#frm").submit();
			alert("승인 거절");
		});
	});
</script>
<style type="text/css">
.contents-wrap{
	width:700px;
	margin:0 auto;
}
</style>
</head>
<body>
	<div class="contents-wrap">
	<h2>AGENCY VIEW</h2>
	
	<form action="" id="frm" method="post">
	<input type="hidden" name="num" value="${dto.num }">

	<h2>TITLE : ${dto.title }</h2>
	<h2>DIRECTOR : ${dto.director }</h2>
	<h2>PUBDATE : ${dto.pubdate }</h2>
	<h2>AGENCY CERTIFICATE : 
		<img alt="" src="../resources/upload/agency/${dto.fname }">
	</h2>
	<c:if test="${dto.commit eq 0 }">
		<input type="button" class="btn btn-info" id="commit" value="승인">
		<input type="button" class="btn btn-info" id="refuse" value="승인거절">
	</c:if>
	<c:if test="${dto.commit eq 1 }">
		<input type="button" class="btn btn-info" id="cancel" value="승인취소">
	</c:if>
	<a href="./agencyList" class="btn btn-info">LIST</a>
	</form>

	</div>
</body>
</html>