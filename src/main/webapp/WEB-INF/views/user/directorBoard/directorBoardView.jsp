<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/resources/part/bootStrap.jspf" %>
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.js"></script>
<link rel="styleSheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/header.css">
<link rel="styleSheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/section.css">
<title>MOVIE COMMUNICATION</title>
<script type="text/javascript">
	$(function(){
		// delete
		$("#deleteBtn").click(function(){
			var num = $(this).attr("title");
			if(confirm("정말 삭제하시겠습니까? 투자금은 모두 회수됩니다.")){
				location.href="./deleteFunding?num="+num;
			}
		});
		
		// investors list
		$("#viewInvestors").click(function(){
			var pnum = $(this).attr("title");
			window.open("./investorList?pnum="+pnum, "", "width=600,height=800");
		});
		
		$("#investBtn").click(function(){
			var chx_check = true;
			// 약관 동의 체크
			if($("#agree").is(":checked")){
				
			}else{
				chx_check = false;
				alert("약관에 동의해주세요.");
			}
			// 0원 입력X
			if($("#money").val()==0){
				alert("정확한 목표 금액을 입력해주세요.");
				chx_check = false;
			}
			// money는 만 원 단위로만 입력. 천 원 단위 입력시 내림계산
			var checkTargetPrice = ($("#money").val())%10000;
			if(checkTargetPrice > 0){
				alert("10,000원 단위로 입력해주세요.");
				$("#money").val($("#money").val()-checkTargetPrice);
				chx_check = false;
			}
			// 가용 포인트보다 높은 금액 입력 불가
			var myAvailable = $("#money").attr("title");
			if($("#money").val() > myAvailable*1){
				alert("가용 포인트보다 더 많은 금액을 입력하실 수 없습니다.");
				$("#money").val(0);
				chx_check = false;
			}
			
			var tAavailable = $("#tAavailable").attr("title");
			if($("#money").val() > tAavailable*1){
				alert("최대 투자 가능 금액을 초과하였습니다.");
				$("#money").val(0);
				chx_check = false;
			}
			
			// submit check
			if(chx_check){
				if(confirm("정말 투자하시겠습니까?")){
					frm.submit();
				}
			}
		});
	});
</script>
<style type="text/css">
	#view-wrap{
		width: 500px;
		height: 600px;
	}
	#view-wrap tr{
		border: 1px solid black;
	}
	#view-wrap td{
		border: 1px solid black;
	}
	.scrollbox{
		padding: 25px;
	    height: 230px;
	    overflow-y: scroll;
	    border: 1px solid #d1d1d1;
	    background: #fdfdfd;
	    text-align: justify;
	}
	#input-money-box{
		height: 200px;
	}
	.box-sub{
		width: 31%;
		height: 90%;
		border: 1px solid #d1d1d1;
		float: left;
	}
	.box-sub-middle{
		margin: 0 19px;
	}
	#input-money-box-top{
		height: 75%;
	}
	#input-money-box-bottom{
		height: 20%;
		margin-top: 10px;
	}
	#money{
		width: 100%;
		height: 100%;
		border: 1px solid #d1d1d1;
	}
</style>
</head>
<body>
	<%@ include file="/resources/part/header2.jspf" %>
	<section>
	<table id="view-wrap">
		<tr>
			<td colspan="4">${boardDTO.title }</td>
		</tr>
		<tr>
			<td>감독</td>
			<td>${boardDTO.name }</td>
			<td>장르</td>
			<td>${boardDTO.genre }</td>
		</tr>
		<tr>
			<td>목표금액</td>
			<fmt:formatNumber var="tPrice" pattern="#,###">${boardDTO.targetPrice }</fmt:formatNumber>
			<td>${tPrice}</td>
			<td>현재금액</td>
			<fmt:formatNumber var="cPrice" pattern="#,###">${boardDTO.curPrice }</fmt:formatNumber>
			<td>${cPrice}(${countInvestors}명)</td>
		</tr>
		<tr>
			<td>나의 투자액</td>
			<fmt:formatNumber var="myMoney" pattern="#,###">${myInvestMoney}</fmt:formatNumber>
				<c:if test="${boardDTO.state==1 }">
					<td colspan="2">${myMoney}원</td>
					<td>
						<button type="button" class="btn" data-toggle="modal" data-target="#myInvestModal">투자하기</button>
					</td>
				</c:if>
				<c:if test="${boardDTO.state==0 }">
					<td colspan="3">${myMoney}원</td>
				</c:if>
		</tr>
		<tr>
			<td colspan="4">${boardDTO.contents }</td>
		</tr>
		<tr>
			<td colspan="2">첨부파일</td>
			<td colspan="2"><a href="./download?fileName=planning_document.hwp">${boardDTO.oname }</a></td>
		</tr>
	</table>
	
	<c:if test="${sessionScope.memberDTO.id == boardDTO.writer }">
		<button id="viewInvestors" title="${boardDTO.num }">Investor List</button>
	</c:if>
	
	<button id="deleteBtn" class="btn" title="${boardDTO.num }">DELETE</button>


	<!-- Modal -->
	<div class="modal fade" id="myInvestModal" role="dialog">
		<div class="modal-dialog">
			<!-- Modal content-->
			<div class="modal-content">
					<!-- Modal Header -->
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title">Header</h4>
					</div>
					<!-- Modal Body -->
					<div class="modal-body">
						<form action="./investInsert" method="post" name="frm">
						<input type="hidden" name="id" value="${sessionScope.memberDTO.id }">
						<input type="hidden" name="pnum" value="${boardDTO.num }">
						<p>약관동의</p>
						<div class="scrollbox"></div>
						<p style="text-align: right;">동의합니다 <input type="checkbox" id="agree"></p>
						<br><p>투자금입력</p>
						<div id="input-money-box">
							<div id="input-money-box-top">
								<div class="box-sub">
									<p>최대투자<br>가능금액</p>
									<c:set var="total_available" value="${boardDTO.targetPrice - boardDTO.curPrice}"></c:set>
									<fmt:formatNumber var="tAvailable" pattern="#,###">${boardDTO.targetPrice - boardDTO.curPrice}</fmt:formatNumber>
									<p id="tAavailable" title="${boardDTO.targetPrice - boardDTO.curPrice}">${tAvailable }</p>
								</div>
								<div class="box-sub box-sub-middle">
									<p>사용가능<br>포인트</p>
									<fmt:formatNumber var="my_available" pattern="#,###">${sessionScope.memberDTO.point}</fmt:formatNumber>
									<p>${my_available }</p>
								</div>
								<div class="box-sub">
									<p>나의현재<br>투자금액</p>
									<fmt:formatNumber var="my_invest" pattern="#,###">${myInvestMoney}</fmt:formatNumber>
									<p>${my_invest }</p>
								</div>
							</div>
							<div id="input-money-box-bottom">
								<input type="number" name="money" id="money" title="${sessionScope.memberDTO.point}" min="0" step="10000">
							</div>
						</div>
						</form>
					</div>
					<!-- Modal Footer -->
					<div class="modal-footer">
						<button class="btn btn-default" id="investBtn">투자하기</button>
					</div>
			</div>
		</div>
	</div>
	</section>
</body>
</html>