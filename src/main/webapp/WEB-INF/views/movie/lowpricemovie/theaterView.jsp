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
		
		$('#reservation').click(function(){
			$('#insertForm').submit();
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
		<div id="result${list.num}"></div>
	</c:forEach>
	
	<div class="container">
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
		        			<tr><td>극장 : ${theater.name }</td></tr>
		        			<tr><td>상영관 : </td></tr>
		        			<tr><td>상영시간 : </td></tr>
		        			<tr><td>영화금액 : ${theater.price }</td></tr>
		        		</table>
		        		<hr>
		        		<form action="reservationInsert" id="insertForm" method="post">
		        			<!-- num은 자동생성 -->
		        			ID : <input type="text" name="id" value="${memberDTO.id}" readonly="readonly">
			        		<input type="hidden" name="screen_num" id="s_num">
		        			<table>
			        			<tr><td>예매할 좌석수 : <input type="number" name="seat" id="seat"></td></tr>
			        			<tr><td>결제할 금액 : <input type="number" name="rprice" readonly="readonly" id="rprice"></td></tr>
		        			</table>        		
		        		
		        		
		        		
		        		
		        		</form>
		        	</div>
		        	<div class="modal-footer">
						<input type="button" id="reservation" class="btn btn-default" data-dismiss="modal" value="예매하기">
		        	</div>
				</div>
			</div>
		</div>
  
	</div>
	
	
	
	
</body>
</html>