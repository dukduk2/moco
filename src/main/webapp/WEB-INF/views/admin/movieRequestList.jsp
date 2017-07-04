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
	.btnBox{
		text-align: right;
	}
</style>
</head>
<body>
	<div class="container">
		<h2>Movie Request</h2>
		<br>
		<table class="table">
			<tr>
				<td><span class="titleSpan">NUM</span></td>
				<td><span class="titleSpan">TITLE</span></td>
				<td><span class="titleSpan">ENG_TITLE</span></td>
				<td><span class="titleSpan">GENRE</span></td>
				<td><span class="titleSpan">DIRECTOR</span></td>
				<td><span class="titleSpan">ACTOR</span></td>
			</tr>	
			<c:forEach items="${movieRequestList}" var="movie">
				<tr>
					<td>${movie.num}</td>
					<td><input type="button" value="${movie.title}" id="${movie.num}" class="uploadGo btn btn-default" ></td>
					<td>${movie.genre}</td>
					<td>${movie.eng_title}</td>
					<td>${movie.director}</td>
					<td>${movie.actor}</td>
				</tr>
			</c:forEach>
		</table>
		
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
			<a href="./index"><button class="btn">Admin Index</button></a>&nbsp;&nbsp;
			<a href="../"><button class="btn">HOME</button></a>
		</div>
		
	</div>
</body>
</html>