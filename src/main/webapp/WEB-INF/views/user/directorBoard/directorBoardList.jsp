<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/resources/part/bootStrap.jspf" %>
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.js"></script>
<link rel="styleSheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/header.css">
<link rel="styleSheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/section.css">
<link rel="styleSheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/directorboardList.css">
<title>MOVIE COMMUNICATION</title>
<script type="text/javascript">
	$(function(){
		var checked_count = 0;
		var chked_val="";
		var chked_state;
		var lastRow;
		
		// 검색 전 전체 결과 뿌려주기
		$.ajax({
			url : "./directorBoardList_ajax",
			type : "GET",
			data : {
			},
			success : function(data) {
				$("#search-result").html(data);
			}
		});
		
		// 장르 선택
		$(".chx").change(function(){
		// 장르 검색은 최대 3개까지
			chked_val="";
	        checked_count = $('input:checkbox[name="genre"]:checked').length;
	        if(checked_count > 3){
	        	alert("장르는 3개까지 선택 가능합니다.");
	        	$(this).prop("checked", false);
	        }
	        // 장르 검색 결과 뿌려주기
     		 $('input:checkbox[name=genre]').each(function() {
	       		 if($(this).is(':checked'))
	       			chked_val += ","+($(this).val());
     		 });
	        
	        $.ajax({
				url : "./directorBoardList_ajax",
				type : "GET",
				data : {
					chked_val : chked_val,
					chked_state : chked_state,
				},
				success : function(data) {
					$("#search-result").html(data);
				}
			});
		});
		// state 선택
		$(".invest_state").click(function(){
			chked_state = $(this).val();
			$.ajax({
				url : "./directorBoardList_ajax",
				type : "GET",
				data : {
					chked_val : chked_val,
					chked_state : chked_state
				},
				success : function(data) {
					$("#search-result").html(data);
				}
			});
		});
		// ajax 페이지에 click event 위임
		// contents보기
		$("#search-result").on('click', ".contents", function(){
			var num = $(this).attr("id");
			location.href="./directorBoardView?num="+num;
		});
		// 더보기
		$("#search-result").on('click','.load-more',function(){
			lastRow = $(this).attr("id")*1;
			$.ajax({
				type : "GET",
				url : "./directorBoardList_ajax",
				data : {
					chked_val : chked_val,
					chked_state : chked_state,
					sRow : lastRow+1
				},
				success : function(data) {
					data = data.trim();
					$(".load-more").remove();
					$("#search-result").append(data);
				}
			});
		});
	});
