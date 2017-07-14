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
<link rel="styleSheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/directorBoardWrite.css">
<title>MOVIE COMMUNICATION</title>
<script src="../../resources/SE2/js/HuskyEZCreator.js"></script>
<script type="text/javascript">
	$(function(){
		var editor_object = [];
	    nhn.husky.EZCreator.createInIFrame({
	        oAppRef: editor_object,
	        //textarea의 id를 줍니다
	        elPlaceHolder: "contents",
	        //경로
	        sSkinURI: "../../resources/SE2/SmartEditor2Skin.html", 
	        htParams : {
	            // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
	            bUseToolbar : true,             
	            // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
	            bUseVerticalResizer : true,     
	            // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
	            bUseModeChanger : true, 
	        }
	    });
	    
		// date에 오늘 날짜 넣기
		document.getElementById('targetDate').valueAsDate = new Date();
		
		// 장르 선택
		var checked_count = 0;
		$(".chx").change(function(){
	        checked_count = $('input:checkbox[name="genre"]:checked').length;
	        if(checked_count > 3){
	        	alert("장르는 3개까지 선택 가능합니다.");
	        	$(this).prop("checked", false);
	        }
	    });
		// submit check
		$("#savebutton").click(function(){
			//id가 contents인 textarea에 에디터에서 대입
	        editor_object.getById["contents"].exec("UPDATE_CONTENTS_FIELD", []);
			
			var input_check = true;
			// title 입력
			if($("#title").val()==""){
				alert("제목을 입력해주세요.");
				input_check = false;
			}
			// writer -> session ID
			// contents 입력
			if($("#contents").val()==""){
				alert("내용을 입력해주세요.");
				input_check = false;
			}
			// target_date 입력
			if($("#tagetDate").val()==""){
				alert("마감일을 선택해주세요.");
				input_check = false;
			}
			// genre 선택
			if(checked_count==0){
				alert("장르를 1개 이상 선택해주세요.");
				input_check = false;
			}
			// target_price
			if($("#targetPrice").val()==0){
				alert("정확한 목표 금액을 입력해주세요.");
				input_check = false;
			}
			// target_price는 만 원 단위로만 입력. 천 원 단위 입력시 내림계산
			var checkTargetPrice = ($("#targetPrice").val())%10000;
			if(checkTargetPrice > 0){
				alert("10,000원 단위로 입력해주세요.");
				$("#targetPrice").val($("#targetPrice").val()-checkTargetPrice);
			}
			
			// file
			if($("#file").val()==""){
				alert("파일을 첨부해주세요.");
				input_check = false;
			}
		    // 날짜 비교. 오늘 날짜보다 이전 날짜 선택X
			var today = new Date();
		    var today_year = today.getFullYear();
		    var today_month = today.getMonth()+1;
		    if(today_month<10){
		    	today_month = "0"+today_month;
		    }
		    var today_day = today.getDate();
		    var stoday = today_year+""+today_month+""+today_day;
		    var targetDate = $("#targetDate").val();
		    var targetDateArr = targetDate.split('-');
		    var stargetDate = targetDateArr[0]+""+targetDateArr[1]+""+targetDateArr[2];
			var diff = stoday*1 - stargetDate*1;
			if(diff>0){
				alert("오늘 날짜보다 이전 날짜를 선택할 수 없습니다.");
				document.getElementById('targetDate').valueAsDate = new Date();
				input_check = false;
			}
			
			if(input_check==true){
				frm.submit();
			}
		});
	});
