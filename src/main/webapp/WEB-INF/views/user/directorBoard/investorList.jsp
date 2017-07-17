<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/resources/part/bootStrap.jspf" %>
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.js"></script>
<link rel="styleSheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/section.css">
<link rel="styleSheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/investorList.css">
<title>MOVIE COMMUNICATION</title>
</head>
<body>
	<div id="contents-body">
		<div id="list-img" style="margin-top: 20px;">
			<p style="text-align: center;">
				<span><img src="../../resources/images/directorBoard/list.png"></span>
				<span>펀딩 투자자 리스트</span>
			</p>
		</div>
		<p style="margin-top: 10px; text-align: right;">
			총 <span style="color:#e65c00; font-weight: bold;">${countInvestors}</span>명의 투자자가 
			<fmt:formatNumber var="totalMoney" pattern="#,###">${totalMoney }</fmt:formatNumber>
			<span style="color:#e65c00; font-weight: bold;">${totalMoney}</span>원을 투자했습니다.
		</p>
		<table class="table table-condensed">
			<tr style="background-color: #f2f2f2;">
				<th>번호</th>
				<th>아이디</th>
				<th>이름</th>
				<th>연락처</th>
				<th>E-MAIL</th>
				<th>펀딩금액(원)</th>
			</tr>
			<c:if test="${noList == null }">
			<c:forEach var="list" items="${list }" varStatus="status">
				<tr>
					<td class="count">${status.count}</td>
					<td class="id">${list.memberDTO.id }</td>
					<td class="name">${list.memberDTO.name }</td>
					<td class="phone">${list.memberDTO.phone }</td>
					<td class="email">${list.memberDTO.email }</td>
					<fmt:formatNumber var="money" pattern="#,###">${list.money }</fmt:formatNumber>
					<td class="money">${money }</td>
				</tr>
			</c:forEach>
			</c:if>
			<c:if test="${noList != null }">
				<tr>
					<td colspan="6" style="text-align: center;">리스트가 없습니다.</td>
				</tr>
			</c:if>
		</table>
	</div>
</body>
</html>