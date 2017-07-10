<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
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

	<h3 class="title">USERBOARD COMMIT</h3>
	<div class="container">	
	<br>
	<div class="form">
		<form action="./userBoardCommit" id="searchForm">
			<select name="kind">
				<option value="title">TITLE</option>
				<option value="writer">WRITER</option>
				<option value="genre">GENRE</option>
			</select>
			<input type="text" name="search">
			<input type="hidden" name="curPage" value="1">
			<input type="button" value="Search" id="search">
		</form>
		<br>
		<form action="./userBoardCommit" id="seasonForm">
			SEASON 
			<select name="season" id="season">
				<option value="all">ALL</option>
				<c:forEach items="${orderList}" var="order">
					<option value="${order.season}">${order.season}</option>
				</c:forEach>
			</select>
			<input type="hidden" name="curPage" value="1">
		</form>
	</div>
	<br>
	<table class="table table-hover">
		<tr>
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
		<c:forEach items="${list}" var="dto">
				<tr>
					<td>${dto.num}	</td>
					<td><span id="${dto.num}" class="boardTitle" data-toggle="modal" data-target="#myModal">${dto.title}</span></td>
					<td>${dto.writer}</td>
					<td>${dto.genre}</td>
					<td>${dto.reg_date}</td>
					<td>${dto.hit}</td>
					<td>${dto.likes}</td>
					<td>${dto.season}</td>
					<td>
						<c:if test="${dto.commit == 0}">
							<span>승인 대기 중</span>
						</c:if>
					</td>
				</tr>
		</c:forEach>
	</table>

<!-- modal Ajax -->
<div class="container">
	<div class="modal fade" id="myModal" role="dialog">
    	<div class="modal-dialog" style="width: 1000px;" >
    		<div class="modal-content" id="boardView">
    		</div>
    	</div>
    </div>
</div>
	
	
	
	<!-- 페이징 처리 -->
	<div class="paging">
		<c:if test="${pageResult.curBlock>1}">
			<button class="btn"><span class="go" id="${pageResult.startNum-1}">[이전]</span></button>
		</c:if>
		<c:forEach begin="${pageResult.startNum}" end="${pageResult.lastNum}" var="i">
			<button class="btn"><span class="go" id="${i}">${i}</span></button>
		</c:forEach>
		<c:if test="${pageResult.curBlock<pageResult.totalBlock}">
			<button class="btn"><span class="go" id="${pageResult.lastNum+1}">[다음]</span></button>
		</c:if>
	</div>
	
	<!-- BTN -->
	<div class="btnBox">
		<a href="./index"><button class="btn">Admin Index</button></a>
		<a href="../"><button class="btn">HOME</button></a>
	</div>
</div>
	
</body>
</html>