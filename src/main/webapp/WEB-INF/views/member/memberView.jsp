<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/resources/part/bootStrap.jspf" %>
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.js"></script>
<link rel="styleSheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/header.css">
<link rel="styleSheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/section.css">
<title>Insert title here</title>
<style type="text/css">
.profile{
	width: 200px;
	height: 200px;
}
</style>
<script type="text/javascript">
$(function(){
	$("#update").click(function(){
		location.href="memberUpdate";
	});

	$("#delete").click(function(){
		location.href="memberDelete";
	});
	
	$("#home").click(function(){
		location.href="../";
	});

	$("#Member_management").click(function(){
		location.href="memberList?curPage=1&kind=&search=";
	});

	$("#Movie_management").click(function(){
		location.href="../movie/movieSchedule/movieScheduleList";
	});
});
</script>
</head>
<body>
	<%@ include file="/resources/part/header1.jspf" %>

	<section>
	<h2>Member View</h2>
	<input type="text" name="id" value="${memberDTO.kind}" readonly="readonly">
	<h3>ID : ${memberDTO.id}</h3>
	<h3>NAME : ${memberDTO.name}</h3>
	<h3>PHONE : ${memberDTO.phone}</h3>
	<h3>IMG</h3>

	<c:if test="${memberDTO.getFname() ne ' '}">
		<p><img class="profile" src="${pageContext.request.contextPath}/resources/upload/member/${memberDTO.fname}"></p>
	</c:if>

	<c:if test="${memberDTO.getFname() eq ' '}">
		<p>사진이 없습니다.</p>
	</c:if>

	<div>
		<input type="button" class="btn btn-warning" value="UPDATE" id="update">
		<input type="button" class="btn btn-danger" value="DELETE" id="delete">
		<input type="button" class="btn btn-success" value="HOME" id="home">

		<c:if test="${memberDTO.getKind() eq '관리자'}">
			<input type="button" class="btn btn-info" value="회원 MANAGEMENT" id="Member_management">
			<input type="button" class="btn btn-info" value="영화 MANAGEMENT" id="Movie_management">
		</c:if>
		
	</div>
	</section>
</body>
</html>