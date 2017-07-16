<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/resources/part/bootStrap.jspf" %>
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
			$('#seat').val(0);
			$('#rprice').val(0);
			var num = $(this).attr('id');
			var time = $('.time'+num+'').val();
			var multiplex_num = $('.multiplex'+num+'').val();
			
			var mul_span_id = '#s'+multiplex_num;
			mul_span_id = $(mul_span_id).text();
			
			$('#movieTimeGo').html(time);
			$('#multiplexGo').html(mul_span_id);
			
			//screen_num setting
			$("#s_num").val(num);
			
		});
		$('#seat').change(function(){
			var seat = $(this).val();
			if(seat < 0) { 
				alert("양수만 입력 해 주세요"); 
				$(this).val(0);
			}
			var rprice = theater_price * seat ;
			$("#rprice").val(rprice);
		});
			
		
		
		//결제하기 누르면 결제 고고싱
		$('#reservation').click(function(){
			var myPoint = $('.myPoint').val();
			myPoint = myPoint*1;
			var rprice = $('#rprice').val();
			rprice = rprice*1;
			var rprice_check = false;
			var point_check = false;
			
			
			
			if(rprice == 0){
				rprice_check = false;
				alert('예매하실 좌석수를 입력해주세요.');
			}else{
				rprice_check = true;
			}
			
			if(rprice>myPoint){
				point_check = false;
				alert('포인트를 충전해주세요.');
			}else{
				point_check = true;
			}
			
			
			
			if(rprice_check && point_check){
				if(confirm('예매하시겠습니까?')){
					$('#reservationForm').submit();
				}
			}
		});
		
		$('#charge').click(function(){
			location.href='../../point/pointList';
		});
		
		$('#theaterDelete').click(function(){
			var num = ${theater.num};
			if(confirm("정말 이 극장의 정보를 삭제하시겠습니까?")){
				location.href='theaterDelete?num='+num;
			}
		});
	});
</script>
<title>Insert title here</title>
<style type="text/css">
	td{
		height: 50px;
	}
	body{
		font-family: Montserrat, sans-serif;
		font-size: 18px;
	}
	h2{
		font-size : 35px;
		font-weight:bold;
		text-align: center;
	}
	.total_wrap{
		width : 800px;
		margin : 0 auto;
		/* background-color: skyblue; */
	}
	.tb_wrap{
		border-top : 1px solid #cccccc;
	}
	.content_wrap{
		border-top : 1px solid #cccccc;
		width : 800px;
		margin : 0 auto;
		/* background-color: lightgreen; */
	}
	.content_tb{
		width : 800px;
		margin : 0 auto;
		/* background-color: lightgreen; */
	}
	.contents{
		margin-top: 30px;
	}
	.multi_wrap{
		display: inline-block; 
		width:120px;
		text-align: center;
		/* background-color: #808080; */
	 	color : black;
	 	font-size: 19px;
	 	font-weight: bold;
	}

	.multi{
		display:inline-block;
		width: 150px;
		text-align: center;
		cursor: pointer;
	}
	.screenInfo{
		display: inline-block;
	}
	.movieInfo{
		display: inline-block;
		text-align: center;
	}
	.screenTime{
		display: inline-block;
		float: right;
	}
	.reservationAdd{
		width : 90px;
	}
	 .td_name{
	 	width:270px;
	 	/* background-color: #808080; */
	 	color : black;
	 	text-align: center;
	 	font-size: 19px;
	 	font-weight: bold;
	 }
	 .td_write{
	 	text-align: center;
	 }
	 .btn_wrap{
	 	text-align: center;
	 	height : 70px;
	 	margin-top:30px;
	 	border-top : 1px solid #cccccc;
	 }
	 #theaterDelete{
	 	margin-top: 20px;
	 }
	 .modalTable{
	 	width : 100%;
		max-width : 100%;
		margin-bottom: 20px;
		background-color: transparent;
		border-spacing : 0;
		border-collapse : collapse;
		border-color: grey;
		vertical-align: middle;	
	 }
	.modal_tr{
		display: table-row;
		vertical-align: middle;
		border-color: inherit;
	}
	.modal_td{
		padding: 8px;
	 	line-height: 1.42857143;
	 	vertical-align: middle;
	 	border-top: 1px solid #ddd;
	 	font-family: Montserrat, sans-serif;
		font-size: 1.1em;
		font-weight: bold;
	}
