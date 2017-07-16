<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<tr class="form-inline">
	<td><input type="hidden" id="size" value="${size }"></td>
	<td>
		<select class="multiplexList form-control" name="multi_num">
			<option value="0">선택</option>
			<c:forEach items="${list }" var="list">
				<option value="${list.num }">${list.name}</option>
			</c:forEach>
		</select>
	</td>
	<td>
		상영시작일: <input type="date" class="form-control" name="start_date" id="start_date">
		상영종료일: <input type="date" class="form-control" name="end_date" id="end_date">
	</td>
</tr>