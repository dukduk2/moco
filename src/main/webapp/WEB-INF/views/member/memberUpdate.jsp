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
<title>MOVIE COMMUNICATION</title>

<script type="text/javascript">
$(function(){
	$("#delete").click(function(){
		var check = confirm("정말 삭제 하시겠습니까?");
		if(check){
			var id = "${sessionScope.memberDTO.id}";
			var fname = "${sessionScope.memberDTO.fname}";
			
			$.post("memberFileDelete", {
				id:id,
				fname:fname
			}, function(data){
				$("#filedelete").html(data);
			})
		}
	});
});
</script>

<style type="text/css">
.member_Table {
 	width: 600px;
 	margin: 20px auto;
}

.hidden {
	display: none;
}
</style>

</head>
<body>
	<%@ include file="/resources/part/header3.jspf" %>

	<section>
		<div class="container">
			<h2 class="title"><img class="icon" src="../resources/images/icon/pop.png"> Member Update</h2>
			<form action="memberUpdate" method="POST" enctype="multipart/form-data">
				<table class="member_Table">
					<tr>
						<td class="name">IMG</td>
							<c:if test="${memberDTO.getFname() ne ' '}">
								<td>
									<span id="filedelete">
										<img class="profile" src="${pageContext.request.contextPath}/resources/upload/member/${memberDTO.fname}">
										<!-- <input type="file" name="f1" class="hidden"> -->
									</span>
									<input type="button" id="delete" class="btn btn-warning" value="삭제">
								</td>
							</c:if>
		
							<c:if test="${memberDTO.getFname() eq ' '}">
								<td><input type="file" class="form-control" name="f1"></td>
							</c:if>
					</tr>
				
					<tr>
						<td class="name">ID</td>
						<td><input type="text" class="form-control" name="id" readonly="readonly" value="${memberDTO.id}"></td>
					</tr>
		
					<tr>
						<td class="name">PW</td>
						<td><input type="text" class="form-control" name="password" value="${memberDTO.password}"></td>
					</tr>
		
					<tr>
						<td class="name">NAME</td>
						<td><input type="text" class="form-control" name="name" value="${memberDTO.name}"></td>
					</tr>
		
					<tr>
						<td class="name">PHONE</td>
						<td><input type="text" class="form-control" name="phone" value="${memberDTO.phone}"></td>
					</tr>
		
					<tr>
						<td class="name">ADDRESS</td>
						<td><input type="text" class="form-control" name="address" value="${memberDTO.address}"></td>
					</tr>
		
					<tr>
						<td class="name">EMAIL</td>
						<td><input type="email" class="form-control" name="email" value="${memberDTO.email}"></td>
					</tr>
					
					<tr>
						<td class="name" colspan="2"><button class="btn btn-success">OK</button></td>
					</tr>
				</table>
			</form>
		</div>
	</section>
</body>
</html>