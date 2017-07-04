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
		     //전송버튼 클릭이벤트
		    $("#savebutton").click(function(){
		    	//id가 smarteditor인 textarea에 에디터에서 대입
		        editor_object.getById["contents"].exec("UPDATE_CONTENTS_FIELD", []);
		        // 이부분에 에디터 validation 검증
		        var chx = $("input:checkbox[name=genre]:checked").length;
		        //alert(chx);
		        if(chx>3){
		        	alert("장르 선택은 최대 3개 까지 하셔야 합니다.");
		        }else if(chx ==0){
		        	alert("장르는 최소 1개 이상 이어야 합니다.");	
		        }else{
			        //폼 submit
			        $("#frm").submit();		        	
		        }
		    })
		    
		    // x
		    $("#x").click(function() {
				var fileU = $("#file").val();
		    	if(fileU.length > 0){
		    		var check = window.confirm("현재 선택된 파일을 지우시겠습니까?");
		    		if(check){
		    			$("#file").val("");
		    		}
		    	}else {
		    		alert("현재 선택된 파일이 없습니다.");
		    	}
			});
	});
</script>
<style type="text/css">
	#contents{
		width: 920px;
	}
	#x{
		cursor: pointer;
	}
	.btnBox{
		text-align: right;
	}
	.titleSpan{
		font-size: 1.2em;
		font-weight: bold;
	}
	.genreSpan{
		font-size : 1.1em;
		font-weight: bold;
	}
</style>
</head>
<body>
	<%@ include file="/resources/part/header2.jspf" %>
	<section>

	<h2 style="text-align: center;">userBoardWrite</h2>
	<br>
<div class="container">
	<form action="./userBoardWrite" method="post" enctype="multipart/form-data" id="frm">
		<table class="table">
			<tr>
				<td><span class="titleSpan">TITLE</span></td>
				<td colspan="2"><input type="text" name="title" class="form-control"></td>
			</tr>
			<tr>
				<td><span class="titleSpan">WRITER</span></td>
				<td colspan="2"><input type="text" name="writer" readonly="readonly" value="${memberDTO.id}" class="form-control"></td>
			</tr>
			<tr>
				<td><span class="titleSpan">SEASON</span></td>
				<td colspan="2"><input type="text" value="${order.season}" readonly="readonly" name="season" class="form-control"></td>
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
				<td><span class="titleSpan">CONTENTS</span></td>
				<td colspan="2"><textarea id="contents" name="contents"></textarea></td>
			</tr>
			<tr>
				<td><span class="titleSpan">저예산 영화</span></td>
				<td><input type="file" name="file" id="file"></td>
				<td><span id="x" class="titleSpan">X</span></td>
			</tr>
		</table>
		<div style="text-align: right;">
			<input type="button" id="savebutton" value="WRITE" class="btn">		
		</div>
	</form>
	<br><br>
	<div class="btnBox">
		<a href="../../" role="button" class="btn"><button class="btn">HOME</button></a>
		<a href="./userBoardList?season=all"><button class="btn">LIST</button></a>
	</div>
	
</div>
	</section>
</body>
</html>