</style>
</head>
<body>

	<%@ include file="/resources/part/header1.jspf" %>
	<section>
		<div class="container">
			<div class="total_wrap">
				<div class="tb_wrap">
					<h2>${theater.name }</h2>
					<table class="content_tb">
						<tr>
							<td class="td_name">LOCATION</td><td class="td_write" colspan="3">${theater.location }</td>
						</tr>
						<tr>
							<td class="td_name">PRICE</td><td class="td_write" colspan="3">${theater.price }원</td>
						</tr>
						<tr>
							<td class="td_name">OPEN TIME</td><td class="td_write" colspan="3">${theater.opening_time }</td>
						</tr>
						<tr>
							<td class="td_name">PHONE</td><td class="td_write" colspan="3">${theater.phone }</td>
						</tr>
					</table>
				</div>
				<br>
				<div class="content_wrap">
					<c:forEach items="${multiplexList }" var="list">
						<div class="contents">
							<div class="multi_wrap"><span>상영관</span></div>
							<div class="multi"><span id="s${list.num}" class="screenAdd">${list.name}</span></div>
							<div id="result${list.num}" class="screenInfo"></div>
						</div>
					</c:forEach>
				</div>
				
				<div class="btn_wrap">
					<c:if test="${memberDTO.id eq 'admin'}">
						<input type="button" id="theaterDelete" class="btn btn-default" value="극장 삭제">
					</c:if>
				</div>
			</div>
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
			        		<form action="reservationInsert" id="reservationForm" method="post">
					        	<input type="hidden" name="screen_num" id="s_num">
				        		<table class="modalTable">
				        			<tr class="modal_tr">
				        				<td class="modal_td">THEATER</td>
				        				<td class="modal_td">${theater.name}</td>
				        			</tr>
				        			<tr class="modal_tr">
				        				<td class="modal_td">MULTIPLEX</td>
				        				<td class="modal_td" id="multiplexGo"></td>	
				        			</tr>
				        			<tr class="modal_tr">
				        				<td class="modal_td">상영시간</td>
				        				<td class="modal_td" id="movieTimeGo"></td>
				        			</tr>
				        			<tr class="modal_tr">
				        				<td class="modal_td">영화금액</td>
				        				<td class="modal_td">${theater.price}원</td>	
				        			</tr>
				        		
			        			<!-- num은 자동생성 -->
			        				<tr class="modal_tr">
			        					<td class="modal_td">ID</td>
			        					<td class="modal_td"><input type="text" name="id" value="${memberDTO.id}" readonly="readonly"></td>
			        			
				        			<tr class="modal_tr">
				        				<td class="modal_td">예매할 좌석수</td>
				        				<td class="modal_td"><input type="number" name="seat" id="seat"></td>
				        			</tr>
				        			<tr class="modal_tr">
				        				<td class="modal_td">결제할 금액</td>
				        				<td class="modal_td"><input type="number" name="rprice" readonly="readonly" id="rprice"></td>
				        			</tr>
				        			<tr class="modal_tr">
				        				<td class="modal_td">사용가능한 POINT</td>
				        				<td class="modal_td"><input type="number" class="myPoint" value="${memberDTO.point}" readonly="readonly"></td>
				        			</tr>
				        		</table>        		
			        		
				        		
				        		
			        		</form>
			        	</div>
			        	<div class="modal-footer">
			        		<input type="button" class="btn btn-default" value="Point충전" id="charge">
							<input type="button" id="reservation" class="btn btn-default" data-dismiss="modal" value="결제하기">
			        	</div>
					</div>
				</div>
			</div>
		  
		</div>
		
	</section>
	
	
</body>
</html>