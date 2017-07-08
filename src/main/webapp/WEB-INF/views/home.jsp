<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<title>Home</title>
</head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/resources/part/bootStrap.jspf" %>
<link rel="styleSheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/section.css">
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
	width: 300px;
	margin: 10px auto;
	border: solid red 2px;
	text-align: center;
	font-family: 'Sofia';
	font-size: 30px;
	font-weight: bold;
	color: white;
}

.contents {
	width: 300px;
	height: 200px;
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
	width: 70%;
	height: 500px;
	margin: 0 auto;
	margin-top: 160px;
	border: solid blue 2px;
}

.menu{
	min-width: 500px;
	min-height: 500px;
	width: auto;
	height: auto;
	opacity : 0.6;
	border-radius: 1000px;
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

#intro{
	/* background-image: url("${pageContext.request.contextPath}/resources/img/intro.jpg");
	background-size: cover; */
	background: none;
	z-index: -2;
}

#go{
	background-color: skyblue;
}

/* side-Menu */
#mySidenav a {
    position: absolute;
    left: -80px;
    transition: 0.3s;
    padding: 15px;
    width: 100px;
    text-decoration: none;
    font-size: 20px;
    color: white;
    border-radius: 0 5px 5px 0;
    position: fixed;
    z-index: 5;
}

#mySidenav a:hover {
    left: 0;
}

#one {
	background-color: red;
    top: 20px;
}

#two {
	background-color: blue;
    top: 80px;
}
/* side-Menu */

/* info-effect */
.event {
	text-align: center;
	width: 500px;
	height: 500px;
	border-radius: 100%;
	border: solid blue 2px;
	overflow: visible;
	float: right;
}

.existent {
	opacity: 1;
	display: block;
	width: 100%;
	height: auto;
	transition: .5s ease;
	line-height: 100px;
	z-index: 8;
	border: solid black 2px;
}

.appear {
	margin: 60px auto;
	transition: .5s ease;
	opacity: 0;
	position: relative;
	height: auto;
	width: auto;
}

.event:hover .existent {
	display: none;
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
</style>
<body id="myPage" data-spy="scroll" data-target=".navbar" data-offset="50">

	<div id="mySidenav" class="sidenav">
		<a href="#intro" id="one">Intro</a>
		<a href="#go" id="two">Go</a>
	</div>

<!-- 수정 中 -->
	<video autoplay loop>
		<source src="${pageContext.request.contextPath}/resources/moving/titanic.mp4">
	</video>

	<div id="intro" class="container">

		<div class="event">
			<div class="existent">마우스를 올려보려무나~</div>

			<div class="appear">
				<div class="title"><p>asd</p></div>
				<div class="contents"><p>불라불라</p></div>
				<a href="#go" id="two">이동하기</a>
			</div>
		</div>

		<button class="info btn btn-info" data-toggle="collapse" data-target="#demo">Info</button>
  		<div id="demo" class="collapse">
			방구 영화 마을 뿡뿡~ (소개를 넣어주세요~)
		</div>
	</div>
<!--  -->
	
	<div id="go" class="container">
		<div class="menu_wrap">
			<c:if test="${memberDTO eq null }">
				<center>
					<!-- Trigger the modal with a button -->
					<button class="menu center" data-toggle="modal" data-target="#myModal">
						<p>'로그인'을 해주셔야 이용가능합니다.</p>
					</button>
				</center>	
			</c:if>
	
			<c:if test="${memberDTO ne null }">
				<button class="menu left" id="left"></button>
				<button class="menu right" id="right"></button>
			</c:if>
		</div>
		<a href="./notice/noticeList">NOTICE</a>
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
</body>
</html>
