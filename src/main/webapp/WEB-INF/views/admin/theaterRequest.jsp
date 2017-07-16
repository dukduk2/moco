<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/resources/part/bootStrap.jspf" %>
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.js"></script>
<link rel="styleSheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/header.css">
<link rel="styleSheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/section.css">
<link rel="styleSheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/list.css">
<title>MOVIE COMMUNICATION</title>
<script type="text/javascript">
	$(function(){
		var movie_num = $("#movie_num").val();
		var theater_num = 0;
		var count = 1;
		var size = 0;
		
		var theater_check = false;
		var multiplex_check = true;
		
		
		$("#theater").change(function(){
			count = 1;
			theater_num = $(this).val();
			if(theater_num != 0){
				theater_check = true;
				$.post("multiplexList_ajax", {theater_num:theater_num}, function(data){
					$("#multiplex").html(data);
				});
			}else{
				$("#multiplex").html("");
				theater_check = false;
			}
		});
		
		$('body').on("change", ".multiplexList", function(){
			var multi_num = $(this).val();
			size = $("#size").val(); 
			var m = document.getElementsByName("multi_num");
			
			if(multi_num == 0){
				multiplex_check = false;
			}else{
				loop:
				for(var i=0; i<m.length ;i++){
					for(var j=0; j<i; j++){
						if(m[i].value == m[j].value){
							multiplex_check = false;
							alert("이미 선택된 상영관입니다.");
							break loop;
						}else{
							multiplex_check = true;
						}
					}
				}
			}
			
			
		});
		
		
		$("#mul_add").click(function(){
			var start_date = $('#start_date').val();
			var end_date = $('#end_date').val();
			size = $("#size").val();
			count++;
						
			if(theater_num != 0 && size >= count && start_date != '' && end_date != ''){
				$.post("multiplexList_ajax", {theater_num:theater_num}, function(data){
					$("#multiplex").append(data);
				});
			}else if(theater_num == 0){
				count--;
				alert("극장을 선택해주세요");
			}else if(size < count){
				count--;
				alert("더 이상 추가할 상영관이 존재하지 않습니다.");
			}else if(start_date == ''){
				count--;
				alert("상영시작일을 입력해주세요");
			}else if(end_date == ''){
				count--;
				alert("상영종료일을 입력해주세요");
			}
		});
		 
		$("#theaterRequest").click(function(){
			
			
			size = $("#size").val();
			var s = document.getElementsByName("start_date");
			var e = document.getElementsByName("end_date");
			
			var s_check = 1;
			var e_check = 1;
 			
 			
			for(var i=0; i<s.length ; i++){
				if(s[i].value == ''){
					s_check = s_check*0;
				}
				if(e[i].value == ''){
					e_check = e_check*0;
				}
			}
			
			
			
			
			if(theater_check && multiplex_check && s_check==1 && e_check==1){
				if(confirm("상영 정보를 추가하시겠습니까?")){
					$('#frm').submit();
				}
			}else if(!theater_check){
				alert("극장을 선택해주세요");
			}else if(!multiplex_check){
				alert("상영관을 다시 선택해주세요");
			}else if(s_check!=1){
				alert("상영시작일을 입력해주세요");
			}else if(e_check!=1){
				alert("상영종료일을 입력해주세요");
			}else{
				alert("상영을 추가하실 수 없습니다");
			}
		});
		
	});
</script>
<title>Insert title here</title>

</head>
<body>
	<%@ include file="/resources/part/header1.jspf" %>
	<section>
		<div class="container">
			<form id="frm" action="theaterRequest" method="post" style="width: 1000px;">
				<input type="hidden" id="movie_num" name="movie_num" value="${lowpricemovie.num }"><br>
				<table style="width: 650px;">
					<tr>
						<td class="write-tdName" rowspan="2"><span class="titleSpan">영화</span></td>
						<td class="write-tdWrite">
							<span><img alt="" src="${lowpricemovie.thumnail }" style="width:200px;"></span>
						</td>
					</tr>
					<tr>
						<td style="font-size: 20px; font-weight: bold;">
							${lowpricemovie.title }
						</td>
					</tr>
					<tr>
						<td class="write-tdName"><span class="titleSpan">극장</span></td>
						<td>
							<select class="form-control" id="theater" name="theater_num">
								<option value="0">선택</option>
								<c:forEach items="${list }" var="list">
									<option value="${list.num }">${list.name }</option>
								</c:forEach>
							</select>
						</td>
					</tr>
				</table>
				
				
				<table style="width: 650px;" id="multiplex">
					
					
				</table>
				
				<table>
					<tr>
						<td style="padding-left: 150px;"><input class="button btn btn-default" type="button" value="상영관 추가하기" id="mul_add">
						
						<!-- 상영시작시간 : 영화시간+준비시간10  -->
						
						<input class="button btn btn-default" type="button" id="theaterRequest" value="상영 추가하기"></td>
					</tr>
				</table>
			</form>
		</div>
	</section>
</body>
</html>
				
				
				