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
<title>MOVIE COMMUNICATION</title>
<script type="text/javascript">
	$(function() {
		// page
		$(".go").click(function(){
			var curPage=$(this).attr("id");
			location.href="./movieRequestList?curPage="+curPage;
		});
		// upload
		$(".uploadGo").click(function(){
			var movieNum = $(this).attr("id");
			var movieTitle = $(this).val();
			location.href="./movieUpload?movieNum="+movieNum+"&movieTitle="+movieTitle;
		});
	});
</script>
<style type="text/css">
	.container{
		width: 1370px;
	}
	.paging{
		text-align: center;
	}
	.titleSpan{
		font-size: 1.2em;
		font-weight: bold;
	}
	.uploadGo{
		border: none;	
		font-weight: bold;
	}
	.uploadGo:hover{
		background-color : white;
		text-decoration: underline;
	}
</style>
</head>
<body>
	<%@ include file="/resources/part/header3.jspf" %>
	<section>
		<div class="container">
			<h2 style="text-align: center;">Movie Request</h2>

			<table class="table table-hover">
				<colgroup>
					<col width="5%">
					<col width="10%">
					<col width="20%">
					<col width="10%">
					<col width="10%">
					<col width="45%">
				</colgroup>

				<thead><tr class="head">
					<td><span class="titleSpan">NUM</span></td>
					<td><span class="titleSpan">TITLE</span></td>
					<td><span class="titleSpan">ENG_TITLE</span></td>
					<td><span class="titleSpan">GENRE</span></td>
					<td><span class="titleSpan">DIRECTOR</span></td>
					<td><span class="titleSpan">ACTOR</span></td>
				</tr></thead>

				<tbody><c:forEach items="${movieRequestList}" var="movie">
					<tr>
						<td>${movie.num}</td>
						<td>
							<input type="button" class="uploadGo btn btn-default" id="${movie.num}" value="${movie.title}">
						</td>
						<td>${movie.eng_title}</td>
						<td>${movie.genre}</td>
						<td>${movie.director}</td>
						<td>${movie.actor}</td>
					</tr>
				</c:forEach></tbody>
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
			
		</div>
	</section>
</body>
</html>