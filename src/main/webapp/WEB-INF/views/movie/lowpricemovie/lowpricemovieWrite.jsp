<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>MOVIE COMMUNICATION</title>
</head>
<body>
	<form action="lowpricemovie${state}" method="post" enctype="multipart/form-data">
		<p><input type="hidden" name="num" value="${lowpricemovie.num }"></p>
		
		<c:if test="${state ne 'Update'}">
		title <p><input type="text" name="title"></p>
		eng_title <p><input type="text" name="eng_title"></p>
		genre <p><input type="text" name="genre"></p>
		director <p><input type="text" name="director"></p>
		actor <p><input type="text" name="actor"></p>
		year <p><input type="number" name="year"></p>
		nation <p><input type="text" name="nation"></p>
		trailer <p><input type="text" name="trailer"></p>
		</c:if>
		
		pub_date <p><input type="date" name="pub_date"></p>
		watching_rate <p><input type="text" name="watching_rate"></p>
		
		<c:if test="${state ne 'Update'}">
		play_time <p><input type="text" name="play_time"></p>
		story <p><textarea rows="" cols="" name="story"></textarea></p>
		keyword <p><input type="text" name="keyword"></p>
		
		<p><input type="hidden" name="user_rating" value="0"></p>
		movie img <p><input type="file" name="f1"></p>
		</c:if>
		
		<button>${state}</button>
	</form>
</body>
</html>