<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/resources/part/bootStrap.jspf" %>
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.js"></script>
<link rel="styleSheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/header.css">
<link rel="styleSheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/section.css">
<title>MOVIE COMMUNICATION</title>
<style type="text/css">
.tb_wrap{
	width : 700px;
	height : 700px;
	margin: 0 auto;
	font-size: 17px;
}
.tb_wrap > table{
	font-size: 20px;
}
</style>
</head>
<body>
	<%@ include file="/resources/part/header1.jspf" %>
		<div class="tb_wrap">
			<table>
				<tr>
					<td>글번호</td><td>극장명</td><td>주소</td><td>문의전화</td>
				</tr>
				<c:forEach items="${list }" var="list">
					<c:if test="${list.commit eq 1}">
						<tr>
							<td>${list.num }</td><td><a href="theaterView?num=${list.num }">${list.name}</a></td><td>${list.location}</td><td>${list.phone}</td>
						</tr>
					</c:if>
				</c:forEach>
			</table>
		</div>
</body>
</html>