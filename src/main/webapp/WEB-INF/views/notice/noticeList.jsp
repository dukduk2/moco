<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/resources/part/bootStrap.jspf" %>
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.js"></script>
<link rel="styleSheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/header.css">
<link rel="styleSheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/section.css">
<link rel="styleSheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/list.css">
<title>Insert title here</title>
</head>
<body>
	<h2 style="text-align: center;">NOTICE</h2>
	<table class="table table-hover">
		<thead><tr class="head">
			<th>NUM</th>
			<th>TITLE</th>
			<th>WRITER</th>
			<th>DATE</th>
			<th>HIT</th>
		</tr>

		<c:forEach items="${list}" var="dto">
			<tr class="body">
				<td>${dto.num}</td>
				<td><a href="./noticeView?num=${dto.num}">${dto.title}</a></td>
				<td>${dto.writer}</td>
				<td>${dto.reg_date}</td>
				<td>${dto.hit}</td>
			</tr>
		</c:forEach>
	</table>

	<!-- 페이징 처리 -->
	<div class="paging">
		<div class="btn-group">
			<div class="btn-group">
				<c:if test="${pageResult.curBlock>1}">
					<input type="button" class="go btn btn-primary" id="${pageResult.startNum-1}" value="[이전]">
				</c:if>

				<c:forEach begin="${pageResult.startNum}" end="${pageResult.lastNum}" var="i">
					<input type="button" class="go btn btn-primary" id="${i}" value="${i}">
				</c:forEach>

				<c:if test="${pageResult.curBlock<pageResult.totalBlock}">
					<input type="button" class="go btn btn-primary" id="${pageResult.lastNum+1}" value="[다음]">
				</c:if>
			</div>
		</div>
	</div>

	<c:if test="${memberDTO.id eq 'admin'}">
		<p><a class="btn btn-info" href="./noticeWrite">WRITE</a></p>
	</c:if>
</body>
</html>