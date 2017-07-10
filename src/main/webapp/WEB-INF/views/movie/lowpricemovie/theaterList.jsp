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
<link rel="styleSheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/list.css">
<title>Insert title here</title>
<script type="text/javascript">
	$(function(){
		$('.boardView').click(function(){
			var num = $(this).attr('id');
			location.href='./theaterView?num='+num;
		});
	});
</script>
<style type="text/css">
.titleSpan{
	font-family: Montserrat, sans-serif;
}
.boardView{
		font-family: Montserrat, sans-serif;
		font-weight: bold;
		cursor: pointer;
	}

</style>
</head>
<body>
	<%@ include file="/resources/part/header1.jspf" %>
	<section>
		<div class="container">
			<h2 style="text-align: center;">Theater List</h2>
			
			<div class="tb_wrap">
				<table class="table table-hover">
					<thead>
						<tr class="head">
							<td><span class="titleSpan">NUM</span></td>
							<td><span class="titleSpan">THEATER NAME</span></td>
							<td><span class="titleSpan">LOCATION</span></td>
							<td><span class="titleSpan">PHONE NUMBER</span></td>
						</tr>
						<c:forEach items="${list }" var="list">
							<c:if test="${list.commit eq 1}">
								<tr>
									<td>${list.num }</td>
									<td><span id="${list.num }" class="boardView">${list.name}</span></td>
									<td>${list.location}</td>
									<td>${list.phone}</td>
								</tr>
							</c:if>
						</c:forEach>
					</thead>
				</table>
			</div>
		</div>
	</section>
</body>
</html>