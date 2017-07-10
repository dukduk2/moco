<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/resources/part/bootStrap.jspf" %>
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.js"></script>
<link rel="styleSheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/header.css">
<link rel="styleSheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/section.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script type="text/javascript">
	$(function() {
		// viewPage로 접근 한 user가 이 게시물에 '좋아요'를 눌렀는지 먼저 판단
		// '좋아요' 상태라면 취소가 되고 아니라면 '좋아요'가 가능하게 한다.
		 // 좋아요 Click
		$("#likesResult").click(function() {
			var id = '${memberDTO.id}';
			var unum = '${UserBoardDTO.num}';
			if(${likesAbleCheck}){
				$.post("./userBoardLikes", {
					id : id,
					unum : unum
				},
				function(data) {
					$("#likesResult").html(data);
				});
			}else{
				alert("시즌이 진행 중일 때만 참여 가능 합니다.");
			}
		}); 
		
		// listLocation
		$("#listLocation").click(function() {
			var curPage = $("#curPage").val();
			location.href="./userBoardList?curPage="+curPage;
		});
		
		// Board Delete
		$("#delete").click(function() {
			var check = window.confirm("정말 삭제하시겠습니까?");
			var num = ${UserBoardDTO.num};
			if(check){
				location.href="./userBoardDelete?num="+num;
			}
		});
		
		// memberInfo
		$("#memberInfo").click(function() {
			alert("gd");
		});
		
		///////////////////////////////////////////////////////////////// 댓글 Ajax
		// ajax 전역변수
		var count = 1;
		var perPage = 5;
		// 보드 종류 : 배우PR, userBoard
		var boardKind = $("#boardKind").val();
		// 보드 번호 : 이 글의 번호 -> kind로 조회해서 anum or unum으로 나눠짐
		var boardNum = $("#boardNum").val();
		var curPage = 1;
		
		// List
			$.post("../reply/replyList",
				{
					boardKind : boardKind,
					boardNum : boardNum,
					perPage : perPage,
					curPage : curPage
				},
				function(data){
					$("#replyResult").html(data);
				});
		
		// moreView 이벤트 위임
		$("#replyResult").on("click","#moreView",function(){
			count++;
			perPage = perPage*count;
			 $.post("../reply/replyList",
				{
					boardKind : boardKind,
					boardNum : boardNum,
					perPage : perPage,
					curPage : curPage
				},
				function(data){
					$("#replyResult").html(data);
				});
		});
		
		// Insert 이벤트 위임
		$("#replyResult").on("click", "#replyInsert", function(){
			var writer = $("#replyWriter").val();
			var contents = $("#replyContents").val();
			$.post("../reply/replyInsert", 
				{
					writer : writer,
					contents : contents,
					boardKind : boardKind,
					boardNum : boardNum,
					perPage : perPage
				}, 
				function(data) {
					$("#replyResult").html(data);
				});
		});
		
		// update 이벤트 위임 - get 폼 가져오기
		$("#replyResult").on("click",".replyUpdate",function(){
			// 댓글의 글번호
			var num = $(this).attr("id");
			// 수정 버튼을 누르면 수정폼을 출력 - 기존 내용 
			$.get("../reply/replyUpdate?num="+num+"&boardKind="+boardKind+"&boardNum="+boardNum+"&curPage="+curPage+"&perPage="+perPage,
				function(data){
					$("#replyResult").html(data);
			});
		}); 
		
		// replyUpdatePost - post
		$("#replyResult").on("click","#replyUpdate",function(){
			var writer = $("#replyUpdateWriter").val();
			var contents = $("#replyUpdateContents").val();
			var num = $("#replyUpdateNum").val();
			// 등록 버튼을 누르면 폼에 입력한 값을 서버로 전송
			// 서버에서 db 업데이트 후 다시 List를 출력
			$.post("../reply/replyUpdate",
				{
					writer : writer,
					contents : contents,
					boardKind : boardKind,
					boardNum : boardNum,
					perPage : perPage,
					num : num
				},
				function(data){
					$("#replyResult").html(data);
				});
		});
		// updateCancel
		$("#replyResult").on("click","#replyUpdateCancel",function(){
			// list
			$.post("../reply/replyList",
				{
					boardKind : boardKind,
					boardNum : boardNum,
					perPage : perPage,
					curPage : curPage
				},
				function(data){
					$("#replyResult").html(data);
				});
		});
		
		// replyDelete 이벤트 위임
		$("#replyResult").on("click",".replyDelete",function(){
			var num = $(this).attr("id");
			$.post("../reply/replyDelete",
				{
					num : num,
					perPage : perPage,
					boardKind : boardKind,
					boardNum : boardNum,
					curPage : curPage
				},
				function(data){
					$("#replyResult").html(data);
				});
		});
		
		
		////////////////////////////////////////////////////////////////
		
	});
