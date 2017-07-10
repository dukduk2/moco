<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/resources/part/bootStrap.jspf"%>
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.js"></script>
<link rel="styleSheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/header.css">
<link rel="styleSheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/section.css">
<title>Insert title here</title>
<script type="text/javascript">
$(function(){
	$("#btn").click(function(){
		$("#frm").submit();
	});
});
</script>
</head>
<body>
	<%@ include file="/resources/part/header1.jspf"%>
	<section>
	<h2>PAY MOVIE</h2>
	<form action="./payMovie" method="post" id="frm">
		<input type="hidden" value="${dto.num }" name="num">

		<p>MOVIE : ${dto.title }</p>
		<p>DIRECTOR : ${dto.director }</p>
		<p>PUBDATE : ${dto.pub_date }</p>
		<p>PRICE : ${price } / ${myPoint }</p>

			<%-- <td>${price }</td> --%>

	<input type="button" value="결제하기" id="btn">
	</form>
	</section>
</body>
</html>