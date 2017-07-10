<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<!DOCTYPE html PUBLIC>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/resources/part/bootStrap.jspf" %>
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.js"></script>
<link rel="styleSheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/header.css">
<link rel="styleSheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/section.css"><title>Insert title here</title>
<style type="text/css">
.contents-wrap{
	width:700px;
	margin:0 auto;
}
</style>
</head>
<body>
	<%@ include file="/resources/part/header2.jspf" %>
	<section>
		<div class="contents-wrap">
		<h2>NOTICE VIEW</h2>
		<h2>TITLE : ${dto.title }</h2>
		<h2>WRITER : ${dto.writer }</h2>
		<h2>CONTENTS : ${dto.contents }</h2>
		<h2>DATE : ${dto.reg_date }</h2>
		<h2>HIT : ${dto.hit }</h2>
		
		<c:if test="${memberDTO.id eq 'admin'}">
		<a class="btn btn-info" href="./noticeUpdate?num=${dto.num }">UPDATE</a>
		<a class="btn btn-info" href="./noticeDelete?num=${dto.num }">DELETE</a>
		</c:if>
		
		<a class="btn btn-info" href="../">LIST</a>
		
		</div>
	</section>
</body>
</html>