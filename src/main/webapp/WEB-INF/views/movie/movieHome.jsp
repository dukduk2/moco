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
<script type="text/javascript">
	$(function(){
		$(".viewMovieInfo").click(function(){
			var kind = $(this).attr("title");
			var num = $(this).attr("id");
			if(kind == 'basic'){
				location.href="./basicMovieSearch/movieView?num="+num+"&kind=basic";
			}else{
				location.href="./lowpricemovie/movieView?num="+num+"&kind=low";
			}
		});
	});
</script>
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
#paidLowList{
	width: 48%;
	height: 100%;
	float: left;
	border: solid green 1px;
}

#paidBasicList{
	width: 48%;
	height: 100%;
	float: right;
	border: solid green 1px;
}
.review{
	width: 100%;
	height: 48%;
	border: solid green 1px;
	margin-bottom: 10px;
}
.review_img{
	width: 20%;
	height: 100%;
	border: solid green 1px;
	float: left;
}
.review_img img{
	width: 100%;
	height: 100%;
}
.review_contents {
	float: left;
	margin-left: 15px;
	width: 74%;
	height: 100%;
}
/* 별점 */
.star-rating{ 
	width: 100px; 
}
.star-rating,.star-rating span{ 
	display:inline-block; 
	height:19px; 
	overflow:hidden; 
	background:url(../resources/images/movie/star.png)no-repeat; 
}
.star-rating span{ 
	background-position:left bottom; 
	line-height:0; 
	vertical-align:top; 
}
.contents-top{
	border-bottom: 1px solid black;
}
</style>
</head>
<body>
	<%@ include file="/resources/part/header1.jspf" %>
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
							<h3>사진 3</h3>
						</div>
					</div>
					
					<div class="item">
						<a href="#"><img src="${pageContext.request.contextPath}/resources/img/intro.jpg"></a>
						<div class="carousel-caption">
							<h3>사진 4</h3>
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
		<div class="sub sub_left">
			<div id="myCarousel2" class="carousel slide" data-ride="carousel">
				<!-- Indicators -->
				<ol class="carousel-indicators">
					<li data-target="#myCarousel2" data-slide-to="0" class="active"></li>
					<li data-target="#myCarousel2" data-slide-to="1"></li>
					<li data-target="#myCarousel2" data-slide-to="2"></li>
					<li data-target="#myCarousel2" data-slide-to="3"></li>
				</ol>

				<!-- Wrapper for slides -->
				<div class="carousel-inner" role="listbox" style="height: 300px;">
					<div class="item active">
						<a href="#"><img style="height: 300px;" src="${pageContext.request.contextPath}/resources/img/intro.jpg"></a>
						<div class="carousel-caption">
							<h3>방구 1</h3>
						</div>
					</div>

					<div class="item">
						<a href="#"><img style="height: 300px;" src="${pageContext.request.contextPath}/resources/img/intro.jpg"></a>
						<div class="carousel-caption">
							<h3>방구 2</h3>
						</div>
					</div>
					
					<div class="item">
						<a href="#"><img style="height: 300px;" src="${pageContext.request.contextPath}/resources/img/intro.jpg"></a>
						<div class="carousel-caption">
							<h3>방구 3</h3>
						</div>
					</div>
					
					<div class="item">
						<a href="#"><img style="height: 300px;" src="${pageContext.request.contextPath}/resources/img/intro.jpg"></a>
						<div class="carousel-caption">
							<h3>방구 4</h3>
						</div>
					</div>
				</div>

				<!-- Left and right controls -->
				<a class="left carousel-control" href="#myCarousel2" role="button" data-slide="prev">
					<span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
					<span class="sr-only">Previous</span>
				</a> <a class="right carousel-control" href="#myCarousel2" role="button"	data-slide="next">
					<span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
					<span class="sr-only">Next</span>
				</a>
			</div>
		</div>
		<div class="sub sub_right">
			<div id="paidLowList">
			<p>유료 영화 업로드(일반영화)</p>
				<table>
					<c:forEach begin="1" end="5" items="${basicInfoList }" var="list" step="1">
						<tr>
							<td id="${list.num }" class="viewMovieInfo" title="basic">${list.title }</td>
						</tr>
					</c:forEach>
				</table>
			</div>
			<div id="paidBasicList">
			<p>유료 영화 업로드(독립영화)</p>
				<table>
					<c:forEach begin="1" end="5" items="${lowInfoList }" var="list" step="1">
						<tr>
							<td id="${list.num }" class="viewMovieInfo" title="low">${list.title }</td>
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>
		<div class="sub sub_left">sub3</div>
		<div class="sub sub_right">
			<c:forEach items="${reviewList }" var="list">
				<div class="review">
					<div class="review_img">
						<img src="${list.movieInfo.thumnail }">
					</div>
					<div class="review_contents">
						<div class="contents-top">
							<p>${list.movieInfo.title }(${list.movieInfo.year })</p>
							<p>${list.reviewInfo.writer }
								<span class="star-rating">
									<span style="width: ${list.reviewInfo.myRating*10}%"></span>
								</span>(${list.reviewInfo.myRating}/10점) - 좋아요 ${list.reviewInfo.likes}
							</p>
						</div>
						<div class="contents-bot">
							${list.reviewInfo.contents}
						</div>
					</div>
				</div>
			</c:forEach>
		</div>
	</section>
</body>
</html>