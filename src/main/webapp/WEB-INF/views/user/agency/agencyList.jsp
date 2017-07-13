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
<script type="text/javascript">
$(function(){
	$(".go").click(function() {
		curPage = $(this).attr("id");
		location.href = "./agencyList?curPage=" + curPage;
	});
});
</script>
</head>
<body>
	<%@ include file="/resources/part/header2.jspf" %>
	<section>
		<div class="container">
			<h2 style="text-align: center;">My Agency Request</h2>
			<table class="table table-hover">
				<thead>
					<tr class="head">
						<td>DIRECTOR</td>
						<td>TITLE</td>
						<td>PUBDATE</td>
						<td>COMMIT</td>
					</tr>
				</thead>

				<tbody>
					<c:forEach items="${list}" var="dto">
						<%-- <c:if test="${memberDTO.name eq dto.director}"> --%>
						<tr>
							<td>${dto.director }</td>
							<td><a href="./agencyView?num=${dto.num}">${dto.title}</a></td>
							<td>${dto.pubdate}</td>
							<c:if test="${dto.commit eq 0}">
								<td>X</td>
							</c:if>
							<c:if test="${dto.commit eq 1}">
								<td>O</td>
							</c:if>
						</tr>
						<%-- </c:if> --%>
					</c:forEach>
				</tbody>
			</table>

			<!-- 페이징 처리 -->
			<div class="paging">
				<div class="btn-group">
					<c:if test="${pageResult.curBlock>1}">
						<input type="button" class="go btn btn-default" id="${pageResult.startNum-1}" value="[이전]">
					</c:if>
					<c:forEach begin="${pageResult.startNum}" end="${pageResult.lastNum}" var="i">
						<input type="button" class="go btn btn-default" id="${i}" value="${i}">
					</c:forEach>
					<c:if test="${pageResult.curBlock<pageResult.totalBlock}">
						<input type="button" class="go btn btn-default" id="${pageResult.lastNum+1}" value="[다음]">
					</c:if>
				</div>
			</div>
			
			<!-- BTN -->
			<div class="btnBox">
				<c:if test="${memberDTO != null}">
					<a href="./agencyRequest"><button class="btn btn-default"><span class="titleSpan">WRITE</span></button></a>
				</c:if>
			</div>
		</div>
	</section>
</body>
</html>