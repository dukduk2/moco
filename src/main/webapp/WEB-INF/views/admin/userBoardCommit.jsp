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
			location.href="./userBoardCommit?curPage="+curPage+"&kind=${map.kind}&search=${map.search}&season=${map.season}";
		});
		
		// boardView - Ajax
		$(".boardTitle").click(function(){
			var num = $(this).attr("id");
			$.post("./userBoardView",
				{
					num : num
				},
				function(data){
					$("#boardView").html(data);
				});
		});
		
		// confirm - commit=1
		$("#boardView").on("click","#confirm",function(){
			var num = $("#Vnum").val();
			alert("승인");
			$.post("./userBoardCommit",
				{
					num : num
				},
				function(data){
					location.reload();
				});
		});
		
		// refuse - 삭제
		$("#boardView").on("click","#refuse",function(){
			var num = $("#Vnum").val();
			alert("승인 거절");
			$.post("./userBoardRefuse",
				{
					num : num
				},
				function(data){
					location.reload();
				});
		});
		
		
	});
</script>
<style type="text/css">
	.title{
		text-align: center;
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
	.form{
		text-align: right;
	}
	.boardTitle{
		cursor: pointer;
		font-weight: bold;
	}
	.memberIMG{
		border-radius: 100%;
		width: 110px;
		height: 110px;
	}
</style>
</head>
<body>
	<%@ include file="/resources/part/header3.jspf" %>
		<section>
			<div class="container">
	
			<h2 style="text-align: center;">USERBOARD COMMIT</h2>

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
								<select name="kind" class="form-control" style="width: 100px;">
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
								<input type="button" value="Search" id="search" class="btn btn-default titleSpan">
							</td>
						</tr>
					</table>				
				</form>
			</div>

			<table class="table table-hover">
				<thead>
					<tr class="head">
						<td>NUM</td>
						<td>TITLE</td>
						<td>WRITER</td>
						<td>GENRE</td>
						<td>DATE</td>
						<td>HIT</td>
						<td>LIKES</td>
						<td>SEASON</td>
						<td>STATE</td>
					</tr>
				</thead>

				<c:forEach items="${list}" var="dto">
					<tr class="body">
						<td>${dto.num}</td>
						<td><span id="${dto.num}" class="boardTitle"
							data-toggle="modal" data-target="#myModal">${dto.title}</span></td>
						<td>${dto.writer}</td>
						<td>${dto.genre}</td>
						<td>${dto.reg_date}</td>
						<td>${dto.hit}</td>
						<td>${dto.likes}</td>
						<td>${dto.season}</td>
						<td><c:if test="${dto.commit == 0}">
								<span>승인 대기 중</span>
							</c:if></td>
					</tr>
				</c:forEach>
			</table>

			<!-- modal Ajax -->
			<div class="modal fade" id="myModal" role="dialog">
			   	<div class="modal-dialog" style="width: 1000px;" >
			   		<div class="modal-content" id="boardView">
			   		</div>
			   	</div>
			</div>

			<!-- 페이징 처리 -->
			<div class="paging">
				<div class="btn-group">
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
			</div>
		</div>
	</section>
</body>
</html>