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
table{
	width:800px;
	font-size: 20px;
	text-align: center;
}
th{
	width: 300px;
	height: 70px;
	text-align: center;
	border-right: 2px solid #ccc;
	border-bottom: 2px solid #ccc; 
}
td{
	border-bottom: 2px solid #ccc; 
}
.img_td{
	height: 500px;
	border-bottom: none;
}
.img_th{
	border-bottom: none;
}
</style>
</head>
<body>
	<%@ include file="/resources/part/header2.jspf" %>
	<section>
	<div class="contents-wrap">
		<table class="table-responsive">
			<tr>
				<th>TITLE</th><td>${dto.title }</td>
			</tr>
			<tr>
				<th>DIRECTOR</th><td>${dto.director }</td>
			</tr>
			<tr>
				<th>PUBDATE</th><td>${dto.pubdate }</td>
			</tr>
			<tr>
				<th class="img_th">CERTIFICATE</th><td class="img_td"><img alt="" src="../../resources/upload/agency/${dto.fname }" width="500"></td>
			</tr>

		
		</table>
		<%-- <h2>MY AGENCY REQUEST</h2>
		<h2>TITLE : ${dto.title }</h2>
		<h2>DIRECTOR : ${dto.director }</h2>
		<h2>PUBDATE : ${dto.pubdate }</h2>
		<h2>AGENCY CERTIFICATE : 
			<img alt="" src="../../resources/upload/agency/${dto.fname }">
		</h2> --%>

		<a href="./agencyList"><button class="btn btn-default"><span class="titleSpan">LIST</span></button></a>
		<a href="./agencyUpdate?num=${dto.num }"><button class="btn btn-default"><span class="titleSpan">수정</span></button></a>
		<a href="./agencyDelete?num=${dto.num }"><button class="btn btn-default"><span class="titleSpan">삭제</span></button></a>
	</div>
	</section>
</body>
</html>