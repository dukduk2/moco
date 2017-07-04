<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<select id="multiplex" name="multi_num">
	<c:forEach items="${list }" var="list">
		<option value="${list.num }">${list.name}</option>
	</c:forEach>
</select>
<div>
	상영시작일 <input type="date" name="start_date">
	상영종료일 <input type="date" name="end_date">
</div>