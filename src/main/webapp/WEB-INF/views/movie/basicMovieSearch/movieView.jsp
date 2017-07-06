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
		
		var boardKind = $("#boardKind").val();
		var boardNum = $("#boardNum").val();
		var curPage = 1;
		
		// viewCheck
		$("#reviewResult").on("click","#viewCheckButton",function(){
			var id = '${memberDTO.id}';
			$.post("../review/viewCheckClick",
				{
					id : id,
					boardKind : boardKind,
					boardNum : boardNum
				},
				function(data){
					$("#reviewResult").html(data);
				});
		});
		
		// reviewLikes
		$("#reviewResult").on("click",".reviewLikes", function(){
			var num = $(this).attr("id");
			var id = '${memberDTO.id}';
			$.post("../review/reviewLikesInsert",
				{
					id : id,
					rNum : num,
					curPage : curPage,
					boardKind : boardKind,
					boardNum : boardNum
				},
				function(data){
					$("#reviewResult").html(data);
					var message = $("#reviewLikesMessage").val();
					alert(message);
				});
		});
		
		// review-list
			$.post("../review/reviewList",
				{
					curPage : curPage,
					boardKind : boardKind,
					boardNum : boardNum
				},
				function(data){
					$("#reviewResult").html(data);
				});
		
		// review-pageing
		$("#reviewResult").on("click",".go",function(){
			curPage=$(this).attr("id");
			$.post("../review/reviewList",
				{
					curPage : curPage,
					boardKind : boardKind,
					boardNum : boardNum
				},
				function(data){
				$("#reviewResult").html(data);
			});
		});
		
		// star
		$("#reviewResult").on("click",".reviewStar",function(){
			var star = $(this).attr("id");
			if(star == 'one'){
				$("#reviewStarResult").html('<i class="fa fa-star-half-full" style="font-size:20px"></i><i class="fa fa-star-o" style="font-size:20px"></i><i class="fa fa-star-o" style="font-size:20px"></i><i class="fa fa-star-o" style="font-size:20px"></i><i class="fa fa-star-o" style="font-size:20px"></i> 1점');
				$("#reviewStarHidden").val(1);
			}else if(star =='two'){
				$("#reviewStarResult").html('<i class="fa fa-star" style="font-size:20px"></i><i class="fa fa-star-o" style="font-size:20px"></i><i class="fa fa-star-o" style="font-size:20px"></i><i class="fa fa-star-o" style="font-size:20px"></i><i class="fa fa-star-o" style="font-size:20px"></i> 2점');
				$("#reviewStarHidden").val(2);
			}else if(star =='three'){
				$("#reviewStarResult").html('<i class="fa fa-star" style="font-size:20px"></i><i class="fa fa-star-half-full" style="font-size:20px"></i><i class="fa fa-star-o" style="font-size:20px"></i><i class="fa fa-star-o" style="font-size:20px"></i><i class="fa fa-star-o" style="font-size:20px"></i> 3점');
				$("#reviewStarHidden").val(3);
			}else if(star == 'four'){
				$("#reviewStarResult").html('<i class="fa fa-star" style="font-size:20px"></i><i class="fa fa-star" style="font-size:20px"></i><i class="fa fa-star-o" style="font-size:20px"></i><i class="fa fa-star-o" style="font-size:20px"></i><i class="fa fa-star-o" style="font-size:20px"></i> 4점');
				$("#reviewStarHidden").val(4);
			}else if(star == 'five'){
				$("#reviewStarResult").html('<i class="fa fa-star" style="font-size:20px"></i><i class="fa fa-star" style="font-size:20px"></i><i class="fa fa-star-half-full" style="font-size:20px"></i><i class="fa fa-star-o" style="font-size:20px"></i><i class="fa fa-star-o" style="font-size:20px"></i> 5점');
				$("#reviewStarHidden").val(5);
			}else if(star == 'six'){
				$("#reviewStarResult").html('<i class="fa fa-star" style="font-size:20px"></i><i class="fa fa-star" style="font-size:20px"></i><i class="fa fa-star" style="font-size:20px"></i><i class="fa fa-star-o" style="font-size:20px"></i><i class="fa fa-star-o" style="font-size:20px"></i> 6점');
				$("#reviewStarHidden").val(6);
			}else if(star == 'seven'){
				$("#reviewStarResult").html('<i class="fa fa-star" style="font-size:20px"></i><i class="fa fa-star" style="font-size:20px"></i><i class="fa fa-star" style="font-size:20px"></i><i class="fa fa-star-half-full" style="font-size:20px"></i><i class="fa fa-star-o" style="font-size:20px"></i> 7점');
				$("#reviewStarHidden").val(7);
			}else if(star == 'eight'){
				$("#reviewStarResult").html('<i class="fa fa-star" style="font-size:20px"></i><i class="fa fa-star" style="font-size:20px"></i><i class="fa fa-star" style="font-size:20px"></i><i class="fa fa-star" style="font-size:20px"></i><i class="fa fa-star-o" style="font-size:20px"></i> 8점');
				$("#reviewStarHidden").val(8);
			}else if(star == 'nine'){
				$("#reviewStarResult").html('<i class="fa fa-star" style="font-size:20px"></i><i class="fa fa-star" style="font-size:20px"></i><i class="fa fa-star" style="font-size:20px"></i><i class="fa fa-star" style="font-size:20px"></i><i class="fa fa-star-half-full" style="font-size:20px"></i> 9점');
				$("#reviewStarHidden").val(9);
			}else if(star == 'ten'){
				$("#reviewStarResult").html('<i class="fa fa-star" style="font-size:20px"></i><i class="fa fa-star" style="font-size:20px"></i><i class="fa fa-star" style="font-size:20px"></i><i class="fa fa-star" style="font-size:20px"></i><i class="fa fa-star" style="font-size:20px"></i> 10점');
				$("#reviewStarHidden").val(10);
			}
		});
		// review-write
		$("#reviewResult").on("click", "#reviewWrite",function(){
			var myRating = $("#reviewStarHidden").val();
			var writer = $("#reviewWriter").val();
			var reviewContents = $("#reviewContents").val();
			$.post("../review/reviewWrite",
				{
					myRating : myRating,
					writer : writer,
					contents : reviewContents,
					curPage : curPage,
					boardKind : boardKind,
					boardNum : boardNum
				},
				function(data){
					$("#reviewResult").html(data);
				});
		});
		// reviewDelete
		$("#reviewResult").on("click",".reviewDelete",function(){
			var num = $(this).attr("id");
			$.post("../review/reviewDelete",
				{
					num : num,
					curPage : curPage,
					boardKind : boardKind,
					boardNum : boardNum
				},
				function(data){
					$("#reviewResult").html(data);
				});
		});
		// review-update - get
		$("#reviewResult").on("click",".reviewUpdate",function(){
			var num = $(this).attr("id"); 
			$.get("../review/reivewUpdate?num="+num+"&boardKind="+boardKind+"&boardNum="+boardNum+"&curPage="+curPage,
				function(data){
					$("#reviewResult").html(data);
			});
		});
		// star
		$("#reviewResult").on("click",".reviewUpdateStar",function(){
			var star = $(this).attr("id");
			if(star == 'one_'){
				$("#reviewUpdateStarResult").html('<i class="fa fa-star-half-full" style="font-size:20px"></i><i class="fa fa-star-o" style="font-size:20px"></i><i class="fa fa-star-o" style="font-size:20px"></i><i class="fa fa-star-o" style="font-size:20px"></i><i class="fa fa-star-o" style="font-size:20px"></i> 1점');
				$("#updateMyRating").val(1);
			}else if(star =='two_'){
				$("#reviewUpdateStarResult").html('<i class="fa fa-star" style="font-size:20px"></i><i class="fa fa-star-o" style="font-size:20px"></i><i class="fa fa-star-o" style="font-size:20px"></i><i class="fa fa-star-o" style="font-size:20px"></i><i class="fa fa-star-o" style="font-size:20px"></i> 2점');
				$("#updateMyRating").val(2);
			}else if(star =='three_'){
				$("#reviewUpdateStarResult").html('<i class="fa fa-star" style="font-size:20px"></i><i class="fa fa-star-half-full" style="font-size:20px"></i><i class="fa fa-star-o" style="font-size:20px"></i><i class="fa fa-star-o" style="font-size:20px"></i><i class="fa fa-star-o" style="font-size:20px"></i> 3점');
				$("#updateMyRating").val(3);
			}else if(star == 'four_'){
				$("#reviewUpdateStarResult").html('<i class="fa fa-star" style="font-size:20px"></i><i class="fa fa-star" style="font-size:20px"></i><i class="fa fa-star-o" style="font-size:20px"></i><i class="fa fa-star-o" style="font-size:20px"></i><i class="fa fa-star-o" style="font-size:20px"></i> 4점');
				$("#updateMyRating").val(4);
			}else if(star == 'five_'){
				$("#reviewUpdateStarResult").html('<i class="fa fa-star" style="font-size:20px"></i><i class="fa fa-star" style="font-size:20px"></i><i class="fa fa-star-half-full" style="font-size:20px"></i><i class="fa fa-star-o" style="font-size:20px"></i><i class="fa fa-star-o" style="font-size:20px"></i> 5점');
				$("#updateMyRating").val(5);
			}else if(star == 'six_'){
				$("#reviewUpdateStarResult").html('<i class="fa fa-star" style="font-size:20px"></i><i class="fa fa-star" style="font-size:20px"></i><i class="fa fa-star" style="font-size:20px"></i><i class="fa fa-star-o" style="font-size:20px"></i><i class="fa fa-star-o" style="font-size:20px"></i> 6점');
				$("#updateMyRating").val(6);
			}else if(star == 'seven_'){
				$("#reviewUpdateStarResult").html('<i class="fa fa-star" style="font-size:20px"></i><i class="fa fa-star" style="font-size:20px"></i><i class="fa fa-star" style="font-size:20px"></i><i class="fa fa-star-half-full" style="font-size:20px"></i><i class="fa fa-star-o" style="font-size:20px"></i> 7점');
				$("#updateMyRating").val(7);
			}else if(star == 'eight_'){
				$("#reviewUpdateStarResult").html('<i class="fa fa-star" style="font-size:20px"></i><i class="fa fa-star" style="font-size:20px"></i><i class="fa fa-star" style="font-size:20px"></i><i class="fa fa-star" style="font-size:20px"></i><i class="fa fa-star-o" style="font-size:20px"></i> 8점');
				$("#updateMyRating").val(8);
			}else if(star == 'nine_'){
				$("#reviewUpdateStarResult").html('<i class="fa fa-star" style="font-size:20px"></i><i class="fa fa-star" style="font-size:20px"></i><i class="fa fa-star" style="font-size:20px"></i><i class="fa fa-star" style="font-size:20px"></i><i class="fa fa-star-half-full" style="font-size:20px"></i> 9점');
				$("#updateMyRating").val(9);
			}else if(star == 'ten_'){
				$("#reviewUpdateStarResult").html('<i class="fa fa-star" style="font-size:20px"></i><i class="fa fa-star" style="font-size:20px"></i><i class="fa fa-star" style="font-size:20px"></i><i class="fa fa-star" style="font-size:20px"></i><i class="fa fa-star" style="font-size:20px"></i> 10점');
				$("#updateMyRating").val(10);
			}
		});
		// review-update - post
		$("#reviewResult").on("click","#reviewUpdate",function(){
			var num = $("#reviewUpdateNum").val();
			var myRating = $("#updateMyRating").val();
			var contents = $("#reviewUpdateContents").val();
			var writer = $("#reviewUpdateWriter").val();
			$.post("../review/reivewUpdate",
				{
					num : num,
					myRating : myRating,
					writer : writer,
					contents : contents,
					curPage : curPage,
					boardKind : boardKind,
					boardNum : boardNum
				},
				function(data){
					$("#reviewResult").html(data);
				});
		});
		// reviewUpdateCancel
		$("#reviewResult").on("click","#reviewUpdateCancel",function(){
			$.post("../review/reviewList",
				{
					curPage : curPage,
					boardKind : boardKind,
					boardNum : boardNum
				},
				function(data){
					$("#reviewResult").html(data);
				});
		});
		
		// 찜하기 체크
		$(".jjim").css('display','none');
		if(${jjimDTO==null}){
			$(".jjimInsert").css('display','block');
		}else{
			$(".jjimDelete").css('display','block');
		}
		
		// 줄거리 or 예고편
		var num = ${movieDTO.num};
		var story_url = "./movieView_story";
		var trailer_url = "./movieView_trailer";
		if(${kind=='story'}){ // 줄거리
			load(story_url, num);
		}else{ // 예고편
			load(trailer_url, num);
		}
		
		// load function. 줄거리/예고편
		function load(url, num){
			$.ajax({
				url : url,
				type : "GET",
				data : {
					num: num
				},
				success : function(data) {
					$("#middleWrap").html(data);
				}
			});
		}
		// 찜하기 
		$(".jjimInsert").click(function(){
			jjim(true,num);
			$(".jjimInsert").css('display','none');
			$(".jjimDelete").css('display','block');
		});
		// 찜하기 취소
		$(".jjimDelete").click(function(){
			jjim(false,num);
			$(".jjimInsert").css('display','block');
			$(".jjimDelete").css('display','none');
		});
		// 찜 function
		function jjim(flag, bNum){
			$.ajax({
				url : "./jjim",
				type : "GET",
				data : {
					flag : flag, 
					bNum : bNum
				},
			});
		}
		// 영화 신청하기, 보러가기
		$(".movieRequest").click(function(){
			var request = $(this).attr("id");
			var bNum = ${movieDTO.num };
			var check='${payCheck}';
			if(request == '영화보러가기'){
				if(check == 'check'){
					location.href="../moviePlay?num="+bNum;
				}else{
					location.href="../payMovie?num="+bNum;
				}
			}else if(request == '영화신청하기'){
				$.ajax({
					url : "./movieRequest",
					type : "GET",
					data : {
						num : num
					},
				});
				alert("영화 신청을 완료했습니다.");
				location.href="./movieView?num="+num;
			}else{
				alert("등록 진행중인 영화입니다.")
			}
		});
	});
