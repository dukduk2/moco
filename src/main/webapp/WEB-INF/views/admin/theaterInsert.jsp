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
			$('#m').after('<tr id="t'+num+'"><td>상영관명</td><td><input type="text" name="multi_name"><span id="'+num+'" class="s">x</span></td></tr><tr><td>총 좌석수</td><td><input type="number" name="totalseat"></td></tr>');
			num++;
		});
		
		$('body').on('click', '.s', function(){
			var id = $(this).attr('id');
			id = '#t'+id;
			$(id).remove();
		});
		
		/*
		
		

	
	$("#add").click(function(){
		if(check<5){
			$("#d1").append('<p id="p'+num+'"><input type="file"><span id="'+num+'" class="s">x</span></p>');
			check++;
			num++;
		}else{
			alert("못만든다 더이상")
		}
	});
		
		*/
	});
</script>
<title>Insert title here</title>
</head>
<body>
	<!-- 
	
	<form id="frm" action="noticeWrite.notice" method="post" enctype="multipart/form-data">
		<p>TITLE : <input type="text" name="title"></p>
		<p>WRITER : <input type="text" name="writer"></p>
		<p>CONTENTS : <textarea id="se" rows="" cols="" name="contents"></textarea></p>
	<div id="f">
		<input type="button" id="add" class="file" value="파일 추가">
		<input type="button" id="del" class="file" value="파일 삭제">
	</div>
	<div id="d1">
	
	</div>
		<input type="button" value="글쓰기" id="savebutton">
	</form>
	
	<파일삭제 미완성이용
	
	
	 -->
	
	<%@ include file="/resources/part/header3.jspf" %>
	<section>
		<div class="container">
			<!-- Insert로 변경하기. -->
			<form action="theaterRequest" method="post">
				<table>
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
					<tr id="m">
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
					<tr>
						<td><input type="button" id="multiplexAdd" value="상영관 추가"></td>
						<td><input type="button" value="입력"></td>
					</tr>
				</table>
			</form>
		</div>
	</section>

</body>
</html>