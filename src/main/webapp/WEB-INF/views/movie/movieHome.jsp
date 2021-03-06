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
<link rel="styleSheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/list.css">
<title>MOVIE COMMUNICATION</title>
<script type="text/javascript">
	$(function(){
		$(".viewMovieInfo").click(function(){
			var kind = $(this).attr("title");
			var num = $(this).attr("id");
			if(kind == 'basic'){
				location.href="./basicMovieSearch/movieView?num="+num;
			}else{
				location.href="./lowpricemovie/movieView?num="+num;
			}
		});
		$(".review").click(function(){
			var kind = $(this).attr("title");
			var num = $(this).attr("id");
			if(kind == 'basic'){
				location.href="./basicMovieSearch/movieView?num="+num;
			}else{
				location.href="./lowpricemovie/movieView?num="+num;
			}
		});
	});
</script>
<style type="text/css">
.img {
	width: 100%;
	height: 400px;
	margin: 0 auto;
	margin-top: 10px;
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
	font-size: 20px;
	font-weight: bold;
}

.sub_left{
	margin-left: 4%;
	float: left;
}

.sub_right {
	margin-right: 4%;
	float: right;
}
#paidLowList{
	width: 48%;
	height: 100%;
	float: left;
}

#paidBasicList{
	width: 48%;
	height: 100%;
	float: right;
}
.review{
	width: 100%;
	height: 48%;
	border: solid black 1px;
	margin-bottom: 10px;
}

.review:hover {
	cursor: pointer;
	background-color: #e6e6e6;
}

.review_img{
	width: 20%;
	height: 100%;
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
.viewMovieInfo:hover {
	cursor: pointer;
	color: blue;
}
</style>
</head>
<body>
	<%@ include file="/resources/part/header1.jspf" %>
	<section>
	
		<%-- <div class="img">
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
					<c:forEach items="${thumnail}" var="thumnail">
						<div class="item active">
							<a href="./lowpricemovie/movieView?num=${thumnail.num}"><img style="width: 50%;" src="${thumnail.thumnail}"></a>
							<div class="carousel-caption">
								<!-- <h3>사진 1</h3> -->
							</div>
						</div>					
					</c:forEach>
				</div>

				<!-- Left and right controls -->
				<c:if test="${thumSU>1}">
					<div>
					<a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
						<span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
						<span class="sr-only">Previous</span>
					</a> <a class="right carousel-control" href="#myCarousel" role="button"	data-slide="next">
						<span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
						<span class="sr-only">Next</span>
					</a>				
					</div>				
				</c:if>
				
			</div>
		</div> --%>
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
						<a href="#"><img style="height: 300px;" src="${lowMovieRecommendList[0].thumnail}"></a>
						<div class="carousel-caption">
							<h3>${lowMovieRecommendList[0].pub_date}개봉</h3>
						</div>
					</div>

					<div class="item">
						<a href="#"><img style="height: 300px;" src="${lowMovieRecommendList[1].thumnail}"></a>
						<div class="carousel-caption">
							<h3>${lowMovieRecommendList[1].pub_date}개봉</h3>
						</div>
					</div>
					
					<div class="item">
						<a href="#"><img style="height: 300px;" src="${lowMovieRecommendList[2].thumnail}"></a>
						<div class="carousel-caption">
							<h3>${lowMovieRecommendList[2].pub_date}개봉</h3>
						</div>
					</div>
					
					<div class="item">
						<a href="#"><img style="height: 300px;" src="${lowMovieRecommendList[3].thumnail}"></a>
						<div class="carousel-caption">
							<h3>${lowMovieRecommendList[3].pub_date}개봉</h3>
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
				
				<table class="table table-hover">
					<thead><tr class="head">
						<td>유료 영화 업로드(일반영화)</td>
					</tr></thead>
					<c:forEach begin="1" end="5" items="${basicInfoList }" var="list" step="1">
						<tr class="body">
							<td id="${list.num }" class="viewMovieInfo" title="basic">${list.title }</td>
						</tr>
					</c:forEach>
				</table>
			</div>

			<div id="paidBasicList">
				<table class="table table-hover">
					<thead><tr class="head">
						<td>유료 영화 업로드(독립영화)</td>
					</tr></thead>
					<c:forEach begin="1" end="5" items="${lowInfoList }" var="list" step="1">
						<tr class="body">
							<td id="${list.num }" class="viewMovieInfo" title="low">${list.title }</td>
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>
		<div class="sub sub_left">
			<div id="myCarousel3" class="carousel slide" data-ride="carousel">
				<!-- Indicators -->
				<ol class="carousel-indicators">
					<li data-target="#myCarousel3" data-slide-to="0" class="active"></li>
					<li data-target="#myCarousel3" data-slide-to="1"></li>
					<li data-target="#myCarousel3" data-slide-to="2"></li>
					<li data-target="#myCarousel3" data-slide-to="3"></li>
				</ol>

				<!-- Wrapper for slides -->
				<div class="carousel-inner" role="listbox" style="height: 300px;">
					<div class="item active">
						<a href="#"><img style="height: 300px; " src="${basicMovieRecommendList[0].thumnail}"></a>
						<div class="carousel-caption">
							<h3>${basicMovieRecommendList[0].pub_date}개봉</h3>
						</div>
					</div>

					<div class="item">
						<a href="#"><img style="height: 300px;" src="${basicMovieRecommendList[1].thumnail}"></a>
						<div class="carousel-caption">
							<h3>${basicMovieRecommendList[1].pub_date}개봉</h3>
						</div>
					</div>
					
					<div class="item">
						<a href="#"><img style="height: 300px;" src="${basicMovieRecommendList[2].thumnail}"></a>
						<div class="carousel-caption">
							<h3>${basicMovieRecommendList[2].pub_date}개봉</h3>
						</div>
					</div>
					
					<div class="item">
						<a href="#"><img style="height: 300px;" src="${basicMovieRecommendList[3].thumnail}"></a>
						<div class="carousel-caption">
							<h3>${basicMovieRecommendList[3].pub_date}개봉</h3>
						</div>
					</div>
				</div>

				<!-- Left and right controls -->
				<a class="left carousel-control" href="#myCarousel3" role="button" data-slide="prev">
					<span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
					<span class="sr-only">Previous</span>
				</a> <a class="right carousel-control" href="#myCarousel3" role="button" data-slide="next">
					<span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
					<span class="sr-only">Next</span>
				</a>
			</div>
		</div>
		<div class="sub sub_right">
			<c:forEach items="${reviewList }" var="list">
				<div class="review" id="${list.movieInfo.num }" title="${list.kind }">
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