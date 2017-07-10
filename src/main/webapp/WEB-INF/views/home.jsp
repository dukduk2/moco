<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<title>Home</title>
</head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/resources/part/bootStrap.jspf" %>
<link rel="styleSheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/section.css">
<link rel="styleSheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/list.css">
<title>Home</title>
<script type="text/javascript">
$(function(){
	/* var message = '${message}';

	if(message != ""){
		alert(message);
	} */
	
	$(".menu").click(function(){
		var go = $(this).attr("id");
		
		if(go == "left"){
			location.href="./movie/movieHome";	//주소를 영화 인덱스로
			window.open("${pageContext.request.contextPath}/movie/movieSchedule/movieScheduleTable", "actity", "width=1200, height=800, left=300, top=100");
		} else if(go == "right"){
			location.href="./user/userHome";	//주소를 배우 인덱스로.
		}
	});
	
	$("#join").click(function(){
		window.open("${pageContext.request.contextPath}/member/memberJoin", "actity", "width=800, height=800, left=300, top=100");
	});
	
	$("#search_id").click(function(){
		window.open("${pageContext.request.contextPath}/member/memberSearch?kind=id", "actity", "width=500, height=300, left=300, top=100");
	});
	
	$("#search_pw").click(function(){
		window.open("${pageContext.request.contextPath}/member/memberSearch?kind=password", "actity", "width=500, height=400, left=300, top=100");
	});
});
</script>

<style type="text/css">
.title {
	width: 400px;
	margin: 10px auto;
	border: solid red 2px;
	text-align: center;
	font-family: 'Sofia';
	font-size: 30px;
	font-weight: bold;
	color: white;
}

.contents {
	width: 400px;
	height: 500px;
	margin: 20px auto;
	border: solid red 2px;
	text-align: center;
	font-family: 'Sofia';
	font-size: 20px;
	font-weight: bold;
	color: white;
}

video{
	position: fixed;
	top: 0;
	left: 0;
	min-width: 100%;
	min-height: 100%;
	width: auto;
	height: auto;
	z-index: -1;
}

.menu_wrap {
	min-width: 1400px;
	width: 10%;
	height: 450px;
	margin: 0 auto;
	margin-top: 250px;
	border: solid blue 2px;
}

.menu{
	min-width: 450px;
	min-height: 450px;
	width: auto;
	height: auto;
	opacity : 0.4;
	border-radius: 100%;
	cursor: pointer;
	z-index: 2;
}

.menu:hover {
	opacity : 1;
}

.center{
	background-image: url("${pageContext.request.contextPath}/resources/img/start.jpg");
	background-size: cover;
	margin: 0 auto;
}

.left{
	background-image: url("${pageContext.request.contextPath}/resources/img/left.jpg");
	background-size: cover;
	float: left;
}

.right{
	background-image: url("${pageContext.request.contextPath}/resources/img/right.jpg");
	background-size: cover;
	float: right;
}

body {
	font: 400 15px/1.8 Lato, sans-serif;
	color: #777;
}

.container {
	height: 100%;
	width: 100%;
	padding: 50px 120px;
	z-index: -2;
}

#go{
	/* background-image: url("${pageContext.request.contextPath}/resources/img/intro.jpg");
	background-size: cover; */
	background: none;
	z-index: -2;
}

/* info-effect */
.event {
	text-align: center;
	width: 410px;
	height: auto;
	border-radius: 30px;
	border: solid blue 2px;
	overflow: visible;
	float: left;
	opacity: 0.4;
	overflow: hidden;
}

.appear {
	margin: 60px auto;
	transition: .5s ease;
	opacity: 0;
	position: relative;
	height: auto;
	width: 405px;
	border: solid yellow 2px;
}

.event:hover {
	opacity: 1;
}

.event:hover .appear {
	opacity: 1;
}

video {
	position: absolute;
	top: 0;
	left: 0;
	min-width: 100%;
	min-height: 100%;
	width: auto;
	height: auto;
}	
/* info-effect */

.info {
	min-width: 100px;
	min-height: 100px;
	width: auto;
	height: auto;
	opacity : 0.6;
	border-radius: 1000px;
	cursor: pointer;
	z-index: 2;
}

.collapse {
	color: red;
}

