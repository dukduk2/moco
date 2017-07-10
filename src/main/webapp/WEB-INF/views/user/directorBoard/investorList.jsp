<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/resources/part/bootStrap.jspf" %>
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.js"></script>
<link rel="styleSheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/section.css">
<title>MOVIE COMMUNICATION</title>
</head>
<body>
	<section>
	<h2>Investor List</h2>
	<p>countInvestors : ${countInvestors}</p>
	<table>
		<tr>
			<td>ID</td>
			<td>NAME</td>
			<td>PHONE</td>
			<td>EMAIL</td>
			<td>MONEY</td>
		</tr>
		<c:if test="${noList == null }">
		<c:forEach var="list" items="${list }">
			<tr>
				<td>${list.memberDTO.id }</td>
				<td>${list.memberDTO.name }</td>
				<td>${list.memberDTO.phone }</td>
				<td>${list.memberDTO.email }</td>
				<td>${list.money }</td>
			</tr>
		</c:forEach>
		</c:if>
		<c:if test="${noList != null }">
			<tr>
				<td colspan="5">${noList }</td>
			</tr>
		</c:if>
	</table>
	
	</section>
</body>
</html>