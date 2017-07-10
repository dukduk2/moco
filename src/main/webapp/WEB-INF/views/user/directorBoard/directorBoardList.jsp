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
		$(".invest_state").change(function(){
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
<style type="text/css">
	.contents{
		height: 200px;
		width: 400px;
		border: 1px solid black;
		float: left;
		margin: 10 10px;
	}
	.contents-top{
		height: 70%;
		border: 1px solid black;
	}
	.contents-middle{
		height: 15%;
		border: 1px solid black;
	}
	.contents-bottom{
		height: 15%;
		border: 1px solid black;
	}
	.contents-top-left{
		height: 100%;
		width: 30%;
		float: left;
	}
	.contents-top-left img{
		border: 1px solid black;
		border-radius: 50%;
	}
	.contents-top-rigth{
		width: 60%;
		height: 100%;
		float: right;
		margin-right: 10px;
		padding-top: 10px;
	}
	.contents-top-rigth p{
		height: 14px;
		font-size: 13px;
	}
	#search-result{
		width: 1300px;
	}
	.state{
		width: 80px;
		float: right;
		margin-top: 2px;
		margin-right: 5px;
		border: 1px solid black;
		text-align: center;
	}
	#state0{
		background-color: #ffcccc;
	}
	#state1{
		background-color: #c6ebc6;
	}
	.load-more{
		width: 100%;
	}
</style>
</head>
<body>
	<%@ include file="/resources/part/header2.jspf" %>
	<%@ include file="/resources/part/sideMenu.jspf" %>
	<section>
	<a href="./download?fileName=planning_document.hwp">양식 다운로드</a><br>
	<a href="./directorBoardWrite">펀딩 등록하기</a>
	<!-- 장르 검색 -->
	<p>-------------- genre(최대 3개까지 선택) ---------------</p> 
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
	<p>-------------- state ---------------</p>
			전체보기 <input type="radio" class="invest_state" name="invest_state" checked="checked" value="2">
			진행중<input type="radio" class="invest_state" name="invest_state" value="1">
			마감완료<input type="radio" class="invest_state" name="invest_state" value="0">
	<div id="search-result"></div>
	</section>
</body>
</html>