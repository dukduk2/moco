<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%@ include file="/resources/part/bootStrap.jspf" %>
<style type="text/css">
	.container{
		background-image: url("${pageContext.request.contextPath}/resources/logo/back.jpg");
		background-size: cover;
		background-repeat: no-repeat;
		margin-top: 50px;
		height: 500px;
		padding-left: 100px;
		padding-top: 70px;
	}
	.logoIMG{
		width: 130px;
		height: 130px;
		cursor: pointer;
	}
</style>
</head>
<body>
		<div class="container">
			<div>
				<p>
					<a href="${pageContext.request.contextPath}/#go"><img alt="" src="${pageContext.request.contextPath}/resources/logo/logo.png" class="logoIMG"></a>
					&nbsp;&nbsp;&nbsp;<a href="${pageContext.request.contextPath}/#go" style="text-decoration: underline; color: teal;">모코 홈으로 가기</a>
				</p>
				<br><br>
		            <p>지금은 스트리밍 제공 시간이 아닙니다<br /> 스트리밍 제공시간은 편성표에 등록되어 있는 날짜에 20시 부터 입니다.</p>
		            <p>다음에 다시 이용하여 주시기 바랍니다.</p>
		            <p>감사합니다.</p>
	         </div>
        </div>
</body>
</html>