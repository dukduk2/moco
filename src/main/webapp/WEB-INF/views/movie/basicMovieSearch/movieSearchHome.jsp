<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/resources/part/bootStrap.jspf" %>
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.js"></script>
<link rel="styleSheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/header.css">
<link rel="styleSheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/section.css">
<link rel="styleSheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/movieSearchHome.css">
<title>MOVIE COMMUNICATION</title>

<script type="text/javascript">
	$(function(){
		// 검색 
		var title="";
		var genre="";
		var yearMin=0;
		var yearMax=0;
		var director="";
		var actor="";
		var nation="";
		var curPage=1;
		// 첫 로딩
		searchAjax(title, genre, yearMin, yearMax, director, actor, nation, curPage);
		// 검색
		$("#searchBtn").click(function(){
			title = $("#title").val();
			genre = $("#genre").val();
			yearMin = $("#yearMin").val();
			yearMax = $("#yearMax").val();
			director = $("#director").val();
			nation = $("#nation").val();
			actor = $("#actor").val();
			searchAjax(title, genre, yearMin, yearMax, director, actor, nation, curPage);
		});
		// 페이징
		$("#searchResult").on('click','.go',function(){
			var curPage = $(this).attr("id");
			searchAjax(title, genre, yearMin, yearMax, director, actor, nation, curPage);
		});
		// view
		$("#searchResult").on('click','.searchResultWrap',function(){
			var num = $(this).attr("id");
			location.href="./movieView?num="+num;
		});
		// ajax function
		function searchAjax(title, genre, yearMin, yearMax, director, actor, nation, curPage){
			$.ajax({
				url : "./movieSearch",
				type : "POST",
				data : {
					title: title,
					genre : genre,
					yearMin : yearMin,
					yearMax : yearMax,
					director : director,
					actor : actor,
					nation : nation,
					curPage : curPage
				},
				success : function(data) {
					$("#searchResult").html(data);
				}
			});
		}
	});
</script>
</head>
<body>
	<%@ include file="/resources/part/header1.jspf" %>
		<section>
			<ul class="nav nav-tabs nav-justified">
			    <li class="active"><a href="#">영화검색</a></li>
			    <li><a href="./movieRecommend/recommendHome">영화추천</a></li>
			</ul>

			<!-- SEARCH -->
			<div id="searchForm">
				<table class="search_table">
					<tr>
						<td class="title top_left">제목</td>
						<td class="input top_right"><input type="text" class="form-control" id="title" style="width :100%;"></td>
					</tr>
	
					<tr>
						<td class="title">장르</td>

						<td class="input">
							<select class="form-control" id="genre" style="width :100%;">
								<option value="all">전체</option>
								<option value="판타지">판타지</option>
								<option value="공포">공포</option>
								<option value="로맨스/멜로">로맨스/멜로</option>
								<option value="모험">모험</option>
								<option value="스릴러">스릴러</option>
								<option value="느와르">느와르</option>
								<option value="다큐멘터리">다큐멘터리</option>
								<option value="코디미">코디미</option>
								<option value="가족">가족</option>
								<option value="미스터리">미스터리</option>
								<option value="전쟁">전쟁</option>
								<option value="애니메이션">애니메이션</option>
								<option value="범죄">범죄</option>
								<option value="뮤지컬">뮤지컬</option>
								<option value="SF">SF</option>
								<option value="액션">액션</option>
							</select>
						</td>
					</tr>
	
					<tr>
						<td class="title">제작년도</td>
	
						<td class="input">
							<span class="form-inline" role="form">
								<span class="form-group">
									<label class="sr-only" for="yearMin">Start Year</label>
									<input class="form-control" type="number" min="1950" id="yearMin" value="1950" style="width :100%;">
								</span>
									
								&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;&nbsp;
	
								<span class="form-group">
									<label class="sr-only" for="yearMax">yearMax</label>
									<input type="number" class="form-control" min="1950" max="2050" id="yearMax" value="2050" style="width :100%;">
								</span>
							</span>
						</td>
					</tr>
	
					<tr>
						<td class="title">감독</td>
						<td class="input"><input type="text" class="form-control" id="director" style="width :100%;"></td>
					</tr>
	
					<tr>
						<td class="title">배우</td>
						<td class="input"><input type="text" class="form-control" id="actor" style="width :100%;"></td>
					</tr>
	
					<tr>
						<td class="title bottom_left">제작국가</td>
						<td class="input bottom_right">
							<select class="form-control" id="nation" style="width :100%;">
								<option value="all">전체</option>
								<c:forEach var="list" items="${nationList }">
									<option value="${list }">${list }</option>
								</c:forEach>
							</select>
						</td>
					</tr>
						
					<tr>
						<td colspan="2"><input type="button" value="검색" id="searchBtn" class="btn"></td>
					</tr>
				</table>
			</div>
			
			<div class="container">
				<!-- RESULT -->
				<div id="searchResult"></div>
			</div>
		</section>
</body>
</html>