<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ROOT" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>${title}</h2>
	
	<c:if test="${commit}">
		<div>
			<p>${message}</p>
			${fname}
			<video autoplay="autoplay" width="640" height="344">
				<source src="${ROOT}/resources/upload/adminMovieUpload/${fname}" type="video/mp4">
			</video>	
		</div>	
	</c:if>
	<c:if test="${!commit}">
		<div>
			<p>${message}</p>
		</div>
	</c:if>
	
</body>
</html>