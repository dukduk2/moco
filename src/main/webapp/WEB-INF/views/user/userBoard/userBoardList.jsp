<%@page import="org.springframework.ui.Model"%>
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
	$(function() {
		
		// 시즌
		$("#season").change(function() {
			var season = $("#season").val();
			alert(season);
			$("#seasonForm").submit();
		});
		
		// 검색
		$("#search").click(function() {
			$("#searchForm").submit();
		});
		
		// page
		$(".go").click(function(){
			var curPage=$(this).attr("id");
			location.href="./userBoardList?curPage="+curPage+"&kind=${map.kind}&search=${map.search}&season=${map.season}";
		});
		
	});
</script>

<<<<<<< HEAD
=======
.search_right {
	width: 380px;
	float: right;
}

table {
	margin: 10px 0;
}

tr.head {
	background-color: #ff6600;
	color: white;
	font-size: 16px;
	font-weight: bold;
	border-top: solid black 2px;
	border-bottom: solid black 2px;
}

td {
	padding: 10px;
}
.titleSpan{
	font-family: Montserrat, sans-serif;
}
.paging{
	text-align: center;	
}

.go{
	font-size : 1.2em;
	cursor: pointer;
}

.btnBox{
	text-align: right;
}
</style>
>>>>>>> chan
</head>
<body>
	<%@ include file="/resources/part/header2.jspf" %>
	<section>
		<div class="container">
			<h2 style="text-align: center;">UserBoard List</h2>
		
			<div class="search_left">
				<form class="form-horizontal" action="./userBoardList" id="seasonForm">
					<table>
						<tr>
							<td><span class="titleSpan">SEASON</span></td>
							<td>
								<select name="season" class="form-control" id="season">
									<option value="all" class="titleSpan">ALL</option>
									<c:forEach items="${orderList}" var="order">
										<option value="${order.season}">${order.season}</option>
									</c:forEach>
								</select>
							</td>
						</tr>
					</table>
					<input type="hidden" name="curPage" value="1">
				</form>
			</div>
		
			<div class="search_right">
				<form action="./userBoardList" id="searchForm">
					<table>
						<tr>
							<td>
								<select name="kind" class="form-control col-sm-5">
									<option value="title" class="titleSpan">TITLE</option>
									<option value="writer" class="titleSpan">WRITER</option>
									<option value="genre" class="titleSpan">GENRE</option>
								</select>						
							</td>
							<td>
								<input type="text" name="search" class="form-control col-sm-5">
								<input type="hidden" name="curPage" value="1">
							</td>
							<td>
								<input type="button" value="Search" id="search" class="btn titleSpan">
							</td>
						</tr>
					</table>				
				</form>
			</div>
		
			<table class="table table-hover">
				<thead>
					<tr class="head">
						<td><span class="titleSpan">NUM</span></td>
						<td><span class="titleSpan">TITLE</span></td>
						<td><span class="titleSpan">WRITER</span></td>
						<td><span class="titleSpan">GENRE</span></td>
						<td><span class="titleSpan">DATE</span></td>
						<td><span class="titleSpan">HIT</span></td>
						<td><span class="titleSpan">LIKES</span></td>
						<td><span class="titleSpan">SEASON</span></td>
					</tr>
				</thead>
				
				<tbody>
					<c:forEach items="${list}" var="dto">
						<tr>
							<td>${dto.num}</td>
							<td><a href="./userBoardView?num=${dto.num}&commit=${dto.commit}">${dto.title}</a></td>
							<td>${dto.writer}</td>
							<td>${dto.genre}</td>
							<td>${dto.reg_date}</td>
							<td>${dto.hit}</td>
							<td>${dto.likes}</td>
							<td>${dto.season}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			
			<!-- 페이징 처리 -->
			<div class="paging">
				<div class="btn-group">
					<c:if test="${pageResult.curBlock>1}">
						<input type="button" class="go btn btn-primary" id="${pageResult.startNum-1}" value="[이전]">
					</c:if>
					<c:forEach begin="${pageResult.startNum}" end="${pageResult.lastNum}" var="i">
						<input type="button" class="go btn btn-primary" id="${i}" value="${i}">
					</c:forEach>
					<c:if test="${pageResult.curBlock<pageResult.totalBlock}">
						<input type="button" class="go btn btn-primary" id="${pageResult.lastNum+1}" value="[다음]">
					</c:if>
				</div>
			</div>
			
			<!-- BTN -->
			<div class="btnBox">
				<c:if test="${seasonCheck && memberDTO != null}">
					<a href="./userBoardWrite"><button class="btn"><span class="titleSpan">WRITE</span></button></a>
				</c:if>
			</div>
		</div>
	</section>
</body>
</html>