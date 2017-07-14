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
		var xx;
		var dd;
		
		
		
		$('#multiplexAdd').click(function(){
			xx = $('#xx'+num+'').val();
			dd = $('#dd'+num+'').val();
			if(xx == '' || dd == ''){
				alert("상영관과 좌석수를 입력해주세요");
			}else{
				num++;
				$('#m').append('<tr class="t'+num+'"><td>상영관명</td><td><input type="text" id="xx'+num+'" name="multi_name"><span id="'+num+'" class="s">x</span></td></tr><tr class="t'+num+'"><td>총 좌석수</td><td><input type="number" id="dd'+num+'" name="totalseat"></td></tr>');
			}
		});
		
		$('body').on('click', '.s', function(){
			var id = $(this).attr('id');
			id = '.t'+id;
			$(id).remove();
		});
		
		$('#theaterInsert').click(function(){
			var opening_time = $('#opening_time').val();
			var check = true;
			
			if($('#name').val() == ''){
				alert('극장을 입력해주세요');
				check = false;	
			}
			if($('#location').val() == ''){
				alert('주소를 입력해주세요');
				check = false;
			}
			if($('#detailLocation').val() == ''){
				alert('상세주소를 입력해주세요');
				check = false;
			}
			if($('#phone').val() == ''){
				alert('문의전화번호를 입력해주세요');
				check = false;
			}
			if($('#price').val() == ''){
				alert('예매가를 입력해주세요');
				check = false;
			}
			if(opening_time == ''){
				alert('영화시작시간을 입력해주세요');
				check = false;
			}else{
				var one = opening_time.substring(0,1);
				var two = opening_time.substring(1,2);
				var three = opening_time.substring(2,3);
				var four = opening_time.substring(3,4);
				var five = opening_time.substring(4);
				
				var oneASC = one.charCodeAt(0);
				var twoASC = two.charCodeAt(0);
				var threeASC = three.charCodeAt(0);
				var fourASC = four.charCodeAt(0);
				var fiveASC = five.charCodeAt(0);

				if(opening_time.length !=5){
					alert("00:00 형식을 지켜주세요(ex: 13:00)");
					check = false;
				}
				if(oneASC<48 || oneASC>50){
					alert("00:00 형식을 지켜주세요(ex: 13:00)");
					check = false;
				}
				if(oneASC==50){
					if(twoASC<48 || twoASC>51){
						alert("00:00 형식을 지켜주세요(ex: 13:00)");
						check = false;
					}
				}
				if(twoASC<48 || twoASC>57){
					alert("00:00 형식을 지켜주세요(ex: 13:00)");
					check = false;
				}
				if(threeASC!=58){
					alert("00:00 형식을 지켜주세요(ex: 13:00)");
					check = false;
				}
				if(fourASC<48 || fourASC>53){
					alert("00:00 형식을 지켜주세요(ex: 13:00)");
					check = false;
				}
				if(fiveASC<48 || fiveASC>57){
					alert("00:00 형식을 지켜주세요(ex: 13:00)");
					check = false;
				}
			}

			if($('#xx0').val() == ''){
				alert('상영관을 입력해주세요');
				check = false;
			}
			if($('#dd0').val() == ''){
				alert('좌석수를 입력해주세요');
				check = false;
			}
			
			if(check == true){
				if(confirm("극장 정보를 입력 하시겠습니까?")){
					$('#frm').submit();
				}
			}
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
						<td>극장</td>
						<td><input type="text" name="name" id="name"></td>
					</tr>
					<tr>
						<td>주소</td>
						<td><input type="text" name="location" id="location"></td>
					</tr>
					<tr>
						<td>상세주소</td>
						<td><input type="text" name="detailLocation" id="detailLocation"></td>
					</tr>
					<tr>
						<td>문의전화</td>
						<td><input type="text" name="phone" id="phone"></td>
					</tr>
					<tr>
						<td>가격</td>
						<td><input type="number" name="price" id="price"></td>
					</tr>
					<tr>
						<td>오픈시간</td>
						<td><input type="text" name="opening_time" placeholder="ex) 13:00" id="opening_time"></td>
					</tr>
					<tr>
						<td colspan="2"><input type="hidden" name="commit" value="1"></td>
					</tr>
					<tr>
						<td colspan="2">------------------------------------------------------------------</td>
					</tr>
					<tr>
						<td>상영관</td>
						<td><input type="text" name="multi_name" id="xx0"></td>
					</tr>
					<tr>
						<td>좌석수</td>
						<td><input type="number" name="totalseat" id="dd0"></td>
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