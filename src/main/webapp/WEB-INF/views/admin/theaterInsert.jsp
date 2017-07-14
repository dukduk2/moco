<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/resources/part/bootStrap.jspf" %>
<link rel="styleSheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/header.css">
<link rel="styleSheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/section.css">
<script type="text/javascript">
	$(function(){
		var num = 0;
		
		$('#multiplexAdd').click(function(){
			$('#m').append('<tr class="t'+num+'"><td>상영관명</td><td><input type="text" name="multi_name"><span id="'+num+'" class="s">x</span></td></tr><tr class="t'+num+'"><td>총 좌석수</td><td><input type="number" name="totalseat"></td></tr>');
			num++;
		});
		
		$('body').on('click', '.s', function(){
			var id = $(this).attr('id');
			id = '.t'+id;
			$(id).remove();
		});
		
		$('#theaterInsert').click(function(){
			$('#frm').submit();
		});
	});
</script>
<title>Insert title here</title>
</head>
<body>
	<%@ include file="/resources/part/header3.jspf" %>
	<section>
		<div class="container">
			<!-- Insert로 변경하기. -->
			<form id="frm" action="theaterInsert" method="post">
				<table id="m">
					<tr>
						<td>극장명</td>
						<td><input type="text" name="name"></td>
					</tr>
					<tr>
						<td>주소</td>
						<td><input type="text" name="location"></td>
					</tr>
					<tr>
						<td>상세주소</td>
						<td><input type="text" name="detailLocation"></td>
					</tr>
					<tr>
						<td>문의전화</td>
						<td><input type="text" name="phone"></td>
					</tr>
					<tr>
						<td>가격</td>
						<td><input type="number" name="price"></td>
					</tr>
					<tr>
						<td>오픈 시간</td>
						<td><input type="text" name="opening_time" placeholder="ex) 13:00"></td>
					</tr>
					<tr>
						<td colspan="2"><input type="hidden" name="commit" value="1"></td>
					</tr>
					<tr>
						<td colspan="2">------------------------------------------------------------------</td>
					</tr>
					<tr>
						<td>상영관명</td>
						<td><input type="text" name="multi_name"></td>
					</tr>
					<tr>
						<td>총 좌석수</td>
						<td><input type="number" name="totalseat"></td>
					</tr>
				</table>
				<table>
					<tr>
						<td><input type="button" id="multiplexAdd" value="상영관 추가"></td>
						<td><input type="button" id="theaterInsert" value="입력"></td>
					</tr>
				</table>
				
			</form>
		</div>
	</section>

</body>
</html>