<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%@ include file="/resources/part/bootStrap.jspf" %>
<style type="text/css">
	.error{
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
	<div class="container error">
		<div>
			<p>
				<a href="${pageContext.request.contextPath}/#go"><img alt="" src="${pageContext.request.contextPath}/resources/logo/logo.png" class="logoIMG"></a>
				&nbsp;&nbsp;&nbsp;<a href="${pageContext.request.contextPath}/#go" style="text-decoration: underline; color: teal;">모코 홈으로 가기</a>
			</p>
			<br><br>
		<h4>${message}</h4><br>
		    <p>죄송합니다. <br/>
		    	이용도중 에러가 발생하였습니다. 다시 시도하여 주시기 바랍니다.
		    </p>
		    <p>감사합니다.</p>
	  	</div>
      </div>
</body>
</html>