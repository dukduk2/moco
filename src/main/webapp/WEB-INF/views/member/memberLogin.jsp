<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	var message = '${message}';
	
	if(message != ''){
		alert(message);
		$("#result").html("<font style='color: red'>"+message+"</font>");
	}
});
</script>
</head>
<body>
	
	<%@ include file="/resources/part/header1.jspf" %>

	<section>
	<h2>Member Login</h2>
	<form action="memberLogin" method="post">
		<table class="table table-hover" style="width: 300px">
			<tr>
				<td>ID <input type="text" class="form-control" name="id"></td>
			</tr>
			<tr>
				<td>PW <input type="password" class="form-control" name="password"></td>
			</tr>
		</table>
		
		<p id="result"></p>
		<input class="btn btn-success" type="submit" value="LOGIN">
		<div class="btn-group">
			<a class="btn btn-warning" href="memberSearch?kind=id">ID search</a>
			<a class="btn btn-warning" href="memberSearch?kind=password">PW search</a>
		</div>
	</form>
	
	</section>
	
	<%@ include file="/resources/part/footer.jspf" %>
</body>
</html>