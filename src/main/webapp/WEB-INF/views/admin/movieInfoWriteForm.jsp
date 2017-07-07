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
		var submit_check = true;
		
		//trailerX
		$("#trailerX").click(function() {
			var trailer = $("#trailer_file").val();
			if(trailer != ""){
				var check = false;
				check = window.confirm("현재 선택된 파일을 지우시겠습니까?");
				if(check){
					$("#trailer_file").val("");					
				}
			}else{
				alert("현재 선택된 파일이 없습니다.");
			}
		
		});
		//thumnailX
		$("#thumnailX").click(function() {
			var thumnail = $("#thumnail_file").val();
			if(thumnail != ""){
				var check = false;
				check = window.confirm("현재 선택된 파일을 지우시겠습니까?");
				if(check){
					$("#thumnail_file").val("");										
				}
			}else{
				alert("현재 선택된 파일이 없습니다.");
			}
		});
		
		// 글 업로드
		$("#submitBtn").click(function(){
			// TITLE CHECK
			if($("#title").val()==""){
				alert("제목을 입력해주세요.");
				submit_check = false;
			}
			
			// ENG_TITLE CHECK
			if($("#eng_title").val()==""){
				alert("영문 제목을 입력해주세요.");
				submit_check = false;
			}
			
			// GENRE CHECK
			$(".chx").change(function(){
			// 장르 검색은 최대 3개까지
				chked_val="";
		        checked_count = $('input:checkbox[name="genre"]:checked').length;
		        if(checked_count > 3){
		        	alert("장르는 3개까지 선택 가능합니다.");
		        	$(this).prop("checked", false);
		        }else if(checked_count == 0){
		        	alert("장르를 선택해주세요.");
		        	submit_check = false;
		        }
			});
			
			// DIRECTOR CHECK
			if($("#director").val()==""){
				alert("감독을 입력해주세요.");
				submit_check = false;
			}
			
			// ACTOR CHECK
			if($("#actor").val()==""){
				alert("배우를 입력해주세요.");
				submit_check = false;
			}
			
			// YEAR CHECK
			if($("#year").val()==""){
				alert("제작년도를 입력해주세요.");
				submit_check = false;
			}
			
			// NATION CHECK
			if($("#nation").val()==""){
				alert("제작국가를 입력해주세요.");
				submit_check = false;
			}
			
			// TRAILER CHECK
			if($("#trailer_file").val()==""){
				alert("예고편을 업로드해주세요.");
				submit_check = false;
			}
			
			// PUB_DATE CHECK
			if($("#pub_date").val()==""){
				alert("개봉일을 설정해주세요.");
				submit_check = false;
			}
			
			// WATCHING_RATE CHECK
			if($("#watching_rate").val()=='default'){
				alert("관람등급을 설정해주세요.");
				submit_check = false;
			}
			
			// PLAY_TIME
			if($("#play_time").val()==""){
				alert("플레이 타임을 입력해주세요.");
				submit_check = false;
			}
			
			// STORY CHECK
			if($("#story").val()==""){
				alert("줄거리를 입력해주세요.");
				submit_check = false;
			}
			
			// THUMNAIL CHECK
			if($("#thumnail_file").val()==""){
				alert("포스터를 업로드해주세요.");
				submit_check = false;
			}
			
			if(submit_check== true){
				if(confirm("영화 정보를 업로드 하시겠습니까?")){
					$("#frm").submit();
					/* frm.submit(); */
				}
			}
		});
		
	});
</script>
<style type="text/css">
	.titleSpan{
		font-size: 1.2em;
		font-weight: bold;
		font-family: Montserrat, sans-serif;
	}
	.contentsSpan{
		font-size: 1.1em;
	}
	.genreSpan{
		font-size : 1.15em;
		font-weight: bold;
	}
	.lastTD{
		text-align: right;
	}
	.btnTD{
		width: 80px;
	}
