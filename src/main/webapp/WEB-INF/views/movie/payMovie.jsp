<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
	$(function() {
		var price = ${price};
		var myPoint = ${myPoint};
		
		var point = $("#point").val();
		$("#btn").click(function() {
			if (price <= myPoint) {
				alert("결제가 완료되었습니다. 잔여 포인트는 " + (myPoint - price) + "점 입니다.");
				$("#frm").submit();
			} else {
				alert("포인트가 부족합니다.");
			}
		});
	});
</script>
<style type="text/css">
.container {
	width: 450px;
	margin: 0 auto;
	border: 1px solid #ccc;
}

.photo{
	margin: 0 auto;
}
.pay_title{
	width: 400px;
	margin: 0 auto;
}
#btn{
	float:right;
}
.label-default{
	width: 100px;
	font-size:15px;
	background-color: #ccc;
}
.pay_form{
	margin-left: 10px;
	margin-bottom: 10px;
}
.pay_input{
	border: none;
}
</style>
</head>
<body>
	<%@ include file="/resources/part/header1.jspf"%>
	<section>
		<div class="container">
			<form action="./payMovie" method="post" id="frm"
				class="form-horizontal">
				<input type="hidden" value="${dto.num }" name="num"> <input
					type="hidden" value="${kind }" name="kind">

				<p>
				<h2 class="pay_title"> ${dto.title }</h2>
				</p>
				<p>
					<img class="photo" src="${dto.thumnail }">
				</p>	
				
				<div class="pay_form">
					<label class="label label-default">감독</label>
					<input type="text" value="${dto.director }" readonly="readonly" class="pay_input">
				</div>
				
				<div class="pay_form">
					<label class="label label-default">개봉일</label>
					<input type="text" value="${dto.pub_date }" readonly="readonly" class="pay_input">
				</div>
				
				<div class="pay_form">
					<label class="label label-default">가격</label>
					<input type="text" value="${price }" readonly="readonly" class="pay_input">
				</div>
				
				<div class="pay_form">
					<label class="label label-default">나의 포인트</label>
					<input type="text" value="${myPoint }" readonly="readonly" class="pay_input">
				</div>
				
				<p>
					<c:if test="${price>myPoint }">
			포인트가 부족합니다.
		</c:if>
					<c:if test="${price<=myPoint }">
			결제 후 잔여 포인트는 ${myPoint-price }점 입니다.
		</c:if>
				</p>
				<input type="button" value="결제하기" id="btn" class="btn btn-default">
			</form>
			</div>
	</section>
</body>
</html>