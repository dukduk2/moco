<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/resources/part/bootStrap.jspf" %>
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.js"></script>
<link rel="styleSheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/header.css">
<link rel="styleSheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/section.css">
<script type="text/javascript">
	$(function(){
		
		$("#write").click(function(){
			location.href="./lowpricemovieInsert";
		});
		
		$("#home").click(function(){
			location.href="../../";
		});
		
		$(".go").click(function(){
			var curPage=$(this).attr("id");
			location.href="./lowpricemovieList?curPage="+curPage+"&kind=${kind}&search=${search}";
		});
		
	});
</script>
<title>Insert title here</title>
<style type="text/css">
.contents-wrap {
	width: 950px;
	margin: 0 auto;
}
.profile {
	border: 1px solid black;
	width: 300px;
	height: 300px;
	margin-right: 10px;
	margin-top: 10px;
	display: inline-block;
}
.paging{
		margin : 20px auto;
}
.search{
		width : 150px;
}
</style>
</head>
<body>
	<%@ include file="/resources/part/header1.jspf" %>
	<a href="theaterList">theater List</a>
	<section>
	<div class="contents-wrap">
		<div>
		<!-- title, fname, userRating, *s_date, *e_date -->
			<c:forEach items="${list}" var="list">
				<input type="hidden" name="num" value="${list.num }">
				
				<div class="profile">
					TITLE : <a href="./lowpricemovieView?num=${list.num}">${list.title }</a>
					개봉일 : ${list.pub_date } 
					<a href="./lowpricemovieView?num=${list.num}"><img src="${list.thumnail}"	class="img-responsive" style="width: 270px; height: 270px;"	alt="Image"></a>
				</div>
				
			</c:forEach>
		</div>
		
	
		<div class="paging">
			<c:if test="${pageResult.curBlock>1}">
				<span class="go" id="${pageResult.startNum-1}">[이전]</span>
			</c:if>
			<c:forEach begin="${pageResult.startNum}" end="${pageResult.lastNum}" var="i">
				<span class="go" id="${i}">${i}</span>
			</c:forEach>
			<c:if test="${pageResult.curBlock<pageResult.totalBlock}">
				<span class="go" id="${pageResult.lastNum+1}">[다음]</span>
			</c:if>
		</div>

		<div class="search">
			<form action="lowpricemovieList">
				<select name="kind" class="form-control">
					<option value="title">제목으로 검색</option>
				</select>
				<input type="hidden" name="curPage" value="">
				<input type="text" class="form-control" name="search" placeholder="검색">
				<button class="btn btn-info">검색</button>
			</form>
		</div>
		
		
		<input type="button" class="btn btn-info" value="글쓰기" id="write">
		<input type="button" class="btn btn-success" value="홈으로" id="home">
	</div>
	</section>
</body>
</html>