</style>
</head>
<body>
	<div class="container">
		<form name="frm" id="frm" action="./movieInfoWrite" method="post" enctype="multipart/form-data">
			<table class="table table-hover">
				<tr>
					<td><span class="titleSpan">KIND</span></td>
					<td colspan="2" class="genreTD">
						<label class="radio-inline">
      						<input type="radio" name="kind" value="basic" checked="checked"><span class="genreSpan">일반영화</span>
    					</label>
    					<label class="radio-inline">
      						<input type="radio" name="kind" value="low"><span class="genreSpan">독립영화</span>
    					</label>
					</td>
				</tr>
				<tr>
					<td><span class="titleSpan">GENRE</span></td>
					<td colspan="2">
						<label class="checkbox-inline">
				      <input type="checkbox" value="가족" class="chx" name="genre"><span class="genreSpan">가족</span>
				    </label>
				    <label class="checkbox-inline">
				      <input type="checkbox" value="공포" class="chx" name="genre"><span class="genreSpan">공포</span>
				    </label>
				    <label class="checkbox-inline">
				      <input type="checkbox" value="느와르" class="chx" name="genre"><span class="genreSpan">느와르</span>
				    </label>
					<label class="checkbox-inline">
				      <input type="checkbox" value="다큐멘터리" class="chx" name="genre"><span class="genreSpan">다큐멘터리</span>
				    </label>
				    <label class="checkbox-inline">
				      <input type="checkbox" value="드라마" class="chx" name="genre"><span class="genreSpan">드라마</span>
				    </label>
					<label class="checkbox-inline">
				      <input type="checkbox" value="모험" class="chx" name="genre"><span class="genreSpan">모험</span>
				    </label>
					<label class="checkbox-inline">
				      <input type="checkbox" value="뮤지컬" class="chx" name="genre"><span class="genreSpan">뮤지컬</span>
				    </label>
					<label class="checkbox-inline">
				      <input type="checkbox" value="멜로" class="chx" name="genre"><span class="genreSpan">멜로</span>
				    </label>
					<label class="checkbox-inline">
				      <input type="checkbox" value="미스터리" class="chx" name="genre"><span class="genreSpan">미스터리</span>
				    </label>
					<br>
					<label class="checkbox-inline">
				      <input type="checkbox" value="범죄" class="chx" name="genre"><span class="genreSpan">범죄</span>
				    </label>
					<label class="checkbox-inline">
				      <input type="checkbox" value="서스펜스" class="chx" name="genre"><span class="genreSpan">서스펜스</span>
				    </label>
					<label class="checkbox-inline">
				      <input type="checkbox" value="스릴러" class="chx" name="genre"><span class="genreSpan">스릴러</span>
				    </label>
					<label class="checkbox-inline">
				      <input type="checkbox" value="애니메이션" class="chx" name="genre"><span class="genreSpan">애니메이션</span>
				    </label>
					<label class="checkbox-inline">
				      <input type="checkbox" value="액션" class="chx" name="genre"><span class="genreSpan">액션</span>
				    </label> 
					<label class="checkbox-inline">
				      <input type="checkbox" value="전쟁" class="chx" name="genre"><span class="genreSpan">전쟁</span>
				    </label>
					<label class="checkbox-inline">
				      <input type="checkbox" value="코미디" class="chx" name="genre"><span class="genreSpan">코미디</span>
				    </label>
					<label class="checkbox-inline">
				      <input type="checkbox" value="판타지" class="chx" name="genre"><span class="genreSpan">판타지</span>
				    </label>
					<label class="checkbox-inline">
				      <input type="checkbox" value="SF" class="chx" name="genre"><span class="genreSpan">SF</span>
				    </label>
					</td>
				</tr>
				<tr>
					<td><span class="titleSpan">DIRECTOR</span></td>
					<td colspan="2"><input class="form-control" type="text" name="director" id="director"></td>
				</tr>
				<tr>
					<td><span class="titleSpan">ACTOR</span></td>
					<td colspan="2"><input class="form-control" type="text" name="actor" id="actor"></td>
				</tr>
				<tr>
					<td><span class="titleSpan">YEAR</span></td>
					<td colspan="2"><input class="form-control" type="number" name="year" id="year" min="1900" max="2050"></td>
				</tr>
				<tr>
					<td><span class="titleSpan">NATION</span></td>
					<td colspan="2"><input class="form-control" type="text" name="nation" id="nation"></td>
				</tr>
				<tr>
					<td><span class="titleSpan">TRAILER</span></td>
					<td><input class="form-control" type="file" name="trailer_file" id="trailer_file"></td>
					<td class="btnTD"><input type="button" id="trailerX" class="btn" value="지우기"></td>
				</tr>
				<tr>
					<td><span class="titleSpan">PUB_DATE</span></td>
					<td colspan="2"><input class="form-control" type="date" name="pub_date" id="pub_date"></td>
				</tr>
				<tr>
					<td><span class="titleSpan">WATCHING_RATE</span></td>
					<td colspan="2">
						<select name="watching_rate" id="watching_rate" class="form-control">
							<option value="default">관람등급선택</option>
							<option value="전체관람가">전체관람가</option>
							<option value="12세이상관람가">12세이상관람가</option>
							<option value="15세이상관람가">15세이상관람가</option>
							<option value="청소년관람불가">청소년관람불가</option>
						</select>
					</td>
				</tr>
				<tr>
					<td><span class="titleSpan">PLAY_TIME</span></td>
					<td colspan="2"><input class="form-control" type="number" name="play_time" id="play_time"></td>
				</tr>
				<tr>
					<td><span class="titleSpan">STORY</span></td>
					<td colspan="2"><textarea style="height: 100px;" class="form-control" name="story" id="story"></textarea></td>
				</tr>
				<tr>
					<td><span class="titleSpan">THUMNAIL</span></td>
					<td><input class="form-control" type="file" name="thumnail_file" id="thumnail_file"></td>
					<td class="btnTD"><input type="button" id="thumnailX" class="btn" value="지우기"></td>
				</tr>
				<tr>
					<td class="lastTD" colspan="3">
						<input class="btn btn-primary" type="button" value="글쓰기" id="submitBtn">				
					</td>
				</tr>
			</table>
		</form>
	</div>
	
	<!-- 수지꺼  -->
	<!-- <form name="frm" action="./movieInfoWrite" method="post" enctype="multipart/form-data">
		KIND 
		일반영화<input type="radio" name="kind" value="basic" checked="checked">
		독립영화<input type="radio" name="kind" value="low"><br>
		TITLE <input type="text" name="title" id="title"><br>
		ENG_TITLE <input type="text" name="eng_title" id="eng_title"><br>
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
		DIRECTOR <input type="text" name="director" id="director"><br>
		ACTOR <input type="text" name="actor" id="actor"><br>
		YEAR<input type="number" name="year" id="year" min="1900" max="2050"><br>
		NATION <input type="text" name="nation" id="nation"><br>
		TRAILER <input type="file" name="trailer_file" id="trailer_file"><br>
		PUB_DATE <input type="date" name="pub_date" id="pub_date"><br>
		WATCHING_RATE 
		<select name="watching_rate" id="watching_rate">
			<option value="default">관람등급선택</option>
			<option value="전체관람가">전체관람가</option>
			<option value="12세이상관람가">12세이상관람가</option>
			<option value="15세이상관람가">15세이상관람가</option>
			<option value="청소년관람불가">청소년관람불가</option>
		</select><br>
		PLAY_TIME <input type="number" name="play_time" id="play_time"><br>
		STORY <textarea name="story" id="story"></textarea><br>
		THUMNAIL <input type="file" name="thumnail_file" id="thumnail_file"><br>
		<input type="button" value="글쓰기" id="submitBtn">
	</form> -->
	
</body>
</html>