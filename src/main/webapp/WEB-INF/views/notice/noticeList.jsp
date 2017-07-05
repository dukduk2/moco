<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>NOTICE</h2>
	<table class="table table-hover">
	<tr>
		<th>TITLE</th>
		<th>WRITER</th>
		<th>DATE</th>
		<th>HIT</th>
	</tr>
	<c:forEach items="${list }" var="dto">
		<tr>
			<td>${dto.title }</td>
			<td>${dto.writer }</td>
			<td>${dto.reg_date }</td>
			<td>${dto.hit }</td>
		</tr>
	</c:forEach>
	</table>
	
	<div class="paging">
		<c:if test="${pageResult.curBlock>1 }">
			<button class="btn">
				<span class="go" id="${pageResult.startNum-1}">[이전]</span>
			</button>
		</c:if>
		<c:forEach begin="${pageResult.startNum}" end="${pageResult.lastNum}"
			var="i">
			<button class="btn">
				<span class="go" id="${i}">${i}</span>
			</button>
		</c:forEach>
		<c:if test="${pageResult.curBlock<pageResult.totalBlock}">
			<button class="btn">
				<span class="go" id="${pageResult.lastNum+1}">[다음]</span>
			</button>
		</c:if>
	</div>
	
		<p><a class="btn btn-info" href="../">HOME</a></p>
	
</body>
</html>