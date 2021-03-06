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
			location.href="./screenCommit?curPage="+curPage;
		});
		
		// view - Ajax
		$(".boardView").click(function(){
			var num = $(this).attr("id");
			location.href = '../movie/lowpricemovie/theaterView?num='+num;
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
	.screenName{
		cursor: pointer;
		font-weight: bold;
	}
</style>
<body>
	<%@ include file="/resources/part/header3.jspf" %>
	<section>
		<div class="container">
			<h2 style="text-align: center;">SCREEN MANAGEMENT</h2>
			<br>
			<table class="table table-hover">
				<thead>
					<tr class="head">
						<td><span class="titleSpan">NUM</span></td>
						<td><span class="titleSpan">NAME</span></td>
						<td><span class="titleSpan">LOCATION</span></td>
						<td><span class="titleSpan">OPENNING TIME</span></td>
						<td><span class="titleSpan">PRICE</span></td>
						<td><span class="titleSpan">PHONE</span></td>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${list}" var="dto">
						<tr>
							<td>${dto.num}	</td>
							<td><span id="${dto.num}" class="boardView" data-toggle="modal" data-target="#myModal">${dto.name}</span></td>
							<td>${dto.location}</td>
							<td>${dto.opening_time }</td>
							<td>${dto.price}</td>
							<td>${dto.phone}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			
			<!-- modal Ajax -->
			<div class="modal fade" id="myModal" role="dialog">
			   	<div class="modal-dialog modal-sm">
			   		<div class="modal-content" id="screenView">
			   		</div>
			   	</div>
			</div>
			
				
				
				
			<!-- 페이징 처리 -->
			<div class="paging">
				<c:if test="${pageResult.curBlock>1}">
					<button class="btn btn-default"><span class="go" id="${pageResult.startNum-1}">[이전]</span></button>
				</c:if>
				<c:forEach begin="${pageResult.startNum}" end="${pageResult.lastNum}" var="i">
					<button class="btn btn-default"><span class="go" id="${i}">${i}</span></button>
				</c:forEach>
				<c:if test="${pageResult.curBlock<pageResult.totalBlock}">
					<button class="btn btn-default"><span class="go" id="${pageResult.lastNum+1}">[다음]</span></button>
				</c:if>
			</div>
			
			<!-- BTN -->
			<div class="btnBox">
				<a href="../movie/lowpricemovie/movieSearchHome"><button class="btn btn-default">상영 추가하기</button></a>
			</div>
		</div>
		
	</section>
</body>
</html>