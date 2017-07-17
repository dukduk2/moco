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
<link rel="styleSheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/directorBoardView.css">
<title>MOVIE COMMUNICATION</title>
<script type="text/javascript">
	$(function(){
		// delete
		$("#deleteBtn").click(function(){
			var num = $(this).attr("title");
			if(confirm("펀딩을 중도 포기하시겠습니까? 투자금은 모두 회수됩니다.")){
				location.href="./deleteFunding?num="+num;
			}
		});
		
		// investors list
		$("#viewInvestors").click(function(){
			var pnum = $(this).attr("title");
			window.open("./investorList?pnum="+pnum, "", "width=800,height=800");
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
</head>
<body>
	<%@ include file="/resources/part/header2.jspf" %>
	<section>
	<div id="intro-wrap">
		<div id="director-info">
			<p id="projected-by">Projected by</p>
			<div id="director-info-img">
				<img src="../../resources/upload/member/${memberDTO.fname }">
			</div>
			<div id="director-name">
				<p>
					<span id="name">${directorMemberDTO.name }</span>&nbsp;
					<span id="dir">감독님</span><br>
					<span id="dir">${directorMemberDTO.email }</span>
				</p>
			</div>
			<fmt:formatNumber var="tPrice" pattern="#,###">${boardDTO.targetPrice }</fmt:formatNumber>
			<p id="funding-intro">이 펀딩은 <span>${tPrice}원</span>을 목표로 <span>${boardDTO.targetDate }</span>까지 진행합니다.</p>
		</div>
		<div style="padding-bottom: 20px;">
			<c:if test="${sessionScope.memberDTO.id == boardDTO.writer }">
				<c:if test="${boardDTO.state == 1}">
					<button id="deleteBtn" class="btn btn-default" title="${boardDTO.num }">펀딩 중도 포기</button>
				</c:if>
				<button id="viewInvestors" class="btn btn-default" title="${boardDTO.num }">투자자 리스트</button>
			</c:if>
			<c:if test="${boardDTO.state == 1 }">
				<button id="goInvest" type="button" class="btn btn-default" data-toggle="modal" data-target="#myInvestModal">투자하기</button>
			</c:if>
		</div>
		<br>
		<c:if test="${boardDTO.curPrice eq boardDTO.targetPrice}">
			<p style="text-align: center;">목표금액 달성으로 조기 마감되었습니다.</p>
		</c:if>
	</div>
	
	<div id="funding-contents-wrap">
		<div id="funding-info">
			<div class="funding-info-sub">
				<span><img src="../../resources/images/directorBoard/mountain.png"></span><br><br>
				<span class="sub-title">목표금액</span><br>
				<fmt:formatNumber var="tPrice" pattern="#,###">${boardDTO.targetPrice }</fmt:formatNumber>
				<span>${tPrice}원</span>
			</div>
			<div class="funding-info-sub">
				<span><img src="../../resources/images/directorBoard/community1.png"></span><br><br>
				<span class="sub-title">투자자 수</span><br>
				<span>${countInvestors}명</span>
			</div>
			<div class="funding-info-sub">
				<span><img src="../../resources/images/directorBoard/totalMoney.png"></span><br><br>
				<span class="sub-title">누적 투자액</span><br>
				<fmt:formatNumber var="cPrice" pattern="#,###">${boardDTO.curPrice }</fmt:formatNumber>
				<span>${cPrice}원</span>
			</div>
			<div class="funding-info-sub">
				<span><img src="../../resources/images/directorBoard/success2.png"></span><br><br>
				<span class="sub-title">달성률</span><br>
				<c:set var="result">${boardDTO.curPrice/boardDTO.targetPrice*100}</c:set>
				<fmt:formatNumber var="result" value="${result }" pattern="##"></fmt:formatNumber>
				<span>${result}%</span>
			</div>
			<div class="funding-info-sub">
				<span><img src="../../resources/images/directorBoard/money.png"></span><br><br>
				<span class="sub-title">나의 투자액</span><br>
				<fmt:formatNumber var="myMoney" pattern="#,###">${myInvestMoney}</fmt:formatNumber>
				<span>${myMoney}원</span>
			</div>
		</div>
		<p id="file-info">
			* 아래 첨부파일을 다운로드 받으시면 상세한 영화 제작 계획서를 보실 수 있습니다.<br>
			<a class="fileDownload" href="./download?fileName=planning_document.hwp">${boardDTO.oname }</a>
		</p>
		<p id="title-info">
			<span id="title">-${boardDTO.title }-</span><br>
			<span id="genre">${boardDTO.genre }</span>
		</p>
		<!-- 글 내용 -->
		<div id="movie-contents-info">${boardDTO.contents}</div>
	</div>

	<!-- Modal -->
	<div class="modal fade" id="myInvestModal" role="dialog">
		<div class="modal-dialog">
			<!-- Modal content-->
			<div class="modal-content">
					<!-- Modal Header -->
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title"><span style="color: #e65c00; letter-spacing: 1px;">${boardDTO.title }</span></h4>
					</div>
					<!-- Modal Body -->
					<div class="modal-body">
						<form action="./investInsert" method="post" name="frm">
						<input type="hidden" name="id" value="${sessionScope.memberDTO.id }">
						<input type="hidden" name="pnum" value="${boardDTO.num }">
						<p style="letter-spacing: 1px;"><strong>● 약관동의</strong></p>
						<div class="scrollbox">
							&#65279;<strong>MOCO 시나리오 펀딩 이용약관 &lt;서비스약관&gt;</strong><br><br>

MOCO의 시나리오 펀딩은 다음과 같은 내용을 담고 있습니다.<br><br>

제1조 목적<br>
본 약관은 MOCO(이하, 회사)에서 운영하는 www.moco.com 이용과 관련하여 MOCO와 회원과의 권리, 의무 및 책임사항, 기타 필요한 사항을 규정함을 목적으로 합니다.<br><br>

제2조 약관의 효력과 변경<br>
(1) 본 약관은 서비스를 통하여 이를 공지하거나, 전자우편, 기타의 방법으로 회원에게 통지함으로써 효력을 발생합니다.<br>
(2) 회사는 사정상 중요한 사유가 발생될 경우 사전 통지 없이 이 약관의 내용을 변경할 수 있으며, 변경된 약관은 본 조 제 1항과 같은 방법으로 공지 또는 통지함으로써 효력을 발생합니다.<br>
(3) 회사는 약관을 개정할 경우 그 개정약관은 그 적용일자 이후에 체결되는 계약에만 적용되고 그 이전에 이미 체결된 계약에 대해서는 개정 전의 약관조항이 그대로 적용됩니다.<br>
(4) 회원은 변경된 약관에 동의하지 않을 경우 회원 탈퇴를 요청할 수 있으며, 변경된 약관의 효력 발생일로부터 7일 이후에도 서비스를 계속 사용할 경우 약관의 변경 사항에 동의한 것으로 간주 됩니다. <br><br>

제3조 약관외 준칙<br>
(1) 본 약관은 회사가 제공하는 개별서비스에 관한 별도의 약관, 정책 및 운영규칙과 함께 적용됩니다.<br>
(2) 본 약관에 명시되지 않은 사항에 대해서는 전기통신기본법, 전기통신사업법, 정보통신윤리위원회 심의규정, 정보통신 윤리 강령, 프로그램 보호법 및 관계규정에 의합니다 <br><br>

제4조 용어의 정의<br>
(1) 회원 : 서비스를 제공받기 위하여 회사와 이용계약을체결하고 아이디(ID)를 부여받은 자를 말합니다.<br>
(2) 아이디(ID) : 회원의 식별과 회원의 서비스 이용을 위하여 회원이 선정하고 회사가 승인하는 문자나 숫자의 조합<br>
(3) 비밀번호 : 회원이 부여받은 ID와 일치된 회원임을 확인하고, 회원 자신의 비밀을 보호하기 위하여 회원이 정한 문자와 숫자의 조합<br>
(4) 이용해지 : 회사 또는 회원이 서비스 사용 후 이용계약을 종료시키는 의사표시<br>
(5) 정지 : 회사가 정한 일정한 요건에 따라 일정기간동안 서비스이용을 보류/중지하는 것<br>
(6) 중복가입 : 1인의 이용자가 서로다른 2개이상의 아이디(ID)로 회원등록을 하는 행위<br><br>
							
						</div>
						<p style="text-align: right; letter-spacing: 1px;">동의합니다 <input type="checkbox" id="agree"></p>
						<br><p><strong>● 투자금입력</strong></p>
						<div id="input-money-box">
							<div id="input-money-box-top">
								<div class="box-sub">
									<p class="box-sub-info">최대투자<br>가능금액</p>
									<c:set var="total_available" value="${boardDTO.targetPrice - boardDTO.curPrice}"></c:set>
									<fmt:formatNumber var="tAvailable" pattern="#,###">${boardDTO.targetPrice - boardDTO.curPrice}</fmt:formatNumber>
									<p id="tAavailable" title="${boardDTO.targetPrice - boardDTO.curPrice}"  style="color:#e65c00;">${tAvailable }원</p>
								</div>
								<div class="box-sub box-sub-middle">
									<p class="box-sub-info">사용가능<br>포인트</p>
									<fmt:formatNumber var="my_available" pattern="#,###">${sessionScope.memberDTO.point}</fmt:formatNumber>
									<p>${my_available }점</p>
								</div>
								<div class="box-sub">
									<p class="box-sub-info">나의현재<br>투자금액</p>
									<fmt:formatNumber var="my_invest" pattern="#,###">${myInvestMoney}</fmt:formatNumber>
									<p>${my_invest }원</p>
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
						<button class="btn btn-default" id="investBtn" style="color: #e65c00; border-color: #e65c00; letter-spacing: 1px;">투자하기</button>
					</div>
			</div>
		</div>
	</div>
	</section>
</body>
</html>