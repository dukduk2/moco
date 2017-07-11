<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="/resources/part/bootStrap.jspf" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
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
</style>
</head>
<body>
		<table>
			<tr>
				<td>제목</td>
				<td>감독</td>
				<td>개봉일</td>
				<td>별점</td>
			</tr>
			<c:forEach items="${jjimMovieList}" var="list">
				<tr>
					<td id="${list.movieDTO.num }" title="${list.kind }" class="viewMovieInfo">${list.movieDTO.title }</td>
					<td>${list.movieDTO.director }</td>
					<td>${list.movieDTO.pub_date }</td>
					<td>
						<span class="star-rating">
							<span style="width: ${list.movieDTO.user_rating*10}%"></span>
						</span><span>${list.movieDTO.user_rating }/10점</span>
					</td>
					<td class="jjimDelete" id="${list.kind }" title="${list.movieDTO.num }">찜하기 취소</td>
				</tr>
			</c:forEach>
		</table>
</body>
</html>