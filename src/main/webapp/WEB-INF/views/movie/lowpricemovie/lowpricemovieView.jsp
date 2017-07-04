<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
#contents_wrap{
	width : 900px;
	height : 900px;
	margin : 0 auto;
}
#d1{
	display: inline-block;
}
</style>
</head>
<body>

	<div id="contents_wrap">
		<div>
			<div id="d1">
				<img alt="MOVIE_IMG" src="<!-- ../../resources/upload/lowpricemovie/ -->${lowpricemovie.thumnail }"> 
			</div>
			<div>
				<div>
					<p>TITLE : ${lowpricemovie.title }</p>
					<p>DIRECTOR : ${lowpricemovie.director }</p>
					<p>ACTOR : ${lowpricemovie.actor }</p>
					<p>GENRE : ${lowpricemovie.genre}</p>
					<p>NATION : ${lowpricemovie.nation }</p>
					
				</div>
				<div>
					<p>STORY : ${lowpricemovie.story }</p>
				</div>	
			</div>
		</div>
		
		<div>
			<a href="theaterInsert?num=${lowpricemovie.num }">상영관 신청하기</a>
		</div>
	</div>


	
	
	
	
	
	
	<%-- <h4>S_DATE - E_DATE : ${screen.s_date} - ${screen.e_date}</h4> --%>
	<a href="lowpricemovieList">LIST</a>
	<a href="lowpricemovieDelete?num=${lowpricemovie.num}">DELETE</a>
	<a href="lowpricemovieUpdate?num=${lowpricemovie.num}">UPDATE</a>
	
</body>
</html>