<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/resources/part/bootStrap.jspf" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	$(function(){
		var checked_count = 0;
		var chked_val="";
		
		// 장르 선택
		$(".chx").change(function(){
		// 장르 검색은 최대 3개까지
			chked_val="";
	        checked_count = $('input:checkbox[name="genre"]:checked').length;
	        if(checked_count > 3){
	        	alert("장르는 3개까지 선택 가능합니다.");
	        	$(this).prop("checked", false);
	        }
		});
		
		// 글 업로드
		$("#submitBtn").click(function(){
			if(confirm("영화 정보를 업로드 하시겠습니까?")){
				frm.submit();
			}
		});
	});
</script>
</head>
<body>
	<form name="frm" action="movieInfoWrite" method="post" enctype="multipart/form-data">
		KIND 
		일반영화<input type="radio" name="kind" value="basic">
		독립영화<input type="radio" name="kind" value="low"><br>
		TITLE <input type="text" name="title"><br>
		ENG_TITLE <input type="text" name="eng_title"><br>
		GENRE 
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
			액션<input type="checkbox" class="chx" name="genre" value="액션"><br>
		DIRECTOR <input type="text" name="director"><br>
		ACTOR <input type="text" name="actor"><br>
		YEAR<input type="number" name="year" min="1900" max="2050"><br>
		NATION <input type="text" name="nation"><br>
		TRAILER <input type="file" name="trailer"><br>
		PUB_DATE <input type="date" name="pub_date"><br>
		WATCHING_RATE 
		<select name="watching_rate">
			<option>관람등급선택</option>
			<option value="전체관람가">전체관람가</option>
			<option value="12세이상관람가">12세이상관람가</option>
			<option value="15세이상관람가">15세이상관람가</option>
			<option value="청소년관람불가">청소년관람불가</option>
		</select><br>
		PLAY_TIME <input type="number" name="play_time"><br>
		STORY <textarea name="story"></textarea><br>
		THUMNAIL <input type="file" name="thumnail"><br>
		<input type="button" value="글쓰기" id="submitBtn">
	</form>
</body>
</html>