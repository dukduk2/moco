<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
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
	$(function(){
		$("#update").click(function(){
			$("#frm").submit();
		});
	});
</script>
<style type="text/css">
	.contents-wrap{
	width:1000px;
	margin:0 auto;
	}
</style>
</head>
<body>
	<%@ include file="/resources/part/header2.jspf" %>
	<section>
	<div class="contents-wrap">
	<h2>ActorPR UPDATE</h2>
	<form action="./agencyUpdate" method="post" id="frm" enctype="multipart/form-data">
		<input type="hidden" name="num" value="${dto.num }">
		
		<div class="form-group">
			<label>TITLE :</label>
			<input type="text" name="title" class="form-control" value="${dto.title }">
		</div>
		<div class="form-group">
			<label>DIRECTOR :</label>
			<input type="text" name="director" class="form-control" value="${dto.director }" readonly="readonly">
		</div>
		
		<div class="form-group">
			<label>PUBDATE :</label>
			<input type="date" name="pubdate" class="form-control" value="${dto.pubdate }">
		</div>
	
		<div class="form-group">
			<label>CERTIFICATION :</label>
			<input type="file" name="f1" value="${dto.oname }">
		</div>

		<input type="button" value="UPDATE" id="update">
	</form>
	</div>
	</section>
</body>
</html>