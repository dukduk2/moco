<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.js"></script>
<script type="text/javascript">
	$(function(){
		$('.screenAdd').click(function(){
			var screenAdd = $(this).attr('id');
			var num = screenAdd.substring(1);
			screenAdd = "#"+screenAdd
			$.post('screen_ajax', {multi_num:num}, function(data){
				$(screenAdd).append(data);
			}); 
			
			
		});
		
	});
</script>
<title>Insert title here</title>
</head>
<body>
	<p>번호 : ${theater.num }</p>
	<p>극장명 : ${theater.name }</p>
	<p>주소 : ${theater.location }</p>
	<p>가격 : ${theater.price }</p>
	<p>오픈시간 : ${theater.opening_time }</p>
	<p>문의전화 : ${theater.phone }</p>
	
	<c:forEach items="${multiplexList }" var="list">
		<p><span id="s${list.num}" class="screenAdd">${list.name}</span></p>
	</c:forEach>
</body>
</html>