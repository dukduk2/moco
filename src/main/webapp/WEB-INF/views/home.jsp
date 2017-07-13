<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/resources/part/bootStrap.jspf" %>
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="styleSheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/list.css">
<title>MOVIE COMMUNICATION</title>
<script type="text/javascript">
$(function(){
 	var message = '${message}';

	if(message != ""){
		alert(message);
	}
	
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
	

	$(".go").click(function() {
		curPage = $(this).attr("id");
		location.href = "./?curPage=" + curPage;
	});
	
	//notice -------------------------------------------------
	
	$(".noticeShowHide").hide();
	var hideCheck= true;
	
	// noticeView
	$(".noticeView").click(function() {
		var id = $(this).attr("id");
		if(hideCheck){
			$("#"+id+"View").show();
			hideCheck = !hideCheck;
			$.get("./notice/noticeView?num="+id, function(data){
				
			});
		}else{
			$("#"+id+"View").hide();
			hideCheck = !hideCheck;	
		}
	});
	
	/* // videoCancel
	$(".noticeCancel").click(function() {
		var id = $(this).attr("id");
		$("#"+id+"View").hide();
	}); */
	
	// videoUpdate
	$(".noticeUpdate").click(function() {
		var id = $(this).attr("id");
		window.open("${pageContext.request.contextPath}/notice/noticeUpdate?num="+id, "actity", "width=1200, height=800, left=300, top=100");
	});
	
	// videoDelete
	$(".noticeDelete").click(function() {
		var id = $(this).attr("id");
		$.get("./notice/noticeDelete?num="+id, function(data){
			
		});
	});
	
	// videoWrite
	$(".noticeWrite").click(function() {
		var id = $(this).attr("id");
		window.open("${pageContext.request.contextPath}/notice/noticeWrite", "actity", "width=1200, height=800, left=300, top=100");
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
	transition: .5s ease;
	min-width: 450px;
	min-height: 450px;
	width: auto;
	height: auto;
	opacity : 0.4;
	border: 0px;
	border-radius: 100%;
	cursor: pointer;
	z-index: 2;
}

.menu:hover {
	opacity : 1;
}

.center{
	background-image: url("${pageContext.request.contextPath}/resources/images/home/button1.jpg");
	background-size: cover;
	margin: 0 auto;
}

.left{
	background-image: url("${pageContext.request.contextPath}/resources/images/home/button1.jpg");
	background-size: cover;
	float: left;
}

.right{
	background-image: url("${pageContext.request.contextPath}/resources/images/home/button2.jpg");
	background-size: cover;
	float: right;
}

.button_text {
	font-size: 25px;
	font-weight: bolder;
	color: black;
	
	text-shadow: -1px 0 #ffffff, 0 1px #ffffff, 1px 0 #ffffff, 0 -1px #ffffff;
	-moz-text-shadow: -1px 0 #ffffff, 0 1px #ffffff, 1px 0 #ffffff, 0 -1px #ffffff;
	-webkit-text-shadow: -1px 0 #ffffff, 0 1px #ffffff, 1px 0 #ffffff, 0 -1px #ffffff;
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
	overflow: visible;
	float: left;
	opacity: 0.6;
	overflow: hidden;
	background-image: url("${pageContext.request.contextPath}/resources/images/home/info-background.jpg");
	background-size: cover;
	bac
}

.appear {
	margin: 60px auto;
	transition: .5s ease;
	opacity: 0;
	position: relative;
	height: auto;
	width: 405px;
}

.info-title {
	transition: .5s ease;
	top: 370px;
	position: relative;
	opacity: inherit;
	color: white;
	font-weight: bolder;
	font-size: 25px;
}

.event:hover {
	opacity: 1;
}

.event:hover .appear {
	opacity: 1;
}

.event:hover .info-title {
	opacity: 0;
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

.notice {
	width: 70%;
	float: left;
}

.noticeView:hover {
	color: blue;
	font-weight: bold;
	cursor: pointer;
}
</style>
</head>

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
						<p class="button_text">'로그인'을 해주셔야 이용가능합니다.</p>
					</button>
				</center>	
			</c:if>
	
			<c:if test="${memberDTO ne null}">
				<button class="menu left" id="left">
					<p class="button_text">Movie Home</p>
				</button>
				<button class="menu right" id="right">
					<p class="button_text">User Home</p>
				</button>
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

<!-- info -->
	<div id="intro" class="container">
		<div class="event">
			<div class="info-title">"MOVIE COMMUNICATION" 란?</div>

			<div class="appear">
				<div class="title">MOVIE COMMUNICATION</div>
				<div class="contents"><p>내용을 넣어주세요~</p></div>
				<!-- <p><a href="./notice/noticeList">NOTICE</a></p>
				<p><a href="#go" id="login">Login</a></p> -->
			</div>
		</div>


<!-- notice -->
		<div class="notice">
			<h2 style="text-align: center;">NOTICE</h2>
	
			<table class="table table-hover">
				<thead><tr class="head">
					<td>NUM</td>
					<td>TITLE</td>
					<td>WRITER</td>
					<td>DATE</td>
					<td>HIT</td>
				</tr></thead>

				<c:forEach items="${list}" var="dto">
					<tbody><tr class="body">
						<td>${dto.num}</td>
						<td><span class="noticeView" id="${dto.num}">${dto.title}</span></td>
						<td>${dto.writer}</td>
						<td>${dto.reg_date}</td>
						<td>${dto.hit}</td>
					</tr>
					<tr class="noticeShowHide" id="${dto.num}View">
						<td colspan="5">${dto.contents}<br>
							<c:if test="${memberDTO.id eq 'admin'}">
								<input type="button" value="수정" id="${dto.num}" class="btn btn-warning noticeUpdate">
								<input type="button" value="삭제" id="${dto.num}" class="btn btn-danger noticeDelete">
							</c:if>
						</td>
					</tr></tbody>
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
				<p><input value="WRITE" type="button" class="btn btn-success noticeWrite"></p>
			</c:if>
		</div>
	</div>
</body>
</html>