</script>
<style type="text/css">
	#topWrap{
		width: 900px;
		height: 300px;
		border-top: 1px solid #cccccc;
		border-bottom: 1px solid #cccccc;
		margin-bottom: 20px;
	}
	#middleWrap{
		width: 900px;
		height: 520px;
		border-bottom: 1px solid #cccccc;
	}
	#thumnailImg{
		width: 25%;
		height: 280px;
		margin-top: 10px;
		margin-left: 10px;
		float: left;
	}
	#thumnailImg img{
		width: 100%;
		height: 280px;
	}
	#movieInfo{
		width: 70%;
		height: 280px;
		margin-top: 10px;
		margin-left: 10px;
		float: left;
	}
	.middle{
		height: 100%;
	}
	.middle video{
		width: 100%;
		height: 100%;
	}
	/* 별점 */
	.star-rating{ 
		width: 100px; 
	}
	.star-rating,.star-rating span{ 
		display:inline-block; 
		height:19px; 
		overflow:hidden; 
		background:url(../../resources/images/movie/star.png)no-repeat; 
	}
	.star-rating span{ 
		background-position:left bottom; 
		line-height:0; 
		vertical-align:top; 
	}
	.jjim:HOVER{
		cursor: pointer;
	}
	/* 후기쓰기 */
	.reviewStar{
    	background-color : rgba(255,255,255);
    }
    .reviewStar:hover{
    	background-color : rgba(192,192,192,0.3);
    }
    .reviewUpdateStar{
    	background-color : rgba(255,255,255);
    }
    .reviewUpdateStar:hover{
    	background-color : rgba(192,192,192,0.3);
    }
    #movieInfo .btn{
    	height: 26px;
    	font-size: 8px;
    	margin-left: 5px;
    }
