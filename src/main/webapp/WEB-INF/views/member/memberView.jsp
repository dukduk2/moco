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
<link rel="styleSheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/list.css">
<title>MOVIE COMMUNICATION</title>

<script type="text/javascript">
$(function(){
	$("#update").click(function(){
		location.href="memberUpdate";
	});

	$("#delete").click(function(){
		var check = confirm("정말 삭제 하시겠습니까?");
		if(check){
			location.href="memberDelete";
		} else {
			
		}
	});
	
	$("#home").click(function(){
		location.href="../";
	});
	
	$("#jjim").click(function(){
		location.href="./viewJjimList";
	});
	
	$("#myMovie").click(function(){
		location.href="./myMovieList";
	});
	
});
</script>

<style type="text/css">
.member_Table {
 	width: 600px;
 	margin: 20px auto;
}

.profile{
	width: 200px;
	height: 200px;
}
.write-tdName{
	font-size: 1.3em;
	font-weight: bold;
	font-family: Montserrat, sans-serif;
}
.write-tdWrite{
	font-size: 1.3em;
	font-weight: bold;
}
</style>

</head>
<body>
	<%@ include file="/resources/part/header3.jspf" %>

	<section>
		<div class="container">
			<h2 style="text-align: center;">Member View</h2>

			<table class="member_Table">
				<tr>
					<td class="write-tdName">프로필 사진</td>
					<td class="write-tdWrite">
						<c:if test="${memberDTO.getFname() ne ' '}">
							<p><img class="profile" src="${pageContext.request.contextPath}/resources/upload/member/${memberDTO.oname}"></p>
						</c:if>

						<c:if test="${memberDTO.getOname() eq ' '}">
							<p>사진이 없습니다.</p>
						</c:if>
					</td>
				</tr>

				<tr>
					<td class="write-tdName">등급</td>
					<td class="write-tdWrite">${memberDTO.grade}</td>
				</tr>

				<tr>
					<td class="write-tdName">아이디</td>
					<td class="write-tdWrite">${memberDTO.id}</td>
				</tr>
				
				<tr>
					<td class="write-tdName">mail</td>
					<td class="write-tdWrite">${memberDTO.email}</td>
				</tr>

				<tr>
					<td class="write-tdName">이름</td>
					<td class="write-tdWrite">${memberDTO.name}</td>
				</tr>

				<tr>
					<td class="write-tdName">전화번호</td>
					<td class="write-tdWrite">${memberDTO.phone}</td>
				</tr>

				<tr>
					<td class="write-tdName">가입날짜</td>
					<td class="write-tdWrite">${memberDTO.joinDate}</td>
				</tr>
				
				<tr>
					<td class="write-tdName">내가 받은 좋아요</td>
					<td class="write-tdWrite">${memberDTO.likes} 개</td>
				</tr>
				
				<tr>
					<td class="write-tdName">포인트 전환 가능 좋아요</td>
					<td class="write-tdWrite">${memberDTO.avaliableLikes} 개</td>
				</tr>
				
				<tr>
					<td class="write-tdName">포인트</td>
					<td class="write-tdWrite">${memberDTO.point} Point</td>
				</tr>
				
				<tr>
					<td colspan="2">
						<input type="button" class="btn btn-default" value="UPDATE" id="update">
						<input type="button" class="btn btn-default" value="DELETE" id="delete">
						<input type="button" class="btn btn-default" value="HOME" id="home">
						<input type="button" class="btn btn-default" value="내찜리스트" id="jjim">
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