<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/resources/part/bootStrap.jspf" %>
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.js"></script>
<link rel="styleSheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/header.css">
<link rel="styleSheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/section.css">
<title>MOVIE COMMUNICATION</title>
<style type="text/css">
.img {
	width: 100%;
	height: 400px;
	border: solid blue 2px;
	margin: 0 auto;
	margin-top: -50px;
	font-size: 30px;
	font-weight: bold;
}

.carousel-inner > .item > img, .carousel-inner > .item > a > img {
	width: 100%;
	height: 400px;
	margin: auto;
}

.sub {
	width: 45%;
	height: 300px;
	margin-top: 20px;
	font-size: 30px;
	font-weight: bold;
}

.sub_left{
	margin-left: 4%;
	border: solid red 2px;
	float: left;
}

.sub_right {
	margin-right: 4%;
	border: solid green 2px;
	float: right;
}
</style>
</head>
<body>
	<%@ include file="/resources/part/header1.jspf" %>
	<%@ include file="/resources/part/sideMenu.jspf" %>
	<section>
	
		<div class="img">
			<div id="myCarousel" class="carousel slide" data-ride="carousel">
				<!-- Indicators -->
				<ol class="carousel-indicators">
					<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
					<li data-target="#myCarousel" data-slide-to="1"></li>
					<li data-target="#myCarousel" data-slide-to="2"></li>
					<li data-target="#myCarousel" data-slide-to="3"></li>
				</ol>

				<!-- Wrapper for slides -->
				<div class="carousel-inner" role="listbox">
					<div class="item active">
						<a href="#"><img src="${pageContext.request.contextPath}/resources/img/intro.jpg"></a>
						<div class="carousel-caption">
							<h3>사진 1</h3>
						</div>
					</div>

					<div class="item">
						<a href="#"><img src="${pageContext.request.contextPath}/resources/img/intro.jpg"></a>
						<div class="carousel-caption">
							<h3>사진 2</h3>
						</div>
					</div>
					
					<div class="item">
						<a href="#"><img src="${pageContext.request.contextPath}/resources/img/intro.jpg"></a>
						<div class="carousel-caption">
							<h3>사진 2</h3>
						</div>
					</div>
					
					<div class="item">
						<a href="#"><img src="${pageContext.request.contextPath}/resources/img/intro.jpg"></a>
						<div class="carousel-caption">
							<h3>사진 2</h3>
						</div>
					</div>
				</div>

				<!-- Left and right controls -->
				<a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
					<span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
					<span class="sr-only">Previous</span>
				</a> <a class="right carousel-control" href="#myCarousel" role="button"	data-slide="next">
					<span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
					<span class="sr-only">Next</span>
				</a>
			</div>
		</div>
		<!-- banner end -->
		
		<div class="sub sub_left">sub1</div>
		<div class="sub sub_right">sub2</div>
		<div class="sub sub_left">sub3</div>
		<div class="sub sub_right">sub4</div>
	</section>
</body>
</html>