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
<link rel="styleSheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/member.css">
<title>Insert title here</title>

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

	/* $("#Member_management").click(function(){
		location.href="memberList?curPage=1&kind=&search=";
	});

	$("#Movie_management").click(function(){
		location.href="../movie/movieSchedule/movieScheduleList";
	}); */
});
</script>
</head>
<body>
	<%@ include file="/resources/part/header1.jspf" %>

	<section>
		<div class="container">
			<h2 class="title"><img class="icon" src="../resources/images/icon/pop.png"> Member View</h2>

			<table class="member_Table">
				<tr>
					<td class="name">프로필 사진</td>
					<td class="push">
						<c:if test="${memberDTO.getFname() ne ' '}">
							<p><img class="profile" src="${pageContext.request.contextPath}/resources/upload/member/${memberDTO.fname}"></p>
						</c:if>

						<c:if test="${memberDTO.getFname() eq ' '}">
							<p>사진이 없습니다.</p>
						</c:if>
					</td>
				</tr>

				<tr>
					<td class="name">등급</td>
					<td class="push">${memberDTO.grade}</td>
				</tr>

				<tr>
					<td class="name">아이디</td>
					<td class="push">${memberDTO.id}</td>
				</tr>

				<tr>
					<td class="name">이름</td>
					<td class="push">${memberDTO.name}</td>
				</tr>

				<tr>
					<td class="name">전화번호</td>
					<td class="push">${memberDTO.phone}</td>
				</tr>

				<tr>
					<td class="name">가입날짜</td>
					<td class="push">${memberDTO.joinDate}</td>
				</tr>

				<tr>
					<td class="name" colspan="2">
						<input type="button" class="btn btn-warning" value="UPDATE" id="update">
						<input type="button" class="btn btn-danger" value="DELETE" id="delete">
						<input type="button" class="btn btn-success" value="HOME" id="home">
					</td>
				</tr>
			</table>
		</div>

		<div>
			
	
			<%-- <c:if test="${memberDTO.getKind() eq '관리자'}">
				<input type="button" class="btn btn-info" value="회원 MANAGEMENT" id="Member_management">
				<input type="button" class="btn btn-info" value="영화 MANAGEMENT" id="Movie_management">
			</c:if> --%>
			
		</div>
	</section>
</body>
</html>