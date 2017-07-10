<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/resources/part/bootStrap.jspf" %>
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.js"></script>
<link rel="styleSheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/header.css">
<link rel="styleSheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/section.css">
<title>MOVIE COMMUNICATION</title>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/script/movieScheduleAdd.js"></script>
<script type="text/javascript">
$(function(){
	$(".delete").click(function(){
		var selectNum = $(this).attr("id");
		
		$.post("movieScheduleDelete", {
			num: selectNum
		}, function(data) {
			$("#result").html(data);
		})
	});
	
	$("#back").click(function(){
		location.href="javascript:history.back()";
	});
	
	$("#refreash").click(function(){
		location.href="javascript:location.reload()";
	});
	
	$("#home").click(function(){
		location.href="../";
	});
	
	$(".go").click(function(){
		var curPage=$(this).attr("id"); 
		location.href="./movieScheduleList?curPage="+curPage+"&search=${search}";
	});
});
</script>

<style type="text/css">
.down{
	width: 300px;
	height: 300px;
}
</style>

</head>
<body>
	<%@ include file="/resources/part/header1.jspf" %>
	
	<section>
	<div id="result">
		<table class="table table-hover">
			<thead>
			<tr>
				<th>NUM</th>
				<th>TITLE</th>
				<th>DATE</th>
				<th>PNUM</th>
				<th>삭제</th>
			</tr>
			</thead>

			<tbody>
			<c:forEach items="${list}" var="movie">
				<tr>
					<td>${movie.num}</td>
					<td>${movie.title}</td>
					<td>${movie.moviedate}</td>
					<td>${movie.pnum}</td>
					<td><input type="button" class="delete btn btn-danger" id="${movie.num}" value="X"></td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
		
		<input type="button" class="btn" id="home" value="HOME">
		<input type="button" class="btn btn-success" id="back" value="BACK">
		<input type="button" class="btn btn-warning" id="refreash" value="REFREASH">

		<!-- Trigger the modal with a button -->
		<button class="btn btn-info" data-toggle="modal" data-target="#myModal2">MOVIE ADD</button>

		<!-- Modal -->
		<div class="modal fade" id="myModal2" role="dialog">
			<div class="modal-dialog">
				<!-- Modal content-->
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h2>Movie Add</h2>
					</div>
					<form action="movieScheduleAdd" name="frm" id="frm" method="POST">
					<div class="modal-body">
						<table class="table table-hover" style="width: 300px">
							<tr>
								<td>MOVIE NUM SEARCH:<input type="number" min="1" class="form-control" name="pnum" id="pnum" required="required">
							</tr>

							<tr>
								<td>MOVIE TITLE:<input type="text" class="form-control" name="title" id="title" required="required" readonly="readonly">
							</tr>

							<tr>
								<td>MOVIE DATE:<input type="date" class="form-control" name="moviedate" id="moviedate" required="required">
							</tr>
						</table>
					</div>

					<div class="modal-footer">					
						<input type="button" id="btn" class="btn btn-success" value="등록">
					</div>
					</form>
				</div>
			</div>
		</div>
		<!-- // -->

		<div class="down">
			<div class="search">
				<form action="movieScheduleList">
					<input type="hidden" name="curPage" value="${curPage}">
					<input type="date" class="form-control" name="search" placeholder="검색">
					<button class="btn btn-info">검색</button>
				</form>
			</div>
		
			<div class="paging btn-group">
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