</script>
<style type="text/css">
	.contentsTable{
		margin: 0 auto;
	}
	.title{
		font-size : 2em;
		font-weight: bold;
	}
	.title2{
		height : 50px;
		font-size : 1.1em;
		font-weight: bold;
		text-align: right;
	}
	.likesTD{
		text-align: center;
		height: 110px;
		vertical-align: middle;
	}
	.likes{
		font-size: 1.4em;
		font-weight: bold;
		cursor: pointer;
		text-align: center;
	}
	.replyDelete{
		cursor: pointer;
	}
	.replyViewDisp{
		border: none;
	}
	.contentsDIV{
		text-align: center;
	}
	.videoDIV{
		text-align: center;
	}
	.videoView{
		height: 330px;
	}
	.memberProfileIMG{
		width: 110px;
		height: 110px;
		border-radius: 100%; 
	}
	.memberProfileID{
		font-family: Montserrat, sans-serif;
		font-size: 2em;
		cursor: pointer;
	}
	.memberProfileID:hover{
		color: skyblue;
	}
	.memberProfileSeason{
		font-family: Montserrat, sans-serif;
		font-size: 1.1em;
	}
	.memberInfoSpan{
		font-family: Montserrat, sans-serif;
		font-size: 1.1em;
	}
	.btnBox{
		width : 1170px;
		height : 50px;
		margin: 0 auto;
		text-align: right;
		margin-top: 30px;
	}
</style>
</head>
<body>
	
	<%@ include file="/resources/part/header2.jspf" %>
	<section>
		<table class="contentsTable">
			<tr>
				<td colspan="2" class="title">${UserBoardDTO.title}</td>
			</tr>
			<tr>
				<td colspan="2" class="title2">
					<span>
						<i class="fa fa-clock-o" style="font-size:24px"></i>&nbsp;<span>${UserBoardDTO.reg_date}&nbsp;&nbsp;</span>
						<i class="fa fa-eye" style="font-size:24px"></i>&nbsp;<span>${UserBoardDTO.hit}&nbsp;&nbsp;</span>
					</span>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<div class="contentsDIV">
						${UserBoardDTO.contents}
					</div>
				</td>
			</tr>
			<!-- videoState -->
			<c:if test="${UserBoardDTO.videoState == 0}">
				<tr>
					<td class="videoView" colspan="2">
						<div class="videoDIV">
							<video width="500" controls="controls">
								<source src="../../resources/upload/userBoard/${UserBoardDTO.fname}" type="video/mp4">
							</video>
						</div>
					</td>
				</tr>
			</c:if>
			<tr>
				<td rowspan="2" style="width: 130px;">
					<img class="memberProfileIMG" alt="" src="../../resources/upload/member/${writerInfo.fname}">
				</td>
				<td></td>
			</tr>
			<tr>
				<td>
				<hr>
				<!-- modal -->
				  <!-- Trigger the modal with a button -->
					  <span class="memberProfileID"  data-toggle="modal" data-target="#myModal">
							<i class="fa fa-pencil"></i> ${UserBoardDTO.writer}
						</span>
				  <!-- Modal -->
				  <div class="modal fade" id="myModal" role="dialog">
				    <div class="modal-dialog">
				      <!-- Modal content-->
				      <div class="modal-content">
				        <div class="modal-header">
				          <button type="button" class="close" data-dismiss="modal">&times;</button>
				          <h4 class="modal-title">${writerInfo.id} 님의 정보</h4>
				        </div>
				        <div class="modal-body">
				          <table class="table">
				          	<tr>
				          		<td><span class="memberInfoSpan">ID</span></td>
				          		<td><span class="memberInfoSpan">${writerInfo.id}</span></td>
				          	</tr>
							<tr>
								<td><span class="memberInfoSpan">EMAIL</span></td>
								<td><span class="memberInfoSpan">${writerInfo.email}</span></td>
							</tr>
				          	<tr>
				          		<td><span class="memberInfoSpan">회원 유형</span></td>
				          		<td><span class="memberInfoSpan">${writerInfo.kind}</span></td>
				          	</tr>
				          	<tr>
				          		<td><span class="memberInfoSpan">회원 등급</span></td>
				          		<td><span class="memberInfoSpan">${writerInfo.grade}</span></td>
				          	</tr>
				          </table>
				        </div>
				        <div class="modal-footer">
				          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				        </div>
				      </div>
				    </div>
				  </div>
					<br>
					<span class="memberProfileSeason">
						<i class="fa fa-bookmark" style="font-size:24px"></i> ${UserBoardDTO.season}
					</span>
				</td>
			</tr>
			<tr>
				<td colspan="2" class="likesTD">
					<span id="likesResult" class="likes">
						<c:if test="${message == true}">
							좋아요 취소 <i class="fa fa-thumbs-up" style="font-size:24px;color:skyblue"></i>
						</c:if>
						<c:if test="${message == false }">
							좋아요 <i class="fa fa-thumbs-o-up" style="font-size:24px"></i>
						</c:if> 
						${likesResult}
					</span>
				</td>
			</tr>
		</table>
		
		
		<article>
			<!-- 댓글 -->
			<input type="hidden" id="boardKind" value="userBoard">
			<input type="hidden" id="boardNum" value="${UserBoardDTO.num}">
			<div id="replyResult" class="container"></div>
		</article>
		
		<article class="btnBox">
			<c:if test="${memberDTO.id == UserBoardDTO.writer}">
				<input type="button" id="delete" value="delete" class="btn btn-danger">
			</c:if>
			<input type="button" id="listLocation" value="list" class="btn btn-primary">
			<input type="hidden" id="curPage" value="${curPage}">
		</article>
		
	</section>
</body>
</html>