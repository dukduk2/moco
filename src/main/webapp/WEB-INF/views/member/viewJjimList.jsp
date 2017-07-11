<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/resources/part/bootStrap.jspf" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/resources/part/bootStrap.jspf" %>
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.js"></script>
<link rel="styleSheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/header.css">
<link rel="styleSheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/section.css">
<link rel="styleSheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/list.css">
<title>MOVIE COMMUNICATION</title>
<script type="text/javascript">
	$(function(){
		// 영화 정보 보기
		$(".viewMovieInfo").click(function(){
			var num = $(this).attr("id");
			var kind = $(this).attr("title");
			if(kind == 'basic'){
				location.href="../movie/basicMovieSearch/movieView?num="+num;
			}else{
				location.href="../movie/lowpricemovie/movieView?num="+num;			
			}
		});
		// 영화 찜하기 취소
		$(".jjimDelete").click(function(){
			var num = $(this).attr("title");
			var kind = $(this).attr("id");			
			if(confirm("찜하기를 취소하시겠습니까?")){
				location.href="./jjimDelete?num="+num+"&kind="+kind;
			}
		});
	});
</script>
<style type="text/css">
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
	.star-wrap {
		width: 170px;
		text-align: left;
	}

	.viewMovieInfo:hover {
		font-weight: bolder;
		color: blue;
		cursor: pointer;
	}

	.jjimDelete:hover {
		cursor: pointer;
		color: red;
	}
</style>
</head>
<body>
	<%@ include file="/resources/part/header3.jspf" %>
	<section>
		<div class="container">
			<table class="table table-hover">
				<colgroup>
					<col width="30%">
					<col width="20%">
					<col width="20%">
					<col width="20%">
					<col width="10%">
				</colgroup>
				<thead><tr class="head">
					<td>제목</td>
					<td>감독</td>
					<td>개봉일</td>
					<td>별점</td>
					<td>Cancel</td>
				</tr></thead>

				<c:forEach items="${jjimMovieList}" var="list">
					<tr class="body">
						<td id="${list.movieDTO.num }" title="${list.kind }" class="viewMovieInfo">${list.movieDTO.title }</td>
						<td>${list.movieDTO.director }</td>
						<td>${list.movieDTO.pub_date }</td>
						<td>
							<span class="star-wrap">
								<span class="star-rating">
									<span style="width: ${list.movieDTO.user_rating*10}%"></span>
								</span>
							</span>
							<span>${list.movieDTO.user_rating }/10점</span>
						</td>
						<td><input type="button" value="찜하기 취소" class="jjimDelete" id="${list.kind }" title="${list.movieDTO.num }"></td>
					</tr>
				</c:forEach>
			</table>
		</div>
	</section>
</body>
</html>