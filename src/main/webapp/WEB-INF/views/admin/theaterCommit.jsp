<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%@ include file="/resources/part/bootStrap.jspf" %>
<link rel="styleSheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/header.css">
<link rel="styleSheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/section.css">
<link rel="styleSheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/list.css">
<script type="text/javascript">
	$(function() {
		// page
		$(".go").click(function(){
			var curPage=$(this).attr("id");
			location.href="./theaterCommit?curPage="+curPage;
		});
		
		// view - Ajax
		$(".theaterName").click(function(){
			var num = $(this).attr("id");
			$.post("./theaterCommit_ajax",
				{
					num : num
				},
				function(data){
					$("#theaterView").html(data);
				});
		});
		
		// 승인(commit=0 -> commit=1)
		$("#theaterView").on("click", "#confirm",function(){
			var num = $("#Tnum").val();
			alert("승인");
			$.post("./theaterCommit", {num:num}, function(data){
					location.reload();
			});
		});
		
		// refuse - 삭제
		$("#theaterView").on("click", "#refuse",function(){
			var num = $("#Tnum").val();
			alert("승인 거절");
			$.post("./theaterUnCommit", {num:num}, function(data){
				location.reload();
			});
		});
		
	});
</script>
</head>
<style type="text/css">
	.title{
		text-align: center;
	}
	.paging{
		text-align: center;	
	}
	.go{
		font-size : 1.2em;
		cursor: pointer;
	}
	.btnBox{
		text-align: right;
	}
	.theaterName{
		cursor: pointer;
		font-weight: bold;
	}
</style>
<body>
	<%@ include file="/resources/part/header3.jspf" %>
	<section>
		<div class="container">
			<h3 class="title">THEATER COMMIT</h3>
			<br>
			<table class="table table-hover">
				<tr>
					<td>NUM</td>
					<td>NAME</td>
					<td>LOCATION</td>
					<td>OPENNING TIME</td>
					<td>PRICE</td>
					<td>PHONE</td>
				</tr>
				<c:forEach items="${list}" var="dto">
					<tr>
						<td>${dto.num}	</td>
						<td><span id="${dto.num}" class="theaterName" data-toggle="modal" data-target="#myModal">${dto.name}</span></td>
						<td>${dto.location}</td>
						<td>${dto.opening_time }</td>
						<td>${dto.price}</td>
						<td>${dto.phone}</td>
					</tr>
				</c:forEach>
			</table>
		
			<!-- modal Ajax -->
			<div class="modal fade" id="myModal" role="dialog">
			  	<div class="modal-dialog modal-sm">
			  		<div class="modal-content" id="theaterView">
			  		</div>
			  	</div>
			</div>
				
				
				
			<!-- 페이징 처리 -->
			<div class="paging">
				<c:if test="${pageResult.curBlock>1}">
					<button class="btn"><span class="go" id="${pageResult.startNum-1}">[이전]</span></button>
				</c:if>
				<c:forEach begin="${pageResult.startNum}" end="${pageResult.lastNum}" var="i">
					<button class="btn"><span class="go" id="${i}">${i}</span></button>
				</c:forEach>
				<c:if test="${pageResult.curBlock<pageResult.totalBlock}">
					<button class="btn"><span class="go" id="${pageResult.lastNum+1}">[다음]</span></button>
				</c:if>
			</div>
			
			<!-- BTN -->
			<div class="btnBox">
				<a href="./index"><button class="btn">Admin Index</button></a>
				<a href="../"><button class="btn">HOME</button></a>
			</div>
		</div>
	</section>
</body>
</html>