</script>
</head>
<body>
	<%@ include file="/resources/part/header2.jspf" %>
	<%@ include file="/resources/part/sideMenu.jspf" %>
	<section>
	<!-- introduce -->
	<!-- <div id="introduce">
		<img src="../../resources/images/directorBoard/introduce.jpg">
		<div id="introduce-contents">
			
		</div>
	</div> -->
	<div id="intro-wrap">
		<!-- 등록 -->
		<div class=intro-contents>
				<div>
					<div class="intro-left">
						<img src="../../resources/images/directorBoard/계약서작성.png">
					</div>
					<div class="intro-right" style="margin-top: 30px;">
						<p class="intro-num">0. 시나리오펀딩 등록하기</p>
						<div>
							<p>펀딩 등록시 아래의 양식을 채워서 함께 업로드해주세요. </p>
							<p>	
								<a href="./download?fileName=planning_document.hwp">양식 다운로드</a>
								<span> | </span>
								<a href="./directorBoardWrite">펀딩 등록하기</a>
							</p>
						</div>
					</div>
				</div>
			</div>
		<!-- 신청 -->
		<div class=intro-contents>
			<div>
				<div class="intro-left">
					<p class="intro-num">1. 시나리오 확인</p>
					<div>
						<p>홈페이지에 게재된 펀딩마다 영화 제작 계획서를 다운받아 확인하실 수 있습니다. </p>
					</div>
				</div>
				<div class="intro-right" style="margin-top: 30px;">
					<img src="../../resources/images/directorBoard/구좌신청.png">
				</div>
			</div>
		</div>
		<!-- 계약서 -->
		<div class=intro-contents>
			<div>
				<div class="intro-left" style="margin-top: 40px;">
					<img src="../../resources/images/directorBoard/수익금지급.png">
				</div>
				<div class="intro-right" style="margin-top: 60px;">
					<p class="intro-num">2. 투자 페이지로 이동</p>
					<div>
						<p>영화 제작 계획서를 확인 후 '투자하기' 버튼 클릭으로 투자 페이지로 이동합니다.</p>
					</div>
				</div>
			</div>
		</div>
		<!-- 참여금액 -->
		<div class=intro-contents>
			<div>
				<div class="intro-left">
					<p class="intro-num">3. 투자금 확인 후 투자하기</p>
					<div>
						<p>투자 페이지에서 현재 투자액, 가능 투자액을 확인합니다.</p>
						<p>최소 참여 투자액은 10,000원이며 10,000만원 단위로 투자하실 수 있습니다.</p>
						<p>투자액은 모두 포인트로 결제 가능하며 투자 즉시 가용포인트에서 차감됩니다.</p>
					</div>
				</div>
				<div class="intro-right" style="margin-top: 30px;">
					<img src="../../resources/images/directorBoard/참여금액송금.png">
				</div>
			</div>
		</div>
		<!-- 모집완료 -->
		<div class=intro-contents>
			<div>
				<div class="intro-left" style="margin-top: 40px;">
					<img src="../../resources/images/directorBoard/모집완료.png">
				</div>
				<div class="intro-right" style="margin-top: 60px;">
					<p class="intro-num">4. 투자자 리스트 확인</p>
					<div>
						<p>감독님께서는 펀딩페이지에서 투자자 리스트를 확인하실 수 있습니다.</p>
					</div>
				</div>
			</div>
		</div>
		<!-- 투자금 -->
		<div class=intro-contents>
			<div>
				<div class="intro-left">
					<p class="intro-num">5. 투자 마감</p>
					<div>
						<p>마감일 이전 모집금을 달성할 시, 달성 즉시 투자금액 100%가 포인트로 전환됩니다.</p>
						<p>모집금 미달성 시, 마감일 자정에 투자자의 투자금액 100%를 포인트로 전환해드립니다.</p>
					</div>
				</div>
				<div class="intro-right">
					<img src="../../resources/images/directorBoard/투자금회수.png">
				</div>
			</div>
		</div>
	</div>
	<br>
	<div id="invest-wrap">
		<p id="invest">투자하기</p>
	</div>
	<!-- 검색 -->
	<table id="serch-table">
		<tr>
			<th>장르</th>
			<td>
				드라마<input type="checkbox" class="chx" name="genre" value="드라마">
				판타지<input type="checkbox" class="chx" name="genre" value="판타지">
				공포<input type="checkbox" class="chx" name="genre" value="공포">
				로맨스/멜로<input type="checkbox" class="chx" name="genre" value="로맨스/멜로">
				모험<input type="checkbox" class="chx" name="genre" value="모험">
				스릴러<input type="checkbox" class="chx" name="genre" value="스릴러">
				느와르<input type="checkbox" class="chx" name="genre" value="느와르">
				다큐멘터리<input type="checkbox" class="chx" name="genre" value="다큐멘터리">
				코미디<input type="checkbox" class="chx" name="genre" value="코미디">
				가족<input type="checkbox" class="chx" name="genre" value="가족">
				미스터리<input type="checkbox" class="chx" name="genre" value="미스터리">
				전쟁<input type="checkbox" class="chx" name="genre" value="전쟁">
				애니메이션<input type="checkbox" class="chx" name="genre" value="애니메이션">
				범죄<input type="checkbox" class="chx" name="genre" value="범죄">
				뮤지컬<input type="checkbox" class="chx" name="genre" value="뮤지컬">
				SF<input type="checkbox" class="chx" name="genre" value="SF">
				액션<input type="checkbox" class="chx" name="genre" value="액션">
			</td>
		</tr>
		<tr>
			<th>상태</th>
			<td>
				<button class="invest_state btn btn-default" name="invest_state" value="2">전체보기</button> | 
				<button class="invest_state btn btn-default" name="invest_state" value="1">진행중</button> | 
				<button class="invest_state btn btn-default" name="invest_state" value="0">마감완료</button>
			</td>
		</tr>
	</table>
	<div id="search-result"></div>
	</section>
</body>
</html>