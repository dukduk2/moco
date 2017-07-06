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
<title>Insert title here</title>
<style type="text/css">
	#searchResult{
		margin-top: 50px;
	}
	.searchResultWrap{
		width: 100%;
		height: 220px;
		border-bottom: 1px solid #cccccc;
	}
	.searchResultWrap-left{
		width: 15%;
		height: 200px;
		margin-top: 10px;
		float: left; 
	}
	.searchResultWrap-left img{
		width: 180px;
		height: 200px;
	}
	.searchResultWrap-right{
		width: 75%;
		height: 180px;
		margin-top: 10px;
		float: left; 
	}
	#contentsWrap{
		width: 1400px;
		margin: 0 auto;
	}
	#searchForm, #searchForm table{
		width: 100%;
		margin-top: 20px;
	}
	#searchForm table tr{
		height: 42px;
	}
	#searchForm table input, select{
		margin-left: 15px;
		height: 30px;
	}
	#searchForm select{
		width: 140px;
	}
	#title, #director, #actor{
		width: 98%;
	}
	#yearMin, #yearMax{
		width: 140px;
	}
	.title{
		width: 13%;
		background-color: #525f78;
		color: white;
		font-weight: bold;
		font-size: 13px;
		text-indent: 10px;
	}
	.input{
		border: 1px solid #cccccc;
	}
	#searchBtn{
		width: 181px;
		height: 42px;
		float: right;
		margin-top: 10px;
		background-color: #525f78;
		color: white;
	}
	/* 별점 */
	.star-rating{ 
		width: 100px;
	}
	.star-rating,.star-rating span{ 
		display:inline-block; 
		height:19px; 
		overflow:hidden; 
		background:url(../../resources/images/movie/star.png)no-repeat; 
	}
	.star-rating span{ 
		background-position:left bottom; 
		line-height:0; 
		vertical-align:top; 
	}
</style>
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
		<section id="contentsWrap">
			<ul class="nav nav-tabs nav-justified">
			    <li class="active"><a href="#">영화검색</a></li>
			    <li><a href="./movieRecommend/recommendHome">영화추천</a></li>
			</ul>
			
			<!-- SEARCH -->
			<div id="searchForm">
				<table>
					<tr>
						<td class="title">제목</td>
						<td class="input"><input type="text" id="title"></td>
					</tr>
					<tr>
						<td class="title">장르</td>
						<td class="input">
							<select id="genre">
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
							<input type="number" min="1950" id="yearMin" value="1950">  -<input type="number" min="1950" max="2050" id="yearMax" value="2050">
						</td>
					</tr>
					<tr>
						<td class="title">감독</td>
						<td class="input"><input type="text" id="director"></td>
					</tr>
					<tr>
						<td class="title">배우</td>
						<td class="input"><input type="text" id="actor"></td>
					</tr>
					<tr>
						<td class="title">제작국가</td>
						<td class="input">
							<select id="nation">
								<option value="all">전체</option>
								<c:forEach var="list" items="${nationList }">
									<option value="${list }">${list }</option>
								</c:forEach>
							</select>
						</td>
					</tr>
				</table>
				<input type="button" value="검색" id="searchBtn" class="btn">
			</div>
			<!-- RESULT -->
			<div id="searchResult">
				
			</div>
		</section>
</body>
</html>