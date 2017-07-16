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
<link rel="styleSheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/list.css">
<script type="text/javascript">
	$(function(){
		var num = 0;
		var multi_name;	//상영관이름을 담을 아이디
		var totalseat;	//좌석수를 담을 아이디
		
		var name_check = false;
		var location_check = false;
		var detailLocation_check = false;
		var phone_check = false;
		var price_check = false;
		var opening_time_check = false;
		
		var multi_name_check = false;
		var totalseat_check = false;
		
		
		$('#multiplexAdd').click(function(){
			multi_name = $('#multi_name'+num+'').val();
			totalseat = $('#totalseat'+num+'').val();
			if(multi_name == '' || totalseat == ''){
				alert("상영관과 좌석수를 입력해주세요");
			}else{
				num++;
				$('#m').append('<tr class="t'+num+'"><td class="write-tdName"><span class="titleSpan">상영관명</span></td><td class="write-tdWrite"><input type="text" id="multi_name'+num+'" name="multi_name" class="form-control"></td><td><span id="'+num+'" class="s">x</span></td></tr><tr class="t'+num+'"><td class="write-tdName"><span class="titleSpan">총 좌석수</span></td><td class="write-tdWrite"><input type="number" id="totalseat'+num+'" name="totalseat" class="form-control"></td></tr>');
			}
		});
		
		$('body').on('click', '.s', function(){
			var id = $(this).attr('id');
			id = '.t'+id;
			$(id).remove();
		});
		
		$('#name').blur(function(){
			if($('#name').val() != ''){
				name_check = true;
			}else{
				name_check = false;
			}
		});
		
		$('#location').blur(function(){
			if($('#location').val() != ''){
				location_check = true;
			}else{
				location_check = false;
			}
		});
		
		$('#detailLocation').blur(function(){
			if($('#detailLocation').val() != ''){
				detailLocation_check = true;
			}else{
				detailLocation_check = false;
			}
		});
		
		$('#phone').blur(function(){
			if($('#phone').val() != ''){
				phone_check = true;
			}else{
				phone_check = false;
			}
		});
		
		$('#price').blur(function(){
			if($('#price').val() != ''){
				price_check = true;
			}else{
				price_check = false;
			}
		});
		
		$('#opening_time').blur(function(){
			var opening_time = $('#opening_time').val();
			
			if(opening_time != ''){
				
				opening_time_check = true;
				
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
					opening_time_check = false;
				}
				if(oneASC<48 || oneASC>50){
					opening_time_check = false;
				}
				if(oneASC==50){
					if(twoASC<48 || twoASC>51){
						opening_time_check = false;
					}
				}
				if(twoASC<48 || twoASC>57){
					opening_time_check = false;
				}
				if(threeASC!=58){
					opening_time_check = false;
				}
				if(fourASC<48 || fourASC>53){
					opening_time_check = false;
				}
				if(fiveASC<48 || fiveASC>57){
					opening_time_check = false;
				}
				
			}else{
				opening_time_check = false;
			}
		});
		
		$('#multi_name'+num+'').blur(function(){
			if($('#multi_name'+num+'').val() != ''){
				multi_name_check = true;
			}else{
				multi_name_check = false;
			}
		});
		
		$('#totalseat'+num+'').blur(function(){
			if($('#totalseat'+num+'').val() != ''){
				totalseat_check = true;
			}else{
				totalseat_check = false;
			}
		});
		
		
		$('#theaterInsert').click(function(){
			var name = $('#name').val();
			var location = $('#location').val();
			var detailLocation = $('#detailLocation').val();
			var phone = $('#phone').val();
			var price = $('#price').val();
			var opening_time = $('#opening_time').val();
			
			var multi_name = $('#multi_name'+num+'').val();
			var totalseat = $('#totalseat'+num+'').val();
			
			if(name != '' && location != '' && detailLocation != '' && phone != '' && price != '' && opening_time != '' && multi_name != '' && totalseat != ''){
				if(name_check && location_check && detailLocation_check && phone_check && price_check && opening_time_check && multi_name_check && totalseat_check){
					if(confirm("극장 정보를 입력 하시겠습니까?")){
						$('#frm').submit();
					}
				}else if(!name_check){
					alert('극장명을 입력해주세요.');
				}else if(!location_check){
					alert('주소를 입력해주세요.');
				}else if(!detailLocation_check){
					alert('상세주소를 입력해주세요.');
				}else if(!phone_check){
					alert('문의전화번호를 입력해주세요.');
				}else if(!price_check){
					alert('예매가를 입력해주세요.');
				}else if(!opening_time_check){
					alert('극장의 첫 관람 시간을 00:00양식에 맞춰 입력해주세요.(ex 13:00)')
				}else if(!multi_name_check){
					alert('상영관명을 입력해주세요.')
				}else if(!totalseat_check){
					alert('좌석수를 입력해주세요.')
				}else{
					alert('극장정보를 추가하실 수 없습니다.');
				}
			}else{
				alert('모든 정보를 입력해주세요');
			}
			
		});
		
		$('#cancel').click(function(){
			if(confirm('극장 추가를 취소하시겠습니까?')){
				location.href="./index";
			}
		});
	});
