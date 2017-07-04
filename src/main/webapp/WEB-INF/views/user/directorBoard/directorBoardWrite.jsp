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
<title>Insert title here</title>
<script type="text/javascript">
	$(function(){
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
		$("#submitBtn").click(function(){
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
	
	<form action="./directorBoardWrite" method="post" enctype="multipart/form-data" name="frm">
		<p>title <input type="text" name="title" id="title"></p>
		<p>writer <input type="text" name="writer"></p>
		<p>contents <input type="text" name="contents" id="contents"></p>
		<p>target_date <input type="date" name="targetDate" id="targetDate"></p>
		<p>genre(최대 3개까지 선택)</p> 
			드라마<input type="checkbox" class="chx" name="genre" value="드라마">
			판타지<input type="checkbox" class="chx" name="genre" value="판타지">
			공포<input type="checkbox" class="chx" name="genre" value="공포">
			멜로<input type="checkbox" class="chx" name="genre" value="멜로">
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
		<p>target_price <input type="number" name="targetPrice" id="targetPrice" min="10000" step="10000"></p>
		<p>file <input type="file" name="multipartFile" id="file"></p>
		<input type="button" value="글쓰기" id="submitBtn">
	</form>
	</section>
</body>
</html>