<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<table class="table table-hover">
		<tr>
			<th>num</th>
			<th>title</th>
			<th>director</th>
			<th>pubdate</th>
		</tr>
	<c:forEach items="${list }" var="dto">
			<tr>
				<td>${dto.num }</td>
				<td><a href="./agencyView?num=${dto.num}">${dto.title }</a></td>
				<td>${dto.director }</td>
				<td>${dto.pubdate }</td>


			</tr>
	</c:forEach>
</table>