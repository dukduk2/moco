<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/resources/part/bootStrap.jspf" %>
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.js"></script>
<link rel="styleSheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/header.css">
<link rel="styleSheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/section.css">
<title>Insert title here</title>
<style type="text/css">
#replyContentsView, #replyWriterView{
	border:none;
}
</style>
<script type="text/javascript">
	$(function() {
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
.contents-wrap{
	width:700px;
	margin:0 auto;
}
.replyViewDisp{
	border: none;
}

th{
	border-bottom: 1px solid #ccc;
	border-right: 1px solid #ccc;
	height: 50px;
	width: 150px;
	text-align: center;
}
td{
	padding-left: 30px;
	border-bottom: 1px solid #ccc;
}
.lastline{
	border-bottom: none;
}
table{
	margin-bottom: 20px;
}
#replyResult{
	margin-top: 20px;
}
#list{
	float: right;
	margin-bottom: 10px;
}
</style>
</head>
<body>
	<%@ include file="/resources/part/header2.jspf" %>
	<section>
		<div class="contents-wrap">
		<table class="table-responsive">
			<tr>
				<th>TITLE</th><td>${dto.title }</td>
			</tr>
			<tr>
				<th>WRITER</th><td>${dto.writer }</td>
			</tr>			
			<tr>
				<th>DATE</th><td>${dto.reg_date }</td>
			</tr>
			<tr>
				<th>HIT</th><td>${dto.hit }</td>
			</tr>
			<tr>
				<th>CONTENTS</th><td>${dto.contents }</td>
			</tr>
			<tr>
				<th class="lastline">VIDEO</th><td class="lastline"><video width="500" controls>
			<source src="../../resources/upload/actorPR/${dto.oname }" type="video/mp4">
		</video></td>
			</tr>
		</table>

		
		<c:if test="${memberDTO.name eq dto.writer}">
			<a href="./actorPRUpdate?num=${dto.num }"><button class="btn btn-default">UPDATE</button></a>
			<a href="./actorPRDelete?num=${dto.num }"><button class="btn btn-default">DELETE</button></a>
		</c:if>
		<a href="./actorPRList"><button class="btn btn-default" id="list">LIST</button></a>
	
		<!-- 댓글 -->
		<input type="hidden" id="boardKind" value="actorPR">
		<input type="hidden" id="boardNum" value="${dto.num}">
		<div id="replyResult"></div>
		</div>
	</section>
</body>
</html>