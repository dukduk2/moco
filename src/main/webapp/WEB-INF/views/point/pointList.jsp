<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%@ include file="/resources/part/bootStrap.jspf" %>
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.js"></script>
<link rel="styleSheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/header.css">
<link rel="styleSheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/section.css">
<link rel="styleSheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/list.css">
<script type="text/javascript">
	$(function() {
		// page
		$(".go").click(function(){
			var curPage=$(this).attr("id");
			location.href="./pointList?curPage="+curPage;
		});
		
		// kind 설정 시
		$("#selectBox").attr("name", "cash");
		$("#hiddenName").attr("name", "likes");
		
		$("input[name='kind']:radio").change(function() {
			var radio = $(this).val();
			if(radio == '좋아요'){
				$("#selectBox").attr("name", "likes");
				$("#hiddenName").attr("name", "cash");
			}else{
				$("#selectBox").attr("name", "cash");
				$("#hiddenName").attr("name", "likes");
			}
		});
		
		// benefit, point 계산 val()셋팅
		$("#selectBox").change(function() {
			var money = $("#selectBox").val();
			var percent = ${percent};
			var benefit = money*percent;
			var point = benefit+money*1;
			$("#benefit").val(benefit);
			$("#point").val(point);
		});
		
		// go!
		$("#pointGo").click(function() {
			var kind = $("#selectBox").attr("name");
			var money = $("#selectBox").val();
			var avlikes = $("#avlikes").val();
			if(kind == 'likes'){
				if(avlikes*1<money*1){
					alert("사용 가능한 '좋아요' 가 부족합니다.");
				}else{
					$("#pointForm").submit();
				}
			}else{
				$("#pointForm").submit();				
			}
		});
		
	});
