<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<table class="table table-hover">
	<thead><tr class="head">
		<td>NUM</td>
		<td>SEASON</td>
		<td>START</td>
		<td>END</td>
		<td>STATE</td>
		<td>FUNCTION</td>
	</tr></thead>

	<tbody><c:forEach items="${userSeason}" var="user">
		<tr>
			<td>${user.num}</td>
			<td>${user.season }</td>
			<td>${user.startDate }</td>
			<td>${user.endDate }</td>
			<c:if test="${user.state == 0}">
				<td>시즌 기간 아님</td>
				<td><button class="btn btn-danger SeasonDelete" id="${user.num}">시즌 삭제</button></td>
			</c:if>

			<c:if test="${user.state == 1}">
				<td>진행 중</td>
				<td><button class="btn btn-danger SeasonDelete" id="${user.num}">시즌 삭제</button></td>
			</c:if>
		</tr>
	</c:forEach></tbody>
</table>