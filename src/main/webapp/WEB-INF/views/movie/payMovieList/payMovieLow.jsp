<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>MOVIE COMMUNICATION</title>
<%@ include file="/resources/part/bootStrap.jspf"%>
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.js"></script>
<link rel="styleSheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/header.css">
<link rel="styleSheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/section.css">
<link rel="styleSheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/movieSearchHome.css">	
<script type="text/javascript">
	$(function(){
		var curPage=${curPage };
		
		$("#search").click(function(){
			$("#frm").submit();
		});
		
		$(".go").click(function() {
			curPage = $(this).attr("id");
			location.href = "./payMovieLow?curPage=" + curPage;
		});
		
		$("#searchResult").on('click','.searchResultWrap',function(){
			var num = $(this).attr("id");
			location.href="../lowpricemovie/movieView?num="+num;
		});
		
	});
</script>
<style type="text/css">

.searchResultWrap{
	border:1px solid #ccc;
}

</style>
</head>
<body>
	<%@ include file="/resources/part/header1.jspf" %>
	<section>
	
	<!-- SEARCH -->
	<div id="searchForm">
		<form action="./payMovieLow" id="frm">
			<input type="text" name="title" placeholder="영화 제목 검색">
			<input type="hidden" name="curPage" value="1">
			<input type="button" class="btn btn-default" value="Search" id="search">
		</form>
	</div>
	
	<div class="container">
	<div id="searchResult">
	<c:forEach var="list" items="${list }">
		<div class="searchResultWrap" id="${list.num }">
			<div class="searchResultWrap-left">
				<c:if test="${list.thumnail == null }">
					<img src="../../resources/images/directorBoard/sample_img.jpg">
				</c:if>
				<c:if test="${list.thumnail != null }">
					<img src="${list.thumnail }">
				</c:if>
			</div>
			<div class="searchResultWrap-right">
				<p style="font-size: 25px;">${list.title }(${list.eng_title })</p>
				<span class="star-rating">
					<span style="width: ${list.user_rating*10}%"></span>
				</span>
				<span class="movie_info" style="font-size: 17px; margin-bottom: 2px;">${list.user_rating }/10</span>
				<p><span class="movie_info">${list.genre}</span>| <span class="movie_info">${list.pub_date}</span> | <span class="movie_info">${list.play_time}</span> |	<span class="movie_info">${list.nation}</span> | <span class="movie_info">${list.watching_rate}</span></p>
				<p><span class="movie_info">감독</span> ${list.director}</p>
				<p><span class="movie_info">주연</span> ${list.actor}</p>
			</div>
		</div>
	</c:forEach>
	<!-- PAGING -->
	<div class="paging">
		<ul class="paging pagination">
			<c:if test="${pageResult.curBlock>1}">
				<li class="go" id="${pageResult.startNum-1}"><a>이전</a></li>
			</c:if>
			<c:forEach begin="${pageResult.startNum}" end="${pageResult.lastNum}" var="i">
				<li class="go" id="${i}"><a>${i}</a></li>
			</c:forEach>
			<c:if test="${pageResult.curBlock<pageResult.totalBlock}">
				<li class="go" id="${pageResult.lastNum+1}"><a>다음</a></li>
			</c:if>
		</ul>
	</div>
	</div>
	</div>
	</section>
</body>
</html>