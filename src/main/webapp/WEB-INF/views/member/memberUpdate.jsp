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
</head>
<body>
	<%@ include file="/resources/part/header1.jspf" %>

	<section>

	<h2>Member Update</h2>
	<form action="memberUpdate" method="POST" enctype="multipart/form-data">
		<table class="table table-hover" style="width: 300px">
			<tr>
				<td>ID <input type="text" class="form-control" name="id" readonly="readonly" value="${memberDTO.id}"></td>
			</tr>

			<tr>
				<td>PW <input type="text" class="form-control" name="password" value="${memberDTO.password}"></td>
			</tr>

			<tr>
				<td>NAME <input type="text" class="form-control" name="name" value="${memberDTO.name}"></td>
			</tr>

			<tr>
				<td>PHONE <input type="text" class="form-control" name="phone" value="${memberDTO.phone}"></td>
			</tr>

			<tr>
				<td>ADDRESS <input type="text" class="form-control" name="address" value="${memberDTO.address}"></td>
			</tr>

			<tr>
				<td>EMAIL <input type="email" class="form-control" name="email" value="${memberDTO.email}"></td>
			</tr>
			
			<tr>
				<td>IMG 
					<c:if test="${memberDTO.getFname() ne ' '}">
						<span id="filedelete">
							<img class="profile" src="${pageContext.request.contextPath}/resources/upload/member/${memberDTO.fname}">
						</span>
						<input type="button" id="delete" class="btn btn-warning" value="삭제">
					</c:if>

					<c:if test="${memberDTO.getFname() eq ' '}">
						<input type="file" class="form-control" name="f1">
					</c:if>
				</td>
			</tr>
		</table>
		<button class="btn btn-success">OK</button>
	</form>
	
	</section>
</body>
</html>