<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="styleSheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/header.css">
<link rel="styleSheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/section.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script type="text/javascript">
	$(function(){
		var theater_price = ${theater.price};
		
		$('.screenAdd').click(function(){
			var screenAdd = $(this).attr('id');
			var multi_num = screenAdd.substring(1);
			var result = "#result"+multi_num;
			$.post('screen_ajax', {multi_num:multi_num}, function(data){
				$(result).html(data);
			});
		});
		
		//영화정보 보기~
		$("body").on("click", ".movieGo", function(){
			var num = $(this).attr('id');
			location.href="movieView?num="+num;
		});
		
		//영화시간 클릭시 예매 이벤트 발생.);
		$("body").on("click", ".reservationAdd", function(){
			var num = $(this).attr('id');
			//screen_num setting
			$("#s_num").val(num);
			
			$('#seat').change(function(){
				var seat = $(this).val();
				if(seat < 0) { 
					alert("양수만 입력 해 주세요"); 
					$(this).val(0);
				} 
				
				var rprice = theater_price * seat ;
				$("#rprice").val(rprice);
			});
		});
		
		
		//결제하기 누르면 결제 고고싱
		$('#reservation').click(function(){
			var myPoint = $('.myPoint').val();
			var rprice = $('#rprice').val();
			
			if(rprice > myPoint){
				alert('Point가 부족합니다. Point를 충전하신 후 이용해주세요');
			}else{
				alert('예매가 완료되었습니다.');
				$('#reservationForm').submit();
			};
		});
		
		$('#charge').click(function(){
			location.href='';
		});
	});
</script>
<title>Insert title here</title>
<style type="text/css">
	td{
		height: 50px;
	}
</style>
</head>
<body>

	<%@ include file="/resources/part/header1.jspf" %>
	<section>
		<div class="container">
			<table>
				<tr>
					<td colspan="2" style="width:120px;"><h2>${theater.name }</h2></td>
				</tr>
				<tr>
					<td style="width:120px;">번호</td><td>${theater.num }</td>
				</tr>
				<tr>
					<td style="width:120px;">주소</td><td>${theater.location }</td>
				</tr>
				<tr>
					<td style="width:120px;">가격</td><td>${theater.price }</td>
				</tr>
				<tr>
					<td style="width:120px;">오픈시간</td><td>${theater.opening_time }</td>
				</tr>
				<tr>
					<td style="width:120px;">문의전화</td><td>${theater.phone }</td>
				</tr>
				<tr>
					<td>상영관</td>
				</tr>
			</table>
			
			
			<br>
			<c:forEach items="${multiplexList }" var="list">
				<p><span id="s${list.num}" class="screenAdd">${list.name}</span></p>
				<div id="result${list.num}"></div>
			</c:forEach>
			
			
			<!-- Modal -->
			<div class="modal fade" id="myModal" role="dialog">
				<div class="modal-dialog">
			    	<!-- Modal content-->
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">&times;</button>
							<h4 class="modal-title">영화좌석 예매</h4>
						</div>
			        	<div class="modal-body">
			        		<table>
			        			<tr><td></td></tr>
			        			<tr><td>극장  ${theater.name }</td></tr>
			        			<tr><td>상영관  </td></tr>
			        			<tr><td>상영시간  </td></tr>
			        			<tr><td>영화금액  ${theater.price }</td></tr>
			        		</table>
			        		<hr>
			        		<form action="reservationInsert" id="reservationForm" method="post">
			        			<!-- num은 자동생성 -->
			        			ID : <input type="text" name="id" value="${memberDTO.id}" readonly="readonly">
				        		<input type="hidden" name="screen_num" id="s_num">
			        			<table>
				        			<tr><td>예매할 좌석수 : <input type="number" name="seat" id="seat"></td></tr>
				        			<tr><td>결제할 금액 : <input type="number" name="rprice" readonly="readonly" id="rprice"></td></tr>
				        			<tr><td>사용가능한 POINT : <input type="number" class="myPoint" value="${memberDTO.point}" readonly="readonly"></td></tr>
				        			<tr><td><input type="button" class="btn btn-default" value="Point충전" id="charge"></td></tr>
				        		</table>        		
			        		
				        		
				        		
			        		</form>
			        	</div>
			        	<div class="modal-footer">
							<input type="button" id="reservation" class="btn btn-default" data-dismiss="modal" value="결제하기">
			        	</div>
					</div>
				</div>
			</div>
		  
		</div>
		
	</section>
	
	
</body>
</html>