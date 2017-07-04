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
<script type="text/javascript">
	$(function(){
		$("#savebutton").click(function(){
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
	<h2>AgencyRequest</h2>
	<form action="./agencyRequest" method="post" id="frm" enctype="multipart/form-data">
		<div class="form-group">
			<label>TITLE :</label>
			<input type="text" name="title" class="form-control" placeholder="Enter Title">
		</div>
		<div class="form-group">
			<label>DIRECTOR :</label>
			<input type="text" name="director" value="${memberDTO.name }" readonly="readonly" class="form-control" placeholder="Enter Writer">
		</div>
		<div class="form-group">
			<label>PUBDATE :</label>
			<input type="date" name="pubdate" class="form-control" placeholder="Enter Title">
		</div>
		<div class="form-group">
			<label>CERTIFICATION :</label>
			<input type="file" name="f1" class="form-control">
		</div>

		<input type="button" value="AGENCY REQUEST" id="savebutton">
	</form>
	<a href="../"><button>HOME</button></a>
	</div>
	</section>
</body>
</html>