.notice {
	width: 70%;
	float: left;
	border: solid red 2px;
}
</style>
<body id="myPage" data-spy="scroll" data-target=".navbar" data-offset="50">

	<%@ include file="/resources/part/sideMenu.jspf" %>

	<video autoplay loop>
		<source src="${pageContext.request.contextPath}/resources/moving/titanic.mp4">
	</video>

	<div id="go" class="container">
		<div class="menu_wrap">
			<c:if test="${memberDTO eq null}">
				<center>
					<!-- Trigger the modal with a button -->
					<button class="menu center" data-toggle="modal" data-target="#myModal">
						<p>'로그인'을 해주셔야 이용가능합니다.</p>
					</button>
				</center>	
			</c:if>
	
			<c:if test="${memberDTO ne null}">
				<button class="menu left" id="left"></button>
				<button class="menu right" id="right"></button>
			</c:if>
		</div>

		<!-- Modal -->
		<div class="modal fade" id="myModal" role="dialog">
			<div class="modal-dialog">
				<!-- Modal content-->
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title">LOGIN</h4>
					</div>
	
					<div class="modal-body">
						<form action="${pageContext.request.contextPath}/member/memberLogin" method="post">
							<table class="table">
								<tr>
									<td>ID <input type="text" class="form-control" name="id"></td>
								</tr>
								<tr>
									<td>PW <input type="password" class="form-control" name="password"></td>
								</tr>
							</table>
	
							<input class="btn btn-success" type="submit" value="LOGIN">
						</form>
					</div>
	
					<div class="modal-footer">
						<div class="btn-group">
							<button class="btn btn-primary" id="join">JOIN</button>
							<button class="btn btn-warning" id="search_id">ID search</button>
							<button class="btn btn-warning" id="search_pw">PW search</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<div id="intro" class="container">
		<div class="event">
			<div>마우스를 올려보려무나~</div>

			<div class="appear">
				<div class="title"><p>제목</p></div>
				<div class="contents"><p>내용</p></div>
				
				<p><a href="./notice/noticeList">NOTICE</a></p>
				<p><a href="#go" id="login">Login</a></p>
			</div>
		</div>
	
		<div class="notice">
			<h2 style="text-align: center;">NOTICE</h2>
	
			<table class="table table-hover">
				<thead><tr class="head">
					<th>NUM</th>
					<th>TITLE</th>
					<th>WRITER</th>
					<th>DATE</th>
					<th>HIT</th>
				</tr>
		
				<c:forEach items="${list}" var="dto">
					<tr class="body">
						<td>${dto.num}</td>
						<td><a href="./notice/noticeView?num=${dto.num}">${dto.title}</a>
						
<!-- notice View start -->
							<!-- Trigger the modal with a button -->
							<button data-toggle="modal" data-target="#myModal${dto.num}">${dto.title}</button>


							<!-- Modal -->
							<div class="modal fade" id="myModal${dto.num}" role="dialog">
								<div class="modal-dialog">
									<!-- Modal content-->
									<div class="modal-content">
										<div class="modal-header">
											<button type="button" class="close" data-dismiss="modal">&times;</button>
											<table style="margin: auto;">
												<tr>
													<td class="modal-title">TITLE : ${dto.title}</td>
													<td>WRITER : ${dto.writer}</td>
													<td>DATE : ${dto.reg_date}</td>
													<td>HIT : ${dto.hit}</td><!-- hit가 안올라감 -->
												</tr>
											</table>
										</div>
						
										<div class="modal-body">
											${dto.contents}
										</div>
						
										<div class="modal-footer">
											<c:if test="${memberDTO.id eq 'admin'}">
												<a class="btn btn-info" href="notice/noticeUpdate?num=${dto.num}">UPDATE</a>
												<a class="btn btn-info" href="notice/noticeDelete?num=${dto.num}">DELETE</a>
											</c:if>
										</div>
										
									</div>
								</div>
							</div>
<!-- notice View end -->
						</td>

						<td>${dto.writer}</td>
						<td>${dto.reg_date}</td>
						<td>${dto.hit}</td>
					</tr>
				</c:forEach>
			</table>
	
			<!-- 페이징 처리 -->
			<div class="paging">
				<div class="btn-group">
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
		
			<c:if test="${memberDTO.id eq 'admin'}">
				<p><a class="btn btn-info" href="./notice/noticeWrite">WRITE</a></p>
			</c:if>
		</div>
	</div>
</body>
</html>
