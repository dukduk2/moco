<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>MOVIE COMMUNICATION</title>
<%@ include file="/resources/part/bootStrap.jspf"%>
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.js"></script>
<link rel="styleSheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/header.css">
<link rel="styleSheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/section.css">
<script type="text/javascript">
$(function(){
	var price=${price };
	var myPoint=${myPoint };
	var point=$("#point").val();
	$("#btn").click(function(){
		if(price<=myPoint){
			alert("결제가 완료되었습니다. 잔여 포인트는 "+(myPoint-price)+"점 입니다.");
			$("#frm").submit();
		}else{
			alert("포인트가 부족합니다.");
		}
	});
	
	$("#point").keypress(function(){
		$("span").html(myPoint-point);
	})
	
});
</script>
</head>
<body>
	<%@ include file="/resources/part/header1.jspf"%>
	<section>
	<h2>PAY MOVIE</h2>
	<form action="./payMovie" method="post" id="frm">
		<input type="hidden" value="${dto.num }" name="num">
		<input type="hidden" value="${kind }" name="kind">

		<p>MOVIE : ${dto.title }</p>
		<p>DIRECTOR : ${dto.director }</p>
		<p>PUBDATE : ${dto.pub_date }</p>
		<p>PRICE : ${price }</p>
		<p>MY POINT : ${myPoint }<button>충전하기</button></p>

	<input type="button" value="결제하기" id="btn">
	</form>
	</section>
</body>
</html>