</script>
<style type="text/css">
	.titleTD{
		font-weight: bold;
		font-size: 1.1em;
		font-family: Montserrat, sans-serif;
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
	.modalTable tr{
		display: table-row;
		vertical-align: middle;
		border-color: inherit;
	}
	.modalTable td{
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
	<section>
		<div class="container">
			<h2 style="text-align: center;">POINT 결제 내역 LIST</h2>
			<table class="table">
				<tr>
					<td class="titleTD">번호</td>
					<td class="titleTD">결제 날짜</td>
					<td class="titleTD">결제 방법</td>
					<td class="titleTD">좋아요</td>
					<td class="titleTD">현금</td>
					<td class="titleTD">혜택</td>
					<td class="titleTD">포인트</td>
				</tr>
				<c:forEach items="${pointList}" var="list">
					<tr>
						<td class="contentsTD">${list.num}</td>
						<td class="contentsTD">${list.point_date}</td>
						<c:if test="${list.kind == '좋아요'}">
							<td class="contentsTD">좋아요</td>
						</c:if>
						<c:if test="${list.kind == '현금/무통장' }">
							<td class="contentsTD">현금/무통장</td>
						</c:if>
						<td class="contentsTD">${list.likes}</td>
						<td class="contentsTD">${list.cash}</td>
						<td class="contentsTD">${list.benefit}</td>
						<td class="contentsTD">${list.point}</td>
					</tr>				
				</c:forEach>
			</table>
		
		<!-- 페이징 처리 -->
			<div class="paging">
				<div class="btn-group">
					<c:if test="${pageResult.curBlock>1}">
						<input type="button" class="go btn btn-primary" id="${pageResult.startNum-1}" value="[이전]">
					</c:if>
					<c:forEach begin="${pageResult.startNum}" end="${pageResult.lastNum}" var="i">
						<input type="button" class="go btn btn-primary" id="${i}" value="${i}">
					</c:forEach>
					<c:if test="${pageResult.curBlock<pageResult.totalBlock}">
						<input type="button" class="go btn btn-primary" id="${pageResult.lastNum+1}" value="[다음]">
					</c:if>
				</div>
			</div>

			<br>
			<button type="button" class="btn btn-success" data-toggle="modal" data-target="#myModal">포인트 충전</button>
			<!-- modal - 충전 -->
	 		<div class="modal fade" id="myModal" role="dialog">
			    <div class="modal-dialog">
			      <!-- Modal content-->
			      <form action="./pointInsert" method="post" id="pointForm">
			      <div class="modal-content">
			        <div class="modal-header">
			          <button type="button" class="close" data-dismiss="modal">&times;</button>
			          <h4 class="modal-title">포인트 충전</h4>
			        </div>
			        <div class="modal-body">
			          <table class="modalTable">
			          		<tr>
			          			<td>ID</td>
			          			<td colspan="2">
			          				${memberDTO.id}
			          				<input type="hidden" name="id" value="${memberDTO.id}">
			          			</td>
			          		</tr>
			          		<tr>
			          			<td>AVALIABLELIKES</td>
			          			<td colspan="2">
			          				${memberDTO.avaliableLikes} 개
			          				<input type="hidden" id="avlikes" value="${memberDTO.avaliableLikes}">
			          			</td>
			          		</tr>
			          		<tr>
			          			<td>POINT</td>
			          			<td colspan="2">${memberDTO.point} 점</td>
			          		</tr>
			          		<tr>
			          			<td>GRADE / BENEFIT</td>
				          			<c:choose>
				          				<c:when test="${memberDTO.grade == '일반' }">
				          					<td colspan="2">${memberDTO.grade} / 충전 금액의 5%</td>
				          				</c:when>
				          				<c:when test="${memberDTO.grade == '브론즈' }">
				          					<td colspan="2">${memberDTO.grade} / 충전 금액의 10%</td>
				          				</c:when>
				          				<c:when test="${memberDTO.grade == '실버' }">
				          					<td colspan="2">${memberDTO.grade} / 충전 금액의 15%</td>
				          				</c:when>
				          				<c:when test="${memberDTO.grade == '골드' }">
				          					<td colspan="2">${memberDTO.grade} / 충전 금액의 20%</td>
				          				</c:when>
				          				<c:when test="${memberDTO.grade == '다이아몬드' }">
				          					<td colspan="2">${memberDTO.grade} / 충전 금액의 25%</td>
				          				</c:when>
				          			</c:choose>
			          		</tr>
			          		<tr>
			          			<td><span>포인트 충전 방식</span></td>
			          			<td colspan="2">
			          				<label class="radio-inline">
			          					<input type="radio" name="kind" value="현금/무통장" checked="checked"><span class="titleTD">현금/무통장</span>
			          				</label>
			          				<label class="radio-inline">
			          					<input type="radio" name="kind" value="좋아요"><span class="titleTD">좋아요</span>
			          				</label>
			          			</td>
			          		</tr>
				          	<tr>
				          		<td>충전 금액</td>
				          		<td colspan="2">
					          		<select name="likes" id="selectBox" class="form-control inputCSS">
					          			<option value="5000">5000원</option>
					          			<option value="10000">10000원</option>
					          			<option value="30000">30000원</option>
					          			<option value="50000">50000원</option>
					          		</select>
					          		<input type="hidden" name="cash" value="0" id="hiddenName">
				          		</td>
				          	</tr>
				          	<tr>
				          		<td>BENEFIT</td>
				          		<td>
					          		<input type="text" name="benefit" value="${benefit}" id="benefit" readonly="readonly" class="form-control inputCSS">		          			
				          		</td>
				          		<td>포인트</td>
				          	</tr>
				          	<tr>
				          		<td>POINT</td>
				          		<td>				          		
					          		<input type="text" name="point" value="${point}" id="point" readonly="readonly" class="form-control inputCSS">
				          		</td>
				          		<td>포인트</td>
				          	</tr>
			          </table>
			        </div>
			        <div class="modal-footer">
			          <input type="button" class="btn btn-primary" value="충전하기" id="pointGo">
			        </div>
			      </div>
			      </form>
			    </div>
			</div>

		</div>		
	</section>
</body>
</html>