</script>
<title>MOVIE COMMUNICATION</title>
<style type="text/css">
	.titleSpan{
		font-size: 1.2em;
		font-weight: bold;
		font-family: Montserrat, sans-serif;
	}
	.btnTD{
		width: 80px;
	}
	#theaterInsert{
		width: 50%;
		height: 42px;
		float: left;
		margin-top: 10px;
		background-color: black;
		color: white;
		border-radius: 5px;
	}
	
	#cancel{
		width: 50%;
		height: 42px;
		float: right;
		margin-top: 10px;
		color: white;
		border-radius: 5px;
	}
</style>
</head>
<body>
	<%@ include file="/resources/part/header3.jspf" %>
	<section>
		<div class="container">
			<!-- Insert로 변경하기. -->
			<form id="frm" action="theaterInsert" method="post" style="width : 1000px;">
				<table id="m" style="width : 1000px;">
					<tr>
						<td class="write-tdName"><span class="titleSpan">극장</span></td>
						<td class="write-tdWrite"><input type="text" name="name" id="name" class="form-control"></td>
					</tr>
					<tr>
						<td class="write-tdName"><span class="titleSpan">주소</span></td>
						<td class="write-tdWrite"><input type="text" name="location" id="location" class="form-control"></td>
					</tr>
					<tr>
						<td class="write-tdName"><span class="titleSpan">상세주소</span></td>
						<td class="write-tdWrite"><input type="text" name="detailLocation" id="detailLocation" class="form-control"></td>
					</tr>
					<tr>
						<td class="write-tdName"><span class="titleSpan">문의전화</span></td>
						<td class="write-tdWrite"><input type="text" name="phone" id="phone" class="form-control"></td>
					</tr>
					<tr>
						<td class="write-tdName"><span class="titleSpan">가격</span></td>
						<td class="write-tdWrite"><input type="number" name="price" id="price" class="form-control"></td>
					</tr>
					<tr>
						<td class="write-tdName"><span class="titleSpan">오픈시간</span></td>
						<td class="write-tdWrite"><input type="text" name="opening_time" placeholder="ex) 13:00" id="opening_time" class="form-control"></td>
					</tr>
					<tr>
						<td colspan="2"><input type="hidden" name="commit" value="1" class="form-control"></td>
					</tr>
					<tr>
						<td colspan="2"></td>
					</tr>

					<tr>
						<td class="write-tdName"><span class="titleSpan">상영관</span></td>
						<td class="write-tdWrite"><input type="text" name="multi_name" id="multi_name0" class="form-control"></td>
						<td class="write-tdWrite btnTD"><input type="button" id="multiplexAdd" class="button btn btn-primary" value="상영관 추가" style="background-color: black;"></td>
					</tr>
					<tr>
						<td class="write-tdName"><span class="titleSpan">좌석수</span></td>
						<td class="write-tdWrite"><input type="number" name="totalseat" id="totalseat0" class="form-control"></td>
					</tr>
				</table>
					
				<input type="button" id="theaterInsert" class="button btn btn-primary" value="입력">
				<input type="button" id="cancel" class="button btn btn-danger" value="취소">				
				
			</form>
		</div>
	</section>

</body>
</html>