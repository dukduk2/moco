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
<title>Insert title here</title>
<script type="text/javascript">
	$(function(){
		var movie_num = $("#movie_num").val();
		var theater_num = 0;
		var multi_num = 0;
		
		$("#theater").change(function(){
			theater_num = $(this).val();
			
			$.post("multiplexList_ajax", {theater_num:theater_num}, function(data){
				$("#multiplex").html(data);
			});
		});
		
		$("#multiplex").change(function(){
			multi_num = $(this).val();
			
		});
		
		$("#mul_add").click(function(){
			$.post("multiplexList_ajax", {theater_num:theater_num}, function(data){
				$("#multiplex").append(data);
			});
		});
		 
		
	});
</script>
<title>Insert title here</title>

</head>
<body>
	<%@ include file="/resources/part/header1.jspf" %>
	<section>
	<form action="theaterInsert" method="post">
		영화 제목 : ${lowpricemovie.title }
		<input type="hidden" id="movie_num" name="movie_num" value="${lowpricemovie.num }"><br>
		극장
		<select id="theater" name="theater_num">
			<option>선택</option>
			<c:forEach items="${list }" var="list">
				<option value="${list.num }">${list.name }</option>
			</c:forEach>
		</select>
		<br>
		상영관
		<div id="multiplex">
		
		</div>
		
		<input type="button" value="add" id="mul_add">
		
		
		
		<!-- 상영시작시간 : 영화시간+준비시간10  -->
		
		<button>insert</button>
		
		
	</form>
	</section>
</body>
</html>