</style>
</head>
<body>
	<%@ include file="/resources/part/header1.jspf" %>
	<section>
	<div id="topWrap">
		<div id="thumnailImg">
			<img src="${movieDTO.thumnail }">
		</div>
		<div id="movieInfo" title="${movieDTO.num }">
			<span style="font-size: 25px;">${movieDTO.title }
				<button class="btn movieRequest" id="${requestMessage }">${requestMessage }</button>
			</span>
			
			<p>${movieDTO.eng_title }</p>
			<span class="star-rating">
				<span style="width: ${movieDTO.user_rating*10}%"></span>
			</span>
			<span>${movieDTO.user_rating }/10 (${review_count }명 참여)</span>
			<p style="margin-top: 10px;"><strong>개요</strong> ${movieDTO.genre } | ${movieDTO.nation } | ${movieDTO.play_time } | ${movieDTO.pub_date }개봉</p>
			<p><strong>감독</strong> ${movieDTO.director }</p>
			<p><strong>주연</strong> ${movieDTO.actor }</p>
			<p><strong>등급</strong> ${movieDTO.watching_rate }</p>
			<p class="jjim jjimInsert" id="${movieDTO.num }">♡ 찜하기</p>
			<p class="jjim jjimDelete" id="${movieDTO.num }">♥ 찜하기취소</p>
		</div>
	</div>
	<div id="middleWrap"></div>
	<!-- 댓글 -->
	<input type="hidden" value="basicMovie" id="boardKind">
	<input type="hidden" value="${movieDTO.num}" id="boardNum">
	<div id="reviewResult" class="container"></div>
	</section>
</body>
</html>