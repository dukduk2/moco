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
</head>
<body>
	<%@ include file="/resources/part/header1.jspf"%>
	<section>

	<p><video width="800" controls>
			<source src="../resources/upload/adminMovieUpload/${dto.fname}" type="video/mp4">
		</video></p>
	</section>
</body>
</html>