</script>
</head>
<body>
	<%@ include file="/resources/part/header2.jspf" %>
	<section>
	<p style="text-align: center; font-size: 50px; font-weight: bold; margin-bottom: 20px; color: #666666;">- 펀딩 작성요령 -</p>
	<div id="notice-contents-wrap">
		<div style="border-top: 1px soilid #cccccc; width: 100%; height: 500px;">
			<div id="notice-contents-mid">
				<p style="text-align: center; margin-top: 20px;"><img src="../../resources/images/directorBoard/calendar.png"></p>
				<p id="targetDate-wrap">펀딩 기간 설정하기</p>
				<p class="targetDate-info">펀딩 모금기간은 보통 2달에서 3달 내외로 설정하시길 권장합니다.(최장 6개월)</p>
				<p class="targetDate-info">대부분의 펀딩은 오픈과 동시에 투자가 집중됩니다.</p>
				<p class="targetDate-info">모금이 길어지면 초반 투자자들이 영화제작을 기다리는 시간이 길어질 수 있습니다.</p>
				<p class="targetDate-info">펀딩 모금기간 내에 목표 금액 달성 즉시 투자금은 포인트로 적립됩니다.</p>
				<p style="text-align: center; margin-top: 40px;">
					<img style="height: 200px;" src="../../resources/images/directorBoard/graph.png">
				</p>
			</div>
			<div id="notice-contents-bot">
				<p style="text-align: center; margin-top: 20px;"><img src="../../resources/images/directorBoard/money.png"></p>
				<p id="targetDate-wrap">펀딩 목표금액 설정하기</p>
				<p class="targetDate-info">목표금액은 펀딩을 독려하기 위한 하나의 지표입니다.</p>
				<p class="targetDate-info">목표를 높게 설정한다고해서 높은 투자금이 보장되지는 않습니다.</p>
				<p class="targetDate-info">오히려 실현 가능한 수준일 때 투자가 독려되는 경향이 있습니다.</p>
				<p class="targetDate-info">투자 종료 후 달성률은 기록으로 남게 되므로 필요한 만큼,</p>
				<p class="targetDate-info">달성 가능한 만큼의 목표금액을 책정해 주세요.</p>
				<p class="targetDate-info">(목표금액에 도달하지 않을 경우 투자금은 모두 회수됩니다.)</p>
			</div>
		</div>
		<div id="notice-contents-top">
			<table style="margin: 50px 0;">
				<tr style="margin-bottom: 30px; height: 100px;">
					<th>● Director</th>
					<td>
						<p>투자자에게 신뢰감을 줄 수 있도록 감독님을 소개해주세요.</p>
						<p>필모그래피 등을 함께 올려주시면 투자자들에게 더욱 친근하게 다가갈 수 있습니다.</p>
					</td>
				</tr>
				<tr style="margin-bottom: 30px; height: 100px;">
					<th>● Funding Story</th>
					<td>
						<p>펀딩을 진행하게 된 이유를 설명해주세요.</p>
					</td>
				</tr>
				<tr style="margin-bottom: 30px; height: 100px;">
					<th>● Funding Plan</th>
					<td>
						<p>투자금의 사용처를 분명하게 써주세요.</p>
						<p>모인 투자금은 계획한 대로 맞춰 사용해야 합니다.</p>
					</td>
				</tr>
				<tr style="margin-bottom: 30px; height: 100px;">
					<th>● Movie Details</th>
					<td>
						<p>제작 계획중인 영화에 대해 최대한 상세히 설명해주세요.</p>
						<p>어떤 메시지를 담고 있는지, 이 영화에 투자하면 어떤 결과가 생길지 서술해주세요.</p>
						<p>영화를 관람하신 분들과 사회에 어떤 메시지를 전할 수 있을까요?</p>
						<p>이 영화가 제작되어야 할 이유를 명확히 풀어주세요. </p>
						<p>이미지와 상세 정보를 첨부해주세요.</p>
						<p><span style="font-weight: bold; color: #e65c00;">* 영화제작계획서 필수 첨부</span></p>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<br><br><br>
	<div id="writeForm">
	<!-- form 입력 -->
	<form action="./directorBoardWrite" method="post" enctype="multipart/form-data" name="frm">
	<p style="text-align: center; font-size: 50px; font-weight: bold; margin-bottom: 20px;">- 펀딩 작성하기 -</p>
		<table>
			<tr style="height: 50px;">
				<th>* 제 &nbsp; &nbsp; &nbsp; 목</th>
				<td colspan="5"><input style="height: 50px;" type="text" name="title" id="title"></td>
			</tr>
			<tr style="height: 100px;">
				<th>
					<p>* 영화 장르</p>
					<p>(최대 3개)</p>
				</th>
				<td colspan="5">
					<div style="margin-left: 10px;" id="checkbox-wrap">
						<p>드라마<input type="checkbox" class="chx" name="genre" value="드라마">
						판타지<input type="checkbox" class="chx" name="genre" value="판타지">
						공포<input type="checkbox" class="chx" name="genre" value="공포">
						멜로<input type="checkbox" class="chx" name="genre" value="멜로">
						모험<input type="checkbox" class="chx" name="genre" value="모험">
						스릴러<input type="checkbox" class="chx" name="genre" value="스릴러">
						느와르<input type="checkbox" class="chx" name="genre" value="느와르">
						다큐멘터리<input type="checkbox" class="chx" name="genre" value="다큐멘터리">
						코미디<input type="checkbox" class="chx" name="genre" value="코미디"></p>
						<p>가족<input type="checkbox" class="chx" name="genre" value="가족">
						미스터리<input type="checkbox" class="chx" name="genre" value="미스터리">
						전쟁<input type="checkbox" class="chx" name="genre" value="전쟁">
						애니메이션<input type="checkbox" class="chx" name="genre" value="애니메이션">
						범죄<input type="checkbox" class="chx" name="genre" value="범죄">
						뮤지컬<input type="checkbox" class="chx" name="genre" value="뮤지컬">
						SF<input type="checkbox" class="chx" name="genre" value="SF">
						액션<input type="checkbox" class="chx" name="genre" value="액션"></p>
					</div>
				</td>
			</tr>
			<tr style="height: 50px;">
				<th>* 펀딩 마감일</th>
				<td><input type="date" name="targetDate" id="targetDate" ></td>
				<th>* 목표금액</th>
				<td><input type="number" name="targetPrice" id="targetPrice" min="10000" step="10000"></td>
				<th><span style="color: #e65c00;">* 첨부파일</span></th>
				<td colspan="3"><input type="file" name="multipartFile" id="file"></td>
			</tr>
			<tr>
				<td colspan="6">
					<textarea id="contents" name="contents" style="width: 100%; height: 800px;"></textarea>
				</td>
			</tr>
		</table>
		<input class="btn btn-default" type="button" value="펀딩등록하기" id="savebutton" style="border: 1px solid #b3b3b3;
		float: right; margin: 15px 60px;">
	</form>
	</div>
	</section